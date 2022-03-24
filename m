Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD434E6037
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348394AbiCXISb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbiCXIS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:18:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFF19BAD8;
        Thu, 24 Mar 2022 01:16:55 -0700 (PDT)
Date:   Thu, 24 Mar 2022 08:16:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648109813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QTxcOWxuZF08C7LwzQu1z3MgI4m/xWk8ZyLCOHh42dE=;
        b=Cx9/rJR2KN8BjXrQXkwy94qb/2mU0uyMFCAwoNpf6rcucAoRy/0lJHsbT958kxt80BnmhQ
        7S0JrpbWUsCuNfmOVwdwMDuxiMf3U8B8exBZ/ogk+4Rg1Y2/ONmpY+Ehuhdw39XBjt4WS2
        emSKQPjTlCr7YMCUrsQJBXR/GPe7+Pe6Jch+PUsic25BUpfMskNT/r7q3VoMx/XWvEZq11
        QXBsMi5hCzhkUOx13/j0be4rezo4ldItIiVoHCyLGdokgS9dcTZURE/sPkY4jeNnEjAlSx
        E5hrR2TDHsyCgybvwmeaCbvoeEmTG2U5kKZfAK46X4tNgtV8j5B8Fa89rJgnow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648109813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QTxcOWxuZF08C7LwzQu1z3MgI4m/xWk8ZyLCOHh42dE=;
        b=auqCzT6YcadE7TqnhYMsIlKFx2Bk4vpjBVlUtxPb9JZxCQ3P5jUcfCbgj6xG/XFl5qXvsV
        LBcW5OYZQ5M10rCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/defconfig: Enable WERROR
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YjsCpoRK7W4l6tSh@zn.tnic>
References: <YjsCpoRK7W4l6tSh@zn.tnic>
MIME-Version: 1.0
Message-ID: <164810981264.389.6376024733991867139.tip-bot2@tip-bot2>
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

Commit-ID:     b9080ba4a6ec56447f263082825a4fddb873316b
Gitweb:        https://git.kernel.org/tip/b9080ba4a6ec56447f263082825a4fddb873316b
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 23 Mar 2022 12:21:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Mar 2022 09:10:56 +01:00

x86/defconfig: Enable WERROR

To quote Linus:

  "EVERYBODY should have CONFIG_WERROR=y on at least x86-64 and other
   serious architectures, unless you have some completely random
   experimental (and broken) compiler.

New compiler warnings are not acceptable."

So this should make at least the most obvious and common ones not go
unnoticed.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/YjsCpoRK7W4l6tSh@zn.tnic
---
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 71124cf..4b20852 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -262,3 +262,4 @@ CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
 CONFIG_KALLSYMS_ALL=y
+CONFIG_WERROR=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 92b1169..38c52e4 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -258,3 +258,4 @@ CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
 CONFIG_KALLSYMS_ALL=y
+CONFIG_WERROR=y
