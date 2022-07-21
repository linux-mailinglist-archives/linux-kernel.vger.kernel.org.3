Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B657D6B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiGUWNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiGUWNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:13:09 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74F9695C11;
        Thu, 21 Jul 2022 15:12:30 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,183,1654527600"; 
   d="scan'208";a="126944331"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jul 2022 07:12:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8B7EA4010DFB;
        Fri, 22 Jul 2022 07:12:26 +0900 (JST)
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
Subject: [PATCH 2/2] soc: renesas: Identify RZ/Five SoC
Date:   Thu, 21 Jul 2022 23:12:12 +0100
Message-Id: <20220721221212.18491-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/soc/renesas/Kconfig       | 10 ++++++++++
 drivers/soc/renesas/renesas-soc.c | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 390f52109cb7..2e3508fbae53 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -333,6 +333,16 @@ config ARCH_R9A09G011
 
 endif # ARM64
 
+if RISCV
+
+config ARCH_R9A07G043
+	bool "RISCV Platform support for RZ/Five"
+	select ARCH_RZG2L
+	help
+	  This enables support for the Renesas RZ/Five SoC.
+
+endif # RISCV
+
 config RST_RCAR
 	bool "Reset Controller support for R-Car" if COMPILE_TEST
 
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index d171f1b635c7..1a31692fc884 100644
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
@@ -398,6 +411,7 @@ static const struct renesas_id id_prr __initconst = {
 
 static const struct of_device_id renesas_ids[] __initconst = {
 	{ .compatible = "renesas,bsid",			.data = &id_bsid },
+	{ .compatible = "renesas,r9a07g043-rzfive-sysc", .data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g043-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g044-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g054-sysc",	.data = &id_rzg2l },
-- 
2.25.1

