Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695CB511741
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiD0MG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiD0MGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:06:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18452E4F;
        Wed, 27 Apr 2022 05:03:10 -0700 (PDT)
Date:   Wed, 27 Apr 2022 12:03:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651060987;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNLBChOzmeFIRIbadE2Y+tnl2fOrqIzLKxhl29s/cc8=;
        b=iY0gmrqqZZya9EEfFmeSn0+f+RWGR2QCCizNjcvM3vScHayCGFrKrGivTeFkw2i22qYSju
        4y8DYw5oq6yYLQqMjc/2x4tkpKQNnyW4WFgcRvRPhfu1gkrYnD+fkmvvMudMZqcudwMaM1
        wtrVSO8MxLXtfZxTEIHtrPid+E5a3/7yqo8M62fhL1SEGxlTiDGW3CpHlKk/rBa6cf3M9i
        mggV1rCPnUlyngUFqT/J2M9Ax2igDWGCJEQhNzKUpslMtOYd+94jxiPdc+hO0HJc2TqI5s
        eiv4E7U39yhM9LY7zJDdA8EW+tji3v51NWflstsPOOQxUXwUOozFuVTq65eWAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651060987;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNLBChOzmeFIRIbadE2Y+tnl2fOrqIzLKxhl29s/cc8=;
        b=JifwPJ1PAXrIk4e5kBbXYnW+ceB38S5alse6BCX/Z4IVwZVzJMlIPOg1+SpLuOiNgFYvIp
        cEUI3AhKCP3TRuDw==
From:   "tip-bot2 for Matthieu Baerts" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/pm: Fix false positive kmemleak report in
 msr_build_context()
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220426202138.498310-1-matthieu.baerts@tessares.net>
References: <20220426202138.498310-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Message-ID: <165106098627.4207.9339334897773264387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b0b592cf08367719e1d1ef07c9f136e8c17f7ec3
Gitweb:        https://git.kernel.org/tip/b0b592cf08367719e1d1ef07c9f136e8c17f7ec3
Author:        Matthieu Baerts <matthieu.baerts@tessares.net>
AuthorDate:    Sat, 23 Apr 2022 20:24:10 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 Apr 2022 13:55:19 +02:00

x86/pm: Fix false positive kmemleak report in msr_build_context()

Since

  e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume")

kmemleak reports this issue:

  unreferenced object 0xffff888009cedc00 (size 256):
    comm "swapper/0", pid 1, jiffies 4294693823 (age 73.764s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 48 00 00 00 00 00 00 00  ........H.......
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      msr_build_context (include/linux/slab.h:621)
      pm_check_save_msr (arch/x86/power/cpu.c:520)
      do_one_initcall (init/main.c:1298)
      kernel_init_freeable (init/main.c:1370)
      kernel_init (init/main.c:1504)
      ret_from_fork (arch/x86/entry/entry_64.S:304)

Reproducer:

  - boot the VM with a debug kernel config (see
    https://github.com/multipath-tcp/mptcp_net-next/issues/268)
  - wait ~1 minute
  - start a kmemleak scan

The root cause here is alignment within the packed struct saved_context
(from suspend_64.h). Kmemleak only searches for pointers that are
aligned (see how pointers are scanned in kmemleak.c), but pahole shows
that the saved_msrs struct member and all members after it in the
structure are unaligned:

  struct saved_context {
    struct pt_regs             regs;                 /*     0   168 */
    /* --- cacheline 2 boundary (128 bytes) was 40 bytes ago --- */
    u16                        ds;                   /*   168     2 */

    ...

    u64                        misc_enable;          /*   232     8 */
    bool                       misc_enable_saved;    /*   240     1 */

   /* Note below odd offset values for the remainder of this struct */

    struct saved_msrs          saved_msrs;           /*   241    16 */
    /* --- cacheline 4 boundary (256 bytes) was 1 bytes ago --- */
    long unsigned int          efer;                 /*   257     8 */
    u16                        gdt_pad;              /*   265     2 */
    struct desc_ptr            gdt_desc;             /*   267    10 */
    u16                        idt_pad;              /*   277     2 */
    struct desc_ptr            idt;                  /*   279    10 */
    u16                        ldt;                  /*   289     2 */
    u16                        tss;                  /*   291     2 */
    long unsigned int          tr;                   /*   293     8 */
    long unsigned int          safety;               /*   301     8 */
    long unsigned int          return_address;       /*   309     8 */

    /* size: 317, cachelines: 5, members: 25 */
    /* last cacheline: 61 bytes */
  } __attribute__((__packed__));

Move misc_enable_saved to the end of the struct declaration so that
saved_msrs fits in before the cacheline 4 boundary.

The comment above the saved_context declaration says to fix wakeup_64.S
file and __save/__restore_processor_state() if the struct is modified:
it looks like all the accesses in wakeup_64.S are done through offsets
which are computed at build-time. Update that comment accordingly.

At the end, the false positive kmemleak report is due to a limitation
from kmemleak but it is always good to avoid unaligned members for
optimisation purposes.

Please note that it looks like this issue is not new, e.g.

  https://lore.kernel.org/all/9f1bb619-c4ee-21c4-a251-870bd4db04fa@lwfinger.net/
  https://lore.kernel.org/all/94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de/

  [ bp: Massage + cleanup commit message. ]

Fixes: 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume")
Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20220426202138.498310-1-matthieu.baerts@tessares.net
---
 arch/x86/include/asm/suspend_32.h |  2 +-
 arch/x86/include/asm/suspend_64.h | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 7b132d0..a800abb 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -19,7 +19,6 @@ struct saved_context {
 	u16 gs;
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
-	bool misc_enable_saved;
 	struct saved_msrs saved_msrs;
 	struct desc_ptr gdt_desc;
 	struct desc_ptr idt;
@@ -28,6 +27,7 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
+	bool misc_enable_saved;
 } __attribute__((packed));
 
 /* routines for saving/restoring kernel state */
diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index 35bb35d..54df066 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -14,9 +14,13 @@
  * Image of the saved processor state, used by the low level ACPI suspend to
  * RAM code and by the low level hibernation code.
  *
- * If you modify it, fix arch/x86/kernel/acpi/wakeup_64.S and make sure that
- * __save/__restore_processor_state(), defined in arch/x86/kernel/suspend_64.c,
- * still work as required.
+ * If you modify it, check how it is used in arch/x86/kernel/acpi/wakeup_64.S
+ * and make sure that __save/__restore_processor_state(), defined in
+ * arch/x86/power/cpu.c, still work as required.
+ *
+ * Because the structure is packed, make sure to avoid unaligned members. For
+ * optimisation purposes but also because tools like kmemleak only search for
+ * pointers that are aligned.
  */
 struct saved_context {
 	struct pt_regs regs;
@@ -36,7 +40,6 @@ struct saved_context {
 
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
-	bool misc_enable_saved;
 	struct saved_msrs saved_msrs;
 	unsigned long efer;
 	u16 gdt_pad; /* Unused */
@@ -48,6 +51,7 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
+	bool misc_enable_saved;
 } __attribute__((packed));
 
 #define loaddebug(thread,register) \
