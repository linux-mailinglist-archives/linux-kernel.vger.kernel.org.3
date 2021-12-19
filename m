Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89D147A2DE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhLSWkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbhLSWkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:14 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8129BC061574;
        Sun, 19 Dec 2021 14:40:14 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id t6so7809497qkg.1;
        Sun, 19 Dec 2021 14:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiSB69/lnlt0JvHfLERHkoqhXycA88i7DNNoftdnvwg=;
        b=Z7mP2oLeF8ek5f+BbDG/IrsKnYNJ/hp28DFi9aZhJfUJYZx4Dk72L6MYoo1cNizDo0
         gTMAmRi9Uwf1WPQh6g9CkMxFp4gri9YdmNAHeNnhmPQn7fA2zUhI3XjGSYWt6m/nNswk
         RkIzUNRQK3AP4t6OV6OIgBKXgR7OZEtE4K7slUNIX3JALBLjx9wXpqqedxjCRiE4Q7v6
         jzTIqYVNgZ0joVY108yNYi8eGZItHKUGLq20k0K4Oie/toj9W8tyy/JPvs/4wApZCzqO
         gp5QacM5Ar1mJrlrJHmHmhQQTJqi5hZ9mld2LyQdTEbzgB3gX7U7QhAjXohkmOCnI60+
         XMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiSB69/lnlt0JvHfLERHkoqhXycA88i7DNNoftdnvwg=;
        b=jnimHfBFSc6MK9LiieNZXLDW8GwHx0hxgPerQtE2y35L098jWIl2A20vTrylMKATQn
         RSTVqwzPd8ValX9gmr21B5h6XfUGvCIFf37UYXMZgsGj9kX/tEXo/BYxIoQoYioiOwQu
         /+nIWb2nTmQDpiWssVPCdAD8q8qQMoBCAUuyD7ih1cnvWHKKQj4J+qhIHFb4pzPME4WD
         KuQt2898jZiEeZtrLucushA67yu6qojuqqqHTyaincZwtGzOvjlnsYGFCu5F+jyeByiB
         HkzgJZo/a69mSiO5NKzVwXk14yiUPzMBVSnVCsjXFnyoB/MsHmLW9kqVxgcE8trOVnKt
         zYJQ==
X-Gm-Message-State: AOAM532/t+gEFtJTovKqNomci/ESnwrFWJc5mJ+TqTnGmy7BsKALVbXn
        8cbmicQgg6z2LyKFLNr9iWA=
X-Google-Smtp-Source: ABdhPJyvH3zFDbg8t+lRnP+/ft/4rzrL61dFUPAL9N8HATrPHyr+dqhADbDVCoBMdE1jSRTX5vxSzg==
X-Received: by 2002:a05:620a:1226:: with SMTP id v6mr7975613qkj.240.1639953613730;
        Sun, 19 Dec 2021 14:40:13 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:13 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 12/14] iio: afe: rescale: add temperature transducers
Date:   Sun, 19 Dec 2021 17:39:51 -0500
Message-Id: <20211219223953.16074-13-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

A temperature transducer is a device that converts a thermal quantity
into any other physical quantity. This patch add support for temperature
to voltage (like the LTC2997) and temperature to current (like the
AD590) linear transducers.
In both cases these are assumed to be connected to a voltage ADC.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index cde39432196a..486eb80f89d7 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -434,11 +434,37 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
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
+	rescale->numerator = 1000000;
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
@@ -458,6 +484,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -469,6 +499,8 @@ static const struct of_device_id rescale_match[] = {
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

