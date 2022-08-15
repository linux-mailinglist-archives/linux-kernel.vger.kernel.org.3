Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24BD59287B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbiHOENv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbiHOENZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:25 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C9714093;
        Sun, 14 Aug 2022 21:13:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 06FB132005D8;
        Mon, 15 Aug 2022 00:13:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 00:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536801; x=1660623201; bh=9B
        C0LSiPGpFiksVoDFV8G0WmbmUqGVokgFnFCFXLEhw=; b=mV9deqOP4HVpwJzUVi
        6gZ24/IBdEJVUOcoJxJ5FUR4wtecQswdVNL3hR41XcubZjrP0taz1SOc7uYn0b1D
        RcxWROtd5nc9ICKtvpyzwBVyFYRl5OlDFzt7URr9Ei+DsIW9eEGBvP2n0QNF8Lqd
        tr24vKmmf8eQK6K3tGS+AR5idO2CGfqA0OveWoLFHggH7kzczjYUC+wgVYVAUgS3
        zEeV2UqS0/FFarPuYtU5pcPMubeyPYTjrVI6rrJRPaAZf/cyCMpRBnGs0s9Hotp1
        Sg5PxdRfgLVxsjE6D+TNPPfDI05JVruz+PIYd3x2P1vwp9RZOZ00oVkRTQ238P+Y
        cibg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536801; x=1660623201; bh=9BC0LSiPGpFik
        sVoDFV8G0WmbmUqGVokgFnFCFXLEhw=; b=QNgedk6eIxXmLDs8HLQaP4CbIW0uv
        4R5fmJ96hF9HyYQjzCM6MFWU3mpXxao8C70CFuRct+KRgHRZlnXU+ro6WCemeovA
        A1vyR2pAb0rPPoKrKxAnj4AksZw3TCeUJTJvUbG3bNnhJC08S/Z+iEDgFVKGo60f
        KWV/og1OIHeNXyjYvy09FMJsJ5yxR8rJMopQUwIR9SHWEcJQZkvCa9HHJqv/845j
        8nsJUgCEJvCtUCya1ys5GgoaPx0lj3yzDAxbEcJp909AGV0V/JniGDePTXi7hoAG
        nc6yVqYV3A/msnyL9g1bnlXCKaN79Xlwb9fboXaF1nWmHexJKQgvwV+2w==
X-ME-Sender: <xms:4cf5YuUIiKy5M6sBseIFrQ0XRhJe05hmDTA02sHSAXBA3fAUbe9Ymw>
    <xme:4cf5Yqmj-76sGdLOawEP8YmHw5MHgjXgqK9d5aUmtLTXEqkGCUfdyxnT2wO3a98Kn
    EIs40i2JQG01i-zTw>
X-ME-Received: <xmr:4cf5YibdWsvWyjMlZ9KqWE-_7qgcNsj2ZsoGkzfbgyNvaTNyzM1BdvuijqZ4NNNjyCd6RuFoyMjKaBX2YUQZ1RADWF2kwa8qmiieDv8w0PGrK66bL23ZhMAZf0iO00l1WKK5Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:4cf5YlW5S1AZKqKItGpHEk08DtraqTF6OG7aFUQI-V-7uwm31_jK2A>
    <xmx:4cf5YokLYAXYKLGVGWc86Dmyuy0Rz894j9tkLhBv83f_OWza5kZSLA>
    <xmx:4cf5YqebdIWaqWm5oSRBz3JjcOaFwXwS3KhX_dVOqoyIrJ6f_xxO7Q>
    <xmx:4cf5YifmFDJXT2vSeHIZPt0Z65LrC8teNqKsTz_NO6k0Fu0O27uA2A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:13:20 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 09/10] soc: sunxi: sram: Export the LDO control register
Date:   Sun, 14 Aug 2022 23:12:46 -0500
Message-Id: <20220815041248.53268-10-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041248.53268-1-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some newer Allwinner SoCs contain internal LDOs managed by a register in
the system control MMIO space. Export this from the regmap in addtion to
the EMAC register.

Use generic names now that the regmap is no longer EMAC-specific.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/soc/sunxi/sunxi_sram.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 7c6fb17cfe7f..7e8dab0f0ec4 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -283,6 +283,7 @@ EXPORT_SYMBOL(sunxi_sram_release);
 
 struct sunxi_sramc_variant {
 	int num_emac_clocks;
+	bool has_ldo_ctrl;
 };
 
 static const struct sunxi_sramc_variant sun4i_a10_sramc_variant = {
@@ -302,25 +303,28 @@ static const struct sunxi_sramc_variant sun50i_h616_sramc_variant = {
 };
 
 #define SUNXI_SRAM_EMAC_CLOCK_REG	0x30
+#define SUNXI_SYS_LDO_CTRL_REG		0x150
+
 static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
 					     unsigned int reg)
 {
 	const struct sunxi_sramc_variant *variant = dev_get_drvdata(dev);
 
-	if (reg < SUNXI_SRAM_EMAC_CLOCK_REG)
-		return false;
-	if (reg > SUNXI_SRAM_EMAC_CLOCK_REG + variant->num_emac_clocks * 4)
-		return false;
+	if (reg >= SUNXI_SRAM_EMAC_CLOCK_REG &&
+	    reg <  SUNXI_SRAM_EMAC_CLOCK_REG + variant->num_emac_clocks * 4)
+		return true;
+	if (reg == SUNXI_SYS_LDO_CTRL_REG && variant->has_ldo_ctrl)
+		return true;
 
-	return true;
+	return false;
 }
 
-static struct regmap_config sunxi_sram_emac_clock_regmap = {
+static struct regmap_config sunxi_sram_regmap_config = {
 	.reg_bits       = 32,
 	.val_bits       = 32,
 	.reg_stride     = 4,
 	/* last defined register */
-	.max_register   = SUNXI_SRAM_EMAC_CLOCK_REG + 4,
+	.max_register   = SUNXI_SYS_LDO_CTRL_REG,
 	/* other devices have no business accessing other registers */
 	.readable_reg	= sunxi_sram_regmap_accessible_reg,
 	.writeable_reg	= sunxi_sram_regmap_accessible_reg,
@@ -328,9 +332,9 @@ static struct regmap_config sunxi_sram_emac_clock_regmap = {
 
 static int __init sunxi_sram_probe(struct platform_device *pdev)
 {
-	struct regmap *emac_clock;
 	const struct sunxi_sramc_variant *variant;
 	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
 
 	sram_dev = &pdev->dev;
 
@@ -344,12 +348,10 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	if (variant->num_emac_clocks > 0) {
-		emac_clock = devm_regmap_init_mmio(&pdev->dev, base,
-						   &sunxi_sram_emac_clock_regmap);
-
-		if (IS_ERR(emac_clock))
-			return PTR_ERR(emac_clock);
+	if (variant->num_emac_clocks || variant->has_ldo_ctrl) {
+		regmap = devm_regmap_init_mmio(dev, base, &sunxi_sram_regmap_config);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
 	}
 
 	of_platform_populate(dev->of_node, NULL, NULL, dev);
-- 
2.35.1

