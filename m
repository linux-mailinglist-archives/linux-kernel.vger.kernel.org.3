Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F210A4A722A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbiBBNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiBBNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:10 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC578C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:50:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so6919951pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Wqt8bANP5ifvGkIaVLK4/SfxJUiMOM5777d8fxcmLM=;
        b=m2ksXmN7GxvSJ/YH+L/9081yGbKbVptVViQ7mbt5uZRnW8oCM+USFPKAP+awj9+dFG
         jO235c+pDT2bEX4Nr7VfDXg1JwB+GOzcK6xg5uUworwikrQ4prvPI/CJ3qNxqaLTyMGD
         paUb6rV0mbYbYGkmOIZ+tDuDktrRvNfBZkToM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Wqt8bANP5ifvGkIaVLK4/SfxJUiMOM5777d8fxcmLM=;
        b=u6Crqw31mWZIj7ha/XqhTkKUuKKV1OTvVZ1BNob9LRL1ojjKFC+ywEdYZ54y++iHik
         dWSzcL4QIBWGh624//s/dMm2Ecs6Dpj0T+Yu44Bnftz/bAwM/gv6i4cASPbF1Hg5HMm5
         mp5Y4E5eLrtbmtUhs1UlMAzzc9y07OyzpI/GCHKiBvV1Y2RfETzZuPkcTVi+YURnqqe9
         Vnys0Jn6cqOoLGX+fRGMvkp+CF038peDhS0RHbvxngpEjdoBwTmYptXl+nvq7F3rYYBu
         X0/izHgDxpEwz09tA8ANlaqX7yTp9lxx9eFLj3yoZc6K05CpZI44xZrxBBuyWvsPA74x
         W66A==
X-Gm-Message-State: AOAM530v0hPjoze8y6fyqcy35UFkjtJiLC44T4kCzbaG4G4Jvg4sAaG6
        7u7TtmGsQviPbLV2F0LBehuAfw==
X-Google-Smtp-Source: ABdhPJz8hyWt2PyEVsnlaUWVM4Es83yV7JTMjXR/JmTG23iFKVNdT73cJkCBQTXNY12fQ41KC/4EBg==
X-Received: by 2002:a17:90b:358e:: with SMTP id mm14mr8052020pjb.229.1643809810312;
        Wed, 02 Feb 2022 05:50:10 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:50:10 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/31] clk: mediatek: Implement mtk_clk_unregister_factors() API
Date:   Wed,  2 Feb 2022 21:48:19 +0800
Message-Id: <20220202134834.690675-17-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_clk_register_factors(), as the name suggests, is used to register
a given list of fixed factor clks. However it is lacking a counterpart
unregister API.

Implement said unregister API so that the various clock platform drivers
can utilize it to do proper unregistration, cleanup and removal.

In the header file, the register function's declaration is also
reformatted to fit code style guidelines.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 20 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  6 ++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 7c0d5706eed7..b267b2f04b84 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -126,6 +126,26 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
 
+void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
+				struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	if (!clk_data)
+		return;
+
+	for (i = num; i > 0; i--) {
+		const struct mtk_fixed_factor *ff = &clks[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
+			continue;
+
+		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
+		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
+
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index cc7f920eabb4..4db1a97c1250 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -55,8 +55,10 @@ struct mtk_fixed_factor {
 		.div = _div,				\
 	}
 
-void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
-		int num, struct clk_onecell_data *clk_data);
+void mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
+			      struct clk_onecell_data *clk_data);
+void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
+				struct clk_onecell_data *clk_data);
 
 struct mtk_composite {
 	int id;
-- 
2.35.0.rc2.247.g8bbb082509-goog

