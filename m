Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7863C51A589
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353022AbiEDQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiEDQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:32:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3163BE2A;
        Wed,  4 May 2022 09:28:39 -0700 (PDT)
Date:   Wed, 04 May 2022 16:28:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651681718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1nhnUez3WutfniW4uOZh+IkzgM6frf+TCfMadffiaI=;
        b=Ro4XiDXUnhs7V4iY6YrhGx9YioqDDpLREeR4sPTMjmYYGcnbrBP5DCLXqmD53Lke6cjzR5
        RYTeWHEsOTm9TCUGZ9Q1wdFkEABfJR56timyoOmPV7pfBECvSfwb3B64g2haQ2hNPJknEO
        0bDwiXl1d9AaBgiCb/pkFlUTQP6AcmvToBhOZ2+SeYHDSIXoTRaOjjlhUor1YhLlrPWObl
        3YPj6hXwjyfrMzCRnj+9mg2mYtSrCxY0gJTpkOccNj9i2GyW48F9CUAjsESmfC6q48xNOU
        XOe0SrxHV2uha+3kg64GSbR3GLn3V3lPC/+dejm75Bh4j970KZfCZRBaHAPGMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651681718;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1nhnUez3WutfniW4uOZh+IkzgM6frf+TCfMadffiaI=;
        b=mLPJHLekMIXXwRv5w16tInYRDcfqGujR5SSUdl25tP+RPYcRm9TWjZbWWWNu3Z6uLy/ku9
        A/FxUaSBmUHA7WDA==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/mm: Cleanup the control_va_addr_alignment()
 __setup handler
Cc:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru>
References: <64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru>
MIME-Version: 1.0
Message-ID: <165168171687.4207.3726639368956620183.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     1ef64b1e89e6d4018da46e08ffc32779a31160c7
Gitweb:        https://git.kernel.org/tip/1ef64b1e89e6d4018da46e08ffc32779a31160c7
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Mon, 14 Mar 2022 17:10:45 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 04 May 2022 18:20:42 +02:00

x86/mm: Cleanup the control_va_addr_alignment() __setup handler

Clean up control_va_addr_alignment():

a. Make '=' required instead of optional (as documented).
b. Print a warning if an invalid option value is used.
c. Return 1 from the __setup handler when an invalid option value is
   used. This prevents the kernel from polluting init's (limited)
   environment space with the entire string.

Fixes: dfb09f9b7ab0 ("x86, amd: Avoid cache aliasing penalties on AMD family 15h")
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Link: https://lore.kernel.org/r/20220315001045.7680-1-rdunlap@infradead.org
---
 arch/x86/kernel/sys_x86_64.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 660b788..8cc653f 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -68,9 +68,6 @@ static int __init control_va_addr_alignment(char *str)
 	if (*str == 0)
 		return 1;
 
-	if (*str == '=')
-		str++;
-
 	if (!strcmp(str, "32"))
 		va_align.flags = ALIGN_VA_32;
 	else if (!strcmp(str, "64"))
@@ -80,11 +77,11 @@ static int __init control_va_addr_alignment(char *str)
 	else if (!strcmp(str, "on"))
 		va_align.flags = ALIGN_VA_32 | ALIGN_VA_64;
 	else
-		return 0;
+		pr_warn("invalid option value: 'align_va_addr=%s'\n", str);
 
 	return 1;
 }
-__setup("align_va_addr", control_va_addr_alignment);
+__setup("align_va_addr=", control_va_addr_alignment);
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
