Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10ED4C27FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiBXJWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiBXJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:22:07 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADC4814001;
        Thu, 24 Feb 2022 01:21:37 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,393,1635174000"; 
   d="scan'208";a="111447775"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Feb 2022 18:21:37 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A350E4007541;
        Thu, 24 Feb 2022 18:21:35 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH] soc: renesas: Kconfig: Introduce ARCH_RZG2L config option
Date:   Thu, 24 Feb 2022 09:21:14 +0000
Message-Id: <20220224092114.25737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renesas RZ/G2L, RZ/G2LC, RZ/G2UL and RZ/V2L SoC's have identical IP blocks
for which drivers are common. To avoid updating the Kconfig files for
drivers in common to each SoC, introduce the ARCH_RZG2L config option.
ARCH_RZG2L config option will be selected by the above mentioned SoC's and
ARCH_RZG2L config option will be used as a dependency for the drivers in
common.

While at it, move PM and PM_GENERIC_DOMAINS under the ARCH_RZG2L
config option instead of adding it to individual SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 57b6292b46a3..fdc99a05a7e0 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -40,6 +40,11 @@ config ARCH_RMOBILE
 	select SYS_SUPPORTS_SH_TMU
 	select SYSC_RMOBILE
 
+config ARCH_RZG2L
+	bool
+	select PM
+	select PM_GENERIC_DOMAINS
+
 config ARCH_RZN1
 	bool
 	select ARM_AMBA
@@ -293,15 +298,13 @@ config ARCH_R8A774B1
 
 config ARCH_R9A07G044
 	bool "ARM64 Platform support for RZ/G2L"
-	select PM
-	select PM_GENERIC_DOMAINS
+	select ARCH_RZG2L
 	help
 	  This enables support for the Renesas RZ/G2L SoC variants.
 
 config ARCH_R9A07G054
 	bool "ARM64 Platform support for RZ/V2L"
-	select PM
-	select PM_GENERIC_DOMAINS
+	select ARCH_RZG2L
 	help
 	  This enables support for the Renesas RZ/V2L SoC variants.
 
-- 
2.17.1

