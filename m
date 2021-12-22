Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A791B47CBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhLVDrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbhLVDrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:16 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE17C06175D;
        Tue, 21 Dec 2021 19:47:12 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z9so790297qtj.9;
        Tue, 21 Dec 2021 19:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TH9SGoqCGqjpRTVMP6t0tW87Hqe51JYySghz/DelDTQ=;
        b=RxdgT4vZ5qQmwj+NgpYDZEIwyzNBxMS1WnsS8/wldFZSyZ1G2xGGrajP2G+7w37eyn
         A8/pXb+VJQL/9jfUTgRXyJqJCK4K6lbZCwanr9HDKn5vUJbG+RkpL9FWff+rcZ8iM4j2
         l4VhEcstKvKgR3gpia8+q9/Xjr4mFcp00mY2yTXAIBpfp02vPdWDlQhtQurX0Nk5Xjfl
         8ruJuShfjhuvUGPYok3Ta16IZoP2QWh1lYJ4aWeYN1mNmgbjDqjALd4zlgeSb+T50OcW
         kD5+wHNFNfttwVdSw27dj5N6LMZsjIGMOOZeGdwOBKobTPvp13+lcMbE4SM945t97yUB
         Yr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TH9SGoqCGqjpRTVMP6t0tW87Hqe51JYySghz/DelDTQ=;
        b=dx8Ov/sJrDLyplojzLckLihj31aXKYsEBsASYq+s9ydhPp+486fSdPmcNw5AHJOA+o
         YLxkIaISMT7plq6QdUFrBN+mHgNjJHDtPyfk+UIkRKQVlPimOG7DBcYHhm888mhHaW6m
         /hhEKeyWoN5GflCU56Jh7akKSyTmM5/nGvNtl0hXXxky6uX9YXGW4Bg2PqP+94jRqmrL
         kvizNncIECvzbH7+w22LEW3Y65eMGEqyZG5YvN5Kjr+xbANAB9itUNpoYczq6T90/JV2
         iR0Pkng1iFAtKuhDxkjbcDLhmDKVimvy5pqh7m4BO7mg2s5jTz336BlirBj+tH2EP3oX
         pPuw==
X-Gm-Message-State: AOAM531SaOgpSSbCY6Mrh8HUzOLyoWH7ATLiGtuKryy7XA2pmwiaqjLn
        KxaOj3tmUEBBL6Iks2hdV+Q=
X-Google-Smtp-Source: ABdhPJx0NMxMbjtMJ2A9Q7kKQgNOJFPhWslsyWreeFEiGFRD4Tw8XW7Q0zsoIU8w6hC2syKw+MmCbA==
X-Received: by 2002:a05:622a:8d:: with SMTP id o13mr916731qtw.574.1640144831650;
        Tue, 21 Dec 2021 19:47:11 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:11 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 13/15] iio: afe: rescale: add temperature transducers
Date:   Tue, 21 Dec 2021 22:46:44 -0500
Message-Id: <20211222034646.222189-14-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
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
index 8cf392500f18..a8e5771d4e79 100644
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
+	rescale->numerator = MICRO;
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

