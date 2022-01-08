Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF5488629
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiAHUyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiAHUxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:53 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94EC061756;
        Sat,  8 Jan 2022 12:53:48 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id f9so8841690qtk.3;
        Sat, 08 Jan 2022 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TjC5W1uMtjFisxRfNfbcBR2U4GPs8BcV/PzZwfqvMv0=;
        b=qgR5O/2WxIrS+uxMmILUab/UbSoxJPm+sTXNeDthISOQBmWbom6pWvtluNnMWz286y
         Klt0TNFrz44DMdCzuBUvYEgFdSTe+wma6ztXkbjfc9wvTtLHKYN/4DM8ulS5560Hu5mu
         D5kQrg2ZeSABNZF3gDdkq6cL2mAtV7/rzHOer/Uds00Y6q1x3k03v6qHFQb1KAIUu4bR
         xNdvHt085N0zUWEbaiH6elK0TcBXHSTnR5IxOJetJ8mA+jemB3bA/QWs/qcrQQAEZ9f3
         PtldnH9a3jWfbHX2V3nQTJyvxakOz/MT9kq21JJoUwzSvwyvmqBqLGJbvvoid/m2w7QU
         m5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TjC5W1uMtjFisxRfNfbcBR2U4GPs8BcV/PzZwfqvMv0=;
        b=0IX5E/Q9AwbYrOHFW3RjN0CEvicRmItsx3tCeKzKVoSMXq0tuT49TCYY0GnEB51Dzs
         DeYd3wJwCKOE/D2rxJqbu6K+J4sCbyHk/h65jponIuvyThQtHroDOqc8zL1Ek0MiIa+v
         uCU3U9RLhVYF2yceBBnynDCb0IfoCOGQpGds8t6tMPynyavuJgVuXOGz1Da7SNONTpxc
         ffWSarKwcXv/TGEK+j1/BsqYSNKLKRDfmAQqvw/1pqhHLS2iQr9V7Yq7Fq6orfT37g92
         YajVzbMmi2/r0rRMXcMY4UIGlLueOGRjwyQJNhZ/04lhqjLbd7qR5Hw4Iu8C+vP65ERO
         3anw==
X-Gm-Message-State: AOAM531jEdsLOoKpiW26PXwsrAS8p3mVjNKG8QMgD0CVawbWBzSzknwK
        4nVmdrZAch3pCxk+LB1kP5s=
X-Google-Smtp-Source: ABdhPJzoKhpzUftsJiJHg3fm+WL8TPTr7iaftV3voI1nR6kaRXcQRgDuj/EWb5SykEdkie7zxyW3MQ==
X-Received: by 2002:a05:622a:312:: with SMTP id q18mr24966493qtw.367.1641675227732;
        Sat, 08 Jan 2022 12:53:47 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:47 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 13/16] iio: afe: rescale: add RTD temperature sensor support
Date:   Sat,  8 Jan 2022 15:53:16 -0500
Message-Id: <20220108205319.2046348-14-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An RTD (Resistance Temperature Detector) is a kind of temperature
sensor used to get a linear voltage to temperature reading within a
give range (usually 0 to 100 degrees Celsius). Common types of RTDs
include PT100, PT500, and PT1000.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 2379da74fe23..12c5e8d0d25c 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -394,10 +394,52 @@ static int rescale_voltage_divider_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_sense_rtd_props(struct device *dev,
+					struct rescale *rescale)
+{
+	u32 factor;
+	u32 alpha;
+	u32 iexc;
+	u32 tmp;
+	int ret;
+	u32 r0;
+
+	ret = device_property_read_u32(dev, "excitation-current-microamp",
+				       &iexc);
+	if (ret) {
+		dev_err(dev, "failed to read excitation-current-microamp: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "r-naught-ohms", &r0);
+	if (ret) {
+		dev_err(dev, "failed to read r-naught-ohms: %d\n", ret);
+		return ret;
+	}
+
+	tmp = r0 * iexc * alpha / MEGA;
+	factor = gcd(tmp, MEGA);
+	rescale->numerator = MEGA / factor;
+	rescale->denominator = tmp / factor;
+
+	rescale->offset = -1 * ((r0 * iexc) / MEGA * MILLI);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
+	TEMP_SENSE_RTD,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -413,6 +455,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -422,6 +468,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
 	{ .compatible = "voltage-divider",
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
+	{ .compatible = "temperature-sense-rtd",
+	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.34.0

