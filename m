Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B7349756D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiAWT6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:58:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38934 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbiAWT6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:58:08 -0500
Date:   Sun, 23 Jan 2022 19:58:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642967887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stwUS8phOi9nAVfCLaOIDX7Wenctdg5uwjwHKKU9RC0=;
        b=NsgMxzyYwujMK1B7c5UvvnlyvMebVdVwqUGedjLVCXYVMZO3vaPvSMGf1b1Fbq6Nc31Q+G
        R/JAHDZduFtgQZtgfGK1Khp3f7lT3y41qwee8deEKwXxAUKvoh+oyHz6HjAYj+4jTO1hvT
        k6h8v8/7Re+NHCYcN990MM9Z0rarHS1tZkiyNlxQyrtr/TiSccqaBtgSi/JmURd/tXg2rC
        9AtDFABB9qP+QeNFdosgz1pYo9849A+CwNUd8t9ChPIDjERQVh1IsqCtjGEaMpO6aDd8Q2
        BAN0SR6t+lptbnn68a5y8gEmSnBb3VZIdBUvIpOglBsX0GqOIHvtBUU99OJFAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642967887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stwUS8phOi9nAVfCLaOIDX7Wenctdg5uwjwHKKU9RC0=;
        b=LMdtwoE904fiTt5JbI6EaV2MsE42kXp+DjHFbk2cOjI13gAa+jFVbuNvxILdeqVc16ppyl
        sUWFsgu4Bg58AnAg==
From:   "tip-bot2 for David Hildenbrand" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/Kconfig: Select ARCH_SELECT_MEMORY_MODEL only if
 FLATMEM and SPARSEMEM are possible
Cc:     David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210929144321.50411-1-david@redhat.com>
References: <20210929144321.50411-1-david@redhat.com>
MIME-Version: 1.0
Message-ID: <164296788648.16921.15761548146550713290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     4eda2bc3431ebe5c8361580877a4666d10ea28a7
Gitweb:        https://git.kernel.org/tip/4eda2bc3431ebe5c8361580877a4666d10ea28a7
Author:        David Hildenbrand <david@redhat.com>
AuthorDate:    Wed, 29 Sep 2021 16:43:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 23 Jan 2022 20:52:16 +01:00

x86/Kconfig: Select ARCH_SELECT_MEMORY_MODEL only if FLATMEM and SPARSEMEM are possible

x86-64 supports only CONFIG_SPARSEMEM; there is nothing users can select.
So enable the memory model selection (via CONFIG_ARCH_SELECT_MEMORY_MODEL)
only if both, SPARSEMEM and FLATMEM are possible, which isn't the case
on x86-64.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20210929144321.50411-1-david@redhat.com
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ebe8fc7..a7e0bf4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1637,7 +1637,7 @@ config ARCH_SPARSEMEM_DEFAULT
 
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
-	depends on ARCH_SPARSEMEM_ENABLE
+	depends on ARCH_SPARSEMEM_ENABLE && ARCH_FLATMEM_ENABLE
 
 config ARCH_MEMORY_PROBE
 	bool "Enable sysfs memory/probe interface"
