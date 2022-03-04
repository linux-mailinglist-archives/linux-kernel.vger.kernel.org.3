Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958864CDBAD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbiCDSDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbiCDSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:03:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB8C2E;
        Fri,  4 Mar 2022 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646416964; x=1677952964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fk0NmpMavnWYkydBGsrkM2BDEq+2Txts8Ye4yYDMtrI=;
  b=gLFqlD+4WYIVv6JybElhjaruRrtyWkxjmlo3d715W3OGg9zdEp4QusAz
   NfQVISeMMViXeGEPkSIEZKdxVwNoOygvgEi58SPwXnDJGfa3+yyF0I/XS
   1rx4hqBLzK9N7IQA+Pe8U7mypG8qUfUPp7CC3RcxlgpUTkkSJmeVdNo15
   uC2kWyDiguYO9BQssNA+C19UZKKLFYP4eo3RdkpD1E/I9FtPWq5j1Yeq6
   dr4BXcFXlNN4Zp/IPJgl+/HwZmkFGg1M4IM03htSmeMgSOTTRIB6LDq0g
   e2B795XFk1h5cm8xijFiocifVCTtVDmyc89cr4qNcxzicOjb5SB4zZ+z5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278720925"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="278720925"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 10:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="686945213"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2022 10:02:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4C937A7; Fri,  4 Mar 2022 20:03:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 1/3] iio: temperature: ltc2983: Don't hard code defined constants in messages
Date:   Fri,  4 Mar 2022 20:02:55 +0200
Message-Id: <20220304180257.80298-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

