Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46025496B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiAVJT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiAVJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:19:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E09C06176D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id h5so2664997pfv.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfZgCCKhWWL4g9b63+UJL7GvGCEBOJx3TOX6o+D52NI=;
        b=BsAVCGC9C4UCU9w4e0beBa1T1K3NEh7vcM+upT9wdmY25oE2j+R+CPgkeTRHf5YF0U
         2HLwzn10mw+DqT20c0YkpYAow643YIWjQZXE/tqB9DuFeaRY5JLeEKvdwGTpttT9fxD1
         xl8Jem+89eo2oglIvf1Hx3HfDHQHmamvRvEmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfZgCCKhWWL4g9b63+UJL7GvGCEBOJx3TOX6o+D52NI=;
        b=gpePOa1PdoiEoiyLnRdlC2yzv9RqGoXrikjfOXgPitXu+W8G0WShxv21k5AoUHATpZ
         TmcbCQtiHpSGLb8GSzGHLKNsRCX04VnqydiHOKn+E54in3gC7o44ql3urNmlrf/f/yTp
         IJkIkNFFqeeB/4BoXvUJfBN8J1Y7yAsYAIwNAiXk7CgyFmojxokDv0/p9NZhPQu3zmOP
         Pn/I6Hqc9NFE2qI5zCDDt+C6q3yKNbxX4TbTQPrHtykH7A73wpuKHYwjXbchjXjgK1OO
         c/Ri55A+af1536Ryc9kBxsxe48koKPxzZQVA3d7xYDltjnBY4SBPd+cU6LFZLv+N3wYy
         xT9Q==
X-Gm-Message-State: AOAM530Ldo7DLCPpFGq3TJgpOikMj1Va4+ozvg2dY+hrmZ7VQqzy6jVJ
        qYiGjno/70FjyzT1sWei+NuC0w==
X-Google-Smtp-Source: ABdhPJx2VhgGVxkpCD6c4pBfWLcAfhPTpc4I2h8LOcFbzz4iFjf2yJpC7rnNN2p2KTBfDDh2j2J+Lw==
X-Received: by 2002:a63:2b84:: with SMTP id r126mr5552900pgr.624.1642843111330;
        Sat, 22 Jan 2022 01:18:31 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:30 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/31] clk: mediatek: cpumux: Implement error handling in register API
Date:   Sat, 22 Jan 2022 17:17:21 +0800
Message-Id: <20220122091731.283592-22-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
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
2.35.0.rc0.227.g00780c9af4-goog

