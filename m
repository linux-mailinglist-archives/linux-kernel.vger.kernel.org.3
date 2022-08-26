Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC175A2D75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbiHZR0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240638AbiHZR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:26:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4485D7D11;
        Fri, 26 Aug 2022 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534794; x=1693070794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cT/5nIKXxykBJq500OJtCkmmFNx0IZv//sufeJTfcOw=;
  b=DOzWVCekvZKNcQQ9y5abgL0dYI0EYkuWDrE7ldCOeE/w8+9eK5smm33Y
   jn/zKMJqDv/PiH7Gnj9VWG/gO2Gvc5VXcHfN76ZS4wqMYP2/vC4VmZxok
   eSy/wUqATyPQ3xY+p0gsswHKGQzxGe2tL4Z6RdQevly0JDkmbJtL0rs5t
   m9Aqegwb8n5lEYXYf5JKb0Q4a3Y7hdULY15lYmmsuL7a4jnzkmr6z/QpB
   zRYXtWGKze3mjLiGeRxKWj3kpCxJ4KxjPXtDBguGxqwfkYSCFDhmrE0dz
   VGUH1ERiBdRwo0wXa4AKyd+qdJKg5g68yPR2AimB4dy6wMKmsd51MJEkk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="320661902"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="320661902"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="643738800"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Aug 2022 10:26:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F0071C3; Fri, 26 Aug 2022 20:26:45 +0300 (EEST)
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
Subject: [PATCH v2 2/3] pwm: core: Get rid of unused devm_of_pwm_get()
Date:   Fri, 26 Aug 2022 20:26:41 +0300
Message-Id: <20220826172642.16404-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826172642.16404-1-andriy.shevchenko@linux.intel.com>
References: <20220826172642.16404-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2: added tag (Uwe)
 .../driver-api/driver-model/devres.rst        |  1 -
 Documentation/driver-api/pwm.rst              |  3 +-
 drivers/pwm/core.c                            | 30 -------------------
 include/linux/pwm.h                           | 10 -------
 4 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index eb01a2f0ab80..57f0620d4c8e 100644
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

