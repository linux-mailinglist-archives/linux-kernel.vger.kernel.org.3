Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FB47CBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbhLVDrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbhLVDrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:03 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8133C061401;
        Tue, 21 Dec 2021 19:47:02 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id q4so1170130qvh.9;
        Tue, 21 Dec 2021 19:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ttl57VYYmerlQaL0ZjPy6rHZFJKzri6btWZcm5ATyE=;
        b=nic9ZXu2Wrk3AVNbLu19LcF+/hVUHwSgOsi5NDruCwmY/A3DIZwFBnkV/bliZpm1RU
         PW9nG/wAy7poTHhZh9ahg5xOVnwDsIz/yRk6c7bE3QJygjirejrpl90q91vdoYZ3bjmk
         /37KNQIyXZdn+eGADNvvEY8b9yg2cxO47zlySY7sgXFNkuosehlvr66BFjqIB7Fro5wl
         jvw8zNfTnX4uFF0qkrppZXNd/fcxY+AkX/fAeq9TYm/0xsdjr5tmj5aUJ8zF3kjnBUb5
         TMzrcxWTWa1zsqcdXJaKIAkFGcm6W9gM9aXlneOuoBWi+dfmvuThttyAjIsZvikBJLEw
         aDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ttl57VYYmerlQaL0ZjPy6rHZFJKzri6btWZcm5ATyE=;
        b=RbHRlSMG4u71VMVJi4R2Y4Cf2+ONKWLsGp4BFb8njqt1akLNrVnwc0exipWOfCN0YT
         4upPeYXAaUUWrU/exH9ZZBUayToMKzkrTcvPhePeZ1IfWqrzKP1/roRrSB564OxkWVQP
         0HWGBK3VXADag10f9rX28Xo+9WxSU+JQXJ1on4voe5CD6pG9WSkW8zhwZbVXv6txVOV9
         zCPmCbakdmAxzPEhrStTH2o6H+E9NSQibCCozXz1tmqmx/uqzsOdQXXZVqL+sS6UdXIJ
         Pr5F4ugamWLm4gmHnYGX/tQwxGBkrk7apHRsJWCVOGHbUeDMyY4Cxo9u8nBEfm6Jqdeu
         Jvbw==
X-Gm-Message-State: AOAM530UGfYFzOJyXuAGBh7+WV4wfstkRUM7mbUobRCId7+QYgAXimoV
        +VR0xLDNS/gAHM5WCz5jS90=
X-Google-Smtp-Source: ABdhPJwDvr0QW/7pr0kNwBSdPRUUBjocWst9Z9oTA0uC3I4/TFB5JUQpswnJDc4OmHvG3QxT092Z8w==
X-Received: by 2002:a0c:f8cc:: with SMTP id h12mr1120934qvo.6.1640144822011;
        Tue, 21 Dec 2021 19:47:02 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:01 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 06/15] iio: afe: rescale: add offset support
Date:   Tue, 21 Dec 2021 22:46:37 -0500
Message-Id: <20211222034646.222189-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

This is a preparatory change required for the addition of temperature
sensing front ends.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c   | 80 +++++++++++++++++++++++++++++++++
 include/linux/iio/afe/rescale.h |  4 ++
 2 files changed, 84 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 190a83e08008..6a2d4ae80652 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -81,11 +81,46 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 	}
 }
 
+int rescale_process_offset(struct rescale *rescale, int scale_type,
+			   int scale, int scale2, int schan_off,
+			   int *val, int *val2)
+{
+	s64 tmp, tmp2;
+
+	switch (scale_type) {
+	case IIO_VAL_FRACTIONAL:
+		tmp = (s64)rescale->offset * scale2;
+		*val = div_s64(tmp, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT:
+		*val = div_s64(rescale->offset, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = (s64)rescale->offset * (1 << scale2);
+		*val = div_s64(tmp, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT_PLUS_NANO:
+		tmp = (s64)rescale->offset * NANO;
+		tmp2 = ((s64)scale * NANO) + scale2;
+		*val = div64_s64(tmp, tmp2) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT_PLUS_MICRO:
+		tmp = (s64)rescale->offset * MICRO;
+		tmp2 = ((s64)scale * MICRO) + scale2;
+		*val = div64_s64(tmp, tmp2) + schan_off;
+		return IIO_VAL_INT;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
+	int scale, scale2;
+	int schan_off = 0;
 	int ret;
 
 	switch (mask) {
@@ -112,6 +147,47 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			ret = iio_read_channel_scale(rescale->source, val, val2);
 		}
 		return rescale_process_scale(rescale, ret, val, val2);
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * Processed channels are scaled 1-to-1 and source offset is
+		 * already taken into account.
+		 *
+		 * In other cases, real world measurement are expressed as:
+		 *
+		 *	schan_scale * (raw + schan_offset)
+		 *
+		 * Given that the rescaler parameters are applied recursively:
+		 *
+		 *	rescaler_scale * (schan_scale * (raw + schan_offset) +
+		 *		rescaler_offset)
+		 *
+		 * Or,
+		 *
+		 *	(rescaler_scale * schan_scale) * (raw +
+		 *		(schan_offset +	rescaler_offset / schan_scale)
+		 *
+		 * Thus, reusing the original expression the parameters exposed
+		 * to userspace are:
+		 *
+		 *	scale = schan_scale * rescaler_scale
+		 *	offset = schan_offset + rescaler_offset / schan_scale
+		 */
+		if (rescale->chan_processed) {
+			*val = rescale->offset;
+			return IIO_VAL_INT;
+		}
+
+		if (iio_channel_has_info(rescale->source->channel,
+					 IIO_CHAN_INFO_OFFSET)) {
+			ret = iio_read_channel_offset(rescale->source,
+						      &schan_off, NULL);
+			if (ret != IIO_VAL_INT)
+				return ret < 0 ? ret : -EOPNOTSUPP;
+		}
+
+		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
+		return rescale_process_offset(rescale, ret, scale, scale2,
+					      schan_off, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -188,6 +264,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -352,6 +431,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
index 14d4ee1227c6..b152ac487403 100644
--- a/include/linux/iio/afe/rescale.h
+++ b/include/linux/iio/afe/rescale.h
@@ -23,8 +23,12 @@ struct rescale {
 	bool chan_processed;
 	s32 numerator;
 	s32 denominator;
+	s32 offset;
 };
 
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2);
+int rescale_process_offset(struct rescale *rescale, int scale_type,
+			   int scale, int scale2, int schan_off,
+			   int *val, int *val2);
 #endif /* __IIO_RESCALE_H__ */
-- 
2.34.0

