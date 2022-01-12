Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7748C594
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353895AbiALOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242148AbiALOFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:05:09 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF229C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:05:08 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:76d0:2bff:fec8:549])
        by baptiste.telenet-ops.be with bizsmtp
        id hq56260030kcUhD01q56ZF; Wed, 12 Jan 2022 15:05:06 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7eFN-009GXL-Iq; Wed, 12 Jan 2022 15:05:05 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7eFM-000Vs0-KO; Wed, 12 Jan 2022 15:05:04 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ananth Jasty <Ananth.Jasty@cavium.com>,
        Omer Khaliq <okhaliq@caviumnetworks.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] hwrng: cavium - HW_RANDOM_CAVIUM should depend on ARCH_THUNDER
Date:   Wed, 12 Jan 2022 15:05:03 +0100
Message-Id: <1c4148e1aaa4d89754ff810386dee8c22bcce4b1.1641996225.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cavium ThunderX Random Number Generator is only present on Cavium
ThunderX SoCs, and not available as an independent PCIe endpoint.  Hence
add a dependency on ARCH_THUNDER, to prevent asking the user about this
driver when configuring a kernel without Cavium Thunder SoC  support.

Fixes: cc2f1908c6b8f625 ("hwrng: cavium - Add Cavium HWRNG driver for ThunderX SoC.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index b33c01e9935336f7..263861c88fcc7e98 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -414,7 +414,7 @@ config HW_RANDOM_MESON
 
 config HW_RANDOM_CAVIUM
 	tristate "Cavium ThunderX Random Number Generator support"
-	depends on HW_RANDOM && PCI && ARM64
+	depends on HW_RANDOM && PCI && ARCH_THUNDER
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
-- 
2.25.1

