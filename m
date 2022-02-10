Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6374B1024
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiBJOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:19:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242766AbiBJOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:19:42 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3185139;
        Thu, 10 Feb 2022 06:19:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E0A3B1F46578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644502779;
        bh=57NHOvClgJm7JxVBdTIcEvBV3nuCjfG86wP9Y0a7m1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfL/COH0a5oZR/uHg1FmqsJFL40Wf7035LZVcE38Dj56hAdCnYxr5QcIUbD1WTWt4
         Zgtkd/b7EdzXlCsvfpmqgVMDA0TmpxCU2xks1V8qGbJ9u8xiejMZHP5Rx0kFjZgT7O
         Kobm6NlCD0mYSWXcxKNlDrICfCoR+Rw+d2CvboJFFGRTjzT0wMQ/PLQ3xiRcILSQEf
         FAcV9A83DH0oapMNe05gKc+yAfVguXG9dHkNM85kAb/NEdpph2vT4O8iiBm0oPLj/z
         ERFK+NrBPAfNMyJxdlKUe1cGF5PG685jboeHMcJBF81TTxGUzfq3TBMQ6beDJUKQdG
         HBTvJYIkVNlwg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/5] pinctrl: mediatek: common-v1: Commonize spec_ies_smt_set callback
Date:   Thu, 10 Feb 2022 15:19:31 +0100
Message-Id: <20220210141931.291712-6-angelogioacchino.delregno@collabora.com>
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

All of the MediaTek pinctrl drivers registering with pinctrl-mtk-common
that are offering a .spec_ies_smt_set() callback are declaring their
own function which is doing exactly the same on all drivers: calling
mtk_pconf_spec_set_ies_smt_range() with their struct and a simple check.

Commonize this callback by adding the ies and smt structure pointers
to struct mtk_pinctrl_devdata and changing the callback signature to
take it.

Removing the callback and checking for the existence of the spec_smt
and/or spec_ies data would allow us to staticize the function
mtk_pconf_spec_set_ies_smt_range(), but this solution was avoided as
to keep flexibility, as some SoCs may need to perform a very different
operation compared to what this commonized function is doing.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt2701.c     | 18 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     | 19 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mt8127.c     | 19 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mt8167.c     | 18 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     | 18 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mt8365.c     | 18 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mt8516.c     | 18 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 29 +++++++++++++++----
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h | 17 ++++++++---
 9 files changed, 71 insertions(+), 103 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
index 816de39858f8..d1583b4fdd9d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -429,18 +429,6 @@ static const struct mtk_pin_ies_smt_set mt2701_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(278, 278, 0xb70, 13),
 };
 
-static int mt2701_ies_smt_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, int value, enum pin_config_param arg)
-{
-	if (arg == PIN_CONFIG_INPUT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt2701_ies_set,
-			ARRAY_SIZE(mt2701_ies_set), pin, align, value);
-	else if (arg == PIN_CONFIG_INPUT_SCHMITT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt2701_smt_set,
-			ARRAY_SIZE(mt2701_smt_set), pin, align, value);
-	return -EINVAL;
-}
-
 static const struct mtk_spec_pinmux_set mt2701_spec_pinmux[] = {
 	MTK_PINMUX_SPEC(22, 0xb10, 3),
 	MTK_PINMUX_SPEC(23, 0xb10, 4),
@@ -501,10 +489,14 @@ static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt2701_drv_grp),
 	.pin_drv_grp = mt2701_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt2701_pin_drv),
+	.spec_ies = mt2701_ies_set,
+	.n_spec_ies = ARRAY_SIZE(mt2701_ies_set),
 	.spec_pupd = mt2701_spec_pupd,
 	.n_spec_pupd = ARRAY_SIZE(mt2701_spec_pupd),
+	.spec_smt = mt2701_smt_set,
+	.n_spec_smt = ARRAY_SIZE(mt2701_smt_set),
 	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
-	.spec_ies_smt_set = mt2701_ies_smt_set,
+	.spec_ies_smt_set = mtk_pconf_spec_set_ies_smt_range,
 	.spec_pinmux_set = mt2701_spec_pinmux_set,
 	.spec_dir_set = mt2701_spec_dir_set,
 	.dir_offset = 0x0000,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
