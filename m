Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84587496B61
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiAVJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiAVJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:19:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEE2C061744
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o64so11345391pjo.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YPN+1zbb0FLmeCLY1r05U9fmN1fkUgWhlHUKwR4SnA=;
        b=X/ZtK2SpDBNbC3Na1TLbE7R39jEjlYu+bOu8u+DNEurHjH1tbv0qDNcyqaLBDYGA1Q
         8VwLaJ/PNA2WR9RbNJ4eDR3BMD8BIyBuTAJ/WNHxn6wrfM3rexdndBFYfjpCNFiKNiqo
         E7c4AfXewebnkxmvND/e8oxCRJ21aYZY5EKFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YPN+1zbb0FLmeCLY1r05U9fmN1fkUgWhlHUKwR4SnA=;
        b=pXuFtVyDYtCL6NxCqmUffdk4gDTh7g52ozlVezSNZKkAs6wYiq+xAzSd+xYf0IWh2v
         R7gIBAp+Jp9J7+9FcAbQ9CYNaD8gSrazULAWzt8A3dv50Js2sLPKkzIquD6kWDbM8n0n
         eP1pkGv2n3GgzY0LHSoF6VJqEtlgt6utlfp96qk3IDP7Vxjb+Dqfzcy7ovWcBYQLGNnN
         4YwTmo8wJ3iqaO5N5aJuOJ7Ocp7bJU2WVBB53rugFvgL0R7UvqiEYk8gUyMSH+TwTNLu
         Ku6HtqdLdJoD3z3TJe64ppcWCg4WwhSJn73EE3wYcwXZpuKM2CeHQ0L6uh51jVdpoxyR
         1GiA==
X-Gm-Message-State: AOAM531U5oSBdrnwNPUwOgmHkmYxKIWKm0/CUatN8KnkGpLuJGzEwTjP
        H2aAQAiGjQMHttpbwcf91T41BQ==
X-Google-Smtp-Source: ABdhPJxXOmZFL9go3UdVwQDSJBJ6fg68hKE0lBH0fAd3eIgttYowB4HFeZeVzoGLMe1c7TNtJJKpJw==
X-Received: by 2002:a17:902:6b02:b0:149:7c20:c15b with SMTP id o2-20020a1709026b0200b001497c20c15bmr7026790plk.173.1642843117953;
        Sat, 22 Jan 2022 01:18:37 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:37 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/31] clk: mediatek: mux: Implement error handling in register API
Date:   Sat, 22 Jan 2022 17:17:24 +0800
Message-Id: <20220122091731.283592-25-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
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
2.35.0.rc0.227.g00780c9af4-goog

