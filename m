Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28759850D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245461AbiHRN7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245454AbiHRN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5C67179;
        Thu, 18 Aug 2022 06:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 590C1616D6;
        Thu, 18 Aug 2022 13:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83D8C433C1;
        Thu, 18 Aug 2022 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831137;
        bh=b8vt69Qw477yM8JIOVSGHYEMcdgBcpySmH+QDCFvREI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muoubQR1vF3zI+qMAoLPrSRs/OGngZZcUC/I2h0qUVoxX3jGQq6Tt2unaA20wpQR3
         oq7OU5/MJxa98aD/+npZmPZt0eOPeUx0wxEyv3ueqr7ZC+9yq0eQiAEH+2r0CWnLBg
         BDeeVB1UsmpLI2rylEKG6mR1AG3xedJpdxVjCsJA8q/4yeup8LEehdwvIAB4AHhtmq
         ynasq1+AdOU2IcR+O74ErhRKMxgV4L5slBfWOu433t+xFvQf4Ex7Q4jYqFLSfNIFFr
         EBSXZ0vksPBaI8+klXRRUFfmTdKsDrgp/Rgp1DXaLIK3Asme3RPvWUH1FEMXS0Q18N
         nedEQcd+JW6Fw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Shannon Nelson <snelson@pensando.io>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 06/11] ARM: defconfig: drop CONFIG_PTP_1588_CLOCK=y
Date:   Thu, 18 Aug 2022 15:57:15 +0200
Message-Id: <20220818135737.3143895-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818135737.3143895-1-arnd@kernel.org>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

PTP support is now enabled by default for configurations with
ethernet support, so drop the redundant entries in defconfig
files.

Fixes: e5f31552674e ("ethernet: fix PTP_1588_CLOCK dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/keystone_defconfig  | 1 -
 arch/arm/configs/multi_v7_defconfig  | 1 -
 arch/arm/configs/omap2plus_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 97f958d55019..4a5b9adbf2a1 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -152,7 +152,6 @@ CONFIG_SPI=y
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
-CONFIG_PTP_1588_CLOCK=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b3669cf855b3..a523591798cb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -462,7 +462,6 @@ CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_SPI_XILINX=y
 CONFIG_SPI_SPIDEV=y
 CONFIG_SPMI=y
-CONFIG_PTP_1588_CLOCK=y
 CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_MICROCHIP_SGPIO=y
 CONFIG_PINCTRL_OCELOT=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 89cda0877c52..39c89576ab2b 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -428,7 +428,6 @@ CONFIG_SPI_TI_QSPI=m
 CONFIG_HSI=m
 CONFIG_OMAP_SSI=m
 CONFIG_SSI_PROTOCOL=m
-CONFIG_PTP_1588_CLOCK=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
-- 
2.29.2

