Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD34D90EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbiCOAME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244248AbiCOAMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:12:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D19C2DA9A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=eCpP1iW/jtoz0bKchozNJkBQv1g6tIp2uQhpL5P71Hg=; b=j1ean3W6r1CCv8EjVPLBCYaxbu
        WjTTFCLkKPRvRh72mTxTyhyp8VnRkj+i4s6+EJRPhWb2hSDJ+4bWAcd2Bsk+vC6u1TTkMVZ0N4PAH
        16C6fsEQw7eqw8UY+dIMAFDaFsKzC7EgmjsTkZeA3905T3kW2SuMmjA9o1ZHK8KNTK+hRvu143/v0
        J8/MLkgaXKtm4cA0+wiaNvNLgMvMbei8QdTckvRDH1o6T4qFZbhKfHJBygPjg2C4ebIMUeZYWveR3
        Lu9SbbPUmEFvLRKsKRpNZZ4hfXrnClyrZ/bt+9G0LMaqY37hmdWEg7aTq4kb24DS2lMZTTyt5jRHM
        QQind9tg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTum0-007GMw-93; Tue, 15 Mar 2022 00:10:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86, amd: modify the control_va_addr_alignment __setup handler
Date:   Mon, 14 Mar 2022 17:10:45 -0700
Message-Id: <20220315001045.7680-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up control_va_addr_alignment():

a. Make '=' required instead of optional (as documented).
b. Print a warning if an invalid option value is used.
c. Return 1 from the __setup handler when an invalid option value is
   used. This prevents the kernel from polluting init's (limited)
   environment space with the entire string.

Fixes: dfb09f9b7ab0 ("x86, amd: Avoid cache aliasing penalties on AMD family 15h")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/sys_x86_64.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- lnx-517-rc8.orig/arch/x86/kernel/sys_x86_64.c
+++ lnx-517-rc8/arch/x86/kernel/sys_x86_64.c
@@ -68,9 +68,6 @@ static int __init control_va_addr_alignm
 	if (*str == 0)
 		return 1;
 
-	if (*str == '=')
-		str++;
-
 	if (!strcmp(str, "32"))
 		va_align.flags = ALIGN_VA_32;
 	else if (!strcmp(str, "64"))
@@ -80,11 +77,11 @@ static int __init control_va_addr_alignm
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