index b6182b06584b..b921068f9e69 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2712.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -275,19 +275,6 @@ static const struct mtk_pin_ies_smt_set mt2712_ies_set[] = {
 	MTK_PIN_IES_SMT_SPEC(207, 209, 0x8b0, 15)
 };
 
-static int mt2712_ies_smt_set(struct regmap *regmap, unsigned int pin,
-			      unsigned char align,
-			      int value, enum pin_config_param arg)
-{
-	if (arg == PIN_CONFIG_INPUT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt2712_ies_set,
-			ARRAY_SIZE(mt2712_ies_set), pin, align, value);
-	if (arg == PIN_CONFIG_INPUT_SCHMITT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt2712_smt_set,
-			ARRAY_SIZE(mt2712_smt_set), pin, align, value);
-	return -EINVAL;
-}
-
 static const struct mtk_drv_group_desc mt2712_drv_grp[] =  {
 	/* 0E4E8SR 4/8/12/16 */
 	MTK_DRV_GRP(4, 16, 1, 2, 4),
@@ -553,10 +540,14 @@ static const struct mtk_pinctrl_devdata mt2712_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt2712_drv_grp),
 	.pin_drv_grp = mt2712_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt2712_pin_drv),
+	.spec_ies = mt2712_ies_set,
+	.n_spec_ies = ARRAY_SIZE(mt2712_ies_set),
 	.spec_pupd = mt2712_spec_pupd,
 	.n_spec_pupd = ARRAY_SIZE(mt2712_spec_pupd),
+	.spec_smt = mt2712_smt_set,
+	.n_spec_smt = ARRAY_SIZE(mt2712_smt_set),
 	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
-	.spec_ies_smt_set = mt2712_ies_smt_set,
+	.spec_ies_smt_set = mtk_pconf_spec_set_ies_smt_range,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0100,
 	.pullsel_offset = 0x0200,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8127.c b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
index 9745d15f93ec..91c530e7b00e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8127.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
@@ -252,19 +252,6 @@ static const struct mtk_pin_ies_smt_set mt8127_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(142, 142, 0x920, 13),
 };
 
-static int mt8127_ies_smt_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, int value, enum pin_config_param arg)
-{
-	if (arg == PIN_CONFIG_INPUT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8127_ies_set,
-			ARRAY_SIZE(mt8127_ies_set), pin, align, value);
-	else if (arg == PIN_CONFIG_INPUT_SCHMITT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8127_smt_set,
-			ARRAY_SIZE(mt8127_smt_set), pin, align, value);
-	return -EINVAL;
-}
-
-
 static const struct mtk_pinctrl_devdata mt8127_pinctrl_data = {
 	.pins = mtk_pins_mt8127,
 	.npins = ARRAY_SIZE(mtk_pins_mt8127),
@@ -272,10 +259,14 @@ static const struct mtk_pinctrl_devdata mt8127_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8127_drv_grp),
 	.pin_drv_grp = mt8127_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8127_pin_drv),
+	.spec_ies = mt8127_ies_set,
+	.n_spec_ies = ARRAY_SIZE(mt8127_ies_set),
 	.spec_pupd = mt8127_spec_pupd,
 	.n_spec_pupd = ARRAY_SIZE(mt8127_spec_pupd),
+	.spec_smt = mt8127_smt_set,
+	.n_spec_smt = ARRAY_SIZE(mt8127_smt_set),
 	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
-	.spec_ies_smt_set = mt8127_ies_smt_set,
+	.spec_ies_smt_set = mtk_pconf_spec_set_ies_smt_range,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0100,
 	.pullsel_offset = 0x0200,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8167.c b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
index 118ddcba18fc..825167f5d020 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8167.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
@@ -285,18 +285,6 @@ static const struct mtk_pin_ies_smt_set mt8167_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(121, 124, 0xA10, 9),
 };
 
