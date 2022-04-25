Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F050DF91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiDYL7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiDYL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:59:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 143F965DF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:56:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDAC51FB;
        Mon, 25 Apr 2022 04:56:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93A383F73B;
        Mon, 25 Apr 2022 04:56:09 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH 0/8] stackleak: fixes and rework
Date:   Mon, 25 Apr 2022 12:55:55 +0100
Message-Id: <20220425115603.781311-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reworks the stackleak code. The first patch fixes some
latent issues on arm64, and the subsequent patches improve the code to
improve clarity and permit better code generation.

I started working on this as a tangent from rework to arm64's stacktrace
code. Looking at users of the `on_*_stack()` helpers I noticed that the
assembly generated for stackleak was particularly awful as it performed
a lot of redundant work and also called instrumentable code, which isn't
sound.

The first patch fixes the major issues on arm64, and is Cc'd to stable
for backporting.

The second patch is a trivial optimization for when stackleak is
dynamically disabled.

The subsequent patches rework the way stackleak manipulates the stack
boundary values. This is partically for clarity (e.g. with separate
'low' and 'high' boundary variables), and also permits the compiler to
generate more optimal assembly by generating the high and low bounds
from the same base.

Patch 5 changes the way that `current->lowest_stack` is reset prior to
return to userspace. The existing code uses an undocumented offset
relative to the top of the stack which doesn't make much sense (as thie
sometimes falls within the task's pt_regs, or sometimes adds 600+ bytes
to erase upon the next exit to userspace). For now I've removed the
offset entirely.

Patch 7 adds stackleak_erase_on_task_stack() and
stackleak_erase_off_task_stack() that can be used when a caller knows
they're always on or off the task stack respectively, avoiding redundant
logic to check this and generate the high boundary value. On arm64 we
always call stackleak_erase() while on the task stack, so this is used
in patch 8.

Testing the series on arm64 with a QEMU HVF VM on an M1 Macbook Pro with
a few microbenchmarks shows a small but measureable improvement when
stackleak is enabled (relative to v5.18-rc1):

* Calling getpid 1^22 times in a loop (avg 50 runs)
  
  Before: 0.652099387 seconds ( +-  0.13% )
  After:  0.641005661 seconds ( +-  0.13% )

  ~1.7% time decrease

* perf bench sched pipe (single run)

  Before: 2.138 seconds total
  After:  2.118 seconds total

  ~0.93% time decrease

I also tested "perf bench sched messaging" but the noise outweighed the
difference.

While the improvement is small, I think the improvement to clarity and
code generation is a win regardless.

Thanks,
Mark.

Mark Rutland (8):
  arm64: stackleak: fix current_top_of_stack()
  stackleak: move skip_erasing() check earlier
  stackleak: rework stack low bound handling
  stackleak: clarify variable names
  stackleak: rework stack high bound handling
  stackleak: remove redundant check
  stackleak: add on/off stack variants
  arm64: entry: use stackleak_erase_on_task_stack()

 arch/arm64/include/asm/processor.h | 10 ++-
 arch/arm64/kernel/entry.S          |  2 +-
 include/linux/stackleak.h          | 29 ++++++++-
 kernel/stackleak.c                 | 99 ++++++++++++++++++++----------
 4 files changed, 98 insertions(+), 42 deletions(-)

-- 
2.30.2

