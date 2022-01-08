Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED7488615
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiAHUxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiAHUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:40 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B404C061401;
        Sat,  8 Jan 2022 12:53:40 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c15so9182699qtc.4;
        Sat, 08 Jan 2022 12:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBLRVrk3xpz2O6iyUKgQBIpD55XcpP+X1Rfi97tWxlw=;
        b=A5kD749gYOKFY2xeF48Es1ixf68+vj4LsL46VBhD6DSbwi+0TMDtQlksYBkvYABs55
         fZLWWhOdWOwCrmeaCXuPdQ5xIPrD5bn7t2MdRqZyShDaN+CPy3khj1h8zW8zKLt5xjJJ
         LAe0F/DT60qqqA+CbmBXaAjx15oQSX57PkkEAkc7aYchkJt/cpoFZcUO474NQadZMnEH
         GHJrjn1WnaOo3z7qjYDNtnM2mJ2rxxZp3GzvKLbguUJMDxtKyjk5tT0RfaRMFGxtGsvE
         UWw9NLZRUj/uzxo+S90+QqL5MYLYPzBzRLiJz7IqcT/fLZLJrbc60OGppWIOckoecKVo
         22gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBLRVrk3xpz2O6iyUKgQBIpD55XcpP+X1Rfi97tWxlw=;
        b=kFRPR1iyihgaVddzvecwMoQ/lP5b5S/Hcx7wvnb9JPt5xu5VjwlKvS0g3JvprkWReG
         GVLYptSIJ/PQh0F1ISV2IJYJibXMA5wyawS4+muvrW8Kccb/hBlLcKUoGtQMC2Nsp/Y9
         w+3mm4wXTObT7Q/akLWEwrH5GkN2XaFGn++/5rhTqmU5oeIBIzAMXevNiShJF9iXI29R
         X4CSKB2qPFDQzPFDkD7VtuVgbTAu336NEaaA9SFJS/tRGwW+fwUtUpL4pzUU9TI11j8A
         crZpiqC5fxfWb8MMCP6UJTa9BQ4/M8dzs2zgHp+vSuzGXlVn2cU6pLXtQ2MEG3jInuIu
         TOeg==
X-Gm-Message-State: AOAM533sA55Rly9uOiC5JT//UHE/7G/EIiaXzRxm66m8d7WuLrCQgiYg
        Q+MIvwXDhd8bJo8twGSwnWk/emS6Dg0=
X-Google-Smtp-Source: ABdhPJx5xFvNDlmgEVio04Nd6rrcMNdelQtA4MfLnaAzafRk5UAoRw9aO39EpgpJYmm5dHHKvy5trA==
X-Received: by 2002:a05:622a:170d:: with SMTP id h13mr62409318qtk.99.1641675219650;
        Sat, 08 Jan 2022 12:53:39 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:39 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 07/16] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Sat,  8 Jan 2022 15:53:10 -0500
Message-Id: <20220108205319.2046348-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
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
2.34.0

