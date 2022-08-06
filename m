Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D6E58B86C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 23:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiHFVXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 17:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiHFVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 17:23:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA7F593;
        Sat,  6 Aug 2022 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659821007; x=1691357007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B9uL+ecQZ0NAOtCcVBdGiNsDhlGKvi4c2/vcVVL4eBU=;
  b=IXeUEGn9lD+N93qv5GNEq3TlSg8huf4PMJ/fj9KkBPLhDyTZlSB8Ny8z
   4dC2B37GOZ49l80mmpOyS893RtPERVVh7KC8BU1iMW7bNSmugoCfk8ZLr
   adyB1FLFe+/HDC/7QsCwnQWU+TTH5gFGM+hLv3eJbnGW3r8sZOTbBk9V7
   Z8oN3v65XNCqoGFQHyHuXG3TO8HGZD27f8nZxR6C1E4Kn3qxthVrqgdN2
   KPyoDdiVadFHoIZObxR2vOzgxP/xL0yaSAvCXup/cqpUZMvIgyZEAW/Uf
   JKKLEqmJ0PDjzsLmv74Sa/xgMXr1Pk2zI3qmfSSiK00CSmyrqpAomVPfW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="270166039"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="270166039"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 14:23:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636859733"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2022 14:23:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8E0ED1AA; Sun,  7 Aug 2022 00:23:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 2/4] pwm: sysfs: Return directly from the for-loop in PM callbacks
Date:   Sun,  7 Aug 2022 00:23:29 +0300
Message-Id: <20220806212331.40086-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
References: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to assign ret to 0 and then break the loop just
for returning the error to the caller. Instead, return directly
from the for-loop, and 0 otherwise.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index c21b6046067b..1543fe07765b 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -413,7 +413,7 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 {
 	struct pwm_chip *chip = dev_get_drvdata(parent);
 	unsigned int i;
-	int ret = 0;
+	int ret;
 
 	for (i = 0; i < npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
@@ -427,17 +427,17 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 		state.enabled = export->suspend.enabled;
 		ret = pwm_class_apply_state(export, pwm, &state);
 		if (ret < 0)
-			break;
+			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int pwm_class_suspend(struct device *parent)
 {
 	struct pwm_chip *chip = dev_get_drvdata(parent);
 	unsigned int i;
-	int ret = 0;
+	int ret;
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
@@ -457,11 +457,11 @@ static int pwm_class_suspend(struct device *parent)
 			 * this suspend function.
 			 */
 			pwm_class_resume_npwm(parent, i);
-			break;
+			return ret;
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static int pwm_class_resume(struct device *parent)
-- 
2.35.1

