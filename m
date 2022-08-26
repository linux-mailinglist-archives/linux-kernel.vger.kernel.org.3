Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A725A2D74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbiHZR0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiHZR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:26:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F53BD7D0F;
        Fri, 26 Aug 2022 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534794; x=1693070794;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sLtaszE6J9bc7D3KksegYwK6vp8ezQTipr7nUkbgLqI=;
  b=YTcRxvFVoeHmhu8KT0MTg9HF/yShpxUozRip5ga5eQNclsDeMtqj8rb6
   6iBBgydCS2ul7zsQ3Oav4sYpgpbgK7UqZTyK2xPOtir+6xHaxFW7EEknn
   vHOI/5jZ7AX13533flwv6tu0mjlBakNqLzqVF9yu+FSZC0IdnJk0VJ8XD
   vGr/t8w4L+rXv7JgVhCtfIa59dbnLsDLNL/3YUs2p5z40u1T1dd6iETjK
   M560dgar9XKXsrPucv+oCTUw0XEbE8L/GP6cc9qsM9Vg688MCFI7hhVSs
   Z8DHI7542yi4Ouc0Y4qwg3gkR9qQRJUhjyWfcvpr5SNWaS9IVsjVGtlLr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="380860245"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="380860245"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="786453671"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 26 Aug 2022 10:26:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8801019D; Fri, 26 Aug 2022 20:26:44 +0300 (EEST)
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
Subject: [PATCH v2 1/3] hwmon: (pwm-fan) Replace OF specific call to PWM by plain one
Date:   Fri, 26 Aug 2022 20:26:40 +0300
Message-Id: <20220826172642.16404-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

There is no need to call OF specific devm_of_pwm_get() since
the device node parameter duplicates in the device parameter.
Hence we may safely replace it by plain devm_pwm_get() call.

This allows to drop devm_of_pwm_get() as no more users will be.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2: added tag (Uwe), left only one-liner change (Uwe, Guenter)
 drivers/hwmon/pwm-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 6c08551d8d14..06fd1d75101d 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -302,7 +302,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	mutex_init(&ctx->lock);
 
-	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
+	ctx->pwm = devm_pwm_get(dev, NULL);
 	if (IS_ERR(ctx->pwm))
 		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
 
-- 
2.35.1

