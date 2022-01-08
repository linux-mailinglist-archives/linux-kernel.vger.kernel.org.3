Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE31F48861E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiAHUx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiAHUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:46 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8FFC06173F;
        Sat,  8 Jan 2022 12:53:45 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id q14so9561623qtx.10;
        Sat, 08 Jan 2022 12:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAVVTR8V7YyJFJ8xkaZy5F2t1OKBs2z26bNzz6aY2ek=;
        b=ANV8NsvVXr4nqmZDfwgyaSwmkIovdPQPoaY3SKd6Q9kI4ZzpNO0+PQz1DqOFM4K8TS
         eNM3ZTXJjS01A5CcU3i08jz3umSpyEdstelPql6HaMu1pYvHddqEoazC/RYwT1iEb1jk
         USTtCDf+pAp3suyQ/FIlA79V54bU296nIHVQLQ4JsfPZg6ALq0OXwtHfcop+Nu3Xysgw
         ZSf4a3i/RIwz3JXP/xitUWHk/hn332+LOff2IDihU66e4O7e8I3uB+K7R90o23/q4Z7L
         79MlNX+9d4+xQdzXJeZ+RKtEBsTTpDuft+dFvFgrfv3fmEtEkDm1jo0Sq3Mf+YiHzSSz
         TJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAVVTR8V7YyJFJ8xkaZy5F2t1OKBs2z26bNzz6aY2ek=;
        b=I/TcchbMvA3oi4sRUnO0JEBpMjFdPa0PDkmuyIAP5J1nn3x7znCPgBbH0AdmcC5jfz
         RZOjOPg3+C9nYSn1DL0aBJ9Lr/tso6LhsaWx29RsJqgorr8Xsumq/e6RR2OkhdQfMOac
         Ga27Sr08laio4gMF89zVNrbvnZhfVJclzSiu+naGMH30expzq4WsNRPr9BbbyWS8L+GB
         5CBjkP1sKqqTcHEqt7/K2H5pGQT1qjmPNkk1vtvAScfS5aaq6HU/hY6KWsPMylIG2Mrt
         +KoU5JSBChBH7Far3hMFtTAJ0SZXPREOJARfHhEJB7DYj1VhG/91clGAazrWjzPco+MP
         TPtg==
X-Gm-Message-State: AOAM531EPnjng+cIpMLB07qwIadeIc5VlUt8CK27MkFvRti2otnoVpWL
        n1RQsueBWOIl5Y1Z56A6IE8=
X-Google-Smtp-Source: ABdhPJxONqKdL+0how5zMI9NQ11vDLD4o1wCrRg32sLGM4ZghTN/e1189vnXyyo0vTnq97zM+RI3tg==
X-Received: by 2002:a05:622a:93:: with SMTP id o19mr6874942qtw.379.1641675224845;
        Sat, 08 Jan 2022 12:53:44 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:44 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 11/16] iio: afe: rescale: make use of units.h
Date:   Sat,  8 Jan 2022 15:53:14 -0500
Message-Id: <20220108205319.2046348-12-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of well-defined SI metric prefixes to improve code readability.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/afe/iio-rescale.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 5b87965482d2..2379da74fe23 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -50,11 +50,11 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		}
 		fallthrough;
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = (s64)*val * 1000000000LL;
+		tmp = (s64)*val * GIGA;
 		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
 
-		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
+		tmp = div_s64_rem(tmp, GIGA, &rem);
 		*val = tmp;
 
 		if (!rem)
@@ -70,7 +70,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 
 		*val2 = rem / (int)tmp;
 		if (rem2)
-			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
+			*val2 += div_s64((s64)rem2 * GIGA, tmp);
 
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_VAL_INT_PLUS_NANO:
@@ -331,8 +331,8 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
 	 * gain_div / (gain_mult * sense), while trying to keep the
 	 * numerator/denominator from overflowing.
 	 */
-	factor = gcd(sense, 1000000);
-	rescale->numerator = 1000000 / factor;
+	factor = gcd(sense, MEGA);
+	rescale->numerator = MEGA / factor;
 	rescale->denominator = sense / factor;
 
 	factor = gcd(rescale->numerator, gain_mult);
@@ -360,8 +360,8 @@ static int rescale_current_sense_shunt_props(struct device *dev,
 		return ret;
 	}
 
-	factor = gcd(shunt, 1000000);
-	rescale->numerator = 1000000 / factor;
+	factor = gcd(shunt, MEGA);
+	rescale->numerator = MEGA / factor;
 	rescale->denominator = shunt / factor;
 
 	return 0;
-- 
2.34.0

