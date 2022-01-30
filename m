Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750384A3766
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355503AbiA3QLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355480AbiA3QLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:19 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9976CC061714;
        Sun, 30 Jan 2022 08:11:19 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b35so9418830qkp.6;
        Sun, 30 Jan 2022 08:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Br1B4u51ocdlt7WfEv0vTubaAejLqNH+Ysavds7M+xg=;
        b=c6BNC82EzqNtTN3Wx+448EseMFzyvIOB/0EWnUurR1HBT5u/0q3M6ygGcJ4YVLuHby
         3J9xCQ7r7uTLbltm2HJxzQnZ0JNEHv3A2EyvpVKY7kh+fsLiFOxaIYRuQ1gVEJKhport
         GBMyXsMV2PPjMt7pMOM9jjSJLS0xVDeVEFdEtr7/l3sr4sQ53EKEZ0nRBUdUMdVa0jzH
         w1cpbhZuRS8YbqM7N0EIm1aK0rNVyVowXc0mbs++eOhya58SvOXesqsRwt3K7h+9o4lf
         roXWyau2u38CafBQJySWCoPlKCX4xYBU+OvnViNUWzVVx+GNkUleXjRZRRCecuJoXHzU
         4NFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Br1B4u51ocdlt7WfEv0vTubaAejLqNH+Ysavds7M+xg=;
        b=4DGDoapVW6F0JPA7PC80oK9AYLXh3zG9mE3Um/wmpwUdB94Xg9SYRMmioPDp38B7gs
         4BBQmKnsC//gz/5ufRF8E9vY5ONOPMlIZPIoXX+jmAame7kuAd2zFIEFPKGSTp+MspiG
         2dAoq9/n0W5nrObrcWGJWG7m6xQMKhg0w5F6JaAcPxAurosKq792d6j6C9xjeH7T+p40
         YvkoB9wARebIZLbt/58dvFPnO4FZ891A0tg9MNLGgxPun4obhKbXzrObzhYrk07xEsk1
         R8WpPI4DEVDIkZX3rJYb2gL+91yUlJHue6JyDdcJpwiDWFiqq6bp8FMieSd6SusxAgrC
         NPjQ==
X-Gm-Message-State: AOAM530jkVRq25lvGe49LW56cP9dtenIfyWtfruEeTzcE14nXvKx5EMJ
        4HD8U00/LUkB0n3o2GpvdzDJTWIt2QI=
X-Google-Smtp-Source: ABdhPJxhJKG1YyPD55P0//hmPlU8XrxhOD/I4xD+bhf9U1joWa9uZTOYy4ZJee4JNm4LVKv8lvkJuA==
X-Received: by 2002:a05:620a:4614:: with SMTP id br20mr1126849qkb.172.1643559078800;
        Sun, 30 Jan 2022 08:11:18 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:18 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 02/11] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Sun, 30 Jan 2022 11:10:52 -0500
Message-Id: <20220130161101.1067691-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
Add support for these to allow using the iio-rescaler with them.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 65832dd09249..f833eb38f8bb 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -14,6 +14,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/units.h>
 
 #include <linux/iio/afe/rescale.h>
 #include <linux/iio/consumer.h>
@@ -23,6 +24,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
+	s32 rem;
+	u32 mult;
+	u32 neg;
 
 	switch (scale_type) {
 	case IIO_VAL_FRACTIONAL:
@@ -41,6 +45,37 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp *= rescale->numerator;
 		tmp = div_s64(tmp, 1000000000LL);
 		*val = tmp;
+		return scale_type;
+	case IIO_VAL_INT_PLUS_NANO:
+	case IIO_VAL_INT_PLUS_MICRO:
+		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
+
+		/*
+		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
+		 * OR *val2 is negative the schan scale is negative, i.e.
+		 * *val = 1 and *val2 = -0.5 yields -1.5 not -0.5.
+		 */
+		neg = *val < 0 || *val2 < 0;
+
+		tmp = (s64)abs(*val) * abs(rescale->numerator);
+		*val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
+
+		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
+		tmp = div_s64(tmp, abs(rescale->denominator));
+
+		*val += div_s64_rem(tmp, mult, val2);
+
+		/*
+		 * If only one of the rescaler elements or the schan scale is
+		 * negative, the combined scale is negative.
+		 */
+		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
+			if (*val)
+				*val = -*val;
+			else
+				*val2 = -*val2;
+		}
+
 		return scale_type;
 	default:
 		return -EOPNOTSUPP;
-- 
2.35.1.4.g5d01301f2b86

