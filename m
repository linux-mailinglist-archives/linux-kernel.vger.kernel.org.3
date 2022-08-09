Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBF58D864
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbiHILut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbiHILuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:50:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D8E15FCB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:50:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t22so11452217pjy.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kOOdMCqFf2vHQIse3uLmGH4VNLU9Ww6hckbBKMi+bEA=;
        b=pVeoR7wqc1FYj6Cs2MjB8QDRTf+bQeOlo7HZd21fLYhnpgtelarQvPIsU86jFgGTuM
         vkEh7AfsnY9mhbIrMGiZUy9gLICLmds6l5/TOFXzQARlUAhgawFY0Y5xSxNqANVGY9Fh
         FVnxENTcQwfreMmPTP2EYO9vnuG+dir1trWFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kOOdMCqFf2vHQIse3uLmGH4VNLU9Ww6hckbBKMi+bEA=;
        b=QS8sDiK4C8GBVYAO8M5HV/Q4UXGYdKrHE5cQkN6OsCW6oLSeYz51V+wxm/WgB8TfLZ
         5399Ftjr4sAyB73XWrlKu6vamGChTbzDRr+gq7CS9DiUhopvtekfrK1DarMrKaAAAabP
         G4dJmkeeplGyvKepPCC7EtzcEqLE0Pe6c5m3pITYPwJrnHxQQMB93EoCxsWrNhKfiANB
         nbs14g2APJY6NerVvYSMSXuIbOlW7shjffKTEW8ydEzNfNG5GnEPXvsHqxfIQMUwxVtP
         xMM7Hm4fhDug3CJvZJ+fclZwahz2fc71tOfHPQiE+xjLtWKAB179dCOMZAHD6cu7J/sx
         b9Kg==
X-Gm-Message-State: ACgBeo1FWToTTChqSpA9sRsh3KlhXM65VkDWCKuCBAMnl/LXXCCpfA9P
        /5Xkc/7KVP46qTvxmCLk3heEiw==
X-Google-Smtp-Source: AA6agR5sgZW7V6P2n37l3umSHwRMu16Lrj/LUpnhjp2+CmUc1eJTUjhPRwTlg3uULnQKGKj/NhM/6g==
X-Received: by 2002:a17:90b:3e86:b0:1f5:2b4f:7460 with SMTP id rj6-20020a17090b3e8600b001f52b4f7460mr34379547pjb.97.1660045845130;
        Tue, 09 Aug 2022 04:50:45 -0700 (PDT)
Received: from localhost.localdomain ([183.83.136.224])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027d8a00b00170a757a191sm4516096plm.9.2022.08.09.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 04:50:44 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kumar Gala <galak@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>, shawn.guo@linaro.org,
        Maxime Ripard <maxime@cerno.tech>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] arm64: defconfig: Enable GPIO SYSCON, sync to savedefconfig
Date:   Tue,  9 Aug 2022 17:20:33 +0530
Message-Id: <20220809115033.693145-1-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver for SYSCON-based GPIOs and sync up the defconfig to
savedefconfig output.

Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d5b2d2dd4904..abfb77182528 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -80,7 +80,6 @@ CONFIG_RANDOMIZE_BASE=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
 CONFIG_ENERGY_MODEL=y
-CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_PSCI_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
@@ -178,10 +177,6 @@ CONFIG_NET_ACT_GATE=m
 CONFIG_QRTR_SMD=m
 CONFIG_QRTR_TUN=m
 CONFIG_CAN=m
-CONFIG_CAN_FLEXCAN=m
-CONFIG_CAN_RCAR=m
-CONFIG_CAN_RCAR_CANFD=m
-CONFIG_CAN_MCP251XFD=m
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
 # CONFIG_BT_LE is not set
@@ -368,6 +363,10 @@ CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
 CONFIG_VITESSE_PHY=y
+CONFIG_CAN_FLEXCAN=m
+CONFIG_CAN_RCAR=m
+CONFIG_CAN_RCAR_CANFD=m
+CONFIG_CAN_MCP251XFD=m
 CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_USB_PEGASUS=m
@@ -549,6 +548,7 @@ CONFIG_GPIO_MPC8XXX=y
 CONFIG_GPIO_MXC=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
+CONFIG_GPIO_SYSCON=y
 CONFIG_GPIO_UNIPHIER=y
 CONFIG_GPIO_VISCONTI=y
 CONFIG_GPIO_WCD934X=m
@@ -612,6 +612,7 @@ CONFIG_ARM_SBSA_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=m
+CONFIG_NPCM7XX_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_IMX_SC_WDT=m
 CONFIG_QCOM_WDT=m
@@ -624,7 +625,6 @@ CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_PM8916_WATCHDOG=m
 CONFIG_BCM2835_WDT=y
 CONFIG_BCM7038_WDT=m
-CONFIG_NPCM7XX_WATCHDOG=y
 CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_I2C=y
@@ -1032,7 +1032,6 @@ CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_COMMON_CLK_VC5=y
-CONFIG_COMMON_CLK_NPCM8XX=y
 CONFIG_COMMON_CLK_BD718XX=m
 CONFIG_CLK_RASPBERRYPI=m
 CONFIG_CLK_IMX8MM=y
-- 
2.25.1