-static int mt8167_ies_smt_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, int value, enum pin_config_param arg)
-{
-	if (arg == PIN_CONFIG_INPUT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8167_ies_set,
-			ARRAY_SIZE(mt8167_ies_set), pin, align, value);
-	else if (arg == PIN_CONFIG_INPUT_SCHMITT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8167_smt_set,
-			ARRAY_SIZE(mt8167_smt_set), pin, align, value);
-	return -EINVAL;
-}
-
 static const struct mtk_pinctrl_devdata mt8167_pinctrl_data = {
 	.pins = mtk_pins_mt8167,
 	.npins = ARRAY_SIZE(mtk_pins_mt8167),
@@ -304,10 +292,14 @@ static const struct mtk_pinctrl_devdata mt8167_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8167_drv_grp),
 	.pin_drv_grp = mt8167_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8167_pin_drv),
+	.spec_ies = mt8167_ies_set,
+	.n_spec_ies = ARRAY_SIZE(mt8167_ies_set),
 	.spec_pupd = mt8167_spec_pupd,
 	.n_spec_pupd = ARRAY_SIZE(mt8167_spec_pupd),
+	.spec_smt = mt8167_smt_set,
+	.n_spec_smt = ARRAY_SIZE(mt8167_smt_set),
 	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
-	.spec_ies_smt_set = mt8167_ies_smt_set,
+	.spec_ies_smt_set = mtk_pconf_spec_set_ies_smt_range,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0500,
 	.pullsel_offset = 0x0600,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index b34c9778e131..1d7d11a32e7d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -167,18 +167,6 @@ static const struct mtk_pin_ies_smt_set mt8173_ies_set[] = {
 	MTK_PIN_IES_SMT_SPEC(133, 134, 0x910, 8)
 };
 
-static int mt8173_ies_smt_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, int value, enum pin_config_param arg)
-{
-	if (arg == PIN_CONFIG_INPUT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8173_ies_set,
-			ARRAY_SIZE(mt8173_ies_set), pin, align, value);
-	else if (arg == PIN_CONFIG_INPUT_SCHMITT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8173_smt_set,
-			ARRAY_SIZE(mt8173_smt_set), pin, align, value);
-	return -EINVAL;
-}
-
 static const struct mtk_drv_group_desc mt8173_drv_grp[] =  {
 	/* 0E4E8SR 4/8/12/16 */
 	MTK_DRV_GRP(4, 16, 1, 2, 4),
@@ -312,10 +300,14 @@ static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8173_drv_grp),
 	.pin_drv_grp = mt8173_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8173_pin_drv),
+	.spec_ies = mt8173_ies_set,
+	.n_spec_ies = ARRAY_SIZE(mt8173_ies_set),
 	.spec_pupd = mt8173_spec_pupd,
 	.n_spec_pupd = ARRAY_SIZE(mt8173_spec_pupd),
+	.spec_smt = mt8173_smt_set,
+	.n_spec_smt = ARRAY_SIZE(mt8173_smt_set),
 	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
-	.spec_ies_smt_set = mt8173_ies_smt_set,
+	.spec_ies_smt_set = mtk_pconf_spec_set_ies_smt_range,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0100,
 	.pullsel_offset = 0x0200,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index dbff7a831235..727c65221aef 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -416,18 +416,6 @@ static const struct mtk_pin_ies_smt_set mt8365_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(144, 144, 0x480, 22),
 };
 
-static int mt8365_ies_smt_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, int value, enum pin_config_param arg)
-{
-	if (arg == PIN_CONFIG_INPUT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8365_ies_set,
-			ARRAY_SIZE(mt8365_ies_set), pin, align, value);
-	else if (arg == PIN_CONFIG_INPUT_SCHMITT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8365_smt_set,
-			ARRAY_SIZE(mt8365_smt_set), pin, align, value);
-	return -EINVAL;
-}
-
 static const struct mtk_pinctrl_devdata mt8365_pinctrl_data = {
 	.pins = mtk_pins_mt8365,
 	.npins = ARRAY_SIZE(mtk_pins_mt8365),
@@ -435,10 +423,14 @@ static const struct mtk_pinctrl_devdata mt8365_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8365_drv_grp),
 	.pin_drv_grp = mt8365_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8365_pin_drv),
