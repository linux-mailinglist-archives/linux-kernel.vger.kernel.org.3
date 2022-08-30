Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB55F5A5CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiH3H1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3H1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:27:51 -0400
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 00:27:50 PDT
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2BE9E100
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:27:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5A8F55801DF;
        Tue, 30 Aug 2022 03:21:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 30 Aug 2022 03:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661844073; x=1661844673; bh=26pE8ggmkg
        tQr3SPAdJrNTBLJZBDL+qDeHjv+0CKWZM=; b=nNx/iiMA6vIenqhBL2PaR8/yEC
        ug1ymFWFeyKjENRQfPsFr2yPsxz7JEwjMYKF3a2dmh5XICnN6kl9xO+zRtt+vzMB
        Op2BWmedtk9ruMZiwPwHgy/1XriTo9NFdWvHoefPCzmzmlbBqzxprwUkq2t97Nqa
        nQQsKoBzZDUUrzRyYjNWTVrBTRJvRu+m7s8dxFGKoQRvn827NLAANABDMn+A6+nP
        /4a4G3uqz4Ec7EsZMfoXsbh3wf9KV8ZotbGJ31o90EbtV4RmaQ+Muw4gvif5fY7i
        A7ndKR80XHwMz60Mndgsne9e+02zGhYRA7YoJ6gltMgQez1rXu2wsrQxmZfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1661844073; x=1661844673; bh=26pE8ggmkgtQr3SPAd
        JrNTBLJZBDL+qDeHjv+0CKWZM=; b=WzjER9xPj4EIBxerPBYULbXWV5mrji80ke
        4waShHmv92FoL4RHwcUekLX/TbpdRQtE/1+HPlik9x+1ApzGTsKE0rneU6nsJDpd
        LSpQn9oZsb6IYHTGfQqYJK2LxyuKk+M6+jSxB289c9/euzj/v3g/abTTPl+K76XV
        0dM7pq3mjfpLh63ixf7M0gf2MDnQY/ZgWnTxWrB/3i5WRZzsxpLx93XEK0AMmg5M
        JVjR42eJDdu6y3O3iPARvoBsG4UuLLSqFkl44sHpHVtVLzeyRKMeUNlR9106KofO
        YxvXgMgsj77lwOy64trUeaTUgaWpWcpxB3YEfTwMkbOLsb2dIvgA==
X-ME-Sender: <xms:aLoNY3cHube44ZjzyIRjh6oAQ70hjvjsuKLC729xt3rcdu075SWN8A>
    <xme:aLoNY9MzJ9LJlBrLCK_-mfSFxLFkp4VogkJ1vHT0oyaMs6D9--Qryj4TjJoMAMSkr
    TRAMIRIGH6yrQVUIcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekvddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:aLoNYwj7JGtiiV2GlZAA9uSxEoYYj36tLcWsEMfdabg03U-L0XeO_g>
    <xmx:aLoNY49-i3gZjJnQCu-LuJwkVjdR5YwMFcF1-TpuxvnINnMBFq83UA>
    <xmx:aLoNYzshMZF4SD5qofXc0FhMCo-85ccOt1lTJfMN48kJbtljZIQtfw>
    <xmx:aboNY8PV0nOhd5OWmaZTNIMINI9Eoc7lB2dXy8skE7EW7rAFlMfqKfPZLVI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2A3CAB60083; Tue, 30 Aug 2022 03:21:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <63a630b7-9068-40f9-b7f7-d9a08f74ed13@www.fastmail.com>
In-Reply-To: <CAK8P3a1PQjR2sv2rar6mFY9g4PkteAC+zgRUvnr04DETJX3K9w@mail.gmail.com>
References: <20220818145616.3156379-1-arnd@kernel.org>
 <20220818145616.3156379-5-arnd@kernel.org>
 <CACRpkdbFkV1T+K9wKDyODkcwu=nhbV+4_JF=YTaA5ad_w4ggbw@mail.gmail.com>
 <CAK8P3a1PQjR2sv2rar6mFY9g4PkteAC+zgRUvnr04DETJX3K9w@mail.gmail.com>
Date:   Tue, 30 Aug 2022 09:20:51 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Arnd Bergmann" <arnd@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King" <linux@armlinux.org.uk>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, "Sekhar Nori" <nsekhar@ti.com>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>
Subject: [PATCH] ARM: fix XIP_KERNEL dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_XIP_KERNEL does not work with any option that involves patching
the read-only kernel .text.

Since at least CONFIG_SMP_ON_UP is required in certain configurations,
flip the dependency to always allow the .text patching options but make
XIP_KERNEL have the dependency instead.

This is a prerequisite for allowing CONFIG_ARCH_MULTIPLATFORM to
be disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
forgot to send this yesterday, replaces the CPU_v6 dependency patch

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3066ce82cffc..2d94e53037ec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -246,7 +246,7 @@ config ARCH_MTD_XIP
 config ARM_PATCH_PHYS_VIRT
 	bool "Patch physical to virtual translations at runtime" if EMBEDDED
 	default y
-	depends on !XIP_KERNEL && MMU
+	depends on MMU
 	help
 	  Patch phys-to-virt and virt-to-phys translation functions at
 	  boot and module load time according to the position of the
@@ -975,7 +975,7 @@ config SMP
 
 config SMP_ON_UP
 	bool "Allow booting SMP kernel on uniprocessor systems"
-	depends on SMP && !XIP_KERNEL && MMU
+	depends on SMP && MMU
 	default y
 	help
 	  SMP kernels contain instructions which fail on non-SMP processors.
@@ -1224,7 +1224,7 @@ config THUMB2_KERNEL
 
 config ARM_PATCH_IDIV
 	bool "Runtime patch udiv/sdiv instructions into __aeabi_{u}idiv()"
-	depends on CPU_32v7 && !XIP_KERNEL
+	depends on CPU_32v7
 	default y
 	help
 	  The ARM compiler inserts calls to __aeabi_idiv() and
@@ -1619,6 +1619,7 @@ endchoice
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
 	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !SMP_ON_UP && !ARM_PATCH_IDIV && !ARM_PATCH_PHYS_VIRT
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
