Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CEE4ACF00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbiBHCJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbiBHCE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:04:59 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E077AC06109E;
        Mon,  7 Feb 2022 18:04:58 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id x5so13633284qtw.10;
        Mon, 07 Feb 2022 18:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/j16zcgnN6WpuyOPSvlatKoD7ekS+Km1Th0TXg5a/E=;
        b=As7m3Lnv/cF03z1hzr/9OwxCxWdLV+Cyd21OXrIFkIe3MQPCNXpMFJu//HM6v8mAYM
         x5pwlX/60Ttpny4OythyWXrTchhSfxcUgH4M0rBlav6Tw1pTT7xZ3MXel/5CbRnefeqr
         S0kgSzyyvJy0Je5sGuEUYODeAWyIi9xFcpd9AdGImlO2ffTrDKBUo2DJSWALxpR+Yfh1
         cubMEuBAsQQkaV46Z+va0NpHmMHVbU3bjxy41nqxhToiab6eCVXVyO046plpCwcD1TBq
         IIzlXPWhjXW3KnGQ9U4vE8PvdSDsUZb+zacxvsSBBsQkOob5A0h2W9W/avgc6Z7ucnvv
         qnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/j16zcgnN6WpuyOPSvlatKoD7ekS+Km1Th0TXg5a/E=;
        b=F5r4tBsLYQhexzTMcoXuFLtg/VJ1xAXXl/QCxr7mdWP0Jy5mwxzcOxFEArs7k6AyEx
         HCUG9XMr1NrY/YkoKRWliG2cr5XxlBaAO4IMYNe8nocqQuJJFlG7Nq4ImWkXrK0pi7QW
         TydlZDocTcLcDBOLng+59xV7iwxCqmI/ZCeWepYhOzBb9aT0z/I47+gGnyM063k8N/0L
         OQAbsu8E5gsN5KHmwa3ACPNVPwz9QUmbqc+cq21ObzR5d8R573GKB0TTuDgkhEP8HuTe
         eBzf7AAdZIHpJJG9G6CDj/YBLMahkZ8Z1BPArIrMisGcWV8WuuyTeMDD7n6OcehhWvDf
         sK7Q==
X-Gm-Message-State: AOAM530ggrmIAcL5V0r2cbZdtsAJJfJ4AyidF049VMzU3au6mjq3CUcE
        C2FCjlY/X5HB7x0k4ke6ScA=
X-Google-Smtp-Source: ABdhPJwu93/HyQKJUVyx6eH9bgt3HMQ7aRf95SHpBCtAva0YLKpZa6oHGXSfBIRnaukAneJVuZ9VOg==
X-Received: by 2002:ac8:66da:: with SMTP id m26mr1668384qtp.536.1644285898091;
        Mon, 07 Feb 2022 18:04:58 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u9sm1416055qko.130.2022.02.07.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:04:57 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v14 09/11] iio: afe: rescale: add temperature transducers
Date:   Mon,  7 Feb 2022 21:04:39 -0500
Message-Id: <20220208020441.3081162-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220208020441.3081162-1-liambeguin@gmail.com>
References: <20220208020441.3081162-1-liambeguin@gmail.com>
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

A temperature transducer is a device that converts a thermal quantity
into any other physical quantity. This patch adds support for
temperature to voltage (like the LTC2997) and temperature to current
(like the AD590) linear transducers.
In both cases these are assumed to be connected to a voltage ADC.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index beadf9fc0ee0..45297530b878 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -441,11 +441,37 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_transducer_props(struct device *dev,
+					 struct rescale *rescale)
+{
+	s32 offset = 0;
+	s32 sense = 1;
+	s32 alpha;
+	int ret;
+
+	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
+	device_property_read_u32(dev, "sense-resistor-ohms", &sense);
+	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n", ret);
+		return ret;
+	}
+
+	rescale->numerator = MEGA;
+	rescale->denominator = alpha * sense;
+
+	rescale->offset = div_s64((s64)offset * rescale->denominator,
+				  rescale->numerator);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
 	TEMP_SENSE_RTD,
+	TEMP_TRANSDUCER,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -465,6 +491,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -476,6 +506,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
 	{ .compatible = "temperature-sense-rtd",
 	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
+	{ .compatible = "temperature-transducer",
+	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.35.1.4.g5d01301f2b86

