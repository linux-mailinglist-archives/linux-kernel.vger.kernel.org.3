Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6140C47CBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbhLVDrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbhLVDrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:05 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B184C061574;
        Tue, 21 Dec 2021 19:47:05 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id q4so1170217qvh.9;
        Tue, 21 Dec 2021 19:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYPd8gcfe49CwczxLhcMyngfR3LuZKuWpZ+bj0iJ0Z4=;
        b=JBJA6EPRPuttGWy6OcVQXcRnHtGWiQUBh3ZMBhKuMlYPB1wzDsAsOqSmo3Wa7x2SzK
         CJoGqvfGIpGoJES3M3EpbA7kX4WHHDBrMCgioJ3MJ1FYbn4DHF/mLGdtpN8bo2w7/lh8
         HroG7TmWlHG1StO9EbkGxTJZ+ypeHungXBDZJP8y/XJaslf8CADKBcJVHcTvLvhrf+Vz
         uPpwIsi4fj2vgYKSm1gNSW0gdONFEIUYHXAgQmdQtMb0S8qjNQMutN//eiSDqI4SsUEM
         Rv5YQFIzHwP/k3OZcd7FF0OwzyzX80Lfa8Si2iriHSdjuyTbLyypxbem5508pwZ8V9ST
         gvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYPd8gcfe49CwczxLhcMyngfR3LuZKuWpZ+bj0iJ0Z4=;
        b=cQtwl+fIWH+MafRk+jdO6gztCalNWhoF1S7pO+x0Hnd4vJqMNk4B0MPS1UexrhNY4Q
         fklp7chVbFVPWHYmeFCoqls8ZzlnQ5NDdettsb+bHwdwChFjlirDruTrhvQF9sEktVd2
         xqOtK2XdACt7Qy/zW25Xwux0oVfSC5wHRE4j3ugUMhBNOFGHnMLvyWO4fkw7N4GPJc6x
         /pZ9lh+3+OhsU2ZoGNF6f8owd540jOsvJkAkyICR6NXiRS95x2ugleKG+YjNMN1Vwj4r
         P4PedzIsT4VIvxZ0LJeom+ApKO7osKIRdKVEtY6sev8PpE4klJ2oVHtecLOVejIhiKEH
         qlDg==
X-Gm-Message-State: AOAM530diobwLS5GngYnvOnQ/TIH94urA9K+75cGv97HvsktHvkuUWIi
        u1rBolMrCrrjiiFH+2gBpAU=
X-Google-Smtp-Source: ABdhPJzyD9LFui3R0kZllDI2FdpWo1O6TKl/HAeMKJ2jdiTbc4TfXPB43gBlDh710DYr96gAZOuwAQ==
X-Received: by 2002:a05:6214:1c85:: with SMTP id ib5mr1119587qvb.72.1640144824747;
        Tue, 21 Dec 2021 19:47:04 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:04 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 08/15] iio: afe: rescale: fix accuracy for small fractional scales
Date:   Tue, 21 Dec 2021 22:46:39 -0500
Message-Id: <20211222034646.222189-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

The approximation caused by integer divisions can be costly on smaller
scale values since the decimal part is significant compared to the
integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
cases to maintain accuracy.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index a7297b4ba17e..ca8fd69bfe46 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -23,7 +23,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
-	s32 rem;
+	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
@@ -42,9 +42,23 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
-		tmp = div_s64(tmp, 1000000000LL);
+
+		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
 		*val = tmp;
-		return scale_type;
+
+		if (!rem)
+			return scale_type;
+
+		tmp = 1 << *val2;
+
+		rem2 = *val % (int)tmp;
+		*val = *val / (int)tmp;
+
+		*val2 = rem / (int)tmp;
+		if (rem2)
+			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
+
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_VAL_INT_PLUS_NANO:
 	case IIO_VAL_INT_PLUS_MICRO:
 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? NANO : MICRO;
-- 
2.34.0

