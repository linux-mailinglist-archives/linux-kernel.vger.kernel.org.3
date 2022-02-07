Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830AD4AB930
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352527AbiBGK4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245176AbiBGKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:49:24 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 02:49:21 PST
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A301FC0401C1;
        Mon,  7 Feb 2022 02:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644230961; x=1675766961;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UGOdXzZC/n1cq7HB8SFnKvHfDjwQEONn26NuIhCCEQw=;
  b=Ly33X9Lhb9zEFZNQ7SMZFCD/o/EgNU2n+0Z/0wGNmnocg1w2bepd5DZN
   KutpYY6LZFDiyD3cJS8gjj1wtAdYsihBOOV1oPs9z71knwmT204RXo1vf
   xUBtfqC1rAKpk5GSnLJc9sT+YHy0Vk9TAbQ/gFxqNDGphQoJAMlYi0icj
   jFs/LLED/a0ZrKKOwl2uMNofI6s/Hq8Qs2Svjqj7AGf8Au77sj4q4HkA2
   7vdGBwF9PlmkhkgCSYDi+p3CT63X9trezjFxmkyJwIXh9XhBpe3rMEnlA
   8Sd9p/ELN5QYZCNbJitz1JCWAib5W+o/utBBOOOG6f2O79JXO+tjS09jg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273209904"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273209904"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 02:48:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="621508215"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2022 02:48:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 61E7D509; Mon,  7 Feb 2022 12:48:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/3] iio: temperature: ltc2983: Don't hard code defined constants in messages
Date:   Mon,  7 Feb 2022 12:48:28 +0200
Message-Id: <20220207104830.83882-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
v2: added Rb tag (Nuno)
 drivers/iio/temperature/ltc2983.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 301c3f13fb26..d272c303c1b0 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -409,8 +409,8 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
 	new_custom->size = n_entries * n_size;
 	/* check Steinhart size */
 	if (is_steinhart && new_custom->size != LTC2983_CUSTOM_STEINHART_SIZE) {
-		dev_err(dev, "Steinhart sensors size(%zu) must be 24",
-							new_custom->size);
+		dev_err(dev, "Steinhart sensors size(%zu) must be %d", new_custom->size,
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
+			dev_err(dev, "chan:%d must be from %d to %d\n", sensor.chan,
+				LTC2983_MIN_CHANNELS_NR, LTC2983_MAX_CHANNELS_NR);
 			goto put_child;
 		} else if (channel_avail_mask & BIT(sensor.chan)) {
 			ret = -EINVAL;
-- 
2.34.1

