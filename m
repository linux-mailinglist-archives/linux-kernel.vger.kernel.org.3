Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17846DB94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbhLHSz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhLHSz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:55:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD70C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:52:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso4869219wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 10:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G2Gn57TXwKz95OGmlmSQTgSA6uRDREV59CLTrA3LDM4=;
        b=OKVuuVaPxR6CLec1hWjzcESiIiIwPaUJRKHf4Dyb3LDystuB797Kv+/4/xZ5Citvkn
         U8Xjlq87pVAKo0ueBD+Tg4uP3jxUtY1WwSjUVUnIIVjTlSbCNjLmA4O4ofTNlH7tHR0s
         r+/3j90OcxZCAsgZY40AEUUF03ijnjME6z/hqs27sLPC0WRVdERzeCzpmsK6MHvhUsRX
         Uj1WFjlrWRx13I/XS3Wh320j97JT9eV0grc9/tJtdLqyGRk1OtlTGa6pF1li+TlXvtLX
         gPkpCqkIhxuf7up7tm1NjbV0Itt+4pvKrnTvOjWeQ/gyrrhBAuSpw7zWSHBvcgdip2S5
         XNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G2Gn57TXwKz95OGmlmSQTgSA6uRDREV59CLTrA3LDM4=;
        b=218eC0JTDy1sKkgLnW6Q8OnNP71G/YFOI6tcdakWNs+8shZBJ3ThJ94jo9+osSLUrV
         YsUVr5rrRvYJ6UbPGZgUei7mAA7prSGTWX619CQpslBWr0Kk69hFLMZB/IkpjSzdkN8t
         Rpn1NDOoCsAf9uP1E15uLRH2uCaSp7+X6T6uKca2zw1Y9Wd9YotBepDxYaQgStd4TVl5
         vdjjdJwZtZZ2TueZCsgrUClAtcmYRmSamqQaHcongeq6Naxc/0zxV7GaDN7GeGK4ulvA
         8JqktF8v4ypOiS7jXa8zsc8xEOKUBSg3pl2ENFIQV3zUunJyZFCqCg47CdLxAxj9Y1S1
         hBCg==
X-Gm-Message-State: AOAM533CjWOuL5M/rUcb0A7sEVPwCSNlMtgplr5l3mQe7QRCv74xx88d
        oq9V8NnJzHIm6PnBIYg75GM=
X-Google-Smtp-Source: ABdhPJzInwKOaTbRNAmtuu7tRYtF9nnvxXPPCs7nIKcSSDh8Z7tTsqRvXpGi8rc38zTONr/NpafPQw==
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr572989wmq.8.1638989543656;
        Wed, 08 Dec 2021 10:52:23 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id b10sm3409220wrt.36.2021.12.08.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:52:23 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, ikjn@chromium.org,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] clk: mediatek: Fix memory leaks on probe
Date:   Wed,  8 Dec 2021 19:52:11 +0100
Message-Id: <20211208185211.40682-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the error branches to free memory where required.

Addresses-Coverity-ID: 1491825 ("Resource leak")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/clk/mediatek/clk-mt8192.c | 36 +++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index cbc7c6dbe0f4..79ddb3cc0b98 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1236,9 +1236,17 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 
 	r = mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks), clk_data);
 	if (r)
-		return r;
+		goto free_clk_data;
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_clk_data;
+
+	return r;
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return r;
 }
 
 static int clk_mt8192_peri_probe(struct platform_device *pdev)
@@ -1253,9 +1261,17 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 
 	r = mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks), clk_data);
 	if (r)
-		return r;
+		goto free_clk_data;
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_clk_data;
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return r;
+
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return r;
 }
 
 static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
@@ -1271,9 +1287,17 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 	if (r)
-		return r;
+		goto free_clk_data;
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_clk_data;
+
+	return r;
+
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return r;
 }
 
 static const struct of_device_id of_match_clk_mt8192[] = {
-- 
2.25.1

