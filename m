Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686AE505F26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347960AbiDRVPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347947AbiDRVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:15:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D813E2CCA7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:12:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j71so7573969pge.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBEMLFx6kZu4Ftbt5C7GuNd16rsxl/WDeqp/06ttweE=;
        b=bJ3B0eFGTchfQv+WU89bGvDjqoGShoz0Hh2L1M20K3S9SMcuTdpL9CLD0dkuRWWAZd
         AWUwcLYEdg+XmrZ5lwvCWhcEPSGMnqSDE8s89V2DyhZggHgNrF8g/7KwRkFzsUoc3ALo
         Vh4fGz6WQukqeBF7jogRDCe96tOG0NPNQ2z+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBEMLFx6kZu4Ftbt5C7GuNd16rsxl/WDeqp/06ttweE=;
        b=fPuqAmjck6eWOHcptLgY4ZljprXPqo12+mDtciF76/zrjRcHjAX3KoEjN/pasihwM9
         vocYWku1C3oeaPgY7SufUreaoh3YjhDb4z3qSESVxPYPKNRySYT6M9rk3a5/Hq91ECD6
         Msslmbw+0/qacAAAx6VjFh6j5tQv5zt+I7BI1sMY2Eo8KuHOAEJlh80DD9igrAMGwkSO
         2RyL6JEHQWWe2k4Dzlrt0nHiUk2aSHRj11pd+TE2AcyyRgNkzHorkwjwHHlBTRVMaZKE
         h84pQZvLcVDT9OtMGiGcGD0FwqBwG5LFeRqMLozMX2uJP74Xfibj59heTIJw0v0S+Z97
         azEQ==
X-Gm-Message-State: AOAM532eYUroYRb0XnL8/pP7JS0E/K2vCZiWr7IPkQmuwqZ5w4GawIMe
        t4xtKWAtV41duJ1epqsL57EXug==
X-Google-Smtp-Source: ABdhPJwolAsWt9h0Y+VVzao+Yr5uxH82gaUDYsG3rPKRlc7WoPfxh6RefYuK0bVybpXNSKVOwdomRw==
X-Received: by 2002:a63:dd54:0:b0:3a8:f358:5b3f with SMTP id g20-20020a63dd54000000b003a8f3585b3fmr8403482pgj.97.1650316373389;
        Mon, 18 Apr 2022 14:12:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c240:3b46:d799:c833])
        by smtp.gmail.com with UTF8SMTPSA id d141-20020a621d93000000b00505aa1026f1sm13679742pfd.51.2022.04.18.14.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 14:12:52 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] regulator: core: Replace _regulator_enable_delay() with fsleep()
Date:   Mon, 18 Apr 2022 14:12:40 -0700
Message-Id: <20220418141158.2.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418141158.1.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
References: <20220418141158.1.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsleep() was designed to handle exactly the same thing as
_regulator_enable_delay(): flexible sleep lengths, according to the
guidelines at Documentation/timers/timers-howto.rst. Let's use it,
instead of duplicating it.

One notable difference: fsleep() allows a usleep range of twice the
requested amount instead of a fixed +100us.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/regulator/core.c | 45 +++-------------------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 223c6d71a2b2..d0bac80206d8 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2510,45 +2510,6 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 	return 0;
 }
 
-/**
- * _regulator_enable_delay - a delay helper function
- * @delay: time to delay in microseconds
- *
- * Delay for the requested amount of time as per the guidelines in:
- *
- *     Documentation/timers/timers-howto.rst
- *
- * The assumption here is that regulators will never be enabled in
- * atomic context and therefore sleeping functions can be used.
- */
-static void _regulator_enable_delay(unsigned int delay)
-{
-	unsigned int ms = delay / 1000;
-	unsigned int us = delay % 1000;
-
-	if (ms > 0) {
-		/*
-		 * For small enough values, handle super-millisecond
-		 * delays in the usleep_range() call below.
-		 */
-		if (ms < 20)
-			us += ms * 1000;
-		else
-			msleep(ms);
-	}
-
-	/*
-	 * Give the scheduler some room to coalesce with any other
-	 * wakeup sources. For delays shorter than 10 us, don't even
-	 * bother setting up high-resolution timers and just busy-
-	 * loop.
-	 */
-	if (us >= 10)
-		usleep_range(us, us + 100);
-	else
-		udelay(us);
-}
-
 /**
  * _regulator_check_status_enabled
  *
@@ -2603,7 +2564,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		s64 remaining = ktime_us_delta(end, ktime_get());
 
 		if (remaining > 0)
-			_regulator_enable_delay(remaining);
+			fsleep(remaining);
 	}
 
 	if (rdev->ena_pin) {
@@ -2637,7 +2598,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		unsigned int time_remaining = delay;
 
 		while (time_remaining > 0) {
-			_regulator_enable_delay(rdev->desc->poll_enabled_time);
+			fsleep(rdev->desc->poll_enabled_time);
 
 			if (rdev->desc->ops->get_status) {
 				ret = _regulator_check_status_enabled(rdev);
@@ -2656,7 +2617,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 			return -ETIMEDOUT;
 		}
 	} else {
-		_regulator_enable_delay(delay);
+		fsleep(delay);
 	}
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
-- 
2.36.0.rc0.470.gd361397f0d-goog

