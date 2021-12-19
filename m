Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4980747A2CA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhLSWkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhLSWkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:07 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0688C061574;
        Sun, 19 Dec 2021 14:40:06 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 132so7760142qkj.11;
        Sun, 19 Dec 2021 14:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9e8irlmRSA2t7JqsVEUlUCAVCFnFIJe4Q4DTVAL8PV4=;
        b=dBz3DQ5iRgcc92fF9auJ0PJ/X7AdURt/qcz6J/BtzTxXufZ8nsyiatjSutdnYI/d6N
         Ol8YdmnMXjdXFiBXT7Pd2HlWOHFBtDOGnW4ajljKLStuOpSqTLseFWFMsfo8xc+WPMhb
         IaVdXE/2gCrCt168LgpM/5zf4EpT+O/XANIkPaq9dKRQPPik8qo5ECGiVbti7h7eBRyp
         iEek//AQUhT/ir4LOJmfvC8IY0D7VWBj6a9w7l8/Olpv5wdrHU7wD3UcoCajZz+VuUPn
         0aPUcxvqp2cmYTbMQPWkS2JGWj+VAdc8PyGnnGCbNPZfv6uASQUGZyP8dLngeSHFdHnl
         hhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9e8irlmRSA2t7JqsVEUlUCAVCFnFIJe4Q4DTVAL8PV4=;
        b=flRfwdez40ApRGMrx6/UkB9Aq0cCoMbjt8ScKP4SspR/qiBHHTgS2Ngz34KWoydQUp
         PIKp2mwrs95+O5hDatkib+J5Fm8tmQgkNK9bRx2sQ7NBaBTkxxwBOhRTOpy4HWecqNJn
         8ha0HwJmUNRLa/HlxWLCk45pyH33j1SkSNoFVQ8CYh/EqYtGICjmX9uqqY5IByfGr421
         cKYPILNLnaVADD2W5RP2KlMfd6LYMdyY5cfJyqGmj0FAB6zNlqfZ7d/2eGpf77dMdPZj
         cZ/63fxBValbUrv90trdvezndirgBQ/6HF+14R0x286YmvE3ZLxq6jkHSuitaylIr0+T
         HKCw==
X-Gm-Message-State: AOAM532gx8cV6tk9a2w2d6hE2cfkQ1V06qovP1dwsu3DIob+HbSYG7xT
        ng7GlNwbGHYY5ozYfgKbhLg=
X-Google-Smtp-Source: ABdhPJzs4RxzbsB2sXi0g3Kh+GVYzE8a0jnXaHikNE4EG6DMqKdbpht2TQHZP0LnfJtiSsOlXIiKow==
X-Received: by 2002:a37:f60a:: with SMTP id y10mr7712828qkj.518.1639953606008;
        Sun, 19 Dec 2021 14:40:06 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:05 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 05/14] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Sun, 19 Dec 2021 17:39:44 -0500
Message-Id: <20211219223953.16074-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
Add support for these to allow using the iio-rescaler with them.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index d0669fd8eac5..190a83e08008 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -17,11 +17,15 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/units.h>
 
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	unsigned long long tmp;
+	s32 rem;
+	u32 mult;
+	u32 neg;
 
 	switch (scale_type) {
 	case IIO_VAL_FRACTIONAL:
@@ -40,6 +44,37 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp *= rescale->numerator;
 		do_div(tmp, 1000000000LL);
 		*val = tmp;
+		return scale_type;
+	case IIO_VAL_INT_PLUS_NANO:
+	case IIO_VAL_INT_PLUS_MICRO:
+		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? NANO : MICRO;
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
2.34.0

