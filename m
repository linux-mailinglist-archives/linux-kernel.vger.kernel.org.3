Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF23502784
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351858AbiDOJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351817AbiDOJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:44:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D214AC046;
        Fri, 15 Apr 2022 02:42:24 -0700 (PDT)
Date:   Fri, 15 Apr 2022 09:42:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650015743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9+MlWfHo9/S6kJXuWo/hH/+hng49XBvdtfu0dGm548=;
        b=iphcZZckLezsEvEUUDub36z0aAdZ/OO0SYHKMPMIrkGlabbXmPYmQiWkcAN0Q6/YETic77
        nwHsAdaT9oyFPQhIcm+nyo4H/CEAHIcXj6gMkCfA5ow200DMFdTVrmzYa/V0y9Ovl0zA/M
        5tBljdsO2rXMts3xpG0bty2K2tb8zKjWpBxtqEeGwSGSc5iBYxzefEFGeCDYvdP18SFqzp
        QLl3F0tifaAEB2L93o1wLj2HGfXz+cwzD+OTr3dPAuZMmLZhyeIJh/fl/LSfjbXZvBgku/
        hM2/9uCP931bxx1HhCOiGM8LYyp3oGx0simpOX0KGQT2cZvlciO5Bk38DqkrTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650015743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9+MlWfHo9/S6kJXuWo/hH/+hng49XBvdtfu0dGm548=;
        b=mlTwPucv0yOMmeK33XfjAKyCS/l2nCJdaodErlgk5VtS25wHRxqwBGgbZBmxvwXUb4x+4o
        O0W6GG8i9sAWH4DQ==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/32: Simplify ELF_CORE_COPY_REGS
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220325153953.162643-2-brgerst@gmail.com>
References: <20220325153953.162643-2-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <165001574217.4207.12557873929669073141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f5d9283ecb33329073033029fe427155aa0abfb1
Gitweb:        https://git.kernel.org/tip/f5d9283ecb33329073033029fe427155aa0abfb1
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 25 Mar 2022 11:39:50 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 Apr 2022 15:42:59 +02:00

x86/32: Simplify ELF_CORE_COPY_REGS

GS is now always a user segment, so there is no difference between user
and kernel registers.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220325153953.162643-2-brgerst@gmail.com
---
 arch/x86/include/asm/elf.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 29fea18..cb0ff10 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -116,7 +116,7 @@ extern unsigned int vdso32_enabled;
  * now struct_user_regs, they are different)
  */
 
-#define ELF_CORE_COPY_REGS_COMMON(pr_reg, regs)	\
+#define ELF_CORE_COPY_REGS(pr_reg, regs)	\
 do {						\
 	pr_reg[0] = regs->bx;			\
 	pr_reg[1] = regs->cx;			\
@@ -128,6 +128,7 @@ do {						\
 	pr_reg[7] = regs->ds;			\
 	pr_reg[8] = regs->es;			\
 	pr_reg[9] = regs->fs;			\
+	savesegment(gs, pr_reg[10]);		\
 	pr_reg[11] = regs->orig_ax;		\
 	pr_reg[12] = regs->ip;			\
 	pr_reg[13] = regs->cs;			\
@@ -136,18 +137,6 @@ do {						\
 	pr_reg[16] = regs->ss;			\
 } while (0);
 
-#define ELF_CORE_COPY_REGS(pr_reg, regs)	\
-do {						\
-	ELF_CORE_COPY_REGS_COMMON(pr_reg, regs);\
-	pr_reg[10] = get_user_gs(regs);		\
-} while (0);
-
-#define ELF_CORE_COPY_KERNEL_REGS(pr_reg, regs)	\
-do {						\
-	ELF_CORE_COPY_REGS_COMMON(pr_reg, regs);\
-	savesegment(gs, pr_reg[10]);		\
-} while (0);
-
 #define ELF_PLATFORM	(utsname()->machine)
 #define set_personality_64bit()	do { } while (0)
 
