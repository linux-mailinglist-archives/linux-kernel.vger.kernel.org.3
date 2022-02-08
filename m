Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9AA4ACEAA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbiBHCJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345427AbiBHCEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:04:55 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E350C061355;
        Mon,  7 Feb 2022 18:04:55 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id fh9so5094920qvb.1;
        Mon, 07 Feb 2022 18:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfQlEQsSnQDvJT0U+aR8JRv9vIvvKerjJkrDdnIFoP8=;
        b=QzW4ymMZQnCBbuu0Tw+hjSiFb7qSatxqWI/xGKc2eMR2FDa6Ev97oVE+K2cG5+51Kh
         NmPVqvPVI5O0vuV6F8BHVEgBomu+Sqeb1xCBWUlBKnnbC3EB0ISx15K7yZZLbOah6mgd
         HegNRMfy+o46wJzSNCLctsAsyK9Asz1IthF4dh8bQNkGiWSlPIBeykkmNu4lPIyPM1OY
         gm3JTAFEBMtd7JpLkwo/Jc+s4F4Incfyy6yjVFrixU1xr8oHLKk/XshKs6xHTf0sPTuH
         LW/w2NNisXy+3TOjgPJBjtea6rcoc91WfuNz7pWFrJFs5OK+7FO4ZMeClBkztPNQjhAe
         pPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfQlEQsSnQDvJT0U+aR8JRv9vIvvKerjJkrDdnIFoP8=;
        b=0bMQlLxfFcIUrCbUyneMEm+Xh+CJN6aacWzK8m41oDVzuRZ5k/Ao2ojzDfgfk4KYsB
         Peti6LBUcZARcJaqmQ4cSsXHDj0WBngyHFXKcNOeMim3e+ZvQYEh1QFgCYzAmfA8NnXM
         Z91DMsTl9uIGHQOEw9S419PjiZZUy8vSxOyzkV+HkeVzS/bjH3xLm68u6wSMDTYjhWYE
         Q8lCFbkAjBLao4B1aGvVkV/jt02PS0N1pgCReJgxoSf6fOVlqqQ33uP7JnaeQIOZ5aru
         qKcmSlna09GVbtLB3h3i9/w3AKEyVdLdfPdLB3UM+cdBKOqThaLF2niFJZqR/BWn+M+e
         NgyA==
X-Gm-Message-State: AOAM530WfMB+HHeexGLpLWK4tQRbGBQ9PTw47JYSKI5QKGDtB2hFCqDY
        2BATghhoN2OTfTiFzSOHIPA=
X-Google-Smtp-Source: ABdhPJwsd2Uc1PKmKFKCYXv+8bDineGyZkaiOERnrr9QfmgiSPgIfjZ13I0FcDMHsnNEe94QAVV2dQ==
X-Received: by 2002:a05:6214:1c47:: with SMTP id if7mr1634191qvb.129.1644285894438;
        Mon, 07 Feb 2022 18:04:54 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u9sm1416055qko.130.2022.02.07.18.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:04:54 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v14 06/11] iio: afe: rescale: make use of units.h
Date:   Mon,  7 Feb 2022 21:04:36 -0500
Message-Id: <20220208020441.3081162-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220208020441.3081162-1-liambeguin@gmail.com>
References: <20220208020441.3081162-1-liambeguin@gmail.com>
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

Make use of well-defined SI metric prefixes to improve code readability.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/afe/iio-rescale.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 67273de46843..4601f84a83c2 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -51,11 +51,16 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		}
 		fallthrough;
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = (s64)*val * 1000000000LL;
+		/*
+		 * GIGA is used here as an arbitrarily large multiplier to avoid
+		 * precision loss in the division. It doesn't have any physical
+		 * meaning attached to it.
+		 */
+		tmp = (s64)*val * GIGA;
 		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
 
-		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
+		tmp = div_s64_rem(tmp, GIGA, &rem);
 		*val = tmp;
 
 		if (!rem)
@@ -71,7 +76,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 
 		*val2 = rem / (int)tmp;
 		if (rem2)
-			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
+			*val2 += div_s64((s64)rem2 * GIGA, tmp);
 
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_VAL_INT_PLUS_NANO:
@@ -332,8 +337,8 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
 	 * gain_div / (gain_mult * sense), while trying to keep the
 	 * numerator/denominator from overflowing.
 	 */
-	factor = gcd(sense, 1000000);
-	rescale->numerator = 1000000 / factor;
+	factor = gcd(sense, MEGA);
+	rescale->numerator = MEGA / factor;
 	rescale->denominator = sense / factor;
 
 	factor = gcd(rescale->numerator, gain_mult);
@@ -361,8 +366,8 @@ static int rescale_current_sense_shunt_props(struct device *dev,
 		return ret;
 	}
 
-	factor = gcd(shunt, 1000000);
-	rescale->numerator = 1000000 / factor;
+	factor = gcd(shunt, MEGA);
+	rescale->numerator = MEGA / factor;
 	rescale->denominator = shunt / factor;
 
 	return 0;
-- 
2.35.1.4.g5d01301f2b86

