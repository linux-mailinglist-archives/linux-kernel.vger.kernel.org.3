Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C949E4B1020
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbiBJOTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:19:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiBJOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:19:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5EF5;
        Thu, 10 Feb 2022 06:19:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 384A41F46573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644502778;
        bh=T6oCvxGI02ejeib653keltA8aaT+DmTLdUz6lyCdlFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsXM+8uQAknm04CPPO9RTgZvKYuoZ0HeLrkU6+q2yr/XeCQJ93ujwet1qJmTA7a1t
         dtSgUEX+LVmNAG1j2dYYtmdFE0CFZVFvAUf+lHHH68qd6bZmfpzGXbApfJlI5IoakR
         jSinthleORHHJgMahN3QM+X5AtOeoiR2b/s3Cj68ETG8ksItV4as7ykXtNyeD9LLc9
         +oykn56hO9RYtmZJXNXNtiyv2FnJg3ncH+t7kQh1NT8WPgOAY5LdtXTtolWa2MW9tp
         ysfPCwR7dgGyHg63PfsYOeTBmRZ0zhRFs1/1yZDHN6BGnLKvsGmOvFRBt8gvOhlPFO
         aWMg6enlLvdKg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/5] pinctrl: mediatek: common-v1: Commonize spec_pupd callback
Date:   Thu, 10 Feb 2022 15:19:30 +0100
Message-Id: <20220210141931.291712-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com>
References: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce code size and duplication by using a common spec_pupd callback,
which is possible to use on all of the pinctrl drivers that are
using the v1 pinctrl-mtk-common code, with the exception of mt8135,
which has a different handling compared to the others.
Since the callback function signature was changed, this had to be
propagated to pinctrl-mt8135's spec_pull_set().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt2701.c     | 11 +++------
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     | 14 +++--------
 drivers/pinctrl/mediatek/pinctrl-mt8127.c     | 11 +++------
 drivers/pinctrl/mediatek/pinctrl-mt8135.c     |  6 +++--
 drivers/pinctrl/mediatek/pinctrl-mt8167.c     | 11 +++------
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     | 11 +++------
 drivers/pinctrl/mediatek/pinctrl-mt8365.c     | 11 +++------
 drivers/pinctrl/mediatek/pinctrl-mt8516.c     | 11 +++------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 23 +++++++++++--------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h | 14 +++++++----
 10 files changed, 47 insertions(+), 76 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
index 2f8821207395..816de39858f8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -270,13 +270,6 @@ static const struct mtk_pin_spec_pupd_set_samereg mt2701_spec_pupd[] = {
 	MTK_PIN_PUPD_SPEC_SR(261, 0x140, 8, 9, 10),	/* ms1 ins */
 };
 
-static int mt2701_spec_pull_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, bool isup, unsigned int r1r0)
-{
-	return mtk_pctrl_spec_pull_set_samereg(regmap, mt2701_spec_pupd,
-		ARRAY_SIZE(mt2701_spec_pupd), pin, align, isup, r1r0);
-}
-
 static const struct mtk_pin_ies_smt_set mt2701_ies_set[] = {
 	MTK_PIN_IES_SMT_SPEC(0, 6, 0xb20, 0),
 	MTK_PIN_IES_SMT_SPEC(7, 9, 0xb20, 1),
@@ -508,7 +501,9 @@ static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt2701_drv_grp),
 	.pin_drv_grp = mt2701_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt2701_pin_drv),
-	.spec_pull_set = mt2701_spec_pull_set,
+	.spec_pupd = mt2701_spec_pupd,
+	.n_spec_pupd = ARRAY_SIZE(mt2701_spec_pupd),
+	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
 	.spec_ies_smt_set = mt2701_ies_smt_set,
 	.spec_pinmux_set = mt2701_spec_pinmux_set,
 	.spec_dir_set = mt2701_spec_dir_set,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
index 03aa14445034..b6182b06584b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2712.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -81,16 +81,6 @@ static const struct mtk_pin_spec_pupd_set_samereg mt2712_spec_pupd[] = {
 	MTK_PIN_PUPD_SPEC_SR(142, 0xe60, 5, 4, 3)
 };
 
-static int mt2712_spec_pull_set(struct regmap *regmap,
-				unsigned int pin,
-				unsigned char align,
-				bool isup,
-				unsigned int r1r0)
-{
-	return mtk_pctrl_spec_pull_set_samereg(regmap, mt2712_spec_pupd,
-		ARRAY_SIZE(mt2712_spec_pupd), pin, align, isup, r1r0);
-}
-
 static const struct mtk_pin_ies_smt_set mt2712_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(0, 3, 0x900, 2),
 	MTK_PIN_IES_SMT_SPEC(4, 7, 0x900, 0),
