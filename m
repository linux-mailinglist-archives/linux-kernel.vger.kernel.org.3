Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C875A2D15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiHZRHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiHZRHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:07:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B6BCD50C;
        Fri, 26 Aug 2022 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661533627; x=1693069627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ilscLTpKs/IqV0qkRKvz7LoihcjNqeU+V/R/IHV5unc=;
  b=HhKLE6/smRztAFKxUOckzckgrCFUl/5SGQ5hwKr5hHR1buaf+MDVOuP/
   g3p5ZhTTKlnHPhegteTtliABB/asKjphFrq71OKUz8mld5jZZ+EJy83G/
   tCm5ZO69R55myaNpVSQ/lEHGWsNF0KBvR8Q6RxPwTH0PXEpjbVplgE8Gs
   rZJNNRbwXwYrsrlvSVRJMcpXPmTyOOX+CudC2eSAKkwkpG1/U/Fwuh6h5
   5H9NaoeCpHI5oi40BWEGqEcl6BuG4973TDgqYV1auCHIqVUWw8FPHexML
   eIibN7vILHjzXnb6dp8C4rnXWE3753U+OuIlrFdW4+7VHezivTPGN9KwX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="274304602"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="274304602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="938821066"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 10:07:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EA3E719D; Fri, 26 Aug 2022 20:07:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 1/4] pwm: sysfs: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Fri, 26 Aug 2022 20:07:13 +0300
Message-Id: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using these newer macros allows the compiler to remove the unused
structure and functions when !CONFIG_PM_SLEEP + removes the need to
mark pm functions __maybe_unused.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2: added tag (Uwe)
 drivers/pwm/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9903c3a7eced..c21b6046067b 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -433,7 +433,7 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 	return ret;
 }
 
-static int __maybe_unused pwm_class_suspend(struct device *parent)
+static int pwm_class_suspend(struct device *parent)
 {
 	struct pwm_chip *chip = dev_get_drvdata(parent);
 	unsigned int i;
@@ -464,20 +464,20 @@ static int __maybe_unused pwm_class_suspend(struct device *parent)
 	return ret;
 }
 
-static int __maybe_unused pwm_class_resume(struct device *parent)
+static int pwm_class_resume(struct device *parent)
 {
 	struct pwm_chip *chip = dev_get_drvdata(parent);
 
 	return pwm_class_resume_npwm(parent, chip->npwm);
 }
 
-static SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_resume);
 
 static struct class pwm_class = {
 	.name = "pwm",
 	.owner = THIS_MODULE,
 	.dev_groups = pwm_chip_groups,
-	.pm = &pwm_class_pm_ops,
+	.pm = pm_sleep_ptr(&pwm_class_pm_ops),
 };
 
 static int pwmchip_sysfs_match(struct device *parent, const void *data)
-- 
2.35.1

