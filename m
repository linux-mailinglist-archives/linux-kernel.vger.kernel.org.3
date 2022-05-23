Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A0531F44
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiEWXep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiEWXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:34:43 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A9077F23
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:34:42 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-d39f741ba0so20312327fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCt+2GrPkkLQuFQd0ysOIrD9v5YRb1ycOqk25ZHe6EU=;
        b=QiH/msiZeAyInxGvrGwUEfSdbKWbaTyNEd961BMevyc/brAfOZXgi6lzt3hdJoSy3O
         D7jK/2O+Y+VfhvOBtk5qhQqIrqsCf3gQybmgwlZiixutgdC1qWv5XxT0HVaH6akBQ1Tf
         e6mRuuCc15D3YjhR25FHwzr7yWiUme0C3xul6WXXLLY3Q/MGwl33YwUxm6/WlaT28v8r
         x2wCg+pKkoMMtTEXFxDOrkZFcuiu0Wrb2j6zbWoRn+6bat1mXf6KjCumlGIPbdd3vZdY
         fMKN7RgEZsClQg6a3DV0VLbwBXRavf2qODQtJtFIb0MmS8UaSlPdyvKxEcWUnP/owuEF
         porg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCt+2GrPkkLQuFQd0ysOIrD9v5YRb1ycOqk25ZHe6EU=;
        b=JjukHDJSKmQyo74NmLAK0MTr2zwgTZ7XSSwSlsMYGIWKn2OlNLmYjqstQsWJApisHH
         ZC7TUbHHss+f8yw79RKC00rMQrprQxzM23v6EReS5zAtG0nVOgcfcRqND03kkRC9Q6vH
         OZXgw6Dq66+ymjdWzaYwerYul+VwQkD4CbBTsSHOxRrVcenKj079c1xakgkpHLOMrn+U
         5xnbQm3Vt0/A40Xzv8zTpYturZW4bH94np5RiILXT0qYIFw1FlYRHkWLqViDSTfZTuM5
         TI3ITSvwH35EnsXG1HJOV0EmXmxiCj7T+x/nNjdo6vi1uFkb6TpI2XRqv/4gRKs6Apam
         4ziw==
X-Gm-Message-State: AOAM5324qwypEQzEtOm1hzL+tSqnki9O0nQF0pYdRzoomsDwinx0W/kW
        Pb+sEysmbkw+B2y7sn1yzKQehw==
X-Google-Smtp-Source: ABdhPJw26M92bveFTTnyDoAXwGBWyIiwm4i/MAtr6dmWYCraDZxguamiLCnyIxrpYoDR+rzsD0Htdg==
X-Received: by 2002:a05:6870:960d:b0:f1:28b4:41ff with SMTP id d13-20020a056870960d00b000f128b441ffmr881447oaq.51.1653348881457;
        Mon, 23 May 2022 16:34:41 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i4-20020a056870044400b000f15ca674b2sm4305696oak.52.2022.05.23.16.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:34:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] leds: qcom-lpg: Require pattern to follow documentation
Date:   Mon, 23 May 2022 16:37:19 -0700
Message-Id: <20220523233719.1496297-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The leds-trigger-pattern documentation describes how the brightness of
the LED should transition linearly from one brightness value to the
next, over the given delta_t.

But the pattern engine in the Qualcomm LPG hardware only supports
holding the brightness for each entry for the period.
This subset of patterns can be represented in the leds-trigger-pattern
by injecting zero-time transitions after each entry in the pattern,
resulting in a pattern that pattern that can be rendered by the LPG.

Rework LPG pattern interface to require these zero-time transitions, to
make it comply with this subset of patterns and reject the patterns it
can't render.

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/leds/leds-qcom-lpg.rst |  8 ++++--
 drivers/leds/rgb/leds-qcom-lpg.c     | 43 ++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/Documentation/leds/leds-qcom-lpg.rst b/Documentation/leds/leds-qcom-lpg.rst
