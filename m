Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E784C7BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiB1V3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiB1V3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:29:37 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB7B12F177
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:28:56 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 40675 invoked from network); 28 Feb 2022 22:28:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646083734; bh=Avryt45+8M17xhEl09lOmqkhM7PC9jo6k3MZepXUpfo=;
          h=From:To:Cc:Subject;
          b=olqmbWi2qe/HOGpZZ+kST3X2Ez5HQFkhBn4NNUzNv6B8DOiq6jENGpKhglEvLEATK
           J/E2C2Ge/rytb0IivgMNvhKI3Vjoei/BMCMTP8XTMg4snEYG267HaMThJOwGVc9AXL
           IuvAmXpZV5jKl+gXdhk5vdKg3oeJ9DxkdGH4jKwU=
Received: from aafa139.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.130.139])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 28 Feb 2022 22:28:53 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH 03/10] x86/Kconfig: always enable ARCH_SPARSEMEM_ENABLE
Date:   Mon, 28 Feb 2022 22:28:19 +0100
Message-Id: <20220228212826.27080-4-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228212826.27080-1-mat.jonczyk@o2.pl>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: a95f45f7b50b5ce6961c91475245914c
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [ESMU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that (X86_64 || X86_32) is always true on x86.

This logical OR directive was introduced in
commit 6ea3038648da ("arch/x86: remove depends on CONFIG_EXPERIMENTAL")
probably by a trivial mistake.

Fixes: 6ea3038648da ("arch/x86: remove depends on CONFIG_EXPERIMENTAL")
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 64d760a2b81a..727fd3998022 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1641,7 +1641,6 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
 
-- 
2.25.1

