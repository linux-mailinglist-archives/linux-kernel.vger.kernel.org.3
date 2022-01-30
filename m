Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6954A377E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355631AbiA3QLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355524AbiA3QL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:29 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02D0C061714;
        Sun, 30 Jan 2022 08:11:28 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id g145so9948394qke.3;
        Sun, 30 Jan 2022 08:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jjgCn3mBolm45h7eqN9B5gezc4C0SdaFeLGtUL9oKqw=;
        b=Y/UTq+/BzSK3RO7H/pXg5RgOsMrlf+61ShkBaJn7a3FPd4YqC1nhTL71Rpeftkoqcd
         Z/F/Tvt8+vWnID8zfPJmR6r5I9hKCerogHLN7Yh9Y3yoZxZN3XjTFLCfkFiDLdb+Vyxy
         P6NNQp1fOn+v0lJnSO+opE3swYqn80CSoys7s5e1k3zQf9TK+Ks9gx5MXPJDAK3BIDzM
         9SbFgqTfYu2lhMaRLT+RYDe5STsYVo6kUw2YauhWyEtrEi40mWOj2+czDz8O3ZisOm29
         drACg9jt5ts1b6JROoFKzU14KtMq6hXAxyghvtWfsrjsZO3V0Wbk+NyQUGCV5WE2RjnP
         ZrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jjgCn3mBolm45h7eqN9B5gezc4C0SdaFeLGtUL9oKqw=;
        b=SLGLmru8ifq/wY/Np7hAmqFT1S/RO7hYioakeTGe+bVqWDKZGZIzBbXdVF7kdFYV5Q
         zU75l6IlfltO2AHiHyKZILKo8Y2F83G6nDV8aDEx00XIYIXpSXGXyaji85xPLGUnd0TH
         wTL+Apbas5gA+JMA/JA8/lG2r8A3JuOInbjukPVidvaSfciuwAnPBm4+svrVqBXY/c8B
         YLAkHUkF8isJhjwbylPX3c2ME4+iP7OIWyXpKxbqlUoi/OlldkkA+MNfy2h/59tDM3yb
         RkaiCBLBSbJy6skLZ0C8mMDtZT8vW9cqgWC9CXEeEp/1WeLE/S7Xk5DBBxe9n7kUviel
         NOTA==
X-Gm-Message-State: AOAM533NxaoAP70FQNU4ZpIZRHXSBHhyfuDYsuVpwH1z5kUNxOBsAVpg
        HdB6l+3xGFPs1WtMq2y9cnWsUaVNVFU=
X-Google-Smtp-Source: ABdhPJw4f20aF63TnrOwhJlsZ/BwUORzblioa5tl2pVr1rso5weDZki2kdfdh8BYYSzmMSauEiXxbg==
X-Received: by 2002:a05:620a:254f:: with SMTP id s15mr10926696qko.321.1643559088040;
        Sun, 30 Jan 2022 08:11:28 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:27 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 08/11] iio: afe: rescale: add RTD temperature sensor support
Date:   Sun, 30 Jan 2022 11:10:58 -0500
Message-Id: <20220130161101.1067691-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
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
index 27c6664915ff..ae71a545c7e0 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -395,10 +395,52 @@ static int rescale_voltage_divider_props(struct device *dev,
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
@@ -414,6 +456,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -423,6 +469,8 @@ static const struct of_device_id rescale_match[] = {
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

