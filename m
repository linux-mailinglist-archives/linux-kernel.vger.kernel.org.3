Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD2538771
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbiE3Siu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiE3Sio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:38:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5638E190
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:38:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p19so6882581wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJIpNSj7cFGZKfz96vdTia4ueHbBhL0XrZ+0w4C6IYE=;
        b=538U10qwEaxm5rxxQsk5NI8sE5wUkOtH4BNKM+zfVW0GNB3vHD62f5U//NDRHmkV2B
         qccG+9m1TxPPc1csSJClj4js1U/gKXBMW0oLYqcBN4XDfCzoIU+RaHH+M0czK+u/H+Wc
         sKkwZqIHJk+KDm7Z1+T36ysTnoDVBBwLEN1RoO2WKRVjUHvKnNVfiIsjWYBMp+9GrSmo
         M1A7vAoy2itFKot4G3HbNejLNaXxeUHQMsQoJ42415V4yTjXKz/RiOO660+SD4QPfkOR
         aIybp4d8hZ7xnZy1f9IYmoeBpAPOCvyuyvO9vovewnScKqmFJTIZS9uESXjhRJRldFHg
         uXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJIpNSj7cFGZKfz96vdTia4ueHbBhL0XrZ+0w4C6IYE=;
        b=DW2tghL+CKSelH/iJhYq4qmyd/7w6sNWh+mzyH5mTldgW8vihYYGapqzYnviGJGMOa
         996UBV5wFiLXhsRPqnnp5l8bHaXBJtxXEJTiYyb3qp3tmagX/SlEEmb3AEV+sRJCQDRA
         B1jTSF1ExB8aiNAKKIz820jymAk5cerCXK2LgJDi7XoAZtXWtD1qtrBcvxgRzjOC1WuB
         mIzL3W51fLY7p/D6WMwe9anmzSDYl4EWEcElf+xpqEoVg/7DuldHxcp+VMGUGYSYv8p0
         8KO5N1s2y9N+AqznXID3H5k+1AI8D9YIP6VBMiDVZV/BOesHyvYl6eddHALVYwWza47H
         lKlQ==
X-Gm-Message-State: AOAM530ohWuZl2OPuVur+3OMXZ5xj2BFJek2PfzDidkQNQZzsmeey6ls
        W7SKKxLc3WPvr8Aj7CGnD7++5A==
X-Google-Smtp-Source: ABdhPJzFPNMdqmxWHsp0ZjP89yZHiEJv77pVuSJhjJ50Elj7hVUbK5nlDWSL0Bz9w+pTjOdDshlSxw==
X-Received: by 2002:a05:600c:4ca1:b0:397:8b29:255a with SMTP id g33-20020a05600c4ca100b003978b29255amr15885946wmp.139.1653935921545;
        Mon, 30 May 2022 11:38:41 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe389000000b0020c5253d8fcsm11459088wrm.72.2022.05.30.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 11:38:40 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] thermal: mediatek: control buffer enablement tweaks
Date:   Mon, 30 May 2022 20:38:32 +0200
Message-Id: <20220530183833.863040-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530183833.863040-1-fparent@baylibre.com>
References: <20220530183833.863040-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

Add logic in order to be able to turn on the control buffer on MT8365.
This change now allows to have control buffer support for MTK_THERMAL_V1,
and it allows to define the register offset, and mask used to enable it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/thermal/mtk_thermal.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..b09738ef1093 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -271,6 +271,9 @@ struct mtk_thermal_data {
 	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 	enum mtk_thermal_version version;
+	u32 apmixed_buffer_ctl_reg;
+	u32 apmixed_buffer_ctl_mask;
+	u32 apmixed_buffer_ctl_set;
 };
 
 struct mtk_thermal {
@@ -514,6 +517,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 	.adcpnp = mt7622_adcpnp,
 	.sensor_mux_values = mt7622_mux_values,
 	.version = MTK_THERMAL_V2,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
+	.apmixed_buffer_ctl_mask = ~0x37,
+	.apmixed_buffer_ctl_set = 0x1,
 };
 
 /*
@@ -963,14 +969,18 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
 
-static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
+static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
+				       void __iomem *apmixed_base)
 {
 	int tmp;
 
-	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
-	tmp &= ~(0x37);
-	tmp |= 0x1;
-	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
+	if (!mt->conf->apmixed_buffer_ctl_reg)
+		return;
+
+	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
+	tmp &= mt->conf->apmixed_buffer_ctl_mask;
+	tmp |= mt->conf->apmixed_buffer_ctl_set;
+	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
 	udelay(200);
 }
 
@@ -1070,8 +1080,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
+	mtk_thermal_turn_on_buffer(mt, apmixed_base);
+
 	if (mt->conf->version == MTK_THERMAL_V2) {
-		mtk_thermal_turn_on_buffer(apmixed_base);
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 
-- 
2.36.1

