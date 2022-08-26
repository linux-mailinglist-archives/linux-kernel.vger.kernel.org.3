Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFAE5A2D17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245203AbiHZRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiHZRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:07:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA32CCE12;
        Fri, 26 Aug 2022 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661533629; x=1693069629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FlBUFOqO3yeVg/iVFi+5/Sl0JuIYKzTkoENlpUb/36E=;
  b=IC1CN3egg1l+q9m3/6lvrikoWwvsQlrJIwi1Sn9qLXrUUqQ/hTEcRutS
   KGmcrZLl91GY17GPdJ4NK/J0LUuPPwry+WL3PHK5KwY5uxauufNsaKIpJ
   m3GgF4RXp5jprZFcZgZXrvOWB68pp3vlr1YVzsO9bA9gwvaoVTCf+F9fp
   Y9R+Bjo8e7JvHr1EGogJUC5Le7TAfeBS28DeM85QoTicxmfGHCp/Stwnp
   F8VBMJFnyJQ6gPS26NdDNGOVSzCU7kuj1zlhL7ggNhi7tjlsQphgB5hTm
   Efkkc+z7c0alDwtQIJRx858w0XZiFtnt0ITwJm+IgZg+BuB1N1lCdqT+9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="274953714"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="274953714"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606822061"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 10:07:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 04AF3238; Fri, 26 Aug 2022 20:07:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 3/4] pwm: sysfs: Replace sprintf() with sysfs_emit()
Date:   Fri, 26 Aug 2022 20:07:15 +0300
Message-Id: <20220826170716.6886-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
instead of the raw sprintf() & co. This patch replaces such a
sprintf() call straightforwardly with the new helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2: added tag (Uwe)
 drivers/pwm/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 1543fe07765b..767c4b19afb1 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -42,7 +42,7 @@ static ssize_t period_show(struct device *child,
 
 	pwm_get_state(pwm, &state);
 
-	return sprintf(buf, "%llu\n", state.period);
+	return sysfs_emit(buf, "%llu\n", state.period);
 }
 
 static ssize_t period_store(struct device *child,
@@ -77,7 +77,7 @@ static ssize_t duty_cycle_show(struct device *child,
 
 	pwm_get_state(pwm, &state);
 
-	return sprintf(buf, "%llu\n", state.duty_cycle);
+	return sysfs_emit(buf, "%llu\n", state.duty_cycle);
 }
 
 static ssize_t duty_cycle_store(struct device *child,
@@ -112,7 +112,7 @@ static ssize_t enable_show(struct device *child,
 
 	pwm_get_state(pwm, &state);
 
-	return sprintf(buf, "%d\n", state.enabled);
+	return sysfs_emit(buf, "%d\n", state.enabled);
 }
 
 static ssize_t enable_store(struct device *child,
@@ -171,7 +171,7 @@ static ssize_t polarity_show(struct device *child,
 		break;
 	}
 
-	return sprintf(buf, "%s\n", polarity);
+	return sysfs_emit(buf, "%s\n", polarity);
 }
 
 static ssize_t polarity_store(struct device *child,
@@ -212,7 +212,7 @@ static ssize_t capture_show(struct device *child,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
+	return sysfs_emit(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
 static DEVICE_ATTR_RW(period);
@@ -361,7 +361,7 @@ static ssize_t npwm_show(struct device *parent, struct device_attribute *attr,
 {
 	const struct pwm_chip *chip = dev_get_drvdata(parent);
 
-	return sprintf(buf, "%u\n", chip->npwm);
+	return sysfs_emit(buf, "%u\n", chip->npwm);
 }
 static DEVICE_ATTR_RO(npwm);
 
-- 
2.35.1

