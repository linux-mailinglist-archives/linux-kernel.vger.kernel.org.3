Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F474B0F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbiBJNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:55:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiBJNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:55:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196EBBB5;
        Thu, 10 Feb 2022 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644501310; x=1676037310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wubRhfgyfc41wjVMWexQ/+k7dIFqa/nCB9F7aZN9v/Y=;
  b=EekYeh8wqG5EhFD2HoJYgUiG2glaMjW+qgBFthvDfs0nrRc10PJyMxc8
   zqId+UrmTXFW6y38XjdAoWIWt6p7poOs9d0vdiQ1NZn4kPdhCSdwDqfMX
   Z9u/avoCPt2PQmOeaJa49ZvfSFIDKURmlq4AxzMmYssGhL9msU54cxK9i
   DGihsZ3S0JyYiSicPh5K1VPBKCmVL4emi0w0qC5pkI0liwgZnC1yq0Cxd
   QOn3X9gYtt5+/2RRwT+rLPiEPWiDxGq+OoyJ5bOLpmAGGxatm2ELc3z2V
   I/MkXnRScydUy3XNI7I6gzoC0kc6UbTwEHtv8kTnhUpVhE6VjSBc6DbCz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="247077619"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="247077619"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="629691138"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2022 05:55:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1E95F366; Thu, 10 Feb 2022 15:55:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 1/3] iio: temperature: ltc2983: Don't hard code defined constants in messages
Date:   Thu, 10 Feb 2022 15:55:20 +0200
Message-Id: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