@@ -563,7 +553,9 @@ static const struct mtk_pinctrl_devdata mt2712_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt2712_drv_grp),
 	.pin_drv_grp = mt2712_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt2712_pin_drv),
-	.spec_pull_set = mt2712_spec_pull_set,
+	.spec_pupd = mt2712_spec_pupd,
+	.n_spec_pupd = ARRAY_SIZE(mt2712_spec_pupd),
+	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
 	.spec_ies_smt_set = mt2712_ies_smt_set,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0100,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8127.c b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
index 76cb525374f2..9745d15f93ec 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8127.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
@@ -172,13 +172,6 @@ static const struct mtk_pin_spec_pupd_set_samereg mt8127_spec_pupd[] = {
 	MTK_PIN_PUPD_SPEC_SR(142, 0xdc0, 2, 0, 1),	/* EINT21 */
 };
 
-static int mt8127_spec_pull_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, bool isup, unsigned int r1r0)
-{
-	return mtk_pctrl_spec_pull_set_samereg(regmap, mt8127_spec_pupd,
-		ARRAY_SIZE(mt8127_spec_pupd), pin, align, isup, r1r0);
-}
-
 static const struct mtk_pin_ies_smt_set mt8127_ies_set[] = {
 	MTK_PIN_IES_SMT_SPEC(0, 9, 0x900, 0),
 	MTK_PIN_IES_SMT_SPEC(10, 13, 0x900, 1),
@@ -279,7 +272,9 @@ static const struct mtk_pinctrl_devdata mt8127_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8127_drv_grp),
 	.pin_drv_grp = mt8127_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8127_pin_drv),
-	.spec_pull_set = mt8127_spec_pull_set,
+	.spec_pupd = mt8127_spec_pupd,
+	.n_spec_pupd = ARRAY_SIZE(mt8127_spec_pupd),
+	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
 	.spec_ies_smt_set = mt8127_ies_smt_set,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0100,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index 4c20b79dec67..562846756517 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -230,12 +230,14 @@ static const struct mtk_spec_pull_set spec_pupd[] = {
 	SPEC_PULL(202, PUPD_BASE2+0xc0, 10, R0_BASE1, 12, R1_BASE2+0xc0, 10)
 };
 
-static int spec_pull_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, bool isup, unsigned int r1r0)
+static int spec_pull_set(struct regmap *regmap,
+		const struct mtk_pinctrl_devdata *devdata,
+		unsigned int pin, bool isup, unsigned int r1r0)
 {
 	unsigned int i;
 	unsigned int reg_pupd, reg_set_r0, reg_set_r1;
 	unsigned int reg_rst_r0, reg_rst_r1;
+	unsigned char align = devdata->port_align;
 	bool find = false;
 
 	for (i = 0; i < ARRAY_SIZE(spec_pupd); i++) {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8167.c b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
index 08aabf408c9c..118ddcba18fc 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8167.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
@@ -186,13 +186,6 @@ static const struct mtk_pin_spec_pupd_set_samereg mt8167_spec_pupd[] = {
 	MTK_PIN_PUPD_SPEC_SR(120, 0xe00, 2, 1, 0),
 };
 
-static int mt8167_spec_pull_set(struct regmap *regmap, unsigned int pin,
-			unsigned char align, bool isup, unsigned int r1r0)
-{
-	return mtk_pctrl_spec_pull_set_samereg(regmap, mt8167_spec_pupd,
-		ARRAY_SIZE(mt8167_spec_pupd), pin, align, isup, r1r0);
-}
-
 static const struct mtk_pin_ies_smt_set mt8167_ies_set[] = {
 	MTK_PIN_IES_SMT_SPEC(0, 6, 0x900, 2),
 	MTK_PIN_IES_SMT_SPEC(7, 10, 0x900, 3),
@@ -311,7 +304,9 @@ static const struct mtk_pinctrl_devdata mt8167_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8167_drv_grp),
 	.pin_drv_grp = mt8167_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8167_pin_drv),
-	.spec_pull_set = mt8167_spec_pull_set,
+	.spec_pupd = mt8167_spec_pupd,
+	.n_spec_pupd = ARRAY_SIZE(mt8167_spec_pupd),
+	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
 	.spec_ies_smt_set = mt8167_ies_smt_set,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0500,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index fc99df8a11c6..b34c9778e131 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -61,13 +61,6 @@ static const struct mtk_pin_spec_pupd_set_samereg mt8173_spec_pupd[] = {
 	MTK_PIN_PUPD_SPEC_SR(27, 0xcd0, 2, 1, 0)     /* ms3 cmd */
 };
 
-static int mt8173_spec_pull_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, bool isup, unsigned int r1r0)
-{
-	return mtk_pctrl_spec_pull_set_samereg(regmap, mt8173_spec_pupd,
-		ARRAY_SIZE(mt8173_spec_pupd), pin, align, isup, r1r0);
-}
-
 static const struct mtk_pin_ies_smt_set mt8173_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(0, 4, 0x930, 1),
 	MTK_PIN_IES_SMT_SPEC(5, 9, 0x930, 2),
