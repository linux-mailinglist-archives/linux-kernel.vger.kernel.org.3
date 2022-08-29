Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494615A5356
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiH2Rin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Ril (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:38:41 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6519A9DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:38:40 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jy14so1052335qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jmKeAtPXOcd+yShd8sCQiTVBynSMhTtxly66Ju96lv0=;
        b=Edq7x/9HKggVb6ESM6Fh0IdGrVve6UXc3lit7QZ14e+bwTxbhlata4cxxxkxf6c+/s
         u+b98kXwmG+eT0FVKLryUnVdVbZwozkLjKDA6REkUaVd7yFB9zljSTHCg0u+9oLy5tGb
         AJLZIj81V5BseUOsetCz4vftiASSe3l8woafCPt0KJ+5S5JETp3p8y+PoMYKss+pG1oa
         Erf7bAeSSGC2SAUPi+WkBc2oqlqiM0jr4rJmad7Zz963S0vEnHhEJkQ5/QCrzFOm96Jp
         +QMKMOuIyFW9tL7eyDkyfy64xt/pdBuuZfZUgLKGe7dSnb43NGrhurUgC11hTv8Ht2D7
         D+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jmKeAtPXOcd+yShd8sCQiTVBynSMhTtxly66Ju96lv0=;
        b=deoBCPwR66C8pDfX2Z+QZX1yeAReD6ogQjsY3eoUzkWZRf1mgHAXyjBBjbh3196iP1
         0qdUBzlzty2JV9FmBSJPqGLLvGHyFj6JzZhkfT3TrnWzzc/78melktnHPw+inrXbLS2+
         RoLuZ1GSL+m11tvMVA9qN/vEqdrXZwbsWNpNcKctiE+FBpOFFlanSfLxiNKFTm1xaOP2
         R8I6jE8uYRvXzohnKxBqenvua4u5vmA7XBJebdLAm2IDIJRQNDGGiNPKSOWKb5hdDDkv
         xGUP4OmqmO5DZNOgEjCLIeiMHW6/KkaLcAyx8I9tTFejllr+u0izd+3tqZtNxqMMkOfv
         sjVg==
X-Gm-Message-State: ACgBeo2OCywnMO3zsP8Woclq+e0Lw/xqHYAu4IvGTVdzioeWeAVgy8z5
        ZcsFwpBA+TQK8pwAAe3zDsQ=
X-Google-Smtp-Source: AA6agR6bnU0ltyY9R5eQpQfqad8/YbId9SHWXpBqe7WhCmE30HHPxB+cGqXxJza4ZsaU7y6v78oRyA==
X-Received: by 2002:ad4:5e8a:0:b0:496:b694:9ca7 with SMTP id jl10-20020ad45e8a000000b00496b6949ca7mr11797521qvb.80.1661794719809;
        Mon, 29 Aug 2022 10:38:39 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a288800b006bb7ccf6855sm6543583qkp.76.2022.08.29.10.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:38:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     soc@kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        krzysztof.kozlowski@linaro.org, arnd@arndb.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        william.zhang@broadcom.com, anand.gore@broadcom.com
Subject: [PATCH v2 1/2] arm64: Kconfig.platforms: Re-organized Broadcom menu
Date:   Mon, 29 Aug 2022 10:38:28 -0700
Message-Id: <20220829173830.3567047-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829173830.3567047-1-f.fainelli@gmail.com>
References: <20220829173830.3567047-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are now multiple Broadcom SoCs supported so group them under their
own menu such that the selection is visually more appealing and we can
easily add new platforms there in the future. This allows us to move
ARCH_BRCMSTB back to its siblings.

No functional changes introduced.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/Kconfig.platforms | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 74e9e9de3759..748f9ac4d775 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -33,6 +33,11 @@ config ARCH_APPLE
 	  This enables support for Apple's in-house ARM SoC family, starting
 	  with the Apple M1.
 
+menuconfig ARCH_BCM
+	bool "Broadcom SoC Support"
+
+if ARCH_BCM
+
 config ARCH_BCM2835
 	bool "Broadcom BCM2835 family"
 	select TIMER_OF
@@ -73,6 +78,16 @@ config ARCH_BCMBCA
 	  This enables support for Broadcom BCA ARM-based broadband chipsets,
 	  including the DSL, PON and Wireless family of chips.
 
+config ARCH_BRCMSTB
+	bool "Broadcom Set-Top-Box SoCs"
+	select ARCH_HAS_RESET_CONTROLLER
+	select GENERIC_IRQ_CHIP
+	select PINCTRL
+	help
+	  This enables support for Broadcom's ARMv8 Set Top Box SoCs
+
+endif
+
 config ARCH_BERLIN
 	bool "Marvell Berlin SoC Family"
 	select DW_APB_ICTL
@@ -87,14 +102,6 @@ config ARCH_BITMAIN
 	help
 	  This enables support for the Bitmain SoC Family.
 
-config ARCH_BRCMSTB
-	bool "Broadcom Set-Top-Box SoCs"
-	select ARCH_HAS_RESET_CONTROLLER
-	select GENERIC_IRQ_CHIP
-	select PINCTRL
-	help
-	  This enables support for Broadcom's ARMv8 Set Top Box SoCs
-
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
-- 
2.25.1

