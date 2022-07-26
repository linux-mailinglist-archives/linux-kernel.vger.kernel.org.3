Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3B581148
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiGZKfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiGZKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:34:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607032478
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l15so15484644wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hS5D+tKbOtBBnrOkxwJ+MyP4haeEuYAKYGV01jemHh0=;
        b=tazKIxvSUmt6J8AlUGlpWsUbd1SkCcezN+LsSgrroc8Y6wJDPNvv93O2bwymIQSTBz
         s91p1uCClrS8RHDFvkBAPn9NKtl7r3P1/hitEiY4eMnl59fpTyVvn7uSW5ttsEsVRuo9
         EgLuocfIZ5LGYgy1N//Y21EweNr7UM4yNe22Tq+zG6qTGULrA2QOpyM7C6U0ZHZEfNTR
         jaBRaSBY+m7t0gu1ZSyD52oJEvuVCkXj66EGaqnLROMGwZIsCEYvNFgd2DvwZSad8mhx
         SoloGOhX+r5BO1zfnYDLtO1AdAOfvKXRgSrWy5rajVT29NQCy8sZubLQmyEyfgUZQspx
         eGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hS5D+tKbOtBBnrOkxwJ+MyP4haeEuYAKYGV01jemHh0=;
        b=LLMc0dabF5/hwXgRWG0uHXzNOgjhYfS00TLD3hRQAMeU3ktI0slwP6XQoQKMgevUX0
         7ZpQQObCKASPU86Jq6kHwCHE6AmogsroN/aWeirEKEk3GyU1TkkQawHF+M+TkhW27F7U
         8wgRc6GbP1xdJLnD9b65JznTNleiNDQfPGnYRQAQc4SIIvlYSj2gruCLUqktiFPRsglW
         /l+CA3i1pcRnyF0GgOG2u6yhr3CGFesm/Vmk3kq5sa3NsM0/CUAbO7kqnlWJadbeBhhn
         p+KjHfsJj5gBtJxuk3IF3GSM6QWCszfV7/23OvfaGdnhn9NjDZEL4T8ltOOlCuWgX23A
         TFAQ==
X-Gm-Message-State: AJIora+6cUlxN/jzgz3FRrj49KwW+AiEvLVbSIun1l22cJzISqIb8w5X
        hnBf6OEFM9SqvSQaIuRGbQ9uiA==
X-Google-Smtp-Source: AGRyM1tq7HlxOzT1Cq9RfdORMGki4QGIyKxdZNlYeX0V4zEmHct8A4MmWKu17E7X6Vdx1RF/3wgeEQ==
X-Received: by 2002:a5d:59a6:0:b0:21d:bc0b:d762 with SMTP id p6-20020a5d59a6000000b0021dbc0bd762mr10396083wrr.637.1658831666001;
        Tue, 26 Jul 2022 03:34:26 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-4641-6f91-91b7-326a-5d27-a1c3.rev.sfr.net. [2a02:8440:4641:6f91:91b7:326a:5d27:a1c3])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b003a2e42ae9a4sm20617121wmb.14.2022.07.26.03.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:34:25 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/11] mfd: tps65219: Add power-button support
Date:   Tue, 26 Jul 2022 12:33:52 +0200
Message-Id: <20220726103355.17684-9-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726103355.17684-1-jneanne@baylibre.com>
References: <20220726103355.17684-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

Using a power-button on the EN/PB/VSENSE pin of TPS65219 is optional, so
this driver adds the mfd cell for tps65219-pwrbutton only if needed. Two
interrupts are passed to the driver.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 drivers/mfd/tps65219.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 7366f251c21d..e1c30a49bf08 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -335,7 +335,10 @@ static int tps65219_probe(struct i2c_client *client,
 	struct tps65219 *tps;
 	int ret;
 	unsigned int chipid;
+	bool pwr_button;
 	bool sys_pwr;
+	struct mfd_cell cells[TPS65219_MAX_CELLS];
+	int nr_cells = 0;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -364,9 +367,16 @@ static int tps65219_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65219_cells,
-				   ARRAY_SIZE(tps65219_cells), NULL, 0,
-				   NULL);
+	memcpy(&cells[nr_cells++], &tps65219_regulator_cell,
+	       sizeof(tps65219_regulator_cell));
+	pwr_button = of_property_read_bool(tps->dev->of_node, "power-button");
+	if (pwr_button)
+		memcpy(&cells[nr_cells++], &tps65219_pwrbutton_cell,
+		       sizeof(tps65219_pwrbutton_cell));
+
+	ret = devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, cells,
+				   nr_cells, NULL, 0,
+				   regmap_irq_get_domain(tps->irq_data));
 	if (ret) {
 		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
 		return ret;
-- 
2.17.1

