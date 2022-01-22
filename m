Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BB496B65
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiAVJUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiAVJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:19:32 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021B2C0613E7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c3so10891781pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRdPqU8/wgjW8dVj35l2dqDHIgNyG8RkF40G3LrYL04=;
        b=Fuyv3VjSgzBkc769Lo/2CI7DZ5+GfuLLZoIVtSUhg6V37yvZZjs0K7eQ4eSZslBFGK
         usShwZDBaY7bdt+XegEK2ZJyP6x7yd5qMvqXo5OydapiA3sNPpx6xr2Zkzu9wSA5RsDS
         FcKihT3u/k8jED2Ow+v5mvkMHtTDBpLzLnIA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRdPqU8/wgjW8dVj35l2dqDHIgNyG8RkF40G3LrYL04=;
        b=31IdeGxn71E24/PZUgHY4CTHv2gM0VwQMy/IGzgLCotB6WjerwScArzvkegZbUSvQG
         nEjqehU3SeLQl7lMmosQOn3TnSiLhyiMI6qDBDFx+6CrN4mwsw55hvwlPi/elt/u/RzI
         B+x88emfnRvhXMO3I1XnJAGVOSAMfaCTc5iiQTKsBKU1Ui3mQD6t7XhXIGBCUU324amk
         Nu1IJvmETLbCKyxJODTvWGRGy/CkA5+wKBhNPTcmGKcTOQw1Tpk3Tn/yPmz4htvdiEf5
         O5OlfXrDKf3B4QCHCYAQhuKVLa13DhwTz3YxR7cnxdQH4CxlFrQcAhKTs/grCpPV3WH5
         nU/Q==
X-Gm-Message-State: AOAM533vyFAEFhkFNJCURc7nPo6qLjmd572vv8QnukRv5B8ElVfdSG/i
        65m1D9rYBjybSNpm701n+KbOjQ==
X-Google-Smtp-Source: ABdhPJxTbBDUz1ZVF3T1/WMxItjtS2Jk9+TiJqGSG9ZvAellDQvwJc4yjnRGhEOmpZtTsU1/xc9bqw==
X-Received: by 2002:a17:903:110c:b0:149:9004:4e7c with SMTP id n12-20020a170903110c00b0014990044e7cmr6904060plh.167.1642843124559;
        Sat, 22 Jan 2022 01:18:44 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:44 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/31] clk: mediatek: Unregister clks in mtk_clk_simple_probe() error path
Date:   Sat, 22 Jan 2022 17:17:27 +0800
Message-Id: <20220122091731.283592-28-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now the mediatek clk driver library did not have any way to
unregister clks, and so all drivers did not do proper cleanup in
their error paths.

Now that the library does have APIs to unregister clks, use them
in the error path of mtk_clk_simple_probe() to do proper cleanup.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index e1977c8e130a..6d0b8842971b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -434,12 +434,14 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
-		goto free_data;
+		goto unregister_clks;
 
 	platform_set_drvdata(pdev, clk_data);
 
 	return r;
 
+unregister_clks:
+	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
 free_data:
 	mtk_free_clk_data(clk_data);
 	return r;
-- 
2.35.0.rc0.227.g00780c9af4-goog

