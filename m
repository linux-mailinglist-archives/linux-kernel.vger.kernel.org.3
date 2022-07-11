Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4656A56FFE1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiGKLOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiGKLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:13:32 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F12D1A83F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:28:03 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id tmU22700F4C55Sk01mU22y; Mon, 11 Jul 2022 12:28:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAqCw-0032if-Gc; Mon, 11 Jul 2022 12:00:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAp37-004dvg-Q0; Mon, 11 Jul 2022 10:45:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: SPI_MICROCHIP_CORE should depend on SOC_MICROCHIP_POLARFIRE
Date:   Mon, 11 Jul 2022 10:45:49 +0200
Message-Id: <4e78693a87d6b83847056d22468c370e7232f390.1657529125.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip "hard" FPGA SPI controller is only present on Microchip
PolarFire SoCs.  Hence add a dependency on SOC_MICROCHIP_POLARFIRE, to
prevent asking the user about this driver when configuring a kernel
without Microchip PolarFire SoC support.

Fixes: 9ac8d17694b66d54 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e03cd16f4469079e..b1cb7fe129ff86da 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -585,6 +585,7 @@ config SPI_MESON_SPIFC
 config SPI_MICROCHIP_CORE
 	tristate "Microchip FPGA SPI controllers"
 	depends on SPI_MASTER
+	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
 	help
 	  This enables the SPI driver for Microchip FPGA SPI controllers.
 	  Say Y or M here if you want to use the "hard" controllers on
-- 
2.25.1

