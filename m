Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4563509202
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382472AbiDTVZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiDTVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:25:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142434830D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:22:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t4so2869142pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnUXeRCRlyzRf4rHdM1oimaR4S836ovYjQgTQFKqNaU=;
        b=gWl8HFUCd0VGT49+fwFZtJrDzR6cLq8eoQKfT7+sFz6AyIaBn6QtaD+GGFAb7ngmhZ
         jCc6qaKnHtubCn4m3L3bS454ZKDk7i5EB8oUKFyEO+RGbItlZ3Y+JdcHZ0RwkdtnZEgL
         HaXTXCFWlLlkdw+10hDiJQuI/lN32tua38RwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnUXeRCRlyzRf4rHdM1oimaR4S836ovYjQgTQFKqNaU=;
        b=6TUbnmXx2qdUTdtO0Z1Aad7KebetmNo8jW6wTyrLad3KxD5hEQ2wPgfeZ+Vk9AlEyU
         SN5hlllYIj6TS0aJkbBaE3p/Z5rpFUmzc/vQRcoD7XgrN/pLKZCv5FwY/VAxIGf4K/IV
         TCMGKPNCUUwfVhpJlsQbPdyY0Rx6P2R9XRGam1UcjPo/SYZ0YVXTjoThBdAs9+/OXmUA
         FEs909seyXHNQTvgDSCq3bNaovAM5BIkPzFbUiZQGZzsG+HZKw6PILxezQcBwpdXc/8c
         ouS3GjiRXzJSTRQgF7rrWULQiZ89epiqEdssth6izMp4LoQtXJG0zpvbPyRSTu4G0wkf
         lr1g==
X-Gm-Message-State: AOAM5312IcybFzZumc/GnSOpywon2CLJ4dDno1MKjqJBtTBDCbi47e6j
        2vTgHSAVBh0tuPEXjy3Q3U8v7A==
X-Google-Smtp-Source: ABdhPJxTjfLCvhJXWrF1Gg7cXHw23OVJmwCdXvURQB5+mzF7Dj9X1z9AxW0R2IZtgpia8wrRGRAseA==
X-Received: by 2002:a63:4a09:0:b0:382:597:3d0d with SMTP id x9-20020a634a09000000b0038205973d0dmr20869896pga.18.1650489744589;
        Wed, 20 Apr 2022 14:22:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:22df:200c:2f31:fe5])
        by smtp.gmail.com with UTF8SMTPSA id h6-20020a056a00218600b004f65315bb37sm22232512pfi.13.2022.04.20.14.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 14:22:23 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/2] regulator: core: Rename _regulator_enable_delay()
Date:   Wed, 20 Apr 2022 14:22:12 -0700
Message-Id: <20220420141511.v2.1.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to use it in other contexts besides _regulator_do_enable().

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Rename/retain this helper, instead of using fsleep() (see also patch
   2)

 drivers/regulator/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d2553970a67b..8b188e56fd0b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2511,17 +2511,17 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 }
 
 /**
- * _regulator_enable_delay - a delay helper function
+ * _regulator_delay_helper - a delay helper function
  * @delay: time to delay in microseconds
  *
  * Delay for the requested amount of time as per the guidelines in:
  *
  *     Documentation/timers/timers-howto.rst
  *
- * The assumption here is that regulators will never be enabled in
+ * The assumption here is that these regulator operations will never used in
  * atomic context and therefore sleeping functions can be used.
  */
-static void _regulator_enable_delay(unsigned int delay)
+static void _regulator_delay_helper(unsigned int delay)
 {
 	unsigned int ms = delay / 1000;
 	unsigned int us = delay % 1000;
@@ -2603,7 +2603,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		s64 remaining = ktime_us_delta(end, ktime_get());
 
 		if (remaining > 0)
-			_regulator_enable_delay(remaining);
+			_regulator_delay_helper(remaining);
 	}
 
 	if (rdev->ena_pin) {
@@ -2630,14 +2630,14 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 	/* If poll_enabled_time is set, poll upto the delay calculated
 	 * above, delaying poll_enabled_time uS to check if the regulator
 	 * actually got enabled.
-	 * If the regulator isn't enabled after enable_delay has
-	 * expired, return -ETIMEDOUT.
+	 * If the regulator isn't enabled after our delay helper has expired,
+	 * return -ETIMEDOUT.
 	 */
 	if (rdev->desc->poll_enabled_time) {
 		unsigned int time_remaining = delay;
 
 		while (time_remaining > 0) {
-			_regulator_enable_delay(rdev->desc->poll_enabled_time);
+			_regulator_delay_helper(rdev->desc->poll_enabled_time);
 
 			if (rdev->desc->ops->get_status) {
 				ret = _regulator_check_status_enabled(rdev);
@@ -2656,7 +2656,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 			return -ETIMEDOUT;
 		}
 	} else {
-		_regulator_enable_delay(delay);
+		_regulator_delay_helper(delay);
 	}
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
-- 
2.36.0.rc0.470.gd361397f0d-goog

