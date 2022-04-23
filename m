Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78950CCDD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiDWS1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbiDWS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:27:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB45D1F7D73
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:24:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y20so22161247eju.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9l5iWYC32c45NSx+NuKLzAKcOwrZzZ8GmpPgq17uhVY=;
        b=yoCfu/jknnnwfT8OUfYAS45iONd0HBI9c/r0wWPD03OPzPGf5rvVhWBh0Af6aK0etD
         qy2fvJ+uQO1zRYB4nwwhAR7h1h+FxgeYkmscwnXJ2dWkNHwtkNvI1F6+8L4Fa3WATAIq
         V/kAbPgHEXpRzA+mUBO+sUckT8XPkAplVc1fOkk9rJhBXUCTwe/dfT0YfAnHDzn711Nj
         fJU7FZyPBZk35QuJiOHPyeTv/Tticy1rp0NCOhLGTubHeWhWAh2xEKD22n2iKmZqkDA3
         kZvnc7sIn8KQkcFgtI110JRFm889URQXrgg01NVwsg/QTGkxGcnW3kl3j0wNIaRJzTmi
         TYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9l5iWYC32c45NSx+NuKLzAKcOwrZzZ8GmpPgq17uhVY=;
        b=GFVkx3i87E4t9tzTXxqZxsR+NZUGKS6+ZlT0aiDXo40QCMOq5JjFkTGMHufDAGAOJ1
         EGfeDS/2jK7dvbeRQSVGXZJGWJR/MLoK7YiMynoCSaCh6qlrb8ycjAJf3zt0Ho53NWbq
         08P+Hipazk/lwoCjVSVc9kgxQ5m1zbbGe7exb24WxxGQFd4ZO6CHpaeIhOdtGht7/bOQ
         aZRMep//CC0t5WU7MLvDinKCfM0qwqNiKfu1RV32I88WgZccS91xkq2DerLBls5ISBaA
         PwgB2fig8PFDzB0zBGNU+sJgLfvMEGzrkb77X3D93jn5ODGokabBqEYj1SH+OmN8WHVa
         aCvw==
X-Gm-Message-State: AOAM532MQPsATRj/9iOS77sUTjtkmJn+y2MakEWVBXcqlEbdfvJ1nK6J
        +/AstxMj6cz5gpPCeGPfQPgIQA==
X-Google-Smtp-Source: ABdhPJwmH1wRvO8sDWYSE3+UlD8hzh47lCTq0NAvsz1o9F6JPcEQkprIEzOjy4uG/1nYcF0C2IvN/Q==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr9062679ejc.605.1650738284337;
        Sat, 23 Apr 2022 11:24:44 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm2358159edb.39.2022.04.23.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 11:24:43 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/pm: fix false positive kmemleak report in msr_build_context()
Date:   Sat, 23 Apr 2022 20:24:10 +0200
Message-Id: <20220423182410.1841114-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume"),
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

It is easy to reproduce it on my side:

  - boot the VM with a debug kernel config (see the 'Closes:' tag)
  - wait ~1 minute
  - start a kmemleak scan

It seems kmemleak has an issue with the array allocated in
msr_build_context(). This array is assigned to a pointer in a static
structure (saved_context.saved_msrs->array): there is no leak then.

A simple fix for this issue would be to use kmemleak_no_leak() but Mat
noticed that the root cause here is alignment within the packed 'struct
saved_context' (from suspend_64.h). Kmemleak only searches for pointers
that are aligned (see how pointers are scanned in kmemleak.c), but
pahole shows that the saved_msrs struct member and all members after it
in the structure are unaligned:

  struct saved_context {
    struct pt_regs             regs;                 /*     0   168 */
    /* --- cacheline 2 boundary (128 bytes) was 40 bytes ago --- */
    u16                        ds;                   /*   168     2 */
    u16                        es;                   /*   170     2 */
    u16                        fs;                   /*   172     2 */
    u16                        gs;                   /*   174     2 */
    long unsigned int          kernelmode_gs_base;   /*   176     8 */
    long unsigned int          usermode_gs_base;     /*   184     8 */
    /* --- cacheline 3 boundary (192 bytes) --- */
    long unsigned int          fs_base;              /*   192     8 */
    long unsigned int          cr0;                  /*   200     8 */
    long unsigned int          cr2;                  /*   208     8 */
    long unsigned int          cr3;                  /*   216     8 */
    long unsigned int          cr4;                  /*   224     8 */
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

By moving 'misc_enable_saved' to the end of the struct declaration,
'saved_msrs' fits in before the cacheline 4 boundary and the kmemleak
warning goes away.

The comment above the 'saved_context' declaration says to check
wakeup_64.S file and __save/__restore_processor_state() if the struct is
modified: it looks like it's the members before 'misc_enable' that must
be carefully placed.

At the end, the false positive kmemleak report is due to a limitation
from kmemleak but that's always good to avoid unaligned member for
optimisation purposes.

Please note that it looks like this issue is not new, e.g.

  https://lore.kernel.org/all/9f1bb619-c4ee-21c4-a251-870bd4db04fa@lwfinger.net/
  https://lore.kernel.org/all/94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de/

But on my side, msr_build_context() is only used since:

  commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume").

Others probably have the same issue since:

  commit 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume"),

Hence the 'Fixes' tag here below to help with the backports.

Fixes: 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/268
Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 arch/x86/include/asm/suspend_32.h |  2 +-
 arch/x86/include/asm/suspend_64.h | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 7b132d0312eb..a800abb1a992 100644
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
index 35bb35d28733..bb7023dbf524 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -14,9 +14,13 @@
  * Image of the saved processor state, used by the low level ACPI suspend to
  * RAM code and by the low level hibernation code.
  *
- * If you modify it, fix arch/x86/kernel/acpi/wakeup_64.S and make sure that
- * __save/__restore_processor_state(), defined in arch/x86/kernel/suspend_64.c,
- * still work as required.
+ * If you modify it before 'misc_enable', fix arch/x86/kernel/acpi/wakeup_64.S
+ * and make sure that __save/__restore_processor_state(), defined in
+ * arch/x86/kernel/suspend_64.c, still work as required.
+ *
+ * Because the structure is packed, make sure to avoid unaligned members. For
+ * optimisations purposes but also because tools like Kmemleak only search for
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
-- 
2.34.1

