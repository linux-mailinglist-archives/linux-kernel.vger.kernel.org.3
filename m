Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC1F4A834B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350309AbiBCLo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:44:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:37570 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238784AbiBCLo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643888696; x=1675424696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0u4IZOCPkZSCR3DLIUohpU7wSQ0fzlGvq16ecAMy2gI=;
  b=SSxybUKsbR06ZDzViAD2sAYQZbCQuA3MEfE3LCNBX0e8dHGOTa0H4rmd
   G6mWIreWEyfyJGaOOZPyorGcUGRSy6iaM4+WhaUFmynxDxk9Qydumm6v9
   yz9Qp9aH7CKSNJWAblLFMP02hiQ4tMiJRL67IABG1345NyjwIM1GPT0yO
   r8ekBsaQ2/3IAGrnGxPRctnVe9+be6e5bnUyO7NssSKKzihOzfj3o8lI2
   q4K4zYOKFNN6du44Y0zI3vjMJ6qrde8tEHJimFaa7pdn3gJRt3enbuKRe
   HEguvKmToLRy0zOvk1Fw5BjK6vBigvWapvjiMMIceA9mGyol/ehp0v3kt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248079269"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="248079269"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 03:44:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="538711865"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Feb 2022 03:44:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E3AA630A; Thu,  3 Feb 2022 13:45:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/2] iio: temperature: ltc2983: Don't hard code defined constants in messages
Date:   Thu,  3 Feb 2022 13:45:05 +0200
Message-Id: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of messages the constants, which have their definitions,
are hard coded into the message text. Unhardcode them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

