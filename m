Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2643454ECFE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiFPWA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFPWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:00:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC98C5EDE1;
        Thu, 16 Jun 2022 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655416823; x=1686952823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FTSAuZio06yo2Ofn9Nn8yskW+7vnLgH3CDz569XEMjg=;
  b=byaNgxfX1rek1E32R68T1XWYtoijfw0seMOJfWdlYgcxk1J4VjwJ6PQG
   x78WmWZ8HHeQ31XFzE6fup+8Fm91QXu6wcXGPxSkIo2IYWGEadbnFkLgx
   gDGU+w2cCbn+JUj6FNDXIRhyLn9oH/KNjPjvDHqdJh/GdmjO3TIniejNs
   izOBitnbu9VxYPMai+qaHV4weFUD+nA3Y/I9H3/EF3PYe7LEZTVR0pIuE
   VDQD2JqxKIQEoA5xBHiSQqj1yJBX4US+qyLwzle+dQ7boN/Ooqt7M3nfd
   hsU6zcF5e1+1x/bJdVFy8+VfSrIvLIa4+MS/wqR/1UtZFgA9U/EymcyC5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268049045"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268049045"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="583799914"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2022 15:00:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EF431109; Fri, 17 Jun 2022 01:00:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: dac: stm32-dac: Replace open coded str_enable_disable()
Date:   Fri, 17 Jun 2022 01:00:23 +0300
Message-Id: <20220616220023.9894-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Replace open coded str_enable_disable() in error message in
stm32_dac_set_enable_state().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/dac/stm32-dac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index e842c15c674d..315d66648210 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/string_helpers.h>
 
 #include "stm32-dac-core.h"
 
@@ -79,8 +80,7 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
 	mutex_unlock(&dac->lock);
 	if (ret < 0) {
-		dev_err(&indio_dev->dev, "%s failed\n", en ?
-			"Enable" : "Disable");
+		dev_err(&indio_dev->dev, "%s failed\n", str_enable_disable(en));
 		goto err_put_pm;
 	}
 
-- 
2.35.1

