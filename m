Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9788D4C3215
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiBXQuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiBXQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA451B71AA;
        Thu, 24 Feb 2022 08:48:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so543965wra.12;
        Thu, 24 Feb 2022 08:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+5VyF9R5qg35oA2HOfIMNY2uyOZcGkyjiMySfjemwzQ=;
        b=ZA9s47j3zqu62IsneLKAOG6OV9LLOwuVlGjSlWLjSOxdoQ7GLq3f0S28oRwYj7FLkL
         2mrXnOerxY/bt9eaNfjyZ0KRZovs8fTv/DM9euKJHi9mD2CIHTQGRLBbeY8Xm1Z3KtC3
         ZBaByH8UqfpdgUYBqkoZnkyFst/ReE7HceKMtDeZlsCCfPJfwsC+H/K3Hu5JK8O+UMgM
         +07yW4zX+jF09vF75kg4lsG98ZX36H4U+UfdcxQertQnkKjrLJDepujF/zqKTtKOjfAS
         yAMCiXaWy98gXZTOjYjB/yY2kvlLVvIhDzaKfVqomGkozt6o6qRq5iUIM9FS4PaRghD1
         cFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5VyF9R5qg35oA2HOfIMNY2uyOZcGkyjiMySfjemwzQ=;
        b=Va1PNd95xhfse7xwtCYqI4WoteOWRsHirCQgEOJot8xzS1YL4EAL15/Y59Tq6h4Lj4
         /miMUcy9osj4PKG/hPlk+pTFWtzRtL/ZAydG6UMdBld13IcaWFzeBjlvBM9TR83KLrBx
         4/rR9IvXUA993Xw4PiKMM/jEpzzkiMGIldq3AQ+qtFY6H6UgQOjC093SAA1wYv7H9Fy0
         5ynM93aPR/U6XxsiBdEhSqlc07elT5ILuvhD+9/N9vvYRCd0QxbxY+JyQt/tYjaWVrvt
         gfFgjhYOsl2jVPsBVa2xDb6ArdjMvQUCa1LDKuBMhj8EBs5trpVvejje1DwA2ao+RvWQ
         zOcg==
X-Gm-Message-State: AOAM531iZcugamt0J/UK2neinvgCLHUkfLuHrdcd3yFmPFFFblrwDIvz
        oYCwHM1g5tPGM64snlUM3+g=
X-Google-Smtp-Source: ABdhPJwql7hK9Cj5MFOAeW0uaE5zsiqGHufEeNZWVzs+Nt0x6gbxbc1qiPvcd3JNT2v6CJ/7QtBdVQ==
X-Received: by 2002:adf:ec10:0:b0:1e4:b3e3:2ef8 with SMTP id x16-20020adfec10000000b001e4b3e32ef8mr2916779wrn.183.1645721331984;
        Thu, 24 Feb 2022 08:48:51 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:51 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/15] clk: qcom: clk-rcg: add clk_rcg_floor_ops ops
Date:   Thu, 24 Feb 2022 17:48:25 +0100
Message-Id: <20220224164831.21475-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clk_rcg_floor_ops for clock that can't provide a stable freq and
require to use a floor freq to provide the requested frequency.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/clk-rcg.c | 24 ++++++++++++++++++++++++
 drivers/clk/qcom/clk-rcg.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index a9d181d6be21..88845baa7f84 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -526,6 +526,19 @@ static int clk_rcg_set_rate(struct clk_hw *hw, unsigned long rate,
 	return __clk_rcg_set_rate(rcg, f);
 }
 
+static int clk_rcg_set_floor_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	struct clk_rcg *rcg = to_clk_rcg(hw);
+	const struct freq_tbl *f;
+
+	f = qcom_find_freq_floor(rcg->freq_tbl, rate);
+	if (!f)
+		return -EINVAL;
+
+	return __clk_rcg_set_rate(rcg, f);
+}
+
 static int clk_rcg_bypass_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
@@ -816,6 +829,17 @@ const struct clk_ops clk_rcg_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_rcg_ops);
 
+const struct clk_ops clk_rcg_floor_ops = {
+	.enable = clk_enable_regmap,
+	.disable = clk_disable_regmap,
+	.get_parent = clk_rcg_get_parent,
+	.set_parent = clk_rcg_set_parent,
+	.recalc_rate = clk_rcg_recalc_rate,
+	.determine_rate = clk_rcg_determine_rate,
+	.set_rate = clk_rcg_set_floor_rate,
+};
+EXPORT_SYMBOL_GPL(clk_rcg_floor_ops);
+
 const struct clk_ops clk_rcg_bypass_ops = {
 	.enable = clk_enable_regmap,
 	.disable = clk_disable_regmap,
diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 99efcc7f8d88..00cea508d49e 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -86,6 +86,7 @@ struct clk_rcg {
 };
 
 extern const struct clk_ops clk_rcg_ops;
+extern const struct clk_ops clk_rcg_floor_ops;
 extern const struct clk_ops clk_rcg_bypass_ops;
 extern const struct clk_ops clk_rcg_bypass2_ops;
 extern const struct clk_ops clk_rcg_pixel_ops;
-- 
2.34.1

