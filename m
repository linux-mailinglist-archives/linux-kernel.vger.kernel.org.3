Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EFC579612
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiGSJSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiGSJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:18:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D1252AB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a5so20617697wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7sysAA+7rUYPU1adrhA9a7CIYRlB/YUN+4vaR7wZ9RE=;
        b=ijzRhrkmLikS+R0gesXzCJ74FzCcjbekplXoiZ+iBUSa9EQx/vIup3ZndV4L+2hUNy
         dUd+uXtmnDKFvwA4Y3nUGxZJf/PloNOsxsJSTTZph21azGmXThXmyphDj7xhzNWMmOGG
         I2FRs425DM3bt4cK08Tornj2UdDMsaeQUsor3SFDpdvBTfF0HGb1rI0kNkysH+TauZyb
         dHx8eaOgkzNE1OjCpMtj1E6f6tQ3bwa65s4zPFS7ES1Tx4JSW6kyXAZk5HwQ8u1MvKd9
         R+8LIDVTSxPE5d1ZCFK/292XuaDkA0M9XVTJ4QgxLZxNKi0EYbOcnHxR/exWi0gRVUdp
         2hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7sysAA+7rUYPU1adrhA9a7CIYRlB/YUN+4vaR7wZ9RE=;
        b=DbyfetR1hZjiI7uonLrc0OGJtOk4vQ4bImBmKqvqG8DK0dw6U5ihK7+VccYMsHNKMj
         kh6ExywibByg/Pv9pYdmAvYSB3WPavZkW7lt1U/GB+wGhVk6XpgyLiQBmXu2lbhuFZza
         ngqvXOuKpLTOttIbWcq1BtwaFS1BRnEfeTzm/lULYsLzbvLO2vYroQAfgfcrGyfIRbNk
         /VMJ4BDGotMnLznzyfpoPiczXHDntGxFjzalE433HbJs73iekNyEn+HNg9OQh1fqiTvK
         xLQQ6r4G3U58GiIW8FHEc/9qfIvgG+25gZitUu7/YDYeobxcv6drF2cBpRgXlNRqfSEX
         ubPA==
X-Gm-Message-State: AJIora+O4m3PDZIIMwnWc1jJ3j6e2ixgO5PlutDGjnsspMIFTbO9bxf9
        +FpjE1joW/mADALkxp+OdAmi8g==
X-Google-Smtp-Source: AGRyM1vGFISv4eWsp75ctQeAvGatpAUDTs/XeI8mXWR4VI3Zvz6tCwQYcS6Z5MrxvgRr1M+xyZVzFg==
X-Received: by 2002:a5d:6da8:0:b0:21d:bddf:b61b with SMTP id u8-20020a5d6da8000000b0021dbddfb61bmr24163308wrs.664.1658222281257;
        Tue, 19 Jul 2022 02:18:01 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:18:00 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 07/14] mfd: tps65219: Add power-button support
Date:   Tue, 19 Jul 2022 11:17:35 +0200
Message-Id: <20220719091742.3221-8-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
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
index b01a62c09885..f9bfc38240ea 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -336,7 +336,10 @@ static int tps65219_probe(struct i2c_client *client,
 	struct tps65219 *tps;
 	int ret;
 	unsigned int chipid;
+	bool pwr_button;
 	bool sys_pwr;
+	struct mfd_cell cells[TPS65219_MAX_CELLS];
+	int nr_cells = 0;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -365,9 +368,16 @@ static int tps65219_probe(struct i2c_client *client,
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

