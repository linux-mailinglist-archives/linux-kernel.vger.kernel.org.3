Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4358B86B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 23:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiHFVXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 17:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiHFVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 17:23:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F683F58C;
        Sat,  6 Aug 2022 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659821006; x=1691357006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y6RbBLDtDHHiMcqJ3KvDVm+exxMIOLcEhhJLr3Mcmm4=;
  b=VtJ4CpKD5b/mAC7RQzhS7oZ9WaEFrwvvJcubmZkbJIui1nWTDy8EsRJ3
   WRsAhsIfbKTn9rgNzg8Zv/O1R/yISpvu9ln1J5iABHvl4zl+ZJOQQg5qV
   k9/x7Dy6aDbS/FZYSb1JXtqphsQyzeGIEav3aM1sfVbyRq3M5ovqB91LX
   C5hGw0AP29dOyruCDhzUdAxLexaIKdmwiDDp8JWiQZlsFwC7k2xifrOcQ
   HZ3ngZigN7Hr5rZLUUuRtCtMekHVOxDDxNQICkfoRy+JraZbG7V92A4F0
   j6vQcohE6BEFLvB+7g66i5Rz8vLOHLmW8NP6J1Y8cTxm9doqDKoCkEz4G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="273440385"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273440385"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 14:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="730332995"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2022 14:23:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 948AAF7; Sun,  7 Aug 2022 00:23:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 1/4] pwm: sysfs: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Sun,  7 Aug 2022 00:23:28 +0300
Message-Id: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using these newer macros allows the compiler to remove the unused
structure and functions when !CONFIG_PM_SLEEP + removes the need to
mark pm functions __maybe_unused.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

