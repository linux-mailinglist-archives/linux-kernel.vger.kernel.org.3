Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84034A7212
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbiBBNur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344648AbiBBNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:27 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6CC06175A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:50:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso6925644pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cx6a8R97PjsjOv6cebI4Z/2hIOUwaDl4/YWSX9mOExw=;
        b=LECTsKvy7t8JOP59Uuw4WqU16hg3GYtSw3sCr0w8VJYVeRfS9yHbZOGJqoXab7B9u0
         tlEfn86K0vk+YtlKRJTlsdK62A7mWfXsfsyGm/ptvH04zxs8M1w5q8zsW13X+Uy8a3VH
         PmrtpQZ9Us4qnZFpKDO84gckboYbX79QVwqJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx6a8R97PjsjOv6cebI4Z/2hIOUwaDl4/YWSX9mOExw=;
        b=Xt7cwJaOU5tctIzMIoT8LZ2aG8zZcg9TR+DP7j5XLcxmNUIG3keSLs6Y7LZ3cRKS9/
         vwXMSzbfpM7ZXVZopwOWh1QGelRHV0RUsVvRlUva94dIt5JNkAQARvO0T3LGyW2lVwQm
         ituE3BB4xyX++wz1sLzp5iBk5nvMeFrCSYI126alKO14mfEBUrQrLm6is5Vr7EZN9LTx
         sTu9Ml+YJ3E1Sr2vBivUSvn6rU1dWKiPBORcvjNQDmqMhi9BRibpx6x14tXlbz+kFCaf
         RR9We3ln2hxT8qmM2txO1/m9MI0ByWhsbFh5WHfyDk2PnFJ2X2JaJLp9HKo7zNUYa1Em
         TrVw==
X-Gm-Message-State: AOAM530W/uKB6qyz2GDYsQbYdgO8NuJ5FqgksL+CUwGhHxb2hioEVbqo
        AZxieVllZIVIXPvx8OZSumXKIg==
X-Google-Smtp-Source: ABdhPJy+zXksxAcSN75EufsBADoPuhChK3JsWvZAjPXNL3ClKCXJ80y1WkJ/1oQJsghUAMYjzltDag==
X-Received: by 2002:a17:902:6807:: with SMTP id h7mr31294827plk.22.1643809820674;
        Wed, 02 Feb 2022 05:50:20 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:50:20 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/31] clk: mediatek: cpumux: Implement error handling in register API
Date:   Wed,  2 Feb 2022 21:48:24 +0800
Message-Id: <20220202134834.690675-22-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpumux clk type registration function does not stop or return errors
if any clk failed to be registered, nor does it implement an error
handling path. This may result in a partially working device if any
step failed.

Make the register function return proper error codes, and bail out if
errors occur. Proper cleanup, i.e. unregister any clks that were
successfully registered, is done in the new error path.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-cpumux.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index 658aee789f44..499c60432280 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -123,13 +123,26 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 		clk = mtk_clk_register_cpumux(mux, regmap);
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
-			continue;
+			goto err;
 		}
 
 		clk_data->clks[mux->id] = clk;
 	}
 
 	return 0;
+
+err:
+	while (--i >= 0) {
+		const struct mtk_composite *mux = &clks[i];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+			continue;
+
+		mtk_clk_unregister_cpumux(clk_data->clks[mux->id]);
+		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+	}
+
+	return PTR_ERR(clk);
 }
 
 void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
-- 
2.35.0.rc2.247.g8bbb082509-goog

