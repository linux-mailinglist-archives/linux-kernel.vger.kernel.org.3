Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D036487C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbiAGSY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbiAGSY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:24:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF63C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 10:24:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e9so11144615wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMZSPHzmKlp4nB0z4xKj0z3g/eSIybOBv9g3NZ7AxBc=;
        b=quivSkBIqvYx7HHIhNcVzJMk1g2PqMCIZD1U/C28SoY52KIZVa5erqh7Ecy9Tc/uZY
         xy4im3rnanh7XX52x+uEDm25eQrSTTTTbNHMWzskQJXewA8l7Hv96MPweGA/piN6vemc
         QVv2Q40zjmLPAkJb+NzuKcX+moy8OXQKB+eokdpiJE08XFhpn0xuE9Y0PsEAAJd29Wem
         7htfnQKkQ5q7zRBKjmd3VSX0H9hNVHQib++OsGrYO+xrumfrsa18w+sFaev6RmewTxf6
         A22wpqc3XnTwBa1i+0U1Vw9ykX9ZeZVRW1vvsZybcWbe5bdOjkgO1PPHNCfPXIwgn5t/
         H8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMZSPHzmKlp4nB0z4xKj0z3g/eSIybOBv9g3NZ7AxBc=;
        b=X6oJj8svwLcnoeyOaAqf23cSHvFLllJh3MQ1wCCRVb7v6Z5p/6aNIUNuFTRMK9VL9v
         ov7RJY/QDBDy7Jviyau60e5cg8d3tlQEeKyH06a7xlCvoI30DmNa3v7FKLxsMZv2rRI1
         Iz3S8vWU30kjMjwspvqYZWfDtkWIVq6yotE4nJVFX8YtAjHJofPb8sBEHJ334BitxqUU
         zKrcrEJEDMqmEjUU1salEcnaSf+uWbYjlchfg2C67i2vW0VAAKIl1GGmSu3uOeiP96h4
         tiqC0QAmRaOzosN2MrVd0Fh4OIKVOPcE56776cSnjzP0A0v7xjJ8IZ86AUqR3NUmLUHP
         SFsg==
X-Gm-Message-State: AOAM532sfA2fx+mbNVsa3FOSmHF+6gia4gZ/0N9ZRIgCnH1EtuZ9WzZE
        Dp1Cn2OIJRw4VwyGdb6zzwA=
X-Google-Smtp-Source: ABdhPJxIMdZG2/mErKh1SRRIvGw8qzcobjoNHtD+/pns9H9ulLIrwuZ3L3ZaYlzt5h+xMKGoMXaS6g==
X-Received: by 2002:a05:6000:2a9:: with SMTP id l9mr55607369wry.71.1641579894699;
        Fri, 07 Jan 2022 10:24:54 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g18sm5305938wrv.42.2022.01.07.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:24:54 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, ikjn@chromium.org,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH RESEND v2] clk: mediatek: Fix memory leaks on probe
Date:   Fri,  7 Jan 2022 19:24:51 +0100
Message-Id: <20220107182451.139456-1-jose.exposito89@gmail.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

---

v2: Add Reviewed-by tag
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

