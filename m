Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AC4D0865
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbiCGUgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiCGUgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:36:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6271EEF;
        Mon,  7 Mar 2022 12:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646685355; x=1678221355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jgn7At9j/g4s7AIZSwQ30iCsOpAQAMzRYDwyFBnM964=;
  b=PMi5reAkAeICAoCFvPnQLgMwJPkBgExIAZIODvN5Qr2G6coacSnZrt2r
   quIfNfCNwbn0g/2eJ2s07Kg2cW1KjK6tR9l1lDXrqgOmqwmQ5sXdF1SUO
   29j9gocz80fc8SQBzk3t6fmjMEwqwsbulcjtPET8pTvmZgXOByfKZXiU9
   wW28sUGYhz8vVZQfdStqunucrBo9IKTJNvE8yNFIJrBCqX+rJcOA/IQBr
   s/U42fxgB3SXlkrL3dA5MYJ2adDEgk9OQgp8RhiK9YwBH8tsX1DU9v9h/
   zvdJWn31RHXXBToLE3+fTBRmNjqaSXutrJndtp0AkuzmGLW6MYF7kGmD3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="253328838"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="253328838"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:35:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="643390308"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 12:35:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC8DD1D6; Mon,  7 Mar 2022 22:36:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v5 1/3] iio: temperature: ltc2983: Don't hard code defined constants in messages
Date:   Mon,  7 Mar 2022 22:36:04 +0200
Message-Id: <20220307203606.87258-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of messages the constants, which have their definitions,
are hard coded into the message text. Unhardcode them.

While at it, add a trailing \n where it's currently missing.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
v5: no changes
v4: no changes
v3: added \n, used %u (Joe)
 drivers/iio/temperature/ltc2983.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 301c3f13fb26..94d6dd4db47a 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -409,8 +409,8 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
 	new_custom->size = n_entries * n_size;
 	/* check Steinhart size */
 	if (is_steinhart && new_custom->size != LTC2983_CUSTOM_STEINHART_SIZE) {
-		dev_err(dev, "Steinhart sensors size(%zu) must be 24",
-							new_custom->size);
+		dev_err(dev, "Steinhart sensors size(%zu) must be %u\n", new_custom->size,
+			LTC2983_CUSTOM_STEINHART_SIZE);
 		return ERR_PTR(-EINVAL);
 	}
 	/* Check space on the table. */
@@ -1299,8 +1299,8 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
 		    sensor.chan > LTC2983_MAX_CHANNELS_NR) {
 			ret = -EINVAL;
-			dev_err(dev,
-				"chan:%d must be from 1 to 20\n", sensor.chan);
+			dev_err(dev, "chan:%d must be from %u to %u\n", sensor.chan,
+				LTC2983_MIN_CHANNELS_NR, LTC2983_MAX_CHANNELS_NR);
 			goto put_child;
 		} else if (channel_avail_mask & BIT(sensor.chan)) {
 			ret = -EINVAL;
-- 
2.34.1

