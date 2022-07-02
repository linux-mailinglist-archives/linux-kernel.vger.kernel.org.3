Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF309563F59
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiGBJyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiGBJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:54:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84A17A83;
        Sat,  2 Jul 2022 02:54:30 -0700 (PDT)
Date:   Sat, 02 Jul 2022 09:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656755668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBi6bQbKvUaG1O4BUv4JNGMVNSmPD8C92Xc4GOlGNDY=;
        b=CENnyoeHQDAfie+nrr00a+ordJlbXZ9B0KHDQiKw5qrHJWFcqgfC29tYl1eWBrRcC1o/Do
        frqrL+eSRCYckP2lZjoD4gglv8m6oxdAC/9gIMdQQFA3xROG2bvCGL0JuODChs5Cd8mHAM
        XmoydCw0De/MfMGTq17cku5sjBdAzyP5EkunaAaRwSQNPrfGDxLVcPt8em+OYQCfoTXMY1
        O8VoQIGlxwokv1+0KsB4RotgCJXoHhGReJP72mWg8YPNhQckd8SyXTZ2wzAeFqLAlAiR9q
        N0pse41NCBOZU27Wpll4mMdR2Vf/spTRjP5eIfasyot0Zju+34lIpC02QbTb4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656755668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBi6bQbKvUaG1O4BUv4JNGMVNSmPD8C92Xc4GOlGNDY=;
        b=Knz75Dk0ywrIFyTGGYJ382xepGOHZFlo+xjQDwHsGVwuQq6V1fJMx/4VI9AZag6iR8sqNZ
        4Yi5W4gJ+uykxlCQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: Fix .brk attribute in linker script
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220630071441.28576-4-jgross@suse.com>
References: <20220630071441.28576-4-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <165675566667.15455.2024070946112481051.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7e09ac27f43b382f5fe9bb7c7f4c465ece1f8a23
Gitweb:        https://git.kernel.org/tip/7e09ac27f43b382f5fe9bb7c7f4c465ece1f8a23
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 30 Jun 2022 09:14:41 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 01 Jul 2022 11:12:43 +02:00

x86: Fix .brk attribute in linker script

Commit in Fixes added the "NOLOAD" attribute to the .brk section as a
"failsafe" measure.

Unfortunately, this leads to the linker no longer covering the .brk
section in a program header, resulting in the kernel loader not knowing
that the memory for the .brk section must be reserved.

This has led to crashes when loading the kernel as PV dom0 under Xen,
but other scenarios could be hit by the same problem (e.g. in case an
uncompressed kernel is used and the initrd is placed directly behind
it).

So drop the "NOLOAD" attribute. This has been verified to correctly
cover the .brk section by a program header of the resulting ELF file.

Fixes: e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for older binutils")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20220630071441.28576-4-jgross@suse.com
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 81aba71..9487ce8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -385,7 +385,7 @@ SECTIONS
 	__end_of_kernel_reserve = .;
 
 	. = ALIGN(PAGE_SIZE);
-	.brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {
+	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
 		*(.bss..brk)		/* areas brk users have reserved */
