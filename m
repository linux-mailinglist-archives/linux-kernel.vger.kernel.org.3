Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D164551C938
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380517AbiEETgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385112AbiEETf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:35:58 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 357735B3DD;
        Thu,  5 May 2022 12:32:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,203,1647270000"; 
   d="scan'208";a="118803611"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 May 2022 04:32:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E850D40E166D;
        Fri,  6 May 2022 04:32:11 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack the resets instead of indexing
Date:   Thu,  5 May 2022 20:31:41 +0100
Message-Id: <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of indexing the resets, stack them and instead create an id member
in struct rzg2l_reset to store the index. With this approach for every id
we will have to loop through the resets array to match the id.

This in preparation to add support for Renesas RZ/Five CPG in
r9a07g043-cpg.c file where the resets array will be split up into three
i.e. common and two SoC specific.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 76 ++++++++++++++++++++++++++-------
 drivers/clk/renesas/rzg2l-cpg.h |  4 +-
 2 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 1ce35f65682b..94fe307ec4c5 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -681,14 +681,37 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 
 #define rcdev_to_priv(x)	container_of(x, struct rzg2l_cpg_priv, rcdev)
 
+static const struct rzg2l_reset
+*rzg2l_get_reset_ptr(struct rzg2l_cpg_priv *priv,
+		     unsigned long id)
+
+{
+	const struct rzg2l_cpg_info *info = priv->info;
+	unsigned int i;
+
+	for (i = 0; i < priv->num_resets; i++) {
+		if (info->resets[i].id == id)
+			return &info->resets[i];
+	}
+
+	return NULL;
+}
+
 static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
 			   unsigned long id)
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
-	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 dis = BIT(info->resets[id].bit);
-	u32 we = dis << 16;
+	const struct rzg2l_reset *reset;
+	unsigned int reg;
+	u32 dis, we;
+
+	reset = rzg2l_get_reset_ptr(priv, id);
+	if (!reset)
+		return -EINVAL;
+
+	reg = reset->off;
+	dis = BIT(reset->bit);
+	we = dis << 16;
 
 	dev_dbg(rcdev->dev, "reset id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
 
@@ -708,9 +731,16 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 			    unsigned long id)
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
-	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 value = BIT(info->resets[id].bit) << 16;
+	const struct rzg2l_reset *reset;
+	unsigned int reg;
+	u32 value;
+
+	reset = rzg2l_get_reset_ptr(priv, id);
+	if (!reset)
+		return -EINVAL;
+
+	reg = reset->off;
+	value = BIT(reset->bit) << 16;
 
 	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
 
@@ -722,11 +752,17 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
-	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 dis = BIT(info->resets[id].bit);
-	u32 value = (dis << 16) | dis;
+	const struct rzg2l_reset *reset;
+	unsigned int reg;
+	u32 dis, value;
+
+	reset = rzg2l_get_reset_ptr(priv, id);
+	if (!reset)
+		return -EINVAL;
 
+	reg = reset->off;
+	dis = BIT(reset->bit);
+	value = (dis << 16) | dis;
 	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
 		CLK_RST_R(reg));
 
@@ -738,9 +774,16 @@ static int rzg2l_cpg_status(struct reset_controller_dev *rcdev,
 			    unsigned long id)
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
-	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 bitmask = BIT(info->resets[id].bit);
+	const struct rzg2l_reset *reset;
+	unsigned int reg;
+	u32 bitmask;
+
+	reset = rzg2l_get_reset_ptr(priv, id);
+	if (!reset)
+		return -EINVAL;
+
+	reg = reset->off;
+	bitmask = BIT(reset->bit);
 
 	return !(readl(priv->base + CLK_MRST_R(reg)) & bitmask);
 }
@@ -756,10 +799,11 @@ static int rzg2l_cpg_reset_xlate(struct reset_controller_dev *rcdev,
 				 const struct of_phandle_args *reset_spec)
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
-	const struct rzg2l_cpg_info *info = priv->info;
 	unsigned int id = reset_spec->args[0];
+	const struct rzg2l_reset *reset;
 
-	if (id >= rcdev->nr_resets || !info->resets[id].off) {
+	reset = rzg2l_get_reset_ptr(priv, id);
+	if (!reset) {
 		dev_err(rcdev->dev, "Invalid reset index %u\n", id);
 		return -EINVAL;
 	}
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 92c88f42ca7f..a99f2ba7868f 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -152,12 +152,14 @@ struct rzg2l_mod_clk {
  * @bit: reset bit
  */
 struct rzg2l_reset {
+	unsigned int id;
 	u16 off;
 	u8 bit;
 };
 
 #define DEF_RST(_id, _off, _bit)	\
-	[_id] = { \
+	{ \
+		.id = (_id), \
 		.off = (_off), \
 		.bit = (_bit) \
 	}
-- 
2.25.1

