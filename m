Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0E58B86D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 23:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiHFVXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiHFVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 17:23:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E4EF59C;
        Sat,  6 Aug 2022 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659821008; x=1691357008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y/ekvDK9lfRgpxrLz1N34iu6xjYZHHBgk3QqU8GADcA=;
  b=ObA13w7BRjtU4X86UJXmupe7mhxn7zjm6v2ev7zJyHcDQ1DQ1cj+rGAA
   BmMP64NLkhFlo5AwaVk3CGgxziP3nGcvVVg2iFp+xudYdH95mKuUCCLIv
   ioXTIf/l28MqWWGfRngTL+mi5VSdk1ypHjjEykWFId9281WRO022QqOn2
   XRUSosjqVnqsUgsww76Z5o3KQN0tzeNhwAL2uiiCxOzUmOonhxVl/o2PX
   ivoROelEemPJE6OONffGX6m00J3jKmUkaRbyqUzJku+EnaXmgpneKUKvM
   wAMqoaUH51uPbY1JvW2d38Bw0kquKAIKqfx/CSyKEs2n6y024qEeEMfxt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="290400604"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="290400604"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 14:23:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="663426672"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2022 14:23:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 12665347; Sun,  7 Aug 2022 00:23:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 4/4] pwm: sysfs: Utilize an array for polarity strings
Date:   Sun,  7 Aug 2022 00:23:31 +0300
Message-Id: <20220806212331.40086-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
References: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code is smaller and looks nicer if we combine polarity strings into an array.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/sysfs.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 767c4b19afb1..1bbc5286b7c6 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -151,27 +151,23 @@ static ssize_t enable_store(struct device *child,
 	return ret ? : size;
 }
 
+static const char * const polarity_strings[] = {
+	[PWM_POLARITY_NORMAL]	= "normal",
+	[PWM_POLARITY_INVERSED]	= "inversed",
+};
+
 static ssize_t polarity_show(struct device *child,
 			     struct device_attribute *attr,
 			     char *buf)
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
-	const char *polarity = "unknown";
 	struct pwm_state state;
 
 	pwm_get_state(pwm, &state);
+	if (state.polarity < 0 || state.polarity >= ARRAY_SIZE(polarity_strings))
+		return sysfs_emit(buf, "unknown\n");
 
-	switch (state.polarity) {
-	case PWM_POLARITY_NORMAL:
-		polarity = "normal";
-		break;
-
-	case PWM_POLARITY_INVERSED:
-		polarity = "inversed";
-		break;
-	}
-
-	return sysfs_emit(buf, "%s\n", polarity);
+	return sysfs_emit(buf, "%s\n", polarity_strings[state.polarity]);
 }
 
 static ssize_t polarity_store(struct device *child,
@@ -180,20 +176,16 @@ static ssize_t polarity_store(struct device *child,
 {
 	struct pwm_export *export = child_to_pwm_export(child);
 	struct pwm_device *pwm = export->pwm;
-	enum pwm_polarity polarity;
 	struct pwm_state state;
 	int ret;
 
-	if (sysfs_streq(buf, "normal"))
-		polarity = PWM_POLARITY_NORMAL;
-	else if (sysfs_streq(buf, "inversed"))
-		polarity = PWM_POLARITY_INVERSED;
-	else
-		return -EINVAL;
+	ret = sysfs_match_string(polarity_strings, buf);
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&export->lock);
 	pwm_get_state(pwm, &state);
-	state.polarity = polarity;
+	state.polarity = ret;
 	ret = pwm_apply_state(pwm, &state);
 	mutex_unlock(&export->lock);
 
-- 
2.35.1

