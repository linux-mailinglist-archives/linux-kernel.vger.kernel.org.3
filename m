Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94CF5A2D70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbiHZR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiHZR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:26:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90548D7D10;
        Fri, 26 Aug 2022 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534794; x=1693070794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2zWAQOZU1jlg5UsmBxiYI1ssdG8wCjNtvRzP9zRWwUk=;
  b=dKEoTXpUSyB6Agoojg1pVTAuie+FLx5aFPqTmTfn/FhuE5LilF7Vlcf+
   gqWfIvyxe06VYEg9FetGJNYGmixvAd3V3D5dvVap6SYHzjHXrcgPwxspe
   Qj8NDlmhg0B3nV9jmq9n8znoh+oFlXTTNjgpEJ30FcVzRoG4W10hz2Zj9
   DoZOuX84kx+mKfON/cH2oNMNvY+xDalxdQN6elSlBsRcJ5ZmWmcW6AxvZ
   2G+Hv1is7Js+xNj+sa2D9kfTI8MBkT7knnCrSFD9HzuA3g3I4EbnXUeAH
   ZGG7/OGY49R2HAiz59DQePS8Z7P+EvDekPTSvUSDCH+TeyCqGq3DUdsNV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="293299381"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="293299381"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="736694594"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 26 Aug 2022 10:26:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C1A5A238; Fri, 26 Aug 2022 20:26:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/3] pwm: core: Make of_pwm_get() static
Date:   Fri, 26 Aug 2022 20:26:42 +0300
Message-Id: <20220826172642.16404-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826172642.16404-1-andriy.shevchenko@linux.intel.com>
References: <20220826172642.16404-1-andriy.shevchenko@linux.intel.com>
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

There are no users outside of PWM core of the of_pwm_get().
Make it static.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2: added tag (Uwe)
 drivers/pwm/core.c  |  5 ++---
 include/linux/pwm.h | 10 ----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index dc1b7263a0b0..cfe3a0327471 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -734,8 +734,8 @@ static struct device_link *pwm_device_link_add(struct device *dev,
  * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
  * error code on failure.
  */
-struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
-			      const char *con_id)
+static struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+				     const char *con_id)
 {
 	struct pwm_device *pwm = NULL;
 	struct of_phandle_args args;
@@ -797,7 +797,6 @@ struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 
 	return pwm;
 }
-EXPORT_SYMBOL_GPL(of_pwm_get);
 
 /**
  * acpi_pwm_get() - request a PWM via parsing "pwms" property in ACPI
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 572ba92e4206..d70c6e5a839d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -403,8 +403,6 @@ struct pwm_device *of_pwm_single_xlate(struct pwm_chip *pc,
 				       const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
-struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
-			      const char *con_id);
 void pwm_put(struct pwm_device *pwm);
 
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
@@ -495,14 +493,6 @@ static inline struct pwm_device *pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct pwm_device *of_pwm_get(struct device *dev,
-					    struct device_node *np,
-					    const char *con_id)
-{
-	might_sleep();
-	return ERR_PTR(-ENODEV);
-}
-
 static inline void pwm_put(struct pwm_device *pwm)
 {
 	might_sleep();
-- 
2.35.1

