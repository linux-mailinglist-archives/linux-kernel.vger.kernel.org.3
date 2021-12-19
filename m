Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630DC47A2DD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhLSWk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbhLSWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:13 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EE8C061574;
        Sun, 19 Dec 2021 14:40:13 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id n15so8270911qta.0;
        Sun, 19 Dec 2021 14:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2vJRPt5O3209sbPrv3mGFkOdn7JojNelTUXnuF8fWk=;
        b=ekk8GcZQzoerTVy8HXZubcJjMReC8RCOQ7LdIo6ZAcPK6dGWOdJb2UjLQWjfiZVR4D
         ogxV+P9uBYpvMqJAvfVeLNu0HCyQSzVv3A83glSH7tpcGaOGjKIS5cMl4sUKKCpkwP+c
         Ghric0rBDTZlyRHpmDR41az0mtkPpUUPHzFIn2/62saEbOE+19fx0BzZiXtAA4dsBM8o
         gv0tmLot9dM90AmSYO61dWsUr9hZf4mxrlTxNDrGkxC176gzAKXvfGCIKQzgmyUN2C7T
         suY8z/ETAt7Bm0XgqiH+ZUS6zeUJgaSjUtNpdRrQvOvp4R5BSbMbAqp1Wm8Rms8Q2qIE
         dVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2vJRPt5O3209sbPrv3mGFkOdn7JojNelTUXnuF8fWk=;
        b=sPMazTuaW+aUHNZht/XUnrm+ZvxFo10+VBqoHgNSw8rUX3ugJTGCQ/63pOGsiobGFE
         gsFJ01ft7OQcvkFzT+5cWzw1voIU1gr4JdTv+T9oOai0iH3B53nvr5OBrTXU5mzP5NOQ
         UUHCPVgDV6cbuhOG6MjjApVgDdbu1MVJSZtbP7bl4yqv77HEJ/mcP6gEapXZiMp1f61L
         YL2Yf/TO4J9ZtMzbUITyWpEwYbHkV4uxccYX5DvQJGWVfFPeSiBkvkryxep4wsIB6Jkp
         j0Ty+cCx4GOS2Ep62j+645x+HnTJufBC6VjaMw/BPEnNm7sxYn8oYS1gVvE1u42wJ4Df
         VP8Q==
X-Gm-Message-State: AOAM530MsiTVZM6aVh3dEtwkmWjRuoo0PWB59xGvxLSZqM947BsTXcY+
        8uj65FGkx5hAiEWpF8WKJms=
X-Google-Smtp-Source: ABdhPJyGKAPf54DiPC7KLM2ycmOw23nJhvrwAcI4TrSm03tsQChBSk4sYKb8O1JdGj8EZSCSdHbwfA==
X-Received: by 2002:ac8:5a13:: with SMTP id n19mr2851442qta.259.1639953612753;
        Sun, 19 Dec 2021 14:40:12 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:12 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 11/14] iio: afe: rescale: add RTD temperature sensor support
Date:   Sun, 19 Dec 2021 17:39:50 -0500
Message-Id: <20211219223953.16074-12-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An RTD (Resistance Temperature Detector) is a kind of temperature
sensor used to get a linear voltage to temperature reading within a
give range (usually 0 to 100 degrees Celsius). Common types of RTDs
include PT100, PT500, and PT1000.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 4ab19a730a57..cde39432196a 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -393,10 +393,52 @@ static int rescale_voltage_divider_props(struct device *dev,
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
+	tmp = r0 * iexc * alpha / 1000000;
+	factor = gcd(tmp, 1000000);
+	rescale->numerator = 1000000 / factor;
+	rescale->denominator = tmp / factor;
+
+	rescale->offset = -1 * ((r0 * iexc) / 1000);
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
@@ -412,6 +454,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -421,6 +467,8 @@ static const struct of_device_id rescale_match[] = {
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

