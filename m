Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97084A7226
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbiBBNu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344749AbiBBNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:42 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020F2C061744
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:50:27 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d1so18252057plh.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrOltClYvXVjDtDBwVIhzlzFVA2EZyTl5dU5D+b2Jm4=;
        b=LE43wTzJh/Wmm0fyvbCb8wCh+3oWVC8adNS/jdl5+42RJ8DxvGICSM+qdZwruOzsIr
         DyHrISocYIMJ6qskgAbWNERefJpsBiQa/dzh4PKqC0vzzTvQp/Z0Ub31MqFITrjPZhzH
         6Xz4xkV2eseSkFUHg+BmD9me17wZXcLr27Fic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrOltClYvXVjDtDBwVIhzlzFVA2EZyTl5dU5D+b2Jm4=;
        b=DeVH8UJUxuHHK39UThmQ0FQ9J5ZdnZo5oVu7ocuTo4tPEZLKxtnK+mYG6ORkCuoSng
         8YfI3m+hceRHKtS9AK3btvoQlH9lV39AObt3U9F0EJLuIf4KqcvR+8CTQRirJgjbUrkC
         cW/uYJjNnQRgcnDQ0P5t/KupOk414nBU61aJqhEbqe2nWUK7Zxf9bttocTRKtD7paQAo
         awFy0VnOp1FP6dR2QNOymxwVNdSreALHCbqavnAnhnDAOpg2O5JtLRsf3fZUULLtTMHs
         ucRTtssFZ5r2Hjb2dFxCNuoHzpZILoPKkL8QKz4I4pobM+cuNurrpvB4YfuU+B2eWLOe
         q1+A==
X-Gm-Message-State: AOAM533XyzJpY5zZ6P/EfSXiUFeBBDLcVXAAM0haWWPmP0g+OuWnp/YJ
        V6FsOzDvB8MLFDi1QX3CKc/r8A==
X-Google-Smtp-Source: ABdhPJxwytrlAarn/g53qU18olqhBZj5GI3l8fMGrFcFpltGq3c95Omxs6sHFPOWJMUCA6/RAdqcQA==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1mr13233814plp.56.1643809826597;
        Wed, 02 Feb 2022 05:50:26 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:50:26 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/31] clk: mediatek: mux: Implement error handling in register API
Date:   Wed,  2 Feb 2022 21:48:27 +0800
Message-Id: <20220202134834.690675-25-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mux clk type registration function does not stop or return errors
if any clk failed to be registered, nor does it implement an error
handling path. This may result in a partially working device if any
step failed.

Make the register function return proper error codes, and bail out if
errors occur. Proper cleanup, i.e. unregister any clks that were
successfully registered, is done in the new error path.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mux.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 70aa42144632..f51e67650f03 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -215,13 +215,26 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 
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
+		const struct mtk_mux *mux = &muxes[i];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+			continue;
+
+		mtk_clk_unregister_mux(clk_data->clks[mux->id]);
+		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+	}
+
+	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_muxes);
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

