Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3734FFF48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiDMTaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiDMTal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:30:41 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508F672E24
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:28:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649878094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L2z4Q/1rfqvzlgKK/+Q8dR7Hr7nD3d/L3KDR+0LUxPU=;
        b=ZvRioLZbeDyL4poeadGgM2c8Po2yBKxCKpGbpWnDtBTp34qUgzhusba/LG+/a/YwJellq0
        Z892c6X/MEaC7LAR5WuUDf/FvNuwCTgizZXrHwgPxfm7DJWldynpomv9Etgx46bEu/yTO4
        TCy+al8B7eu/+lHMiLrkDnNJNV2av8o=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 0/3] kasan, arm64, scs: collect stack traces from Shadow Call Stack
Date:   Wed, 13 Apr 2022 21:26:43 +0200
Message-Id: <cover.1649877511.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Currently, when saving alloc and free stack traces, KASAN uses the normal
stack trace collection routines, which rely on the unwinder.

Instead of invoking the unwinder, collect the stack trace by copying
frames from the Shadow Call Stack. This reduces boot time by ~30% for
all KASAN modes when Shadow Call Stack is enabled. See below for the
details of how the measurements were performed.

Stack staces are collected from the Shadow Call Stack via a new
stack_trace_save_shadow() interface.

Note that the implementation is best-effort and only works in certain
contexts. See patch #3 for details.

---

Changes
=======

v2->v3:
- Limit hardirq and drop SDEI support for performance and simplicity.
- Move stack_trace_save_shadow() implementation back to mm/kasan:
  it's not mature enough to be used as a system-wide stack trace
  collection replacement.
- Clarify -ENOSYS return value from stack_trace_save_shadow().
- Don't rename nr_entries to size in kasan_save_stack().
- Check return value of stack_trace_save_shadow() instead of checking
  CONFIG_HAVE_SHADOW_STACKTRACE in kasan_save_stack().

v1->v2:
- Provide a kernel-wide stack_trace_save_shadow() interface for collecting
  stack traces from shadow stack.
- Use ptrauth_strip_insn_pac() and READ_ONCE_NOCHECK, see the comments.
- Get SCS pointer from x18, as per-task value is meant to save the SCS
  value on CPU switches.
- Collect stack frames from SDEI and IRQ contexts.

Perf
====

To measure performance impact, I used QEMU in full system emulation mode
on an x86-64 host.

As proposed by Mark, I passed no filesystem to QEMU and booted with panic=-1:

qemu-system-aarch64 \
	-machine virt,mte=on -cpu max \
	-m 2G -smp 1 -nographic \
	-kernel ./xbins/Image \
	-append "console=ttyAMA0 earlyprintk=serial panic=-1" \
	-no-shutdown -no-reboot

Just in case, the QEMU version is:

$ qemu-system-aarch64 --version
QEMU emulator version 6.2.94 (v5.2.0-rc3-12124-g81c7ed41a1)
Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers

Then, I recorded the timestamp of when the "Kernel panic" line was printed
to the kernel log.

The measurements were done on 5 kernel flavors:

master                 (mainline commit a19944809fe99):
master-no-stack-traces (stack trace collection commented out)
master-no-stack-depot  (saving to stack depot commented out)
up-scs-stacks-v3       (collecting stack traces from SCS)
up-scs-stacks-v3-noscs (up-scs-stacks-v3 with __noscs marking)

(The last flavor is included just for the record: it produces an unexpected
 slowdown. The likely reason is that helper functions stop getting inlined.)

All the branches can be found here:

https://github.com/xairy/linux/branches/all

The measurements were performed for Generic and HW_TAGS KASAN modes.

The .configs are here (essentially, defconfig + SCS + KASAN):

Generic KASAN: https://gist.github.com/xairy/d527ad31c0b54898512c92898d62beed
HW_TAGS KASAN: https://gist.github.com/xairy/390e4ef0140de3f4f9a49efe20708d21

The results:

Generic KASAN
-------------

master-no-stack-traces: 8.03
master:                 11.55 (+43.8%)
master-no-stack-depot:  11.53 (+43.5%)
up-scs-stacks-v3:       8.31  (+3.4%)
up-scs-stacks-v3-noscs: 9.11  (+13.4%)

HW_TAGS KASAN
-------------

master-no-stack-traces: 3.31
master:                 5.01 (+51%)
master-no-stack-depot:  4.85 (+47%)
up-scs-stacks-v3:       3.49 (+5.4%)
up-scs-stacks-v3-noscs: 4.27 (+29%)

The deviation for all numbers above is ~0.05.

As can be seen, the up-scs-stacks-v3 flavor results in a significantly
faster boot compared to master.

Andrey Konovalov (3):
  arm64, scs: expose irq_shadow_call_stack_ptr
  kasan, arm64: implement stack_trace_save_shadow
  kasan: use stack_trace_save_shadow

 arch/arm64/include/asm/scs.h | 10 +++++-
 arch/arm64/kernel/irq.c      |  4 +--
 arch/arm64/kernel/sdei.c     |  3 --
 mm/kasan/common.c            | 66 +++++++++++++++++++++++++++++++++++-
 4 files changed, 75 insertions(+), 8 deletions(-)

-- 
2.25.1

