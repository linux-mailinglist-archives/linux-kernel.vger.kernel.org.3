Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0E538848
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbiE3Umh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241496AbiE3Umc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:42:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A7525293
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:42:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z17so7005784wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkFKykSg+LXExaO0zjWiIjLlKGz26EUYiL/1qNJ2Q8w=;
        b=Yhl2ZB+7Oo+MPtAhiZPeb1kGOMCy4KpgnrI1FI8wALaO4TnnblLX3RYtX71zTX8Ty+
         /rPiSwPS8Ntj1+6iluycUEgCuOi2rovnnYNtL3FABc18GLpj7FNM5fZSVhBhmZycGKVu
         6LubAHLGtOMujGoNYwKkV4pdUWEsj/KowS9g2145xsMXol0LyLtC6ANFCtp0XQ3WlXLT
         E1RyWfnQpYGdQ9JEXNpRh67kZbdQ/iOU2jjdJgxOAPBx01toc85+LHc3mRy1MF+UCZfV
         ifCLCxjBeUNqQ6QcuPzm4kS5b0w4/5ivZW9Ijl7dU266jlgxaELeiiMp6jxo7boo3OBF
         IirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkFKykSg+LXExaO0zjWiIjLlKGz26EUYiL/1qNJ2Q8w=;
        b=SND5W82wWrDX0oDCgNfQjxUysQgGEqqqrwwGUwcUUfh71/jXvcNRSY/NSoSkirg4Yp
         fGUFiMw3VUbYfJJM2cyDGhUQm/bJi2wb/8wpmtLp+ovd6km1bbzfqosMGPw9Nl8O2e72
         S4/x6d4cGKNzglMkQIB1socGhYAJ9k7cswRFFwHj7WFDDqSZ5Tm+o7yn+s/fXzHit7Pr
         G8jhdDNQTIUWmExb4R44k3oKb7thkix/GKC04cSs5xnMHAWCix2b7O9k9BviZ5k8nR4z
         4Ah4wQ2+9io0mStrHVhOSR4HpT62XurpvDo4QY7/M5XLmWbTlJ72OfIJykGwj2bjMjy7
         N3ow==
X-Gm-Message-State: AOAM531W1+w4rKqq97g5ripxAtIAqYGhO1v1/xpBgzmLr5pgbB1P03+P
        8qCBwQxEdJXEEncCAVe3q4vIeHxR4/YZCA==
X-Google-Smtp-Source: ABdhPJyWZ0ltCGykHekzkC4wGU2P0YpdAkpBmOKuYqWdsTCUCVOJrAGcowWtV41kGKzubyTCQ0edQg==
X-Received: by 2002:a05:600c:2b8f:b0:397:46f2:7a10 with SMTP id j15-20020a05600c2b8f00b0039746f27a10mr20146610wmc.75.1653943349546;
        Mon, 30 May 2022 13:42:29 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id w13-20020a7bc74d000000b0039b17714eb2sm262253wmk.34.2022.05.30.13.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:42:28 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] soc: mediatek: Add support of WAYEN operations
Date:   Mon, 30 May 2022 22:42:12 +0200
Message-Id: <20220530204214.913251-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530204214.913251-1-fparent@baylibre.com>
References: <20220530204214.913251-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

This updates the power domain to support WAYEN operations.
This is required by the mt8365 for the MM power domain.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 64 +++++++++++++++++++++------
 drivers/soc/mediatek/mtk-pm-domains.h | 27 ++++++-----
 2 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 5ced254b082b..90b91b3b19a8 100644
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
 
+		if (bpd[i].wayen) {
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
+			pd->infracfg, pd->infracfg_nao);
 	if (ret)
 		return ret;
 
-	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
+	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
 }
 
+#define mask_cond(wayen, val, mask) \
+	((wayen && ((val & mask) == mask)) || (!wayen && !(val & mask)))
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
 
+		if (bpd[i].wayen) {
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
+					       val, mask_cond(bpd[i].wayen, val, sta_mask),
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
index daa24e890dd4..a3955d960233 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -39,23 +39,28 @@
 
 #define SPM_MAX_BUS_PROT_DATA		6
 
-#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
-		.bus_prot_mask = (_mask),			\
-		.bus_prot_set = _set,				\
-		.bus_prot_clr = _clr,				\
-		.bus_prot_sta = _sta,				\
-		.bus_prot_reg_update = _update,			\
-		.ignore_clr_ack = _ignore,			\
+#define _BUS_PROT(_mask, _sta_mask, _set, _clr, _sta, _update, _ignore, _wayen) {	\
+		.bus_prot_mask = (_mask),				\
+		.bus_prot_set = _set,					\
+		.bus_prot_clr = _clr,					\
+		.bus_prot_sta = _sta,					\
+		.bus_prot_sta_mask = _sta_mask,				\
+		.bus_prot_reg_update = _update,				\
+		.ignore_clr_ack = _ignore,				\
+		.wayen = _wayen,					\
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
+#define BUS_PROT_WAYEN(_en_mask, _sta_mask, _set, _sta)		\
+		_BUS_PROT(_en_mask, _sta_mask, _set, _set, _sta, true, false, true)
 
 #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
 		BUS_PROT_UPDATE(_mask,				\
@@ -68,8 +73,10 @@ struct scpsys_bus_prot_data {
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
 	u32 bus_prot_sta;
+	u32 bus_prot_sta_mask;
 	bool bus_prot_reg_update;
 	bool ignore_clr_ack;
+	bool wayen;
 };
 
 /**
-- 
2.36.1

