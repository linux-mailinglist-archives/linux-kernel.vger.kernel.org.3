Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5D4B3924
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiBMC6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 21:58:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiBMC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:58:02 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E8606E8;
        Sat, 12 Feb 2022 18:57:52 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id r9so1396839qta.1;
        Sat, 12 Feb 2022 18:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2beK8Xo7ZUA6pwRUqGcFRI5SxTB6l8oXZqr26ObJoM=;
        b=ldiF86Xq0Wu7iIPYZCMAovUvu+QjlvhE/Cj4J1nLDTbJB+U47EHmIXtJEYAeMNddlu
         0jhdoobRVdoo29yXKqWma+mmCT176Q6xcxZSv6+ExlMGwlFy96mOyE/bRTxdVdN+5RLo
         m41BzXcSfTqJiUyPg8eF4CjzfCbKdTq25R2VxD2ROaRh+I4guWhmB2oYhpmNs9ZbJ1uI
         JXCLn5FKhl5pEMAmHaQ0pWX2VtvDH6wEAbibaDzOlaDofPZrhNuFqYI4gf72BXoU4AqW
         XcmdgfwG83/Uqv5ccsvpYqCI/3F4ykFCEDrTChoPuAQO2qLx47m5zD+2W/0t9ddyRADX
         Jn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2beK8Xo7ZUA6pwRUqGcFRI5SxTB6l8oXZqr26ObJoM=;
        b=58oRt1HIvfpU3j74rmZRFmUzpUQUIMsg85EtzdFaCm61LmaPfbhXUam8mMcd1dJkkT
         sJ+AKvpDZUElZtnDQ2z4XbHPvmC9WxxMWkeBqvT41GCoNlH2/Pl6ipkZQov3OUB4Wuor
         f0JNJevG99K+FQLiVnhUXqwnS6BYg0mEudm2w8cE9Ho1GoaING4rGtF/S4dGHe0N/LCU
         Nxq9Xw5Iktm+3CUyu+7dKccChgmJZLWk/QwsjyfWMkGu3Vpk5UFa8Ag4xcPfwM8/via/
         5UE8eZyi9rdgoSQyZIeNrd7A0yiYfGTIA/EguNxVouANifHQ6Jm8Hce0KtfoDeWfyyBE
         oSZg==
X-Gm-Message-State: AOAM530LgRiiJgPqaAv5i7QEqNQvsKFSKOCpfjrxYa7UVIOGsf/+w87h
        TVhZ8DqFuqQ/AtL2s3pvkqM=
X-Google-Smtp-Source: ABdhPJwZFS85eS5W4PJxrhrFFSWdT9xvHMuosYnx58YpgcOSYmrdpWeKuCxcQOPpx6QtitfJaOHVGw==
X-Received: by 2002:ac8:5b8a:: with SMTP id a10mr5604208qta.469.1644721072056;
        Sat, 12 Feb 2022 18:57:52 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id y15sm14551106qkp.22.2022.02.12.18.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 18:57:51 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v15 07/10] iio: afe: rescale: add RTD temperature sensor support
Date:   Sat, 12 Feb 2022 21:57:36 -0500
Message-Id: <20220213025739.2561834-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220213025739.2561834-1-liambeguin@gmail.com>
References: <20220213025739.2561834-1-liambeguin@gmail.com>
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
index 46947c68d3a9..e31a93435536 100644
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
2.35.1.4.g5d01301f2b86

