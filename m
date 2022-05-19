Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E426D52D6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiESPEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiESPEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:04:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC9EBAA0;
        Thu, 19 May 2022 08:03:15 -0700 (PDT)
Received: from zn.tnic (p200300ea97465796329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5796:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8847D1EC026E;
        Thu, 19 May 2022 17:03:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652972590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yvKb4IzN3NrjS2AQS+ImmzuX/ff1+9+b8fevzzkU7Ig=;
        b=FLB4Wuf55Lc4bCmExyixxbJkiLXZSY+MeSuvOC5RPGKQ+S2UYTU+HbHulu3DLm0dfqgL3N
        lQzc7OQlmxCp5K9bqwLSyn9M+8XWv/Ek2oOoV//M2MFzOdLyXg9piMchyNooxJsCs3K0m5
        rkIERLMRVjyqkNSZjCr1dHc/y8JGOU4=
Date:   Thu, 19 May 2022 17:03:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/microcode: Add explicit CPU vendor dependency
Message-ID: <YoZcLsqkxJ+VGf0W@zn.tnic>
References: <20220518202934.730a8aba@canb.auug.org.au>
 <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
 <YoVlwN/IeVXoMaq1@zn.tnic>
 <df5ed1d0-6304-89b8-ad68-0cf6a59d8614@infradead.org>
 <YoVzUxSwhoim9TOX@zn.tnic>
 <65f17e84-83e4-c33a-1718-fbb5841cef46@infradead.org>
 <YoZaZ+HVyjKrwtSQ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoZaZ+HVyjKrwtSQ@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add a explicit dependency to the respective CPU vendor so that the
respective microcode support for it gets built only when that support is
enabled.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..7ba627c60504 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1313,7 +1313,7 @@ config MICROCODE
 
 config MICROCODE_INTEL
 	bool "Intel microcode loading support"
-	depends on MICROCODE
+	depends on CPU_SUP_INTEL && MICROCODE
 	default MICROCODE
 	help
 	  This options enables microcode patch loading support for Intel
@@ -1325,7 +1325,7 @@ config MICROCODE_INTEL
 
 config MICROCODE_AMD
 	bool "AMD microcode loading support"
-	depends on MICROCODE
+	depends on CPU_SUP_AMD && MICROCODE
 	help
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
