Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843D848C35C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352934AbiALLkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiALLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:40:44 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6012DC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:40:44 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:76d0:2bff:fec8:549])
        by laurent.telenet-ops.be with bizsmtp
        id hngg2600A0kcUhD01nggAt; Wed, 12 Jan 2022 12:40:41 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7bzb-009FhI-V2; Wed, 12 Jan 2022 12:40:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7bzb-000S4m-Go; Wed, 12 Jan 2022 12:40:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] phy: freescale: i.MX8 PHYs should depend on ARCH_MXC && ARM64
Date:   Wed, 12 Jan 2022 12:40:38 +0100
Message-Id: <393868affd830016d35f0d9aba32ccd7098c8073.1641987369.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Freescale/NXP i.MX8 USB3, MIPI DSI, and PCIE PHYs are only present
on the NXP i.MX8 family of SoCs.  Hence wrap the config symbols for
these PHYs inside a check for ARCH_MXC && ARM64, to prevent asking the
user about these drivers when configuring a kernel without NXP i.MX SoC
family support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/phy/freescale/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index c3669c28ea9fe83a..856cbec7057d9e54 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+if (ARCH_MXC && ARM64) || COMPILE_TEST
+
 config PHY_FSL_IMX8MQ_USB
 	tristate "Freescale i.MX8M USB3 PHY"
 	depends on OF && HAS_IOMEM
@@ -22,3 +25,5 @@ config PHY_FSL_IMX8M_PCIE
 	help
 	  Enable this to add support for the PCIE PHY as found on
 	  i.MX8M family of SOCs.
+
+endif
-- 
2.25.1