index f12416f02dd8..de7ceead9337 100644
--- a/Documentation/leds/leds-qcom-lpg.rst
+++ b/Documentation/leds/leds-qcom-lpg.rst
@@ -35,11 +35,13 @@ Specify a hardware pattern for a Qualcomm LPG LED.
 The pattern is a series of brightness and hold-time pairs, with the hold-time
 expressed in milliseconds. The hold time is a property of the pattern and must
 therefor be identical for each element in the pattern (except for the pauses
-described below).
+described below). As the LPG hardware is not able to perform the linear
+transitions expected by the leds-trigger-pattern format, each entry in the
+pattern must be followed a zero-length entry of the same brightness.
 
 Simple pattern::
 
-    "255 500 0 500"
+    "255 500 255 0 0 500 0 0"
 
         ^
         |
@@ -54,7 +56,7 @@ in the pattern, the so called "low pause" and "high pause".
 
 Low-pause pattern::
 
-    "255 1000 0 500 255 500 0 500"
+    "255 1000 255 0 0 500 0 0 255 500 255 0 0 500 0 0"
 
         ^
         |
diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index cfa3362b2457..02f51cc61837 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -704,11 +704,12 @@ static int lpg_blink_mc_set(struct led_classdev *cdev,
 	return ret;
 }
 
-static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *pattern,
+static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 			   u32 len, int repeat)
 {
 	struct lpg_channel *chan;
 	struct lpg *lpg = led->lpg;
+	struct led_pattern *pattern;
 	unsigned int brightness_a;
 	unsigned int brightness_b;
 	unsigned int actual_len;
@@ -719,18 +720,48 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *pattern,
 	unsigned int hi_idx;
 	unsigned int i;
 	bool ping_pong = true;
-	int ret;
+	int ret = -EINVAL;
 
 	/* Hardware only support oneshot or indefinite loops */
 	if (repeat != -1 && repeat != 1)
 		return -EINVAL;
 
+	/*
+	 * The standardized leds-trigger-pattern format defines that the
+	 * brightness of the LED follows a linear transition from one entry
+	 * in the pattern to the next, over the given delta_t time. It
+	 * describes that the way to perform instant transitions a zero-length
+	 * entry should be added following a pattern entry.
+	 *
+	 * The LPG hardware is only able to perform the latter (no linear
+	 * transitions), so require each entry in the pattern to be followed by
+	 * a zero-length transition.
+	 */
+	if (len % 2)
+		return -EINVAL;
+
+	pattern = kcalloc(len / 2, sizeof(*pattern), GFP_KERNEL);
+	if (!pattern)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i += 2) {
+		if (led_pattern[i].brightness != led_pattern[i + 1].brightness)
+			goto out_free_pattern;
+		if (led_pattern[i + 1].delta_t != 0)
+			goto out_free_pattern;
+
+		pattern[i / 2].brightness = led_pattern[i].brightness;
+		pattern[i / 2].delta_t = led_pattern[i].delta_t;
+	}
+
+	len /= 2;
+
 	/*
 	 * Specifying a pattern of length 1 causes the hardware to iterate
 	 * through the entire LUT, so prohibit this.
 	 */
 	if (len < 2)
-		return -EINVAL;
+		goto out_free_pattern;
 
 	/*
 	 * The LPG plays patterns with at a fixed pace, a "low pause" can be
@@ -781,13 +812,13 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *pattern,
 			 * specify hi pause. Reject other variations.
 			 */
 			if (i != actual_len - 1)
-				return -EINVAL;
+				goto out_free_pattern;
 		}
 	}
 
 	/* LPG_RAMP_DURATION_REG is a 9bit */
 	if (delta_t >= BIT(9))
-		return -EINVAL;
+		goto out_free_pattern;
 
 	/* Find "low pause" and "high pause" in the pattern */
 	lo_pause = pattern[0].delta_t;
@@ -814,6 +845,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *pattern,
 
 out_unlock:
 	mutex_unlock(&lpg->lock);
+out_free_pattern:
+	kfree(pattern);
 
 	return ret;
 }
-- 
2.35.1

