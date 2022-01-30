Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87AF4A3777
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355543AbiA3QLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355506AbiA3QL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:26 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA0C061751;
        Sun, 30 Jan 2022 08:11:24 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 13so9901158qkd.13;
        Sun, 30 Jan 2022 08:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3rHofytIHL6hqd3yZWm4UUK7FUFMg5OI+YIKcI4+yE=;
        b=Q0YBL9m8be2oqdHgbAKUEE51LMQddjeNY8fpF4YEguWnm4oZvjL4Giu63VKreF34xI
         fqWxtlNhLhFe+7YbBE7YUR0r1laPemGLfV+3q0y/M3/F/MYN+mFVDo9vHTRGcaZ1YARR
         vC52UpvuW4RBBYygubr5/zlWfqoBfdfBRCM7TA6otPpNEVEK0FtNhpPXhvwgfMCrNVav
         zqihEAJatfzr1vtEnAGbkQAMUrrfSfdo3dLStFvn3hLUFlbdHcemWIG8/btIKwwE4vux
         fIvWCYr+3DgsPQ7xv9Mp2u5g+SC5V65Q61ZWySQyK+1zQOLsLfM9pf69B7VEqH3wR7Dc
         B53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3rHofytIHL6hqd3yZWm4UUK7FUFMg5OI+YIKcI4+yE=;
        b=EwYoHOzgjQISJ4RPk4mOzy0Oos7gmGrJhs51PiYMadxKDtVrOltTwpC6wmHgvdCRbh
         mMhB0zOJ4fheHwWuNBqX9ZMuzEWDvX7TPek+nG3veG+ApKy8IB7hDj7skyJf/4R/IMIk
         ipyHCc56OnGMoKAh9JzWCDGSWCoGfZBX/Hw2WKWhkfy6K68S5e7RYKy4XDu20lBernEv
         JtobNyGPQegppwgffcrXWJtzon6jxnIOMM5q9bBHGeXiMqbJZQxKLVGW79mrbutbi2yY
         KlwA8W5pFX95vO4n/GOEsOX1prgLVgMpQkoPgvWOnADxc4hVt8DE51YFcX+tIkmo4D7z
         Q5Gg==
X-Gm-Message-State: AOAM533Vx9SyVJkAkI6m8M3MEoqtep/UZG8ByC5CoYniueESkWzfbDM5
        /k2VZoLdjJev5ngvhNkYzgc=
X-Google-Smtp-Source: ABdhPJzqUZSbSI8KvRrN8LL7dQrOjv97csm3FvpISrq6P8kGiZDmUEhzo52dCojaPq8AKXG74gHbEQ==
X-Received: by 2002:a05:620a:2886:: with SMTP id j6mr10949233qkp.316.1643559083333;
        Sun, 30 Jan 2022 08:11:23 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:22 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 05/11] iio: afe: rescale: reduce risk of integer overflow
Date:   Sun, 30 Jan 2022 11:10:55 -0500
Message-Id: <20220130161101.1067691-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the risk of integer overflow by doing the scale calculation on
a 64-bit integer. Since the rescaling is only performed on *val, reuse
the IIO_VAL_FRACTIONAL_LOG2 case.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 468e6c345bd1..67273de46843 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -25,21 +25,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
+	int _val, _val2;
 	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
 	switch (scale_type) {
-	case IIO_VAL_FRACTIONAL:
-		*val *= rescale->numerator;
-		*val2 *= rescale->denominator;
-		return scale_type;
 	case IIO_VAL_INT:
 		*val *= rescale->numerator;
 		if (rescale->denominator == 1)
 			return scale_type;
 		*val2 = rescale->denominator;
 		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL:
+		/*
+		 * When the product of both scales doesn't overflow, avoid
+		 * potential accuracy loss (for in kernel consumers) by
+		 * keeping a fractional representation.
+		 */
+		if (!check_mul_overflow(*val, rescale->numerator, &_val) &&
+		    !check_mul_overflow(*val2, rescale->denominator, &_val2)) {
+			*val = _val;
+			*val2 = _val2;
+			return IIO_VAL_FRACTIONAL;
+		}
+		fallthrough;
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
@@ -51,7 +61,10 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		if (!rem)
 			return scale_type;
 
-		tmp = 1 << *val2;
+		if (scale_type == IIO_VAL_FRACTIONAL)
+			tmp = *val2;
+		else
+			tmp = ULL(1) << *val2;
 
 		rem2 = *val % (int)tmp;
 		*val = *val / (int)tmp;
-- 
2.35.1.4.g5d01301f2b86

