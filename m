Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030645398E2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344206AbiEaVjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbiEaVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:39:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C173553;
        Tue, 31 May 2022 14:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654033166; x=1685569166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3LGc6UbOk46vOqseuqFkVY/oNvVjxu8CVHv7UXo3n8=;
  b=WhYWn8FklYhVLU/W2xrPIo6q7rP8kB041IRJAuxCUKPeCTCClBY3J6sB
   VdMInFByGhqGX/pYaOvyW+9H1ITxwGB6PoiXYvNMb/o28ybVsxlw+ySJq
   oXjXs44IGkkI2C3nrAvRAONA63/6GTq0p70wUwBDfu09vtS/J3CzjOPHt
   74mbGXCmlr2G6EBxFJ8i8G1YEB3qrDBAUBDg0ByrHFdes/td7OhPyOPJF
   xbkvUmw/CSwcUvc/3JGai0wE0t+fftEZHAyC4FP3AJT8pBez1vdIJZmkJ
   FGWSU9zLmoxqkGK3w8qrCpqPB9UP0393cFSyONFFYKeQFuy7iByW5NoLS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="272962029"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="272962029"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 14:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="633237026"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 31 May 2022 14:39:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7F2CD2; Wed,  1 Jun 2022 00:39:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] iio: adc: nau7802: Make use of device properties
Date:   Wed,  1 Jun 2022 00:39:22 +0300
Message-Id: <20220531213922.72992-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531213922.72992-1-andriy.shevchenko@linux.intel.com>
References: <20220531213922.72992-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Add mod_devicetable.h include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/nau7802.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 2d71cdbcd82f..c1261ecd400c 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -8,10 +8,11 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/wait.h>
 #include <linux/log2.h>
-#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -411,7 +412,6 @@ static int nau7802_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct nau7802_state *st;
-	struct device_node *np = client->dev.of_node;
 	int i, ret;
 	u8 data;
 	u32 tmp = 0;
@@ -451,7 +451,7 @@ static int nau7802_probe(struct i2c_client *client)
 	if (!(ret & NAU7802_PUCTRL_PUR_BIT))
 		return ret;
 
-	of_property_read_u32(np, "nuvoton,vldo", &tmp);
+	device_property_read_u32(&client->dev, "nuvoton,vldo", &tmp);
 	st->vref_mv = tmp;
 
 	data = NAU7802_PUCTRL_PUD_BIT | NAU7802_PUCTRL_PUA_BIT |
-- 
2.35.1

