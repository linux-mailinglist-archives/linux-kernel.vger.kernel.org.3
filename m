Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2357213F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiGLQn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiGLQnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:43:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F10D6CDD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:42:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so8780131pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38qVWGdU7HKJkL6IeCHeQKdX+0uOfPHorBf46EI1KJs=;
        b=nVBSoT3GWPU4E9j6+KwPb2GXTEMNqck6Lio7zEkhgrmsW4lsa0rlm9nUQaVaF0XaIp
         bFiKfAHlnEMwbcNJjb/ZIBNaBcWiR13sXTVSW3l2G72ri0vIBrdmz0Wqf+gSU6oq99+y
         SNxe+8FbAENRA35QJLfQlf+JA7ii4Ka7N98XKEc0NFaxeUxN2h/TS4mZ/LkUVTJGw6eF
         JpTCyzwcrbDR1NUGVdsOvZtY+jiJbqLw1NI1HAJnQAWCaG8oWrwls3appxJ40EPz6yLc
         3wGiuSsiSAb3V+cjwx+mSoB1DDpycEQr2k/CzCKj/bpJ8hkToVo9QxAgrCQhmodDenXK
         VSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38qVWGdU7HKJkL6IeCHeQKdX+0uOfPHorBf46EI1KJs=;
        b=hlAn6/VeKp/X860vwQnN2ssXHwvXgayONhYtjzA/ZzM1D7ScMln5ZjEQcrxvvt9d0a
         5601Jyiw+6tCWt8XZd3Li1uY/bo2r812EWKQA+vvrNeIKP7KliCb6dhnxcfqlFfuP970
         l9q8ntKtYaJay6LNtdJ8cnNcf208k1PpEAuRNb16VsQAX03t2VUPtMOZgUN7xQ96tPR2
         6/nX/xKRxynGNb4r+IXXxcIOpwmEYqOgpYigRTvZV+JB9OQ2o7x7jVVO9VUKE3ZFpgfx
         o50NBPgUpbmMVLoxepCTIbOIkbbm9HqfxPNXbdjW+LDzT9qm6oYhM9PpAKxX+ID1J7TC
         opig==
X-Gm-Message-State: AJIora/Ygx4JL+JR6vQKPVoN/IurtMCAy3VVTXGyXLroE5UokQ3GgKw8
        4zCx8jPjKCi0SZGORMYmL3E=
X-Google-Smtp-Source: AGRyM1vM/uufGxIf0o5rDefUv4yeq7W+vjifZQYSEdFtEs1ZztI71WgQjYPptMY8+ctn++udD323Mw==
X-Received: by 2002:a17:90b:4ad2:b0:1f0:3395:6427 with SMTP id mh18-20020a17090b4ad200b001f033956427mr5166794pjb.93.1657644161878;
        Tue, 12 Jul 2022 09:42:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n5-20020a622705000000b005254c71df0esm7050562pfn.86.2022.07.12.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:42:40 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     soc@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        william.zhang@broadcom.com, krzysztof.kozlowski@linaro.org,
        anand.gore@broadcom.com, arnd@arndb.de, olof@lixom.net,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: Kconfig.platforms: Re-organized Broadcom menu
Date:   Tue, 12 Jul 2022 09:42:35 -0700
Message-Id: <20220712164235.40293-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Note this is based on "arm64: bcmbca: add arch bcmbca machine entry"

 arch/arm64/Kconfig.platforms | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 88ddc2e5b152..c8c15f611d4e 100644
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
@@ -72,6 +77,16 @@ config ARCH_BCMBCA
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
@@ -86,14 +101,6 @@ config ARCH_BITMAIN
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

