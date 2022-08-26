Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D4B5A2D19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344649AbiHZRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243995AbiHZRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:07:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E6CCD73;
        Fri, 26 Aug 2022 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661533632; x=1693069632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wHbno+9bH5FlaHl2aCUA9a9noFNnMz8wJkNpCpcnCGc=;
  b=acxhi9j/FcgeWG+zUF+dUQtki3isCOWyEyQNIFRRwWPrt7a7ijDamkSt
   Bo0rMhJKha1F2yguYrU48yu6RgUptsZ49+727OlmtjmhJgtlnW0b0bfMF
   07Nrw0qi0CsNiNM1OUHndZlrA7jFHYMxs56fqKILMGUTWAnmSvTYlRzlQ
   I4CJbMGoY9ytgwm/9YkbwPeebGZpNRJ2+SdxmHDQRhH2h+FnbWgRQLC+A
   0pD8Ek+7Z6rdZujizi2MWKaokZuqRWDxB/rnRipyr8BrtPS5Jc2+MgycX
   NJ8dUtDpGalnovMvtPmwM1OixtWiiWiBCm/Rwvnugz96WPadckjRzwbdg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295825585"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295825585"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="640131972"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2022 10:07:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5D85E1C3; Fri, 26 Aug 2022 20:07:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 2/4] pwm: sysfs: Return directly from the for-loop in PM callbacks
Date:   Fri, 26 Aug 2022 20:07:14 +0300
Message-Id: <20220826170716.6886-2-andriy.shevchenko@linux.intel.com>
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

There is no need to assign ret to 0 and then break the loop just
for returning the error to the caller. Instead, return directly
from the for-loop, and 0 otherwise.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2: added tag (Uwe)
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

