Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BFF47CBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbhLVDrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbhLVDrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:08 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662CAC061756;
        Tue, 21 Dec 2021 19:47:08 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id f9so813736qtk.4;
        Tue, 21 Dec 2021 19:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UwYzFW3ObM8HmwfflXwu0huIgB7vI5nc3iAdMmTmNmU=;
        b=gkGt1VmVj87XpqmfwtcUnP+dNXQGARdd4RirKrYz9F1ElEwmr4a/i/BS36b2pAA5cC
         TFBAf5cYiLyJ2g7fb2F7qWEzonhcjTL1i5tWeTWXocAu1PqLI3inGjDYtULGN/wgj3Xl
         u74hoGNUWsmklNJI24TozFaW33E2vIayODsWj1Lz7oL62iTSLPWq4Qq8BJhlUpDg9eg8
         HWIcHqC+/6PIICStaYmiNd7M2kaB1OFWt498cA3iQpObNAhY4UGKC7A+awgMMygO/eaQ
         rLNpSsX50TgBR6FiktY3wz+L/sze8sfgnwAnNVNnBd0MHyFQV+4N9NigfKIq9lMPKgyA
         7TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwYzFW3ObM8HmwfflXwu0huIgB7vI5nc3iAdMmTmNmU=;
        b=J6Za3WFGfFNuUSy9NM/DemDCNOtRoyGgRemBpxf+1Gnr9H6OIQ+tJOfjrOzNn/8jxp
         ug6aFxVuK+stKwFWRhQRG3nX0wivU4zVTlKMrG8OXIPq5EU/bx8TlmaReVu//xZM5x+6
         ttIHTYOEk8dSlVoIZ2h4m8I7Y2uya92DF38ZN+L/5JPKBk+r3B/J9yCjJWa+VKSLUzjt
         ZWObth0DlXNYz0Hh7W0grLWztr4+zFeJD7L3sZTdgGeKnWKzdL9Ej7xLE6vdOCUbNTn1
         Wzs8W+t2Zd7/PbZH0By9sXLtWeoid27DGuOS86KEhWsZFuL1g/pnm97IMzELFl1fLCS4
         n3tg==
X-Gm-Message-State: AOAM531pyx3d1KxXwy1y1u2BrNB9fQV2h7YCJ3gYx3ea0v3lfvtlLSGu
        O5n1r6wP1K9MocQWgtbMfpVZRsHbXq+8XQ==
X-Google-Smtp-Source: ABdhPJxodpMPcKxoG5CyMw2GNazR17uc6pIl4Xl2Z0qt4LRJZKKtjvEbUio5uk2Z+qjeAktxgBKkiw==
X-Received: by 2002:a05:622a:256:: with SMTP id c22mr937110qtx.284.1640144827607;
        Tue, 21 Dec 2021 19:47:07 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:07 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 10/15] iio: afe: rescale: make use of units.h
Date:   Tue, 21 Dec 2021 22:46:41 -0500
Message-Id: <20211222034646.222189-11-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Make use of well-defined SI metric prefixes to improve code readability.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 0000a58bab9d..27f99ce67b94 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -49,11 +49,11 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		}
 		fallthrough;
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = (s64)*val * 1000000000LL;
+		tmp = (s64)*val * NANO;
 		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
 
-		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
+		tmp = div_s64_rem(tmp, NANO, &rem);
 		*val = tmp;
 
 		if (!rem)
@@ -69,7 +69,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 
 		*val2 = rem / (int)tmp;
 		if (rem2)
-			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
+			*val2 += div_s64((s64)rem2 * NANO, tmp);
 
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_VAL_INT_PLUS_NANO:
@@ -330,8 +330,8 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
 	 * gain_div / (gain_mult * sense), while trying to keep the
 	 * numerator/denominator from overflowing.
 	 */
-	factor = gcd(sense, 1000000);
-	rescale->numerator = 1000000 / factor;
+	factor = gcd(sense, MICRO);
+	rescale->numerator = MICRO / factor;
 	rescale->denominator = sense / factor;
 
 	factor = gcd(rescale->numerator, gain_mult);
@@ -359,8 +359,8 @@ static int rescale_current_sense_shunt_props(struct device *dev,
 		return ret;
 	}
 
-	factor = gcd(shunt, 1000000);
-	rescale->numerator = 1000000 / factor;
+	factor = gcd(shunt, MICRO);
+	rescale->numerator = MICRO / factor;
 	rescale->denominator = shunt / factor;
 
 	return 0;
-- 
2.34.0