+	.spec_ies = mt8365_ies_set,
+	.n_spec_ies = ARRAY_SIZE(mt8365_ies_set),
+	.spec_smt = mt8365_smt_set,
+	.n_spec_smt = ARRAY_SIZE(mt8365_smt_set),
 	.spec_pupd = mt8365_spec_pupd,
 	.n_spec_pupd = ARRAY_SIZE(mt8365_spec_pupd),
 	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
-	.spec_ies_smt_set = mt8365_ies_smt_set,
+	.spec_ies_smt_set = mtk_pconf_spec_set_ies_smt_range,
 	.dir_offset = 0x0140,
 	.dout_offset = 0x00A0,
 	.din_offset = 0x0000,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8516.c b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
index 8ad2006857c0..939a1932b8dc 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8516.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
@@ -285,18 +285,6 @@ static const struct mtk_pin_ies_smt_set mt8516_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(121, 124, 0xA10, 9),
 };
 
-static int mt8516_ies_smt_set(struct regmap *regmap, unsigned int pin,
-		unsigned char align, int value, enum pin_config_param arg)
-{
-	if (arg == PIN_CONFIG_INPUT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8516_ies_set,
-			ARRAY_SIZE(mt8516_ies_set), pin, align, value);
-	else if (arg == PIN_CONFIG_INPUT_SCHMITT_ENABLE)
-		return mtk_pconf_spec_set_ies_smt_range(regmap, mt8516_smt_set,
-			ARRAY_SIZE(mt8516_smt_set), pin, align, value);
-	return -EINVAL;
-}
-
 static const struct mtk_pinctrl_devdata mt8516_pinctrl_data = {
 	.pins = mtk_pins_mt8516,
 	.npins = ARRAY_SIZE(mtk_pins_mt8516),
@@ -304,10 +292,14 @@ static const struct mtk_pinctrl_devdata mt8516_pinctrl_data = {
 	.n_grp_cls = ARRAY_SIZE(mt8516_drv_grp),
 	.pin_drv_grp = mt8516_pin_drv,
 	.n_pin_drv_grps = ARRAY_SIZE(mt8516_pin_drv),
+	.spec_ies = mt8516_ies_set,
+	.n_spec_ies = ARRAY_SIZE(mt8516_ies_set),
 	.spec_pupd = mt8516_spec_pupd,
 	.n_spec_pupd = ARRAY_SIZE(mt8516_spec_pupd),
+	.spec_smt = mt8516_smt_set,
+	.n_spec_smt = ARRAY_SIZE(mt8516_smt_set),
 	.spec_pull_set = mtk_pctrl_spec_pull_set_samereg,
-	.spec_ies_smt_set = mt8516_ies_smt_set,
+	.spec_ies_smt_set = mtk_pconf_spec_set_ies_smt_range,
 	.dir_offset = 0x0000,
 	.pullen_offset = 0x0500,
 	.pullsel_offset = 0x0600,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 5e1d17512a0d..a515fdc43b85 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -131,7 +131,7 @@ static int mtk_pconf_set_ies_smt(struct mtk_pinctrl *pctl, unsigned pin,
 	 */
 	if (pctl->devdata->spec_ies_smt_set) {
 		return pctl->devdata->spec_ies_smt_set(mtk_get_regmap(pctl, pin),
-			pin, pctl->devdata->port_align, value, arg);
+			pctl->devdata, pin, value, arg);
 	}
 
 	if (arg == PIN_CONFIG_INPUT_ENABLE)
@@ -151,10 +151,27 @@ static int mtk_pconf_set_ies_smt(struct mtk_pinctrl *pctl, unsigned pin,
 }
 
 int mtk_pconf_spec_set_ies_smt_range(struct regmap *regmap,
-		const struct mtk_pin_ies_smt_set *ies_smt_infos, unsigned int info_num,
-		unsigned int pin, unsigned char align, int value)
+		const struct mtk_pinctrl_devdata *devdata,
+		unsigned int pin, int value, enum pin_config_param arg)
 {
-	unsigned int i, reg_addr, bit;
+	const struct mtk_pin_ies_smt_set *ies_smt_infos = NULL;
+	unsigned int i, info_num, reg_addr, bit;
+
+	switch (arg) {
+	case PIN_CONFIG_INPUT_ENABLE:
+		ies_smt_infos = devdata->spec_ies;
+		info_num = devdata->n_spec_ies;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		ies_smt_infos = devdata->spec_smt;
+		info_num = devdata->n_spec_smt;
+		break;
+	default:
+		break;
+	};
+
+	if (!ies_smt_infos)
+		return -EINVAL;
 
 	for (i = 0; i < info_num; i++) {
 		if (pin >= ies_smt_infos[i].start &&
@@ -167,9 +184,9 @@ int mtk_pconf_spec_set_ies_smt_range(struct regmap *regmap,
 		return -EINVAL;
 
 	if (value)
-		reg_addr = ies_smt_infos[i].offset + align;
+		reg_addr = ies_smt_infos[i].offset + devdata->port_align;
 	else
-		reg_addr = ies_smt_infos[i].offset + (align << 1);
+		reg_addr = ies_smt_infos[i].offset + (devdata->port_align << 1);
 
 	bit = BIT(ies_smt_infos[i].bit);
 	regmap_write(regmap, reg_addr, bit);
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index f7968a6ac563..6fe8564334c9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -193,8 +193,12 @@ struct mtk_eint_offsets {
  *
  * @grp_desc: The driving group info.
  * @pin_drv_grp: The driving group for all pins.
+ * @spec_ies: Special pin setting for input enable
+ * @n_spec_ies: Number of entries in spec_ies
  * @spec_pupd: Special pull up/down setting
  * @n_spec_pupd: Number of entries in spec_pupd
+ * @spec_smt: Special pin setting for schmitt
+ * @n_spec_smt: Number of entries in spec_smt
  * @spec_pull_set: Each SoC may have special pins for pull up/down setting,
  *  these pins' pull setting are very different, they have separate pull
  *  up/down bit, R0 and R1 resistor bit, so they need special pull setting.
@@ -233,13 +237,18 @@ struct mtk_pinctrl_devdata {
 	unsigned int	n_grp_cls;
 	const struct mtk_pin_drv_grp	*pin_drv_grp;
 	unsigned int	n_pin_drv_grps;
+	const struct mtk_pin_ies_smt_set *spec_ies;
+	unsigned int n_spec_ies;
 	const struct mtk_pin_spec_pupd_set_samereg *spec_pupd;
 	unsigned int n_spec_pupd;
+	const struct mtk_pin_ies_smt_set *spec_smt;
+	unsigned int n_spec_smt;
 	int (*spec_pull_set)(struct regmap *regmap,
 			const struct mtk_pinctrl_devdata *devdata,
 			unsigned int pin, bool isup, unsigned int r1r0);
-	int (*spec_ies_smt_set)(struct regmap *reg, unsigned int pin,
-			unsigned char align, int value, enum pin_config_param arg);
+	int (*spec_ies_smt_set)(struct regmap *reg,
+			const struct mtk_pinctrl_devdata *devdata,
+			unsigned int pin, int value, enum pin_config_param arg);
 	void (*spec_pinmux_set)(struct regmap *reg, unsigned int pin,
 			unsigned int mode);
 	void (*spec_dir_set)(unsigned int *reg_addr, unsigned int pin);
@@ -289,8 +298,8 @@ int mtk_pctrl_spec_pull_set_samereg(struct regmap *regmap,
 		unsigned int pin, bool isup, unsigned int r1r0);
 
 int mtk_pconf_spec_set_ies_smt_range(struct regmap *regmap,
-		const struct mtk_pin_ies_smt_set *ies_smt_infos, unsigned int info_num,
-		unsigned int pin, unsigned char align, int value);
+		const struct mtk_pinctrl_devdata *devdata,
+		unsigned int pin, int value, enum pin_config_param arg);
 
 extern const struct dev_pm_ops mtk_eint_pm_ops;
 
-- 
2.33.1

