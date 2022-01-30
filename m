Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9542A4A377F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355562AbiA3QLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355515AbiA3QLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:30 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B353C061714;
        Sun, 30 Jan 2022 08:11:30 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o10so9987057qkg.0;
        Sun, 30 Jan 2022 08:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fw/OVzC4/TuMycBbtz3LA1hmx+kQhk8KPKDNwn0IS50=;
        b=PYXOsbP6gUDRLEeeVwg+7H5/J19fcRD0T1JLyqiMI6S2Z42qIx3o+Y2+U3b/5mj41n
         p8a8LTgDb5+FKtDBJ0KO6fglNZrYDAeOIo4NY/jEnp1NIeCZ/VCuplPv41B7mXrXA/DP
         REC5LCPS29VLKhTreLYTPGPB7PLyxa3oerf68p9JQJJQ9hgn5Kg7+kMTbiN9fBzkyAp3
         GcFCvC9E6jgH/7+sETY7QYZFpn4seOI188GGkZL/K4tGrxhFPmWW4vraN5tRVslPCdsX
         T79B8C7QwxRy6cSklQ57AksWFj39BzTKxpxMY4UVuGg4tQCpCX/U9CeXZ9pdSzqfiOp/
         FHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fw/OVzC4/TuMycBbtz3LA1hmx+kQhk8KPKDNwn0IS50=;
        b=1Q1MYXQX5nVHgVDDsmlw3WKqgW0MLOyEP/5NdcN4O1oHS+Cdbk2dvGS4ODTQWkARt7
         g0h/rnpHIXaGsLROTPfywd+YLzeaH+5HGhSCKhUp0KQzgp259M3SkZuCww+1fpgD1Ya8
         des6E+fcyxqZfiH8DmwVmsvex6guUM28cLRwTvy3VjYRqwnkGERSezthLuMGbdRoR6Ju
         JJTGS9tFOUxcy4m65u1ndiuSomvYWchs3eDnxFLvvw5UZTGkJkdst8+jyo9mt2m1tx+j
         3KiUcFz5ioSn9W0FMngmSrGVYbzJ7kB1xuoX5+FRuJ4pk6G4rnZ6tLhoo+JX3AdvhKIj
         33+Q==
X-Gm-Message-State: AOAM533eUE79WvBbNubUUI6gz8Q0vjGQRV1GMUGf5EEFLU2Ew27ZA2xm
        LmV7A92mDry4Za0dYEN4Gs0=
X-Google-Smtp-Source: ABdhPJwOYlNllxg97M9fxsgY9oDVUnOHkrQc36asyfMusxWSncSXGbwylnLs8HAd07Kcv/i7MvHmzw==
X-Received: by 2002:a05:620a:40c5:: with SMTP id g5mr10746742qko.139.1643559089695;
        Sun, 30 Jan 2022 08:11:29 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:29 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 09/11] iio: afe: rescale: add temperature transducers
Date:   Sun, 30 Jan 2022 11:10:59 -0500
Message-Id: <20220130161101.1067691-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
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
index ae71a545c7e0..706d2d224777 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -436,11 +436,37 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
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
@@ -460,6 +486,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -471,6 +501,8 @@ static const struct of_device_id rescale_match[] = {
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

