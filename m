Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904BF489A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiAJNrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:47:20 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:46458 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233800AbiAJNrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:47:16 -0500
X-IronPort-AV: E=Sophos;i="5.88,277,1635174000"; 
   d="scan'208";a="106014806"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 22:47:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 911BB42E3548;
        Mon, 10 Jan 2022 22:47:12 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 02/12] soc: renesas: Identify RZ/V2L SoC
Date:   Mon, 10 Jan 2022 13:46:49 +0000
Message-Id: <20220110134659.30424-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for identifying the RZ/V2L (R9A07G054) SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* None
---
 drivers/soc/renesas/Kconfig       |  5 +++++
 drivers/soc/renesas/renesas-soc.c | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index ce16ef5c939c..15ace18968f6 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -289,6 +289,11 @@ config ARCH_R9A07G044
 	help
 	  This enables support for the Renesas RZ/G2L SoC variants.
 
+config ARCH_R9A07G054
+	bool "ARM64 Platform support for RZ/V2L"
+	help
+	  This enables support for the Renesas RZ/V2L SoC variants.
+
 endif # ARM64
 
 config RST_RCAR
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 3d7711d5178c..7eeb73768369 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -60,6 +60,10 @@ static const struct renesas_family fam_rzg2l __initconst __maybe_unused = {
 	.name	= "RZ/G2L",
 };
 
+static const struct renesas_family fam_rzv2l __initconst __maybe_unused = {
+	.name	= "RZ/V2L",
+};
+
 static const struct renesas_family fam_shmobile __initconst __maybe_unused = {
 	.name	= "SH-Mobile",
 	.reg	= 0xe600101c,		/* CCCR (Common Chip Code Register) */
@@ -140,6 +144,11 @@ static const struct renesas_soc soc_rz_g2l __initconst __maybe_unused = {
 	.id     = 0x841c447,
 };
 
+static const struct renesas_soc soc_rz_v2l __initconst __maybe_unused = {
+	.family = &fam_rzv2l,
+	.id     = 0x8447447,
+};
+
 static const struct renesas_soc soc_rcar_m1a __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen1,
 };
@@ -322,6 +331,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #if defined(CONFIG_ARCH_R9A07G044)
 	{ .compatible = "renesas,r9a07g044",	.data = &soc_rz_g2l },
 #endif
+#if defined(CONFIG_ARCH_R9A07G054)
+	{ .compatible = "renesas,r9a07g054",	.data = &soc_rz_v2l },
+#endif
 #ifdef CONFIG_ARCH_SH73A0
 	{ .compatible = "renesas,sh73a0",	.data = &soc_shmobile_ag5 },
 #endif
@@ -355,6 +367,7 @@ static const struct renesas_id id_prr __initconst = {
 static const struct of_device_id renesas_ids[] __initconst = {
 	{ .compatible = "renesas,bsid",			.data = &id_bsid },
 	{ .compatible = "renesas,r9a07g044-sysc",	.data = &id_rzg2l },
+	{ .compatible = "renesas,r9a07g054-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,prr",			.data = &id_prr },
 	{ /* sentinel */ }
 };
-- 
2.17.1

