Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E39507076
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349495AbiDSO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349238AbiDSO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E555F5C;
        Tue, 19 Apr 2022 07:25:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso2023203pjj.3;
        Tue, 19 Apr 2022 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoTHaiJJheo7KKQ2FMLM7Z79POojCIJETOG/5UiPeO4=;
        b=V1vTAndmeibZH8iE/xUMcoNeVacWGBTAOMJw52hjd+IQn34XUQ0Vr+qKvVDGPPNbsU
         J6NL8lpVUZpF02yLXkD0LcVC2oBs6sz4NAI8UF6hOaERvtegVftT42eIDoBoxzG9YnqF
         Tyb77CQ7OeUD7la/TABkJfvmQGoW6kSM5SOfuTX2yZu4dcPWjpjzHlr7BB2LgX3TIJ+A
         hKZECvd+znVtutkiAHbqiXrt9cwM82cK4M/0aXyMDQmljP8010bmEslMnEMVS71iLNVZ
         6dqu9W+FTPyBMNHI7k4tVOIqotsqXjSiC+71Oc6b5+XrDLxcedZ2mtMSlZ99Cvjuc1V0
         M6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoTHaiJJheo7KKQ2FMLM7Z79POojCIJETOG/5UiPeO4=;
        b=fPimG5jYf1FE/FrD+pnVwKpPu6YXGIiq8afGbtLJJz2lfQ9sF6PjBkE3nPe2YN3lsQ
         F2HcRJRlAaNSMKxAeUMCZjrKpNGIdtXSjrme1coyqGWYySj9xluq52FRWbIPzgNraMmg
         TLxdBcw3/JNBROik4BOMbjhaJJ2yWSpVcCrOMcv0RbE9qYjI2283Be4vR0AejihdOxCq
         M/TWdXdIzv3W7t7d0l8F3yHOAdLUI6Dy4dwEp7B5us3ztASAjeoMZU50WJxQxctlfPI9
         om53+i/yRb62VTBPXsMdQ07RwI7bfJ5VMM5n+RDJeq0eioKjJ8waY+UpJfVDBkzwtsIT
         4PxQ==
X-Gm-Message-State: AOAM5322DMj5wCI7nZ/B1f3+SVicYY9B1p8HSzvRCh87PV0OoDQImK8S
        CX/PeOLBxPawcTVIAWjNxl8=
X-Google-Smtp-Source: ABdhPJzIR/QVqB4iKQvO54+pVWntm8Sf6vHurqT14unSImicnbUcPLibJds9V+DwtFyGr/DYZjd+Kg==
X-Received: by 2002:a17:902:bc86:b0:151:ec83:4a8b with SMTP id bb6-20020a170902bc8600b00151ec834a8bmr15747008plb.69.1650378334039;
        Tue, 19 Apr 2022 07:25:34 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm16681939pgp.22.2022.04.19.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:25:33 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 5/7] iio: adc: refactor some functions for support more PMiCs
Date:   Tue, 19 Apr 2022 22:24:56 +0800
Message-Id: <20220419142458.884933-6-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419142458.884933-1-gengcixi@gmail.com>
References: <20220419142458.884933-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Refactor the common adc_nvmem_cell_calib_data,adc_to_volt and call
these in the origin sc27xx_adc_scale_calibration,sc27xx_adc_to_volt

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 56 +++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index a8906ffd85bf..27fab579a281 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -138,16 +138,41 @@ static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
 	return ((calib_data & 0xff) + calib_adc - 128) * 4;
 }
 
+/* get the adc nvmem cell calibration data */
+static int adc_nvmem_cell_calib_data(struct sc27xx_adc_data *data, const char *cell_name)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	u32 origin_calib_data = 0;
+	size_t len;
+
+	if (!data)
+		return -EINVAL;
+
+	cell = nvmem_cell_get(data->dev, cell_name);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR(buf)) {
+		nvmem_cell_put(cell);
+		return PTR_ERR(buf);
+	}
+
+	memcpy(&origin_calib_data, buf, min(len, sizeof(u32)));
+
+	kfree(buf);
+	nvmem_cell_put(cell);
+	return origin_calib_data;
+}
+
 static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 					bool big_scale)
 {
 	const struct sc27xx_adc_linear_graph *calib_graph;
 	struct sc27xx_adc_linear_graph *graph;
-	struct nvmem_cell *cell;
 	const char *cell_name;
 	u32 calib_data = 0;
-	void *buf;
-	size_t len;
 
 	if (big_scale) {
 		calib_graph = data->var_data->bscale_cal;
@@ -159,24 +184,13 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 		cell_name = "small_scale_calib";
 	}
 
-	cell = nvmem_cell_get(data->dev, cell_name);
-	if (IS_ERR(cell))
-		return PTR_ERR(cell);
-
-	buf = nvmem_cell_read(cell, &len);
-	nvmem_cell_put(cell);
-
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
-	memcpy(&calib_data, buf, min(len, sizeof(u32)));
+	calib_data = adc_nvmem_cell_calib_data(data, cell_name);
 
 	/* Only need to calibrate the adc values in the linear graph. */
 	graph->adc0 = sc27xx_adc_get_calib_data(calib_data, calib_graph->adc0);
 	graph->adc1 = sc27xx_adc_get_calib_data(calib_data >> 8,
 						calib_graph->adc1);
 
-	kfree(buf);
 	return 0;
 }
 
@@ -312,7 +326,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
 
-static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
+static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 			      int raw_adc)
 {
	int tmp;
@@ -321,6 +335,16 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 	tmp /= (graph->adc0 - graph->adc1);
 	tmp += graph->volt1;
 
+	return tmp;
+}
+
+static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
+			      int raw_adc)
+{
+	int tmp;
+
+	tmp = adc_to_volt(graph, raw_adc);
+
 	return tmp < 0 ? 0 : tmp;
 }
 
-- 
2.25.1

