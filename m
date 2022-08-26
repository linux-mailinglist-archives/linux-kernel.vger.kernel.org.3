Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27B25A2D18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbiHZRHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiHZRHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:07:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9ACCD73;
        Fri, 26 Aug 2022 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661533631; x=1693069631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XAme111dOCB0Z2pzDjE7oI0QWdXeQ1KXWJkSS2PlD+E=;
  b=Gvl/FQ4xlLAkM74iaZjk+26ZbHmfBFWZknJdiNhqHZt0D5lL+lz30NX0
   rKWiFE4BjRDX5ebgyNju22qTqIYHoz+ui92x0lCi2PEhcjnO4AXbh7Cz6
   3dnGuBfYModOKTotYvYsXdoUDGpJxV/uZuSMGg1+hU0ENu0EPNGssy9SC
   nZLWyC62nasyvAU4wt2VZsNXtRAo7OAtMF0AMDNZKNmFGpTLP/gL2Hz4N
   XUr4+6/8blCYr2xAH7xgoRIiTZa/SDnTtyKJvwu8+hGzg7YD7m2KERfxS
   zLe7qpcmu6ae7vpv8/y4L9SU1P9aokXa1WVQD/6OeKAo2QgEVNuR0klYn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="356267443"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="356267443"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="736689377"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 26 Aug 2022 10:07:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 698FA19D; Fri, 26 Aug 2022 20:07:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 4/4] pwm: sysfs: Utilize an array for polarity strings
Date:   Fri, 26 Aug 2022 20:07:16 +0300
Message-Id: <20220826170716.6886-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code is smaller and looks nicer if we combine polarity strings
into an array.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added pwm_ prefix to the variable (Uwe), adjusted intendation (Uwe)
 drivers/pwm/sysfs.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 767c4b19afb1..502167e44a3d 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -151,27 +151,23 @@ static ssize_t enable_store(struct device *child,
 	return ret ? : size;
 }
 
+static const char * const pwm_polarity_strings[] = {
+	[PWM_POLARITY_NORMAL] = "normal",
+	[PWM_POLARITY_INVERSED] = "inversed",
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
+	if (state.polarity < 0 || state.polarity >= ARRAY_SIZE(pwm_polarity_strings))
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
+	return sysfs_emit(buf, "%s\n", pwm_polarity_strings[state.polarity]);
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
+	ret = sysfs_match_string(pwm_polarity_strings, buf);
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