@@ -319,7 +312,9 @@ static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8173_drv_grp),
 	.pin_drv_grp = mt8173_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8173_pin_drv),
-	.spec_pull_set = mt8173_spec_pull_set,
+	.spec_pupd = mt8173_spec_pupd,
+	.n_spec_pupd = ARRAY_SIZE(mt8173_spec_pupd),
+	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
 	.spec_ies_smt_set = mt8173_ies_smt_set,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0100,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 6863a8150a2b..dbff7a831235 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -416,13 +416,6 @@ static const struct mtk_pin_ies_smt_set mt8365_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(144, 144, 0x480, 22),
 };
 
-static int mt8365_spec_pull_set(struct regmap *regmap, unsigned int pin,
-			unsigned char align, bool isup, unsigned int r1r0)
-{
-	return mtk_pctrl_spec_pull_set_samereg(regmap, mt8365_spec_pupd,
-		ARRAY_SIZE(mt8365_spec_pupd), pin, align, isup, r1r0);
-}
-
 static int mt8365_ies_smt_set(struct regmap *regmap, unsigned int pin,
 		unsigned char align, int value, enum pin_config_param arg)
 {
@@ -442,7 +435,9 @@ static const struct mtk_pinctrl_devdata mt8365_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8365_drv_grp),
 	.pin_drv_grp = mt8365_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8365_pin_drv),
-	.spec_pull_set = mt8365_spec_pull_set,
+	.spec_pupd = mt8365_spec_pupd,
+	.n_spec_pupd = ARRAY_SIZE(mt8365_spec_pupd),
+	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
 	.spec_ies_smt_set = mt8365_ies_smt_set,
 	.dir_offset = 0x0140,
 	.dout_offset = 0x00A0,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8516.c b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
index 99c1a04c7fd8..8ad2006857c0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8516.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
@@ -186,13 +186,6 @@ static const struct mtk_pin_spec_pupd_set_samereg mt8516_spec_pupd[] = {
 	MTK_PIN_PUPD_SPEC_SR(120, 0xe00, 2, 1, 0),
 };
 
-static int mt8516_spec_pull_set(struct regmap *regmap, unsigned int pin,
-			unsigned char align, bool isup, unsigned int r1r0)
-{
-	return mtk_pctrl_spec_pull_set_samereg(regmap, mt8516_spec_pupd,
-		ARRAY_SIZE(mt8516_spec_pupd), pin, align, isup, r1r0);
-}
-
 static const struct mtk_pin_ies_smt_set mt8516_ies_set[] = {
 	MTK_PIN_IES_SMT_SPEC(0, 6, 0x900, 2),
 	MTK_PIN_IES_SMT_SPEC(7, 10, 0x900, 3),
@@ -311,7 +304,9 @@ static const struct mtk_pinctrl_devdata mt8516_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8516_drv_grp),
 	.pin_drv_grp = mt8516_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8516_pin_drv),
