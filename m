Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F334AD995
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356873AbiBHNVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358790AbiBHMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:39 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48882C03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:39 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id e28so18651077pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ga+gjzrzR/LMbGVHXMahoAG4teobfaMr0L0SPMOkFuM=;
        b=RZ9aNJj6d+PjwBnU0ZJr9mX0nqK+z2KPKSE1hVDOXS6VR7K79uaqtUSEcm7xi/csiT
         PWkXmSg1lDYbXRJVyBHvI8LGnEa9ps7DiMTFIno+JyB6kH8xzJ+339+ev6Rsm53OTn79
         B3I6j48uRr2+5wLm760I9Q9pCw2Z3sZkrOEYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ga+gjzrzR/LMbGVHXMahoAG4teobfaMr0L0SPMOkFuM=;
        b=FoYAMbmg7nfKosPs3suttsuknXm3ObgBsYVG48d9Zt4sDCKa8WSJjYMffHVfbwPrw5
         IZu8eiQYptq/XRS9ECQ9xLYkYO5MIeUQItflulComA0stbiy3xTPooJxRGjpOGb9EdoG
         jnio9lnOJty6jZdA/WoZJZYnSA7bY/QIRuCE7Lx9akIYUS6RO9PfIYhPFVJfsoyyNhXA
         XiY0ECDBhEby999EZE5r43tUqsTlrvvH+Bjh3wtOGfmJONEHn9QywAjeT9fOjLrl3cBR
         QjKGcDy+YsleuM6ia7Giaxo2zxnBlJ4E/tFrvVmycmn922KgLezfc4M4xdRjjwStBlFO
         ydYg==
X-Gm-Message-State: AOAM533/T4WVcooSjXdJq3G6YHILpxNX7cM87YtqQvJLAHg7nNGJxC45
        WmZ46Z3LArOAwVmx1OU4KyLZbQ==
X-Google-Smtp-Source: ABdhPJw8d0noYcaqrmuUm0oYUt6VCRIRuANK5szIhgF5+nvEpUNbWJNicRVw/Rm/sTOyay6sR7vcPA==
X-Received: by 2002:a63:2a86:: with SMTP id q128mr3374314pgq.53.1644324098777;
        Tue, 08 Feb 2022 04:41:38 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:38 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 23/31] clk: mediatek: mux: Reverse check for existing clk to reduce nesting level
Date:   Tue,  8 Feb 2022 20:40:26 +0800
Message-Id: <20220208124034.414635-24-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208124034.414635-1-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk registration code here currently does:

    if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
            ... do clk registration ...
    }

This extra level of nesting wastes screen real estate.

Reduce the nesting level by reversing the conditional shown above.
Other than that, functionality is not changed.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mux.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 01af6a52711a..70aa42144632 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -208,16 +208,17 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 	for (i = 0; i < num; i++) {
 		const struct mtk_mux *mux = &muxes[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
-			clk = mtk_clk_register_mux(mux, regmap, lock);
+		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+			continue;
 
-			if (IS_ERR(clk)) {
-				pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
-				continue;
-			}
+		clk = mtk_clk_register_mux(mux, regmap, lock);
 
-			clk_data->clks[mux->id] = clk;
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
+			continue;
 		}
+
+		clk_data->clks[mux->id] = clk;
 	}
 
 	return 0;
-- 
2.35.0.263.gb82422642f-goog

