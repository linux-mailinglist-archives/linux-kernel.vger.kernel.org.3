Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565DE488632
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiAHUyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiAHUxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:54 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB21C06175B;
        Sat,  8 Jan 2022 12:53:50 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id a1so9551484qtx.11;
        Sat, 08 Jan 2022 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0ROVjBtOv58dYnTC1wxv7OiF3Nz5B0Zoen6sj7TfJ8=;
        b=ZB3KqunNjaHpw0gvIBkdvu2xaxjBoSRBMEwhiNHLJSo41PtOWYdsXL4GXdoagab2Zu
         8Np4CR6eku4Qgh8rhTAx1RwOo2l6xoa6jgChL9Q1hpOQyuzLoaHLpQnZcU1PwZkg0/4l
         mhm1fUkSv5Wg3LHJrhYPo5owERIT3l/g66+1OHsA5THlgTZSlGaYHNKReoEGB/YqBiaR
         AgPQMP0ce6/BJnl8zf/G6ENHLdOjkNz4usjZ5z7KGSW6gQWzg47vgUPqv8AWur1r2Iqq
         MsUulPfTtYjNyDNMfY7/c2Kqn3sPe1XH5AaqgBK6g91qQArKZxUwynyNnO7Inq6pyFWL
         5T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0ROVjBtOv58dYnTC1wxv7OiF3Nz5B0Zoen6sj7TfJ8=;
        b=vLE81sY4qcnvjW/Z6G897Gzo/4p8ENaln9akr1M2Qn2v9qseDrOKyaFXwp25EzMgSB
         SnxlQykY0JlOXhdePtaQ9ps0e70dlQ8C2FoQwmBWQOFTYKGQwTn9TrzVl3w+UOdssqjO
         taKHxfydXUfpzpGplMJf7Bk5QxcgmJnE4cpekp/G/M/BVXkHV3If7A9e9B6Tp5/Izs7e
         OOPq2wKrPl8nKC2sQn2pCmygYGG4SzIABly5km53DwGpyP9sn6h67r9uhOayKFaVJ7WX
         kfMJ0ZWlsV3Mmw5clxf7Ve/S0QZJGZJututD6WY1j2PcUudYGWdaNQIcVMcjGeg6xZjY
         SWnQ==
X-Gm-Message-State: AOAM530rf8wfIMFMlI++0i3Y8JmojbrWY4E3xYxpz1R1i6txOTP8iEro
        Xv/db/3GJd37oq3gSftycSg=
X-Google-Smtp-Source: ABdhPJz21wLTntPP49TQIqloAjfdrmn2uQZw6sgUBe42HokKBeSeCER37yicB5j4+LV0hs9J01Ovxw==
X-Received: by 2002:ac8:7d08:: with SMTP id g8mr59713780qtb.443.1641675229438;
        Sat, 08 Jan 2022 12:53:49 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:48 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 14/16] iio: afe: rescale: add temperature transducers
Date:   Sat,  8 Jan 2022 15:53:17 -0500
Message-Id: <20220108205319.2046348-15-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 12c5e8d0d25c..4d70b72f59a5 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -435,11 +435,37 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
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
@@ -459,6 +485,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -470,6 +500,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
 	{ .compatible = "temperature-sense-rtd",
 	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
+	{ .compatible = "temperature-transducer",
+	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.34.0