-	.spec_pull_set = mt8516_spec_pull_set,
+	.spec_pupd = mt8516_spec_pupd,
+	.n_spec_pupd = ARRAY_SIZE(mt8516_spec_pupd),
+	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
 	.spec_ies_smt_set = mt8516_ies_smt_set,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0500,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 007da39b68c9..5e1d17512a0d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -222,9 +222,8 @@ static int mtk_pconf_set_driving(struct mtk_pinctrl *pctl,
 }
 
 int mtk_pctrl_spec_pull_set_samereg(struct regmap *regmap,
-		const struct mtk_pin_spec_pupd_set_samereg *pupd_infos,
-		unsigned int info_num, unsigned int pin,
-		unsigned char align, bool isup, unsigned int r1r0)
+		const struct mtk_pinctrl_devdata *devdata,
+		unsigned int pin, bool isup, unsigned int r1r0)
 {
 	unsigned int i;
 	unsigned int reg_pupd, reg_set, reg_rst;
@@ -232,8 +231,11 @@ int mtk_pctrl_spec_pull_set_samereg(struct regmap *regmap,
 	const struct mtk_pin_spec_pupd_set_samereg *spec_pupd_pin;
 	bool find = false;
 
-	for (i = 0; i < info_num; i++) {
-		if (pin == pupd_infos[i].pin) {
+	if (!devdata->spec_pupd)
+		return -EINVAL;
+
+	for (i = 0; i < devdata->n_spec_pupd; i++) {
+		if (pin == devdata->spec_pupd[i].pin) {
 			find = true;
 			break;
 		}
@@ -242,9 +244,9 @@ int mtk_pctrl_spec_pull_set_samereg(struct regmap *regmap,
 	if (!find)
 		return -EINVAL;
 
-	spec_pupd_pin = pupd_infos + i;
-	reg_set = spec_pupd_pin->offset + align;
-	reg_rst = spec_pupd_pin->offset + (align << 1);
+	spec_pupd_pin = devdata->spec_pupd + i;
+	reg_set = spec_pupd_pin->offset + devdata->port_align;
+	reg_rst = spec_pupd_pin->offset + (devdata->port_align << 1);
 
 	if (isup)
 		reg_pupd = reg_rst;
@@ -293,12 +295,13 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
 	 * resistor bit, so we need this special handle.
 	 */
 	if (pctl->devdata->spec_pull_set) {
-		/* For special pins, bias-disable is set by R1R0,
+		/* For special pins, bias-disable is set by R1R0
 		 * the parameter should be "MTK_PUPD_SET_R1R0_00".
 		 */
 		r1r0 = enable ? arg : MTK_PUPD_SET_R1R0_00;
 		ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
-			pin, pctl->devdata->port_align, isup, r1r0);
+						   pctl->devdata, pin, isup,
+						   r1r0);
 		if (!ret)
 			return 0;
 	}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index cd264cc3547b..f7968a6ac563 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -193,6 +193,8 @@ struct mtk_eint_offsets {
  *
  * @grp_desc: The driving group info.
  * @pin_drv_grp: The driving group for all pins.
+ * @spec_pupd: Special pull up/down setting
+ * @n_spec_pupd: Number of entries in spec_pupd
  * @spec_pull_set: Each SoC may have special pins for pull up/down setting,
  *  these pins' pull setting are very different, they have separate pull
  *  up/down bit, R0 and R1 resistor bit, so they need special pull setting.
@@ -231,8 +233,11 @@ struct mtk_pinctrl_devdata {
 	unsigned int	n_grp_cls;
 	const struct mtk_pin_drv_grp	*pin_drv_grp;
 	unsigned int	n_pin_drv_grps;
-	int (*spec_pull_set)(struct regmap *reg, unsigned int pin,
-			unsigned char align, bool isup, unsigned int arg);
+	const struct mtk_pin_spec_pupd_set_samereg *spec_pupd;
+	unsigned int n_spec_pupd;
+	int (*spec_pull_set)(struct regmap *regmap,
+			const struct mtk_pinctrl_devdata *devdata,
+			unsigned int pin, bool isup, unsigned int r1r0);
 	int (*spec_ies_smt_set)(struct regmap *reg, unsigned int pin,
 			unsigned char align, int value, enum pin_config_param arg);
 	void (*spec_pinmux_set)(struct regmap *reg, unsigned int pin,
@@ -280,9 +285,8 @@ int mtk_pctrl_init(struct platform_device *pdev,
 int mtk_pctrl_common_probe(struct platform_device *pdev);
 
 int mtk_pctrl_spec_pull_set_samereg(struct regmap *regmap,
-		const struct mtk_pin_spec_pupd_set_samereg *pupd_infos,
-		unsigned int info_num, unsigned int pin,
-		unsigned char align, bool isup, unsigned int r1r0);
+		const struct mtk_pinctrl_devdata *devdata,
+		unsigned int pin, bool isup, unsigned int r1r0);
 
 int mtk_pconf_spec_set_ies_smt_range(struct regmap *regmap,
 		const struct mtk_pin_ies_smt_set *ies_smt_infos, unsigned int info_num,
-- 
2.33.1

