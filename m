Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D420447CBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242452AbhLVDre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242328AbhLVDrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:16 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6B9C06175C;
        Tue, 21 Dec 2021 19:47:11 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id f138so1081050qke.10;
        Tue, 21 Dec 2021 19:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pigMIgkunI5i2snmGmunXuqLDS2CrPPd48Fho6Szmdo=;
        b=gCkQe2rNPWyPBzT6lTaClKtwIXUaW8wACcJ8CST5tXlkGP40sb+k5lCECG361NNDPn
         FyhMM15XPfsLNZ9SCWRBbyvZtAA+U7DwTXxyCTgV1s3n3Gm9MMCApJ6w+rpQWvRLiP0V
         /ZPWPLvMheYG4FWxoVCSSZpmCipVjAZ8QNkPgoCReCGXYAYtFizbG8EE1bdn2RJcRKVJ
         /FgLMgqijFSSzrakeVynWxs083knAgmIeriHCDS6wjLNxjbgWEzm68AXBU7uehyYxYUu
         zmXb0QnP9tdjx0D0ofWMklfgLWvjzSQ1EExKmGZQ9piQ64I0viyAz6U2qX3wb2OHvyHP
         G4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pigMIgkunI5i2snmGmunXuqLDS2CrPPd48Fho6Szmdo=;
        b=2pixuhuYTi8wjXYfbioiNQj1RIM25ZTyvFSvrNDsTTQPMS88ID6Er8/QpXpKBVUPY7
         Y9u6TYdUXVe7j2cAWTOpFx+MV1BOK88eXsnUDQQFyOFMyksx0SYlS6jS4JqEbTXPGaNX
         QzyPYy3FtB2OLIQkTEW9gyLTUNG6UxsVjhyASIbUzML9RdQx/cfZHz2b3D+x3cWvMKPV
         C2HjEJE5lntVLhSbcOxX/UAmf7c9rlnTID3Zspt21KFmmJOE88RPPdIfyLjfosmXos5u
         rb1un1SBDJv3KNWG28YoCG3gEFS1TNMhCPnI7aBGmVpF9qyQb4orxQE0D3yVHsu0KcO1
         N4+A==
X-Gm-Message-State: AOAM531bH5kXwY6DTZDxWNYEP3DKtl+N7akTf7/7yj1SOQ0UtUMviGBp
        ERRNP9ARcac1oWKbib9WUpk=
X-Google-Smtp-Source: ABdhPJz+XW2lkuDF8x6Bu712pi2trqBF9eej86h9oW7mytFiDe4jChXT2DKDOg8mJJv2xtucVR+N5A==
X-Received: by 2002:a05:620a:1f8:: with SMTP id x24mr927854qkn.773.1640144830317;
        Tue, 21 Dec 2021 19:47:10 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:09 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 12/15] iio: afe: rescale: add RTD temperature sensor support
Date:   Tue, 21 Dec 2021 22:46:43 -0500
Message-Id: <20211222034646.222189-13-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
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
index 27f99ce67b94..8cf392500f18 100644
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
+	tmp = r0 * iexc * alpha / MICRO;
+	factor = gcd(tmp, MICRO);
+	rescale->numerator = MICRO / factor;
+	rescale->denominator = tmp / factor;
+
+	rescale->offset = -1 * ((r0 * iexc) / MICRO * MILLI);
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

