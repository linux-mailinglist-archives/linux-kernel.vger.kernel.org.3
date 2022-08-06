Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22DE58B86A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 23:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiHFVXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 17:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiHFVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 17:23:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E309AF59A;
        Sat,  6 Aug 2022 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659821007; x=1691357007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v+i54djYfnoUzIKie9dv1CNcKoQgAuSTdid5qaQpsnk=;
  b=CYkH/x1P84Z/K5zyRFNAv8bcvumdKeZ1BOdb8bg7iP6jU0P7pzXobPF3
   hKnwiHS6dAdNgb00FWxA9CSp0aIYv0UHEA0YDjeCWDyX9qfjj3iX+zEch
   kIltOIxH9pE7adgqVh2H33MlDIy3YTUECP0qBYqgCfW/X+ZNxdlacYXGl
   f0pq5E2sklNhOqE4EOiEc2Mq80jvTo7JTVkOXYH6Yrlk4u4nthObbcAod
   groRIITSPR7yJPRtsVeerBGovq7lkaySKij+XXKGqC3//HD/fcuufC+Jb
   IzIlD+Oqg9QbsU6gJnvZZwedbKJFLr/l++HzISNCK6TI+jLe0an6DlPV3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="352116771"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="352116771"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 14:23:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="746212463"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2022 14:23:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4C2E91D0; Sun,  7 Aug 2022 00:23:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 3/4] pwm: sysfs: Replace sprintf() with sysfs_emit()
Date:   Sun,  7 Aug 2022 00:23:30 +0300
Message-Id: <20220806212331.40086-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
References: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
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

