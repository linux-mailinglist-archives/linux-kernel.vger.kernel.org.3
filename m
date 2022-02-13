Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548814B3918
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiBMC54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 21:57:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiBMC5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:57:51 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A76460074;
        Sat, 12 Feb 2022 18:57:47 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id w8so11621501qkw.8;
        Sat, 12 Feb 2022 18:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnbjHCh1QOx92DD6e2NgUk0P0sOKvVCe1OMBoIGNUKw=;
        b=JDOxp4OvGsK1PR4H3nyjwhyuEzXd8WCKIIuuJjT8Cumwkjmzo0AxbdE92dOYnxez4b
         M9wLYT0QBtEUwaMj1EEdqTIwvJo/AKHIkqdnAqQXZR3YvcEWjFQGCJp4Gcz84tafO1V8
         pCTV1DXse9jl4hzy1XjyJBjWOps9ogngKfyefdBy5eBNKpiD5QCn6iHqs1gYHTBrzgEy
         dCZK4oteUf5xbWmzMz/VduqlV3Dvh95H0LD5SHfY2QwtleBDZXf3KLCSu2hppir+GX1g
         kJdpm7D/dk90+mTe1YeV++ry8UMsQmIIt0kyOMXlSIA/DOFn3Ue3SpwZq3f8ExsLvWcv
         izqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnbjHCh1QOx92DD6e2NgUk0P0sOKvVCe1OMBoIGNUKw=;
        b=vFE3bcIVK9/mFHdOw/EC7iZ8PvgCBj7syxftytSVh25ijtBiV/Mo0E+i0BnX8I4ouE
         iqbe17daVWNWSMgtxdEQJWKu0uQinihYuq5sLRKMX7n+3UKZ2NfYeN6zi3fmoQHtUL5v
         WBvOD2XNI0TEKVaWpC3Sf4UR8LI6Kzf2Owoc+kCSyyihPA1OBvrxvCAEN4IbLGSH+GPq
         sPfPDJGDvooxLx4UAJxdikJk3IkGdCW7SdT0dD4RyJxPX5mDllqKRnQf7Z+lwif4xWEI
         G1zk5M42wMIGGME/HHzImlC/23WdaEXHhVFkaP7/heEkBVSqQiaQK3vJUwfcWrwZ82YW
         7Umg==
X-Gm-Message-State: AOAM531sRtJ3uspfbNjJZ12Qdrw2xT+NHLAVS75n9h8ywoGInLRcWf0C
        dctaT4gDxlsGwxQcbgdUhs4=
X-Google-Smtp-Source: ABdhPJy7VhADcMx2cpLX8Sm1nRqct5oqaAaDowro1AshKSCSMYZbjclWMN3zAkcoj+JDY4/SEZC3mA==
X-Received: by 2002:a05:620a:2443:: with SMTP id h3mr4049841qkn.258.1644721066539;
        Sat, 12 Feb 2022 18:57:46 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id y15sm14551106qkp.22.2022.02.12.18.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 18:57:46 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v15 02/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Sat, 12 Feb 2022 21:57:31 -0500
Message-Id: <20220213025739.2561834-3-liambeguin@gmail.com>
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

Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
Add support for these to allow using the iio-rescaler with them.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 65832dd09249..e67d9a9e6135 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -23,6 +23,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
+	s32 rem;
+	u32 mult;
+	u32 neg;
 
 	switch (scale_type) {
 	case IIO_VAL_FRACTIONAL:
@@ -41,6 +44,37 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp *= rescale->numerator;
 		tmp = div_s64(tmp, 1000000000LL);
 		*val = tmp;
+		return scale_type;
+	case IIO_VAL_INT_PLUS_NANO:
+	case IIO_VAL_INT_PLUS_MICRO:
+		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? 1000000000L : 1000000L;
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

