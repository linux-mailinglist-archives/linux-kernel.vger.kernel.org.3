Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0075558B675
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiHFPZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiHFPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:25:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6673DBE26;
        Sat,  6 Aug 2022 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659799524; x=1691335524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kbBuaKEL5Eapwb44NRKZmmeZ/n+9y6E91HvPfKTfkzw=;
  b=Gj46FZRn4tkjhZcXS53ejOf7BWZyBajO5x4O4aiTR9MxjDidwlSxHNrU
   Ek7qI8ujvqbhvIN0jmI2hu2CeGoxnyU7S+XUrcIm1ptiKlzfyXCMbZ4Ef
   GtnRMhVDAE0J+QXlJR3zLbueyp57LaRJkmuog2yM3euFCLzgyl2RNB234
   uNZiVMqxNYO4FxGPEmRnuQ+GFTSWd96plXVtLL/ci3hha0RswxzfEKvjw
   SDQbjp0uOpxRKLXyVExps1HpU5HqPQCj1CHNgHYBfsvSNPH/pBdFitn6y
   cjl/LO6UYqhurrJAsGcpmpKn6IDKnCL1bQ56Ti6Qj0IzDUZ633YV4n612
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="289131958"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289131958"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 08:25:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="607432285"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Aug 2022 08:25:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E4ED317E7; Sat,  6 Aug 2022 18:25:32 +0300 (EEST)
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
Subject: [PATCH v1 3/3] pwm: core: Make of_pwm_get() static
Date:   Sat,  6 Aug 2022 18:25:17 +0300
Message-Id: <20220806152517.78159-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
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

There are no users outside of PWM core of the of_pwm_get().
Make it static.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

