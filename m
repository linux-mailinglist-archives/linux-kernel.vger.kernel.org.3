Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A914D58B674
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiHFPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiHFPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:25:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A89FC2;
        Sat,  6 Aug 2022 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659799524; x=1691335524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T/RhLZ5ogPkiHbWiY0hUVl7ToaXbUI2YnBdA5OdIpAg=;
  b=Q1N9RxhVcE657AZn261qFXphRXI+Ng1+kwrJ3dktoup6t5WMFkOKnI3L
   2sqoucURJDCjZvRZSk7u3UJq1Ns+D7OioQkhnwBk1tw/GIt1cJ7zwLCzA
   oSc+9KxeZvMp15ej1jpVFrjsNu2xdXbq2fpxXtxws5Y7MpvuwBd3H2ici
   vhzu/X7LPa0eqJfgsOZCZJNJTTjq8HRGjMOvlSOPfU2aOfc5TPvpa+KU0
   LKdvIsZ0NrGGflryuVjCVsObc703eRFfVhGlstoEWg1z5tkRalK79BAbJ
   20huNHhP72DtsGFeH2WVAP2Gb9NHHoO036sg4MXuQINeqEeNYi8KVaSub
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="291149402"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="291149402"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 08:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636811018"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2022 08:25:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F063017D8; Sat,  6 Aug 2022 18:25:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v1 2/3] pwm: core: Get rid of unused devm_of_pwm_get()
Date:   Sat,  6 Aug 2022 18:25:16 +0300
Message-Id: <20220806152517.78159-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_of_pwm_get() has recently lost its single user, drop
the dead API as well.

Note, the new code should use either plain pwm_get() or managed
devm_pwm_get() or devm_fwnode_pwm_get() APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 Documentation/driver-api/pwm.rst              |  3 +-
 drivers/pwm/core.c                            | 30 -------------------
 include/linux/pwm.h                           | 10 -------
 4 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index aeb3b2d7cc54..e431f1d746b6 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -410,7 +410,6 @@ POWER
 
 PWM
   devm_pwm_get()
-  devm_of_pwm_get()
   devm_fwnode_pwm_get()
 
 REGULATOR
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index fd26c3d895b6..8c71a2055d27 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -40,8 +40,7 @@ after usage with pwm_free().
 
 New users should use the pwm_get() function and pass to it the consumer
 device or a consumer name. pwm_put() is used to free the PWM device. Managed
-variants of the getter, devm_pwm_get(), devm_of_pwm_get(),
-devm_fwnode_pwm_get(), also exist.
+variants of the getter, devm_pwm_get() and devm_fwnode_pwm_get(), also exist.
 
 After being requested, a PWM has to be configured using::
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0e042410f6b9..dc1b7263a0b0 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1070,36 +1070,6 @@ struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL_GPL(devm_pwm_get);
 
-/**
- * devm_of_pwm_get() - resource managed of_pwm_get()
- * @dev: device for PWM consumer
- * @np: device node to get the PWM from
- * @con_id: consumer name
- *
- * This function performs like of_pwm_get() but the acquired PWM device will
- * automatically be released on driver detach.
- *
- * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
- * error code on failure.
- */
-struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
-				   const char *con_id)
-{
-	struct pwm_device *pwm;
-	int ret;
-
-	pwm = of_pwm_get(dev, np, con_id);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	ret = devm_add_action_or_reset(dev, devm_pwm_release, pwm);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return pwm;
-}
-EXPORT_SYMBOL_GPL(devm_of_pwm_get);
-
 /**
  * devm_fwnode_pwm_get() - request a resource managed PWM from firmware node
  * @dev: device for PWM consumer
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 9429930c5566..572ba92e4206 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -408,8 +408,6 @@ struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 void pwm_put(struct pwm_device *pwm);
 
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
-struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
-				   const char *con_id);
 struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
@@ -517,14 +515,6 @@ static inline struct pwm_device *devm_pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct pwm_device *devm_of_pwm_get(struct device *dev,
-						 struct device_node *np,
-						 const char *con_id)
-{
-	might_sleep();
-	return ERR_PTR(-ENODEV);
-}
-
 static inline struct pwm_device *
 devm_fwnode_pwm_get(struct device *dev, struct fwnode_handle *fwnode,
 		    const char *con_id)
-- 
2.35.1

