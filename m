Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77774ACEA7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiBHCJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345436AbiBHCE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:04:58 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA054C061A73;
        Mon,  7 Feb 2022 18:04:57 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id b5so13600124qtq.11;
        Mon, 07 Feb 2022 18:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QvoZbv+pHr/L1kA1kLF299yBHBR+a/t0yMa6iirTydQ=;
        b=Lea+WvNOOMQPMUcxwKxYBTPwn5oDJmsaqDfD9/f6O5Cd2tnExQUfHd6ApkzP1aoXDS
         o6gmtkrRVoxhZfRzv6MG+GQKCvhEq0780EE5nLROg3Ho0/25ey4eKhDee3H+WIFfbJ7N
         rlCMTx3HkRrkZUz4dCLjqFjMKxpPgW3oaw5nGJtiQXczPgG6zcf4bjlnTSLtnQM4SkJc
         S3foxKUfyXHBaGPYEw5y+ZiRbjMpc+x9ceXOm7t7XP5JmfbUfLoLew0YZnd8O3bG5Vm0
         AuEF7LwyBVOAztxkAF8+c/VXKGd52qn5l0/icma/JYI7YXKLo92RHc0RTW0LK1ZMJxBI
         XSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QvoZbv+pHr/L1kA1kLF299yBHBR+a/t0yMa6iirTydQ=;
        b=RVHGnbGkPxGHn4ePDlKrkwr8W0R6uov5saCfGZkI7RDDscXklZmtpPH4QIRkPy+2aD
         qj7BNp68ZlWuwr0m1M27svjaivmYS6Z+CARW8Ha6FaWswkCNZ//kV+ygaTdP1any6VGb
         IiGj+v7dxrkIq4U2vcx7ikj3kLm98oBHkHLnaPwRDgUeZyULlmpvrcKS9d4j/n/Kqgob
         SyryFrnQJ3Ri3/Cr557HcWV3n2jMHe2cy9mlExZJV7WQdTkO5Rb2eE52g36f6gkbaBXp
         GLl3DDCrEaJSCjvDhNtK/NzpeAzJkaMdA5V0H/IYxsNDRLU7t2YNTh/kI+nxGmVwurbT
         yjVQ==
X-Gm-Message-State: AOAM533fDQyFyhc1XBBX82hl4RaFafFp8lG1ibxmPn+ltSLx4JviJT0M
        kYEUQkYgZoBUFYroyixCicM=
X-Google-Smtp-Source: ABdhPJyYfzqd3aS3QpsD+mzM/KwOIcFNZbfXF30XPGIMlOuksZSKucpA36kZUlYUYnLBgexjrkpIgA==
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr1718337qtx.376.1644285897036;
        Mon, 07 Feb 2022 18:04:57 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u9sm1416055qko.130.2022.02.07.18.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:04:56 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v14 08/11] iio: afe: rescale: add RTD temperature sensor support
Date:   Mon,  7 Feb 2022 21:04:38 -0500
Message-Id: <20220208020441.3081162-9-liambeguin@gmail.com>
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
index 4601f84a83c2..beadf9fc0ee0 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -400,10 +400,52 @@ static int rescale_voltage_divider_props(struct device *dev,
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
+	rescale->offset = -1 * ((r0 * iexc) / KILO);
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
@@ -419,6 +461,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -428,6 +474,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
 	{ .compatible = "voltage-divider",
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
+	{ .compatible = "temperature-sense-rtd",
+	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.35.1.4.g5d01301f2b86

