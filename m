Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41B158F973
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiHKIpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiHKIou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:44:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513B891085
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:44:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z2so22093406edc.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5tIyJd7B0eaGhd67Ybtop510tDngvww4odk8IMMRG6s=;
        b=59PQQYMw0Zm5ulpJrfvpl5YbbZlB3E3YXKz3F0lHJa6V9iyaHOXFllzSGUA/WttF5q
         cu8gTEqEoMGsfp58/p3FdS3pDNMN5JgoWaO+ZPACoomPjbxXxxY99qb15ry/coipDDlL
         ysRZoptSSvNz0FpRKYueVI75Be3rKGACAhrouLBKsiAGEH5aCd6t5npSHGot1XHmPZHZ
         d2ZnbiE8aJodxHkc7bzA6LlFcohOuu5FyCG8nqxXzUPWxvB+FQDzBwM70Kqd/KMH6ywj
         KPRPEkmjiF513VWcx3dkX3fg0U+V2vtqrNS5uwzka+VdOiDUe2pooDH6oLyJkoFgrROR
         jdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5tIyJd7B0eaGhd67Ybtop510tDngvww4odk8IMMRG6s=;
        b=XnuL2shywWLo0ZOyjnnDNHP7RVwDF6HEgX1zgCljrBx2wUKtTAQOeGAXgflwj+SHGC
         0GNBJtnN8NRYNQAsg8mgBalpDkP2gd0mU+ICSIdDorL3B3Gf41p4XE0r2PZcf59xxo7N
         3LF+/xIwxmemmfdIn6VZ6aZe16rIJductkNLRcbYZcON7tSy6yjem6BC9gwRA7kHndPp
         bv6kE82OC3HKJW91Mkxg7CWCYOfIzdocIBhAKemTbB7XizbybpTFtc49jdKF+MQ0zUT4
         czQbq61ifYiO6JpP19G5SO7SVsLQ0Mwp4VRQhhuz7Vds5aeJixOyYJPRpi0tjINWezDw
         D4Dg==
X-Gm-Message-State: ACgBeo3fQupwS5Begnr41YDpU0mhgLy9Aj0fbkQxX3hPA9pqUBYNpJ/U
        z8jnIC65xarpMQgsfNhsCqWAEA==
X-Google-Smtp-Source: AA6agR6jeK54Uy/TCm3EvDq24pgOJe+pznfoFX6xcVV9Pdh3UyU3/O14iqVLE5vRIMnGnrlKJY5YqQ==
X-Received: by 2002:a05:6402:2398:b0:43d:fd2c:b0a2 with SMTP id j24-20020a056402239800b0043dfd2cb0a2mr30114294eda.172.1660207482897;
        Thu, 11 Aug 2022 01:44:42 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a243:8036:200c:a862:4253:884])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7d5cf000000b0043d6ece495asm8799314eds.55.2022.08.11.01.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:44:42 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <parent.f@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 2/4] clk: mediatek: Provide mtk_devm_alloc_clk_data
Date:   Thu, 11 Aug 2022 10:44:31 +0200
Message-Id: <20220811084433.2598575-3-msp@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220811084433.2598575-1-msp@baylibre.com>
References: <20220811084433.2598575-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a helper that replaces the kzalloc with devm_kzalloc so error
handling gets easier.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    Changes in v3:
    - New patch

 drivers/clk/mediatek/clk-mtk.c | 33 ++++++++++++++++++++++++++++-----
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b9188000ab3c..a317e69cf298 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -18,19 +18,42 @@
 #include "clk-mtk.h"
 #include "clk-gate.h"
 
-struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
+static void mtk_init_clk_data(struct clk_hw_onecell_data *clk_data,
+			      unsigned int clk_num)
 {
 	int i;
+
+	clk_data->num = clk_num;
+
+	for (i = 0; i < clk_num; i++)
+		clk_data->hws[i] = ERR_PTR(-ENOENT);
+}
+
+struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
+						    unsigned int clk_num)
+{
 	struct clk_hw_onecell_data *clk_data;
 
-	clk_data = kzalloc(struct_size(clk_data, hws, clk_num), GFP_KERNEL);
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, clk_num),
+				GFP_KERNEL);
 	if (!clk_data)
 		return NULL;
 
-	clk_data->num = clk_num;
+	mtk_init_clk_data(clk_data, clk_num);
 
-	for (i = 0; i < clk_num; i++)
-		clk_data->hws[i] = ERR_PTR(-ENOENT);
+	return clk_data;
+}
+EXPORT_SYMBOL_GPL(mtk_devm_alloc_clk_data);
+
+struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
+{
+	struct clk_hw_onecell_data *clk_data;
+
+	clk_data = kzalloc(struct_size(clk_data, hws, clk_num), GFP_KERNEL);
+	if (!clk_data)
+		return NULL;
+
+	mtk_init_clk_data(clk_data, clk_num);
 
 	return clk_data;
 }
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index adb1304d35d4..4390058d172c 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -182,6 +182,8 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 				 struct clk_hw_onecell_data *clk_data);
 
 struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
+struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
+						    unsigned int clk_num);
 void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data);
 
 struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
-- 
2.36.1

