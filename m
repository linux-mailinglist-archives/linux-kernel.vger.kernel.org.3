Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392FF511F39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiD0RfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244186AbiD0Rew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:34:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8E601F3534
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9119ED1;
        Wed, 27 Apr 2022 10:31:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3B203F73B;
        Wed, 27 Apr 2022 10:31:33 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex.popov@linux.com, keescook@chromium.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        luto@kernel.org, mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 00/13] stackleak: fixes and rework
Date:   Wed, 27 Apr 2022 18:31:15 +0100
Message-Id: <20220427173128.2603085-1-mark.rutland@arm.com>
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

Hi Alexander, Kees,

This is the vs I promised. Since Alexander wanted to look at this in
more detail (and since this is subtle and needs review), I'm assuming
that Kees will pick this up some time next week after that's happened,
if all goes well. :)

This series reworks the stackleak code and the associated LKDTM test.
The first patch fixes some latent issues on arm64, and the subsequent
patches improve the code to improve clarity and permit better code
generation. Patches 8-10 address some latent issues in the LKDTM test
and add more diagnostic output.

Since v1 [1]:
* Fix and rework the LKDTM test
* Rework the poison scan

[1] https://lore.kernel.org/lkml/20220425115603.781311-1-mark.rutland@arm.com/

Benchmarking arm64 with a QEMU HVF VM on an M1 Macbook Pro shows a
reasonable improvement when stackleak is enabled. I've included figures
for when stackleak is dynamically disabled with v2:

* Calling getpid 1^22 times in a loop (avg 50 runs)
  
  5.18-rc1/on: 0.652099387s ( +-  0.13% )
  v1/on:       0.641005661s ( +-  0.13% ) ; 1.7% improvement
  v2/on:       0.611699824s ( +-  0.08% ) ; 6.2% improvement
  v2/off:      0.507505632s ( +-  0.15% )

* perf bench sched pipe (single run)

  5.18-rc1/on: 2.138s total
  v1/on:       2.118s total ; 0.93% improvement
  v2/on:       2.116s total ; 1.03% improvement
  v2/off:      1.708s total

The large jump between v1 and v2 is largely due to the changes to poison
scanning avoiding redundantly overwriting poison. For the getpid syscall
the poison which gets overwritten is a substantial fraction of the stack
usage, and for more involved syscalls this may be a trivial fraction, so
the average benefit is fairly small.

With the whole series applied, the LKDTM test reliably passes on both
arm64 and x86_64, e.g.

| # uname -a
| Linux buildroot 5.18.0-rc1-00013-g26f638ab0d7c #3 SMP PREEMPT Wed Apr 27 16:21:37 BST 2022 aarch64 GNU/Linux
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT 
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: stackleak stack usage:
|   high offset: 336 bytes
|   current:     688 bytes
|   lowest:      1232 bytes
|   tracked:     1232 bytes
|   untracked:   672 bytes
|   poisoned:    14136 bytes
|   low offset:  8 bytes
| lkdtm: OK: the rest of the thread stack is properly erased

The first patch fixes the major issues on arm64, and is Cc'd to stable
for backporting.

The second patch is a trivial optimization for when stackleak is
dynamically disabled.

The subsequent patches rework the way stackleak manipulates the stack
boundary values. This is partially for clarity (e.g. with separate 'low'
and 'high' boundary variables), and also permits the compiler to
generate more optimal assembly by generating the high and low bounds
from the same base.

Patch 6 changes the way that `current->lowest_stack` is reset prior to
return to userspace. The existing code uses an undocumented offset
relative to the top of the stack which doesn't make much sense (as thie
sometimes falls within the task's pt_regs, or sometimes adds 600+ bytes
to erase upon the next exit to userspace). For now I've removed the
offset entirely.

Patch 7 changes the way we scan for poison. This fixes what I believe
are fencepost errors, and also avoids the need to redundantly overwrite
poison.

Patches 8-11 rework the LKDTM test, fixing cases where the test could
spuriously fail and improving the diagnostic output.

Patches 12 and 13 add stackleak_erase_on_task_stack() and
stackleak_erase_off_task_stack() that can be used when a caller knows
they're always on or off the task stack respectively, avoiding redundant
logic to check this and generate the high boundary value. The former is
used on arm64 where we always perform the erase on the task stack, and
I've included the latter for completeness (as e.g. it could be used on
x86) given it is trivial.

Thanks,
Mark.

Mark Rutland (13):
  arm64: stackleak: fix current_top_of_stack()
  stackleak: move skip_erasing() check earlier
  stackleak: remove redundant check
  stackleak: rework stack low bound handling
  stackleak: clarify variable names
  stackleak: rework stack high bound handling
  stackleak: rework poison scanning
  lkdtm/stackleak: avoid spurious failure
  lkdtm/stackleak: rework boundary management
  lkdtm/stackleak: prevent unexpected stack usage
  lkdtm/stackleak: check stack boundaries
  stackleak: add on/off stack variants
  arm64: entry: use stackleak_erase_on_task_stack()

 arch/arm64/include/asm/processor.h |  10 +--
 arch/arm64/kernel/entry.S          |   2 +-
 drivers/misc/lkdtm/stackleak.c     | 133 +++++++++++++++++++----------
 include/linux/stackleak.h          |  55 +++++++++++-
 kernel/stackleak.c                 | 105 ++++++++++++++---------
 5 files changed, 210 insertions(+), 95 deletions(-)

-- 
2.30.2

