Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5844357FB23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiGYITf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiGYITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:19:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E5813CFA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so8853057wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rREHSjcfjpQHk4UrVZdBRlfSt+1lfTPjdekI0y3kZ04=;
        b=D56mAjLu+4DO0gYwFOIfTQoMPShxKAu9iqoLUzuAHDtYvr96HxZ4K8nWVi0emxOsdC
         GdOmL7lPLnAfs9ijm+KFBpT6tbGjfIZuapL0IxrUTXZ1V/o10UgD28U8tT70XTOPJdik
         fv5akro7XWCv7tF5D7GELbMONuk9HIBGFTZ3oLBMgVfQnX5qaagIMxyfnsiYuyBHHvFa
         bznbRwgn+gGqKgP1JxhjDVtw+2qcinXU7LuImk9iiRKU4iDX2DEt3T+SF2H0iYfPd8pI
         hkCNprZYObiZbtnZHTTRp0pS2SsI2xNWoTa/UTiDTz+dN/FNAPIf5W8jpuz/fRnjnTT7
         wMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rREHSjcfjpQHk4UrVZdBRlfSt+1lfTPjdekI0y3kZ04=;
        b=4tC5Gr5gN58GSQBPRSQbhIvyV5MqVpzX/oYXomlLu9UfaiMi9efibTJ8VNWQMqNih7
         ITvKOx8nSx8aZKl0ug3mBLyriWCr6CvnWiPuWuE7zwrUASbHioKuec99TFwuAKkAvwjG
         qnY9uYh1asN9iTeQYx5BMhCZCffY3PTdU/bmJZfBbo45Ydr2/Pv7dbRc76aJbO4KkfR1
         EnHptTJPB+EpxQUCaXQdmpcAx2Q/w69UteJWtGWqAzlJIObqWdQO32LA98Ld7Dq0hqel
         VCwNNPoc5jAhKlreGJxaYFQZL3m/VrhzJ5U8kb+yk8fsNA8iTl/d9Rp3JahYpN9NlqJ9
         F/Ww==
X-Gm-Message-State: AJIora+PhURO/tbfYTXUBJwMthlsnUjWyx+D5P4n4WVYEJu9dXpvEWFG
        q26l6+RyHOghd1+TrEaYmFVX9mlUqL+atA==
X-Google-Smtp-Source: AGRyM1vqDUKigQoG3ZcH0lsHrxYYImD6MOwA/s7sNlVJpsXootKiw4xE/A7jZKRVkC3sldrBKnN6rg==
X-Received: by 2002:a05:600c:c6:b0:3a3:ea8:7995 with SMTP id u6-20020a05600c00c600b003a30ea87995mr7653425wmm.135.1658737150258;
        Mon, 25 Jul 2022 01:19:10 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a243:806e:25e7:daa:8208:ceb])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm16695264wmh.33.2022.07.25.01.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 01:19:09 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 2/4] soc: mediatek: Add support of WAY_EN operations
Date:   Mon, 25 Jul 2022 10:18:51 +0200
Message-Id: <20220725081853.1636444-3-msp@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725081853.1636444-1-msp@baylibre.com>
References: <20220725081853.1636444-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

This updates the power domain to support WAY_EN operations. These
operations enable a path between different units of the chip and are
labeled as 'way_en' in the register descriptions.

This operation is required by the mt8365 for the MM power domain.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    Changes in v2:
    - some minor style fixes.
    - Renamed 'wayen' to 'way_en' to clarify the meaning
    - Updated commit message

 drivers/soc/mediatek/mtk-pm-domains.c | 64 +++++++++++++++++++++------
 drivers/soc/mediatek/mtk-pm-domains.h | 28 +++++++-----
 2 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 5ced254b082b..d0eae2227813 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -44,6 +44,7 @@ struct scpsys_domain {
 	struct clk_bulk_data *subsys_clks;
 	struct regmap *infracfg;
 	struct regmap *smi;
+	struct regmap *infracfg_nao;
 	struct regulator *supply;
 };
 
@@ -116,23 +117,38 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 					MTK_POLL_TIMEOUT);
 }
 
-static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
+static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
+				      struct regmap *regmap, struct regmap *infracfg_nao)
 {
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		u32 val, mask = bpd[i].bus_prot_mask;
+		u32 mask = bpd[i].bus_prot_mask;
+		u32 val = mask, sta_mask = mask;
+		struct regmap *ack_regmap = regmap;
 
 		if (!mask)
 			break;
 
+		if (bpd[i].way_en) {
+			if (!infracfg_nao)
+				return -ENODEV;
+
+			val = 0;
+			sta_mask = bpd[i].bus_prot_sta_mask;
+			ack_regmap = infracfg_nao;
+		}
+
 		if (bpd[i].bus_prot_reg_update)
-			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
+			regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, val);
 		else
 			regmap_write(regmap, bpd[i].bus_prot_set, mask);
 
