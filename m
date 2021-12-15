Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931EC4753AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbhLOH3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbhLOH3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:29:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:29:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p18so15889114wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMZSPHzmKlp4nB0z4xKj0z3g/eSIybOBv9g3NZ7AxBc=;
        b=GztGmfJYV8tlywo/+a2VFYMkAVdKt7YfBdqaVivbNaR1/K0tqYK9zRBkHsraJk1yMG
         c03G1ZaZOgndjYVpAoBeOHtgim9A0rW+bXNvAHHw93auSDoSLXgdMoFE3CrHZlff5Avt
         A6iR+nzBbTxhu+8HuMMs4NJcv/aFnnsoG+yzPW9ezYPurXkDH0MN/GgD7/TpmSO507rI
         4TPMMdnqvK2Iw2Sr0YjxHsUwZ3oaijXriaQHDLJ7ztwxBNvRddKNe2D176aOJFvu3uR1
         Cr6MlTLq/VE6NI3MxAXCfNFd03OlsedQ+jaewFX+RP9rprU8QLP7lVD49bcEnNXxVGt9
         aYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMZSPHzmKlp4nB0z4xKj0z3g/eSIybOBv9g3NZ7AxBc=;
        b=KOLBQvhKFehK8u6E9EWDrk4DZT4h8noZu2GsdPmCWEfTlWlK1cKhLNBFNWTPBImiRM
         fiKa5iUhkzzdFuOhZB4PwCf0qvkw4BswZLovrfHWc+72zNNpef8WX25AmfQTtW2YTCps
         gy+jjdedXxvENbMF7UiOSyoPYkNYR3SkHJgK3o9rBOQaKcQVwy5uZojNlBg9pVRkF/B+
         YWKEDVygCoVrqlKVSDv3Rh3VtQ/+Zcdc9kbaaUnwZDLkuaisZm6MzQadJoKYK2YFzgCN
         NkYVxvKcAkmen86lxkHjJ3FNX6wbK/aJvrXgWsBhiSiiYd7DGIf6cHsGi35sowvO4Jlu
         yFvA==
X-Gm-Message-State: AOAM531HuimzAQO8XH2/DDvXXhnIh2Wd4L9pL0tIJ63NYW2+Ih1jPkC/
        FyWTW3bQjJKZSg+AcJPa/oQ=
X-Google-Smtp-Source: ABdhPJye3e8Fd3RuWitjlcsNICFnsTS5SmIxWwZuo312bTG8xiFg9RxZcyL3DnR9MqIFlnZ1jLC75A==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr3390565wmc.58.1639553361731;
        Tue, 14 Dec 2021 23:29:21 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id n4sm1204728wrc.1.2021.12.14.23.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 23:29:21 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, ikjn@chromium.org,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2] clk: mediatek: Fix memory leaks on probe
Date:   Wed, 15 Dec 2021 08:29:15 +0100
Message-Id: <20211215072915.8678-1-jose.exposito89@gmail.com>
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

