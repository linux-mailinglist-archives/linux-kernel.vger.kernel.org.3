Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1181852BD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiEROQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiEROQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:16:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684CC62E2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:15:53 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9D2BB2222E;
        Wed, 18 May 2022 16:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652883350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SSJAzEBLTF3cVsOUo7/c6hXKoi6NTUJx6rBT9EjOfwk=;
        b=FgO7IsmjnS6x1oPNQ1KEGDU2vZvEMPA0z7mSqHidCrBEBT8XMJDzDLLZPQFSOQGvLfA/Hr
        Vyc9GHX4vbYSIVvYbrrHaGYlJ/AFMLEIHFq6QOaD4LHlEyBk32J/rTI+2FpAneA46eoWNR
        vaOjVpk5RM4nZB9IbZqOfpu6zWrBnV8=
From:   Michael Walle <michael@walle.cc>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] ARM: configs: enable support for Kontron KSwitch D10
Date:   Wed, 18 May 2022 16:15:42 +0200
Message-Id: <20220518141542.531148-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kontron KSwitch D10 is based on a Microchip LAN9668 SoC. It is a
managed ethernet network switch with either 8 copper ports or 6 copper
ports and 2 SFP cages.

Enable all required kconfig symbols, either as module where possible or
compiled-in where it is not possible.

Signed-off-by: Michael Walle <michael@walle.cc>
---
FWIW, there will be a board in our lab in KernelCI using this config.

 arch/arm/configs/multi_v7_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 547918170f1f..a858ba971340 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -17,6 +17,7 @@ CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
 CONFIG_SOC_SAMA7G5=y
+CONFIG_SOC_LAN966=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_CYGNUS=y
 CONFIG_ARCH_BCM_HR2=y
@@ -277,6 +278,7 @@ CONFIG_MV643XX_ETH=y
 CONFIG_MVNETA=y
 CONFIG_PXA168_ETH=m
 CONFIG_KS8851=y
+CONFIG_LAN966X_SWITCH=m
 CONFIG_R8169=y
 CONFIG_SH_ETH=y
 CONFIG_SMSC911X=y
@@ -287,6 +289,7 @@ CONFIG_TI_CPSW=y
 CONFIG_TI_CPSW_SWITCHDEV=y
 CONFIG_TI_CPTS=y
 CONFIG_XILINX_EMACLITE=y
+CONFIG_SFP=m
 CONFIG_BROADCOM_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MARVELL_PHY=y
@@ -294,6 +297,7 @@ CONFIG_AT803X_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
 CONFIG_USB_BRCMSTB=m
+CONFIG_MDIO_MSCC_MIIM=m
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_RTL8152=m
 CONFIG_USB_LAN78XX=m
@@ -430,6 +434,7 @@ CONFIG_I2C_CROS_EC_TUNNEL=m
 CONFIG_I2C_SLAVE_EEPROM=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=m
+CONFIG_SPI_ATMEL_QUADSPI=m
 CONFIG_SPI_BCM2835=y
 CONFIG_SPI_BCM2835AUX=y
 CONFIG_SPI_CADENCE=y
@@ -459,6 +464,8 @@ CONFIG_SPMI=y
 CONFIG_PTP_1588_CLOCK=y
 CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_STMFX=y
+CONFIG_PINCTRL_MICROCHIP_SGPIO=y
+CONFIG_PINCTRL_OCELOT=y
 CONFIG_PINCTRL_PALMAS=y
 CONFIG_PINCTRL_OWL=y
 CONFIG_PINCTRL_S500=y
@@ -517,6 +524,7 @@ CONFIG_CHARGER_TPS65090=y
 CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ASPEED=m
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_LAN966X=m
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_SENSORS_NTC_THERMISTOR=m
@@ -1018,6 +1026,7 @@ CONFIG_CROS_EC_SPI=m
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_RK808=m
 CONFIG_COMMON_CLK_SCMI=y
+CONFIG_COMMON_CLK_LAN966X=y
 CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_CLK_RASPBERRYPI=y
 CONFIG_COMMON_CLK_QCOM=y
@@ -1145,6 +1154,7 @@ CONFIG_PWM_SUN4I=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
 CONFIG_KEYSTONE_IRQ=y
+CONFIG_RESET_MCHP_SPARX5=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_HIX5HD2_SATA=y
@@ -1152,6 +1162,7 @@ CONFIG_PHY_BERLIN_SATA=y
 CONFIG_PHY_BERLIN_USB=y
 CONFIG_PHY_BRCM_USB=m
 CONFIG_PHY_MMP3_USB=m
+CONFIG_PHY_LAN966X_SERDES=m
 CONFIG_PHY_CPCAP_USB=m
 CONFIG_PHY_QCOM_APQ8064_SATA=m
 CONFIG_PHY_QCOM_USB_HS=y
-- 
2.30.2