-		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, (val & mask) == mask,
+		if (bpd[i].ignore_clr_ack)
+			continue;
+
+		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
+					       val, (val & sta_mask) == sta_mask,
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
@@ -145,34 +161,49 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 {
 	int ret;
 
-	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
+	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg,
+					 pd->infracfg, pd->infracfg_nao);
 	if (ret)
 		return ret;
 
-	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
+	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
 }
 
+#define mask_cond(way_en, val, mask) \
+	((way_en && ((val & mask) == mask)) || (!way_en && !(val & mask)))
+
 static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
-				       struct regmap *regmap)
+				       struct regmap *regmap, struct regmap *infracfg_nao)
 {
 	int i, ret;
 
 	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
-		u32 val, mask = bpd[i].bus_prot_mask;
+		u32 val = 0, mask = bpd[i].bus_prot_mask;
+		u32 sta_mask = mask;
+		struct regmap *ack_regmap = regmap;
 
 		if (!mask)
 			continue;
 
+		if (bpd[i].way_en) {
+			if (!infracfg_nao)
+				return -ENODEV;
+
+			val = mask;
+			sta_mask = bpd[i].bus_prot_sta_mask;
+			ack_regmap = infracfg_nao;
+		}
+
 		if (bpd[i].bus_prot_reg_update)
-			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
+			regmap_update_bits(regmap, bpd[i].bus_prot_clr, mask, val);
 		else
 			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
 
 		if (bpd[i].ignore_clr_ack)
 			continue;
 
-		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, !(val & mask),
+		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
+					       val, mask_cond(bpd[i].way_en, val, sta_mask),
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
@@ -185,11 +216,12 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 {
 	int ret;
 
-	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
+	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi, NULL);
 	if (ret)
 		return ret;
 
-	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
+	return _scpsys_bus_protect_disable(pd->data->bp_infracfg,
+			pd->infracfg, pd->infracfg_nao);
 }
 
 static int scpsys_regulator_enable(struct regulator *supply)
@@ -363,6 +395,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 			return ERR_CAST(pd->smi);
 	}
 
+	pd->infracfg_nao = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg_nao");
+	if (IS_ERR(pd->infracfg_nao))
+		return ERR_CAST(pd->infracfg_nao);
+
 	num_clks = of_clk_get_parent_count(node);
 	if (num_clks > 0) {
 		/* Calculate number of subsys_clks */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index daa24e890dd4..e788d6bdde9d 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -39,23 +39,29 @@
 
 #define SPM_MAX_BUS_PROT_DATA		6
 
-#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
-		.bus_prot_mask = (_mask),			\
-		.bus_prot_set = _set,				\
-		.bus_prot_clr = _clr,				\
-		.bus_prot_sta = _sta,				\
-		.bus_prot_reg_update = _update,			\
-		.ignore_clr_ack = _ignore,			\
+#define _BUS_PROT(_mask, _sta_mask, _set, _clr, _sta, _update, _ignore, _way_en) {	\
+		.bus_prot_mask = (_mask),				\
+		.bus_prot_set = _set,					\
+		.bus_prot_clr = _clr,					\
+		.bus_prot_sta = _sta,					\
+		.bus_prot_sta_mask = _sta_mask,				\
+		.bus_prot_reg_update = _update,				\
+		.ignore_clr_ack = _ignore,				\
+		.way_en = _way_en,					\
 	}
 
 #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
+		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, false, false)
 
 #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
+		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, true, false)
 
 #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
+		_BUS_PROT(_mask, _mask, _set, _clr, _sta, true, false, false)
+
+#define BUS_PROT_WAY_EN(_en_mask, _sta_mask, _set, _sta)	\
+		_BUS_PROT(_en_mask, _sta_mask, _set, _set, _sta, true, false, \
+			  true)
 
 #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
 		BUS_PROT_UPDATE(_mask,				\
@@ -68,8 +74,10 @@ struct scpsys_bus_prot_data {
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
 	u32 bus_prot_sta;
+	u32 bus_prot_sta_mask;
 	bool bus_prot_reg_update;
 	bool ignore_clr_ack;
+	bool way_en;
 };
 
 /**
-- 
2.36.1

