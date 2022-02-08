Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100D64ACEA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbiBHCJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbiBHCEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:04:51 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4540C061355;
        Mon,  7 Feb 2022 18:04:50 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id o5so5317309qvm.3;
        Mon, 07 Feb 2022 18:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Br1B4u51ocdlt7WfEv0vTubaAejLqNH+Ysavds7M+xg=;
        b=ivtlL0RVL3/2BmFSoOQg0rPtEIDekwF2pi0Cv21Mbsczxq7t+J8mEHBXWf/dtFcTpG
         1fDrYouiwfeMUskkkfXo8mbkkz7gLhCWt0lLQxWa28Gq5ICMnLVJ/9USIrTF7PC/Jwi5
         nBZ2aM2ojh3B5AVsI+Asg5jm/yWJTBcOvmIQ2Rw434nrSnwR6f/VfhVWutGQZ9KwVNmo
         7b5TBusKCGIa8mt++IXRZW0HfQDf7y9jl7Qx53YUwL8e+qKIgpjq+bycCIYN7bSNAAwU
         +Q5LrAgv3cnqWuS+7YAXjDZGbO9mFX5X+5X0bZOfqbkFX3/Wj2cn22/OlXCHBdsSLuOw
         TqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Br1B4u51ocdlt7WfEv0vTubaAejLqNH+Ysavds7M+xg=;
        b=FiXMb6krWa6knfFTq2pJkbWLfvdvLp56O5g3Ww0w9asIm06vFUXTC4JvSQ0/tYZ0IE
         r4+1Jb/OlRCmI/1ohjJnB7HqHW9kKsPhuAJx/bP8xQM7+EI5vCkZ3COk9ETE+O9dSmYj
         cmvqcrwjjur/RtG/FknWlAoLkAUGFCmndwykVSEhaP1hllafHYBwjNzk/U35G58xzTCb
         9KBjVCBirer1OSMw3mlzj60UmD86TGGm4LcKfCCqV6l8aGMMar55bPICGFFulHUzdm0C
         p4tfXMAX/JIGQXVxZqi7V2+2GbzRXq1EyWUI8yWpcaYsEnY8AKhapejBn/X3ex1n6KrB
         EAUg==
X-Gm-Message-State: AOAM532EZ51lEX7YIjfcMm9nLpRaLIhqD8Hpz3ISM1zBp6ntsuouW2oI
        /4xN6j6hPZ1nrIIuoQfHAOg=
X-Google-Smtp-Source: ABdhPJy+BiiE4X+UxpvAcfOf2f3HKfzaBI0qQ+adwSPW4elIeJpPC8LRjBFvTpfpAbHKPoAml4yLTQ==
X-Received: by 2002:a05:6214:20ab:: with SMTP id 11mr1688846qvd.11.1644285890048;
        Mon, 07 Feb 2022 18:04:50 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u9sm1416055qko.130.2022.02.07.18.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:04:49 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v14 02/11] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Mon,  7 Feb 2022 21:04:32 -0500
Message-Id: <20220208020441.3081162-3-liambeguin@gmail.com>
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

