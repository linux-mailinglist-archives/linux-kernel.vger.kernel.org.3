Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556F6496B50
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiAVJS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiAVJSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:20 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF3AC061748
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:20 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w190so4880433pfw.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0r/icLyBiPRWAX9DR8xwoo1Ajn0xsQM7/jQJfiNovl4=;
        b=NIkPglMlv2Ah6b+M/D72wGdMSWs329exo2s/sWwo2kEcfCVveRvRW8MflsWkpCHok3
         UZJp2re6/JJjOPSx8f/2LE/F4aWPQMMtXDkn8xgg+wi4Q6MmSbCmDvaIcAGT/QwbE6Oi
         zhQ2nJ1tR6PVO4uBVfjkOAcFQ/7daZCPRGv40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0r/icLyBiPRWAX9DR8xwoo1Ajn0xsQM7/jQJfiNovl4=;
        b=bh6Jatf9NTYdNjf7/T+3EUuHWfzwocXM+wsi+apw5roosyRlIUFn7SmKHbA869tRZP
         pqWu1QsoYSnMCKfIane0qmGnHqJ5iT/MQ0mV/Xz79+kdXJE1MLB51cr4N4W5WuUmdP8g
         twYyKtukLONteZ6RQRGTSnYIEUjZbKKFMAhrvyaLlbpq6GScDI9VfKiwTFBk8uJV6NeF
         ZKwRTaXKsYOvtRTW190/xiR/r9ys7bvyVVi11aD2A/9h1cywXNf1zx6p+VoAD55pVov2
         Q3UPkIh3cAL18osu4ylyrGnfJt07urAIhiCgni/GkbPPSKDsRTA+oAL2NHAddHi9pq0v
         GL5A==
X-Gm-Message-State: AOAM532/JMEciEUN6LkPM7f6PJfngxVHoApUjPJ6WDiIg2fsOLpAtrmB
        BSPxh6g4ljBZX2879NEO3Pi5lA==
X-Google-Smtp-Source: ABdhPJwZs4dBcrlJUtQnvPcUNmuVMsA70DkLPP33YojMfq1AMhxrajglxuuN8K2CRtm/7ScyiwQpMw==
X-Received: by 2002:a65:4685:: with SMTP id h5mr5536639pgr.14.1642843100230;
        Sat, 22 Jan 2022 01:18:20 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:19 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/31] clk: mediatek: Implement mtk_clk_unregister_factors() API
Date:   Sat, 22 Jan 2022 17:17:16 +0800
Message-Id: <20220122091731.283592-17-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
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
2.35.0.rc0.227.g00780c9af4-goog

