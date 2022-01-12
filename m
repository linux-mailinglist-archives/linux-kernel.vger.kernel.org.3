Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB248C588
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353933AbiALODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353901AbiALODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:03:46 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7AC06175E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:03:44 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:76d0:2bff:fec8:549])
        by albert.telenet-ops.be with bizsmtp
        id hq3j260020kcUhD06q3jnQ; Wed, 12 Jan 2022 15:03:43 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7eE2-009GWv-Ld; Wed, 12 Jan 2022 15:03:42 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7eE1-000VpH-P3; Wed, 12 Jan 2022 15:03:41 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Sunil Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] hwrng: cn10k - HW_RANDOM_CN10K should depend on ARCH_THUNDER
Date:   Wed, 12 Jan 2022 15:03:40 +0100
Message-Id: <266065918e47e8965bb6a0ab486da070278788e4.1641996057.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell CN10K True Random Number generator is only present on
Marvell CN10K SoCs, and not available as an independent PCIe endpoint.
Hence add a dependency on ARCH_THUNDER, to prevent asking the user about
this driver when configuring a kernel without Cavium Thunder (incl.
Marvell CN10K) SoC support.

Fixes: 38e9791a02090414 ("hwrng: cn10k - Add random number generator support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index c91cb48a1db168dd..b33c01e9935336f7 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -540,7 +540,7 @@ config HW_RANDOM_ARM_SMCCC_TRNG
 
 config HW_RANDOM_CN10K
        tristate "Marvell CN10K Random Number Generator support"
-       depends on HW_RANDOM && PCI && ARM64
+       depends on HW_RANDOM && PCI && ARCH_THUNDER
        default HW_RANDOM
        help
 	 This driver provides support for the True Random Number
-- 
2.25.1

