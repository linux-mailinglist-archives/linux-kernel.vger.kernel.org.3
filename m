Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB42557E2E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiGVOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiGVOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:15:25 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F5DC29827;
        Fri, 22 Jul 2022 07:15:23 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,185,1654527600"; 
   d="scan'208";a="127042277"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jul 2022 23:15:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0AD4C43279E4;
        Fri, 22 Jul 2022 23:15:19 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] soc: renesas: Identify RZ/Five SoC
Date:   Fri, 22 Jul 2022 15:15:06 +0100
Message-Id: <20220722141506.20171-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for identifying the (R9A07G043) RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Replaced RISCV -> RISCV
* Reused "renesas,r9a07g043-sysc" string for RZ/Five detection
---
 drivers/soc/renesas/Kconfig       | 10 ++++++++++
 drivers/soc/renesas/renesas-soc.c | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 390f52109cb7..f95a1337450d 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -333,6 +333,16 @@ config ARCH_R9A09G011
 
 endif # ARM64
 
+if RISCV
+
+config ARCH_R9A07G043
+	bool "RISC-V Platform support for RZ/Five"
+	select ARCH_RZG2L
+	help
+	  This enables support for the Renesas RZ/Five SoC.
+
+endif # RISCV
+
 config RST_RCAR
 	bool "Reset Controller support for R-Car" if COMPILE_TEST
 
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index d171f1b635c7..c0e2c62c76c9 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -50,6 +50,10 @@ static const struct renesas_family fam_rza2 __initconst __maybe_unused = {
 	.name	= "RZ/A2",
 };
 
+static const struct renesas_family fam_rzfive __initconst __maybe_unused = {
+	.name	= "RZ/Five",
+};
+
 static const struct renesas_family fam_rzg1 __initconst __maybe_unused = {
 	.name	= "RZ/G1",
 	.reg	= 0xff000044,		/* PRR (Product Register) */
@@ -102,6 +106,11 @@ static const struct renesas_soc soc_rmobile_a1 __initconst __maybe_unused = {
 	.id	= 0x40,
 };
 
+static const struct renesas_soc soc_rz_five __initconst __maybe_unused = {
+	.family = &fam_rzfive,
+	.id     = 0x847c447,
+};
+
 static const struct renesas_soc soc_rz_g1h __initconst __maybe_unused = {
 	.family	= &fam_rzg1,
 	.id	= 0x45,
@@ -358,8 +367,12 @@ static const struct of_device_id renesas_socs[] __initconst = {
 	{ .compatible = "renesas,r8a779g0",	.data = &soc_rcar_v4h },
 #endif
 #if defined(CONFIG_ARCH_R9A07G043)
+#ifdef CONFIG_RISCV
+	{ .compatible = "renesas,r9a07g043",	.data = &soc_rz_five },
+#else
 	{ .compatible = "renesas,r9a07g043",	.data = &soc_rz_g2ul },
 #endif
+#endif
 #if defined(CONFIG_ARCH_R9A07G044)
 	{ .compatible = "renesas,r9a07g044",	.data = &soc_rz_g2l },
 #endif
-- 
2.25.1

