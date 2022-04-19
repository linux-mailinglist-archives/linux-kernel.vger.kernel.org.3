Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC03507053
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiDSO2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353484AbiDSO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51924634F;
        Tue, 19 Apr 2022 07:25:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r83so3856810pgr.2;
        Tue, 19 Apr 2022 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2XIqcdWZLZ6QhkysIjeGWslZHtJcz+vplIUafCxugM=;
        b=MOi01fvFRljtspIqhYSGTrwOQU5LYW1s9xhOzeaVXfaf1foOgWoRwJay0GxqikA7jM
         E8FOi3KIwPxjlzaR27LnpNtlHshJzHZmjPr3l9cS7BhM9YGeHcH7asuyzHE/kRM2d96S
         +peh6M7lJWCXeBTvNf0XSUaF3HpOrGP8T16Sp7puadYdsFa9s0xLmabFEfFcVzFwP9MO
         p2F93mtCadhI6LsSZ2DmxgZEhCcyZsymmiB8mvnRffnuqQta4FmAuoYKVicIMiv70ogb
         SqU1AdPFFKA+u/HUxkTwSG4f2SR2IWjl3ap+ujgmD9bX1xpzeeltL88KfFfNzuxiVr3u
         sd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2XIqcdWZLZ6QhkysIjeGWslZHtJcz+vplIUafCxugM=;
        b=T1yk7R7QAXXtLF6yrgsLXv8xIVPuXv1nYJuOM6oNJ8bpVz30aWiio7ml0tFub0d0Ct
         S+0fCwIV7POW0VVKyShly0Z5pz5lZof/QBtah49PPJl75YSvxuE8yNWTkhVEm2bqXM63
         OXyYvRcmvgnFfNUTGVVItqk8k5nGqy3tRNeYyil+uUlD6a3WzUHRItCOuJt0gVngxpXd
         9iFUTwyhA/d8U5OPAF7hkagJ1ePTxZkWOw+Zal/1xfRXKhuy2zWq4xddtk0D/fK6linD
         z5gPxYu5N4y7pQg97lnKwUOoojTQ0nQjyGsAnVg8Dtt56owUk6y2f4UQ7fcpV7BhDrSd
         YaXQ==
X-Gm-Message-State: AOAM532Gpu6dAIf0LgXYdV6i9epAwLjeSZT7KfGJazBZu7zFuZCVcKo+
        I4JA7obO2yZuySuJYdlbCME=
X-Google-Smtp-Source: ABdhPJzCKW3Xm3lgZE1UbJffYaPAT0Ljgn4RLlo2BuUgIUp5R6Hg+vwnMnsZu5sAsC5rd48FKzWCSg==
X-Received: by 2002:a05:6a00:1a01:b0:505:b3e5:b5fc with SMTP id g1-20020a056a001a0100b00505b3e5b5fcmr17948583pfv.53.1650378326610;
        Tue, 19 Apr 2022 07:25:26 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm16681939pgp.22.2022.04.19.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:25:26 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/7] iio: adc: Fine tune the scale calibration values
Date:   Tue, 19 Apr 2022 22:24:54 +0800
Message-Id: <20220419142458.884933-4-gengcixi@gmail.com>
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

Small adjustment the scale calibration value for the sc2731,
use new name sc2731_[big|small]_scale_graph_calib, and remove
the origin [big|small]_scale_graph_calib struct for unused.

Fixes: 8ba0dbfd07a35 (iio: adc: sc27xx: Add ADC scale calibration)

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index aee076c8e2b1..24211d2a71b1 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -103,14 +103,17 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
 	100, 341,
 };
 
-static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
-	4200, 856,
-	3600, 733,
+/*
+ * Add the sc2731_[big|small]_scale_graph_calib for sc2731 pmic.
+ */
+static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
+	4200, 850,
+	3600, 728,
 };
 
-static const struct sc27xx_adc_linear_graph small_scale_graph_calib = {
-	1000, 833,
-	100, 80,
+static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
+	1000, 838,
+	100, 84,
 };
 
 static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
@@ -130,11 +133,11 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 	size_t len;
 
 	if (big_scale) {
-		calib_graph = &big_scale_graph_calib;
+		calib_graph = &sc2731_big_scale_graph_calib;
 		graph = &big_scale_graph;
 		cell_name = "big_scale_calib";
 	} else {
-		calib_graph = &small_scale_graph_calib;
+		calib_graph = &sc2731_small_scale_graph_calib;
 		graph = &small_scale_graph;
 		cell_name = "small_scale_calib";
 	}
-- 
2.25.1

