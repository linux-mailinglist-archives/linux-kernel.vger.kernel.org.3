Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66848C55F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353848AbiALOA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbiALOAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:00:55 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A9C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:00:55 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:76d0:2bff:fec8:549])
        by laurent.telenet-ops.be with bizsmtp
        id hq0t2600C0kcUhD01q0tjW; Wed, 12 Jan 2022 15:00:53 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7eBI-009GW7-Qg; Wed, 12 Jan 2022 15:00:52 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7eBI-000Tza-Cg; Wed, 12 Jan 2022 15:00:52 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] perf: MARVELL_CN10K_TAD_PMU should depend on ARCH_THUNDER
Date:   Wed, 12 Jan 2022 15:00:47 +0100
Message-Id: <b4662a2c767d04cca19417e0c845edea2da262ad.1641995941.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell CN10K Last-Level cache Tag-and-data Units (LLC-TAD)
performance monitor is only present on Marvell CN10K SoCs.  Hence add a
dependency on ARCH_THUNDER, to prevent asking the user about this driver
when configuring a kernel without Cavium Thunder (incl. Marvell CN10K)
SoC support.

Fixes: 036a7584bede317d ("drivers: perf: Add LLC-TAD perf counter support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/perf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index e1a0c44bc686493e..7d6ffdf44a415a66 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -141,7 +141,7 @@ config ARM_DMC620_PMU
 
 config MARVELL_CN10K_TAD_PMU
 	tristate "Marvell CN10K LLC-TAD PMU"
-	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
 	help
 	  Provides support for Last-Level cache Tag-and-data Units (LLC-TAD)
 	  performance monitors on CN10K family silicons.
-- 
2.25.1

