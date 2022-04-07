Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25A84F7985
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiDGIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbiDGIYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:24:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC1E63FE;
        Thu,  7 Apr 2022 01:22:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ku13-20020a17090b218d00b001ca8fcd3adeso8231102pjb.2;
        Thu, 07 Apr 2022 01:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+uWWlnuFd7vO8N9zc8sOV6FOaZWFAFbSeaNVdil/S0=;
        b=dJ1LQZmVxaJQzAl4Em8X6n6hEBhtIMHAnzaAZPoI72wZA8XE+l3h0VUPGl2dDcWow/
         CYuxWjrZIoAdpi9eDYIgqg4Ut/8kAs9KvBTfqu2y6OsiwJYrs8MgUOe3p6T7T92M2s3l
         rCgT2BeySmmz04tzYldkO10NHCvwqhs79SCK9UxkRscD6KFLfJcUoE1KO5SXoTxx1GY2
         2Ul9GHb1/qNjc1oyyANaRB6pn5UtzpsV7FI12/R8NIdJdLiYqmyg3k7Shs8WRYNoqcaa
         TN+NAm02MRyDRXaOAr64t3eLgolut6AuTwBiE1SvIfwp4H4dRCt91uBG3Z2uBH1aooK+
         SkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+uWWlnuFd7vO8N9zc8sOV6FOaZWFAFbSeaNVdil/S0=;
        b=0XneEX2ittPtwZV8BUeytSoh42jVXLNf41we1hsCn4PfxmOrQd0+A5JjHLmjfJw7nV
         due1EgGwi7nKHQUI1TmI/Csb0qoIFmhx183OjH5ADONvUF0tbHiNXMcSC2FfhR18ULhR
         x4oFx+PkBqnANBG3m4U5ENRBOPL66J5knn0eGFRVVG+pYPFGykvrIX8EmOsRXJzkAuPh
         txC94AQFVoMsBTm7Cbm7sv87HudbbenoBHZsynv1bAzpsclZMP4batsh23IfnIO+2yrv
         hw6mCQF+988xl2JqGGV9N6d3zWxM+PCnWB5MprdvQ7hYqmGx4xX4F3rGjPpPICJU14ZC
         6z4Q==
X-Gm-Message-State: AOAM532tZ2p3K7qXIDmC/n3se6jZtCVRNeHtXGRPs5SPp1x7+IdJp4Hh
        LfecWcXy1Yg1vBUn22sCtAAkIvk3qTN3JdIM
X-Google-Smtp-Source: ABdhPJwrGyMMDYmDtJaAJcGcRHesDYwqKJo+ErFg5g7Wmu9ZF2HITl5Uet/0fz2q1Xa0OEtSrJwu3w==
X-Received: by 2002:a17:902:8496:b0:156:a95d:69c7 with SMTP id c22-20020a170902849600b00156a95d69c7mr12804223plo.131.1649319742777;
        Thu, 07 Apr 2022 01:22:22 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm22248098pfx.34.2022.04.07.01.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:22:22 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/7] iio: adc: refactor some functions for support more PMiCs
Date:   Thu,  7 Apr 2022 16:21:45 +0800
Message-Id: <20220407082148.571442-5-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407082148.571442-1-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
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

refactor the common adc_nvmem_cell_calib_data,adc_to_volt and call
these in the origin sc27xx_adc_scale_calibration,sc27xx_adc_to_volt

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 57 ++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 28bd70c27420..60c0a6aa3f45 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -136,16 +136,41 @@ static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
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
@@ -157,24 +182,13 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
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
 
@@ -285,6 +299,7 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 disable_adc:
 	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
 			   SC27XX_ADC_EN, 0);
+
 unlock_adc:
 	hwspin_unlock_raw(data->hwlock);
 
@@ -305,7 +320,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
 
-static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
+static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 			      int raw_adc)
 {
 	int tmp;
@@ -314,6 +329,16 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
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

