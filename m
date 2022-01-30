Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1100A4A3774
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355542AbiA3QLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355486AbiA3QLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:22 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697ECC061749;
        Sun, 30 Jan 2022 08:11:22 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id o25so9939440qkj.7;
        Sun, 30 Jan 2022 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LZuh2BJBRJTUtNvsar+NW2892hNjIAPPNUSFSiWG50=;
        b=dpnZO3KT6kmPArsuYNYs+ZMNl7/HALPgkEoI+18SEIBTN3uAAqWXX62f5X/7pdv/wC
         PmDyi4G812jtgi5vjOloMi1WggowQ7qynEiOBPzqB3Hu6c1PCkDMQAnXzZxkllKy92rp
         6wz2ADR1FfDF6M5U0VK9WJciSdnU6eH2B9CLmQtJaHOGlZu7SD0O2s5fcGL7rIhIRuY9
         msKyDyUAnV7/9RkxElf6rdkRK62rzb+T4pYq0M/LnDPaEcaiDzRmsi2KI6NT7B5UpnaC
         9r0rNu3ePOGAxm9jxXykx++b6miKyjcxvqLaZ3riMu6ZS0K6k8govYoOPNqEhk3nSdZK
         raUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LZuh2BJBRJTUtNvsar+NW2892hNjIAPPNUSFSiWG50=;
        b=POaraYi/0DNPHmGfV5NHI72WzQkszebqx1T7g9j7HMPrKg6H+XTpVQy+awG+8QvWrA
         szoKQfu7IcI16fwwAsSCBfvOD6PydBPHFGEZEz/MOGnBYtppU/Djf0vqlsAYaHYZ5Di1
         eGz4cyrV9kE3aPcudglWqTGV3MpHFkC5EibQDJE5hPYTD2lBLQkkuyXXMDXLqCSNuYOW
         m590z5szJgrqD+jMuo8L4xYuoz7fc/AwND9Uh33YjgSuc+8gf7ui8KCEp9H2Rx/tVTKn
         Rb1sJK2NPN3iXfKHS5gD79Ea//YUP8boFYZZNpfx3Sis9j5bSZnZGhDTJD9QOvJtFnKu
         RCMA==
X-Gm-Message-State: AOAM530rU1hAEylmY/AEQEqqsJky8aLifkbNp0FgsZzVX5bMp/krnR5g
        BpfzxhA+ORPViN3sgg+V8Ns=
X-Google-Smtp-Source: ABdhPJyfqgcx1YeMVuq5cWtH/dXMJeiL5IEt6I9xU8yUwIzDltLIs/V4nHMKBy+WGlwQKmaCvLNX8A==
X-Received: by 2002:a05:620a:4404:: with SMTP id v4mr10779489qkp.250.1643559081627;
        Sun, 30 Jan 2022 08:11:21 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:21 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 04/11] iio: afe: rescale: fix accuracy for small fractional scales
Date:   Sun, 30 Jan 2022 11:10:54 -0500
Message-Id: <20220130161101.1067691-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The approximation caused by integer divisions can be costly on smaller
scale values since the decimal part is significant compared to the
integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
cases to maintain accuracy.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 63035b4bce5e..468e6c345bd1 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -25,7 +25,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
-	s32 rem;
+	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
@@ -44,9 +44,23 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
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
 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
-- 
2.35.1.4.g5d01301f2b86

