Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B170E59C2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiHVP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbiHVP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:28:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9927662
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:27:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so13697387wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=28oTaBj3QQ5qfaOFdNPJMDdWbmEaZFUPrH2tNyFmGNs=;
        b=Mz37NWkaYb8tMZzMmpyuq6NH9EzKNwvmWsb3pTvm4FhWcQbDGD11j6E62eklimeBJY
         3p9KSEGRD+4Fy+N918v25mr32pNsi3krgMHS4wTrb3BK+xetSFwNVbMS7Cb23Bp80yhL
         yAcgkqmXLCeB4oudoaBtSXH/QLAv8qCTE33weqW3pJ3VszCOnzEpZHy7IvvL45PLN58k
         4SqzJnOs9xSWK282JiFioTkTntzb2mEbq1Q0ysUWJYCgFiCrjht1OXBUByxGq270M3bB
         mQG8vG6s3rZAmCDJ0xm/c0Cy9C374UIWueZy882vN51ffj+1HCVc0lx1FlNB6atJDOno
         a7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=28oTaBj3QQ5qfaOFdNPJMDdWbmEaZFUPrH2tNyFmGNs=;
        b=NRZ6eYg6AUzdjTZXUUUub9zQUEIRCAIROScKPV01wDjSBZxJ/xmQ8M1oLckCeE5j2g
         shjys/+zVyX5kn8x2r1q6auT5sW6FRZfnnUPg7SG7sj9xJwMtmC+u3nySZsNYRMthTjR
         sUvZ5D9n6JfoNmT2TtXysj0s1lG8Xm17guiB5RyHNbXsH4FCyl3RwRI52aP30TB2NjTX
         FiAmczCYRIPCG2anfb0JukwigQzzzu51JmRgWckMEaHu0PvTYaeR04sL5OL/xgYXZMjV
         qKUllvM4rY3NW9uxT61qJTT31zZ/lY8xlo/i8MPdUabaws5PEuKBF413yCXLSP3qi31y
         Bsfg==
X-Gm-Message-State: ACgBeo01oF8tGzgluAUs7Ob2FJ8uUW8PNlPlGsiHiGfjFfY+R5oShvto
        1iCHGs7N36gnLTwrpkC5/VpMQA==
X-Google-Smtp-Source: AA6agR4u3+bPVRQ4wO7LjAXuGWcbUhm/5HfeLP71djMpFnwiWgUWX9PeYY1veq2kxJ45kdfxXbP2rA==
X-Received: by 2002:a05:6000:1867:b0:21f:f2cf:74a8 with SMTP id d7-20020a056000186700b0021ff2cf74a8mr11191849wri.344.1661182050812;
        Mon, 22 Aug 2022 08:27:30 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a245:8020:2658:1f7c:362:3e99])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdb92000000b0021eaf4138aesm14492011wri.108.2022.08.22.08.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:27:30 -0700 (PDT)
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
Subject: [PATCH v4 2/4] clk: mediatek: Provide mtk_devm_alloc_clk_data
Date:   Mon, 22 Aug 2022 17:26:50 +0200
Message-Id: <20220822152652.3499972-3-msp@baylibre.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822152652.3499972-1-msp@baylibre.com>
References: <20220822152652.3499972-1-msp@baylibre.com>
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
index 05a188c62119..ef4c29422bbb 100644
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
index 1b95c484d5aa..190fe66ae79f 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -184,6 +184,8 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 				 struct clk_hw_onecell_data *clk_data);
 
 struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
+struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
+						    unsigned int clk_num);
 void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data);
 
 struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
-- 
2.37.2

