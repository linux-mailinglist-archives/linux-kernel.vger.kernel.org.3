Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB424A720D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbiBBNu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbiBBNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A85C061401
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:50:25 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x11so18290271plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNRljrWOAeUndIQnSVvEuUfXq7FasZjB3yC6SLPOuYM=;
        b=U4vn34H0WZLQA8MoBFSj8XH+wsm8GLd/vRb1NzXQolOCQ6oqrB9XEHDXlwVR+0Yef6
         wkYdmZeZSVKK9vVy6IiPGuwINl7+oHUyqqzA63Zn+h4F4mV51am7/giIRB415XQRleoF
         nPc0iVKyIb/sVzkHaTRkm8kkWuk4z/cWbCzx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNRljrWOAeUndIQnSVvEuUfXq7FasZjB3yC6SLPOuYM=;
        b=61OGkf62zW9BvoBVT1L9FoDG0Gwtb5c0OQIGzFj4lOXWZolrmGZnGnVDWa7LR52I5+
         biumx9XRVqJNc3MdgQCwAD6NuQ7hgU/T58ACVpLaijrJ22y4kgbdQXcZM3kGFJnxVA4a
         Q1cIqJOTcKHDThnlvSCzAwCXsfNhzcycl3eMwmC6zklea4mkr7LscE6TdYneN8KQ1MD6
         gBAjRoBSsvK1gDyHdPmnWsGcwulp7P6hGe2B26f4K0v8BQB28Ft1+esYtZKBS11Hek88
         mbSJ13yyI/KMNTQyM+hZ3YSyg5z2MeYbGZKzRUjRt3lsjBRi0WUKniTRZbs5k4kYX9d2
         ibsw==
X-Gm-Message-State: AOAM533A6Cq0sAJfRfBzqC0izIM/L4ASBVMM37F6bYopcyhK/dpFPnYE
        WTNLMmHff08mtPOsLQky2f6nGw==
X-Google-Smtp-Source: ABdhPJxg9luWRJ9r/j2zVez342YUr/p2ncftDzjGtTu9Ak9s1/hRg0GpZyJdP3tIQGpruvbs2nlMjQ==
X-Received: by 2002:a17:903:1110:: with SMTP id n16mr32138856plh.120.1643809824608;
        Wed, 02 Feb 2022 05:50:24 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:50:24 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/31] clk: mediatek: mux: Reverse check for existing clk to reduce nesting level
Date:   Wed,  2 Feb 2022 21:48:26 +0800
Message-Id: <20220202134834.690675-24-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
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
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
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
2.35.0.rc2.247.g8bbb082509-goog

