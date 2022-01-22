Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170F5496B60
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiAVJUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiAVJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:19:13 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38106C061773
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:36 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 187so10050931pga.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yYGXqDxo/eWqrROn24aC9cA0IymJmQ8zZXIQFx6Mzg=;
        b=E3fL9k4nB0J+U7dhnH/244EmdfdD1ulLNX+eG5dBwQJtHMj/EcLeIsfa2TRUuWcGd9
         oiNAiHupmkNXYOFsXFJ6LIF2ndolec9H7eZ97eKqnFFN80k3IizBuZjLwuQ1VELWkx31
         mochVNtqJ50lh6iJe00VnTcom/Wyt65N6eHLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yYGXqDxo/eWqrROn24aC9cA0IymJmQ8zZXIQFx6Mzg=;
        b=QjC0egiQgzUAOUj41mR/rOcZO2ziAFL50imS6LnM0bdhF/TgJDhqQvD/e6P97IzNAU
         5LQE+4292t3NOHc74JUAvTXlRPBR6pIO9Tp7jMfWYbW7bRvt24S0Gst30ypDfxcsFwRf
         klhSl/I25HtjNHvNfkn12clnUgWnhMZxoZdH1nMQZnhVwQasjWagkd2lsV1bg1JpvmOQ
         3SE21zkIzphmIzXEdt+KhPHw2/CjStPOph5YfQgTYUa7vZwQaeNNm9WPnwBTvYiLHSi0
         39Pl/Q3c+WXcy4JVR20axAae+cK6YlJlcEdR+j+VbGx/qjjmMYWi1SUMMA9mZuKQ61uS
         zFYw==
X-Gm-Message-State: AOAM532YKW0QEqABXYaqfzd4VTS/fLAJvD+cvjfuUx83LU9wGXVKuGBK
        Yu9GA+HLmdw/Hoo0YeqyJyK89g==
X-Google-Smtp-Source: ABdhPJyf9HKfNksySR0iObSvFPhmBF8ZKz+iwD2Gd4unIv10qS1uI5MvXPoHzlLDKI0sSrcTb0B6jA==
X-Received: by 2002:a63:6845:: with SMTP id d66mr5494690pgc.199.1642843115668;
        Sat, 22 Jan 2022 01:18:35 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:35 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/31] clk: mediatek: mux: Reverse check for existing clk to reduce nesting level
Date:   Sat, 22 Jan 2022 17:17:23 +0800
Message-Id: <20220122091731.283592-24-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.35.0.rc0.227.g00780c9af4-goog

