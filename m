Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95F54A377A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355594AbiA3QLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355507AbiA3QL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:26 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C7C061753;
        Sun, 30 Jan 2022 08:11:25 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id g145so9948325qke.3;
        Sun, 30 Jan 2022 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZB9+RjUHcGrEBPjD/U8YMyBPtBxHiTx27AuwKkfNg0=;
        b=b+4jTzJJdbSigDJepW9QHFwAsA97mdbadodDkbe9iY2pFxQTVjL8wlBTCMBfcvXFXP
         Ie4igs8Zg9ugB+KwKesxG7xiFgNkI3GSzGdep5K5d1WA31gAPRTBStEUUqKwQxjbx2Qq
         BTDQUzWKgeyazHHwiDPPqWp2uh/JDAaO+Zj/Ars4Z3XhG5pj2vlu3uElLEuAbVdSh9/4
         0d3LFMkefo7o1LrJvAeqgxLfucE4xinS6+ygPoXF1f+4UPjdlyL5Q7GRc6k4uqI3/LXr
         yW75zwHAKQg5sdAKXCzGRu3jKIdOlV9tjwLU8udI5j+SS+Kq6VohCmZWvCopjXH+ZVyC
         kl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZB9+RjUHcGrEBPjD/U8YMyBPtBxHiTx27AuwKkfNg0=;
        b=GIctDbLJf5hxOTiAtUPel9R80CgxRKd+7mIIxaJwM3saci6sLm/KI2YcmGOmvxORlf
         wdeUfrbm8dttxsezw6OzpExmbuPduMdO+yEQm+HptMe5aR6KqH5vDUQ3pcNTSsQ8iUJV
         3mHe5YjXgbivYESubKzlckW0loNcZksYkfr6+86ddAvBGagB6tLOOnIlTh/nFrpc/hJC
         /EjWe2XekT9weWSntIIjb++egsNq9xQoAvOt5d9XWmenzHZvH7l+v37Z87poR7j+9UMl
         3Pk0/dziofS/v4J0yTtpgfyISgMpLKKNrbheErCndhiVYq4zne41Z1t4bda7F0/yEmzB
         hRHQ==
X-Gm-Message-State: AOAM5315ZzFEH2K5bCG9tojgIxI7EMsTv0HvBZ6kC7Jd3xVwnLxX0VCy
        ckMBpAHG4TbKLaORm7p9RpE=
X-Google-Smtp-Source: ABdhPJyBrISgAi37wCnuXYJL2YS4VD5OxrqWTRXcI8zk8aL4H9JNHdfppzo6CB1Hqsy1p+AnD9Msww==
X-Received: by 2002:a05:620a:1790:: with SMTP id ay16mr10763124qkb.330.1643559084766;
        Sun, 30 Jan 2022 08:11:24 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:24 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 06/11] iio: afe: rescale: make use of units.h
Date:   Sun, 30 Jan 2022 11:10:56 -0500
Message-Id: <20220130161101.1067691-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
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
index 67273de46843..27c6664915ff 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -51,11 +51,11 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
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
@@ -71,7 +71,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 
 		*val2 = rem / (int)tmp;
 		if (rem2)
-			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
+			*val2 += div_s64((s64)rem2 * GIGA, tmp);
 
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_VAL_INT_PLUS_NANO:
@@ -332,8 +332,8 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
 	 * gain_div / (gain_mult * sense), while trying to keep the
 	 * numerator/denominator from overflowing.
 	 */
-	factor = gcd(sense, 1000000);
-	rescale->numerator = 1000000 / factor;
+	factor = gcd(sense, MEGA);
+	rescale->numerator = MEGA / factor;
 	rescale->denominator = sense / factor;
 
 	factor = gcd(rescale->numerator, gain_mult);
@@ -361,8 +361,8 @@ static int rescale_current_sense_shunt_props(struct device *dev,
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

