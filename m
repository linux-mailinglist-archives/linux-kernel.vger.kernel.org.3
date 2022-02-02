Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE94A76EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346298AbiBBRho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:37:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:23197 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbiBBRhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643823461; x=1675359461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1c796pRA108XkXxWTPpcbBnyJc0I512SUo76lYWtBpQ=;
  b=PznBJZrKVed0p5gUlCyfSyPj/SpvaALvbvHfvwaIbgL9fiPp4g8Mwbi9
   z4V/0uusKjtQ3YDFy2i3ceQUh+mAr2pvJp/mf2ED6dlnvmARdVk173fwD
   PZ5/IEO9CdDPujZVmxgwvjHFHUtC7rp9kWxFymPBcgbrQO8ftQ4WiDcJz
   9Oa2Fa2VsGE0Y6IvvnZy+0xTw5Ks04P4mneYKnYObX8Ro/7QcJQ0qnmEI
   WniZNfoFH+lQ8Tjgugrm6c8EQJjKE0CDstMSW7ogrgS9e5pystn1WUSR8
   l6p2YDVHAIYJnsV+z6DM79GGHy/2yOXEgQyONLSLUgL3TF6Z2jpVsOums
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247934279"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="247934279"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 09:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="698976511"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2022 09:37:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 333DE3B7; Wed,  2 Feb 2022 19:37:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Puranjay Mohan <puranjay12@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 1/1] iio: accel: adxl355: Replace custom definitions with generic from units.h
Date:   Wed,  2 Feb 2022 19:37:23 +0200
Message-Id: <20220202173723.8678-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The units.h provides MEGA and TERA. Replace custom ones.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/adxl355_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 4f485909f459..7023de888835 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -20,6 +20,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
+
 #include <asm/unaligned.h>
 
 #include "adxl355.h"
@@ -60,9 +62,6 @@
 #define ADXL355_PARTID_VAL		0xED
 #define ADXL355_RESET_CODE		0x52
 
-#define MEGA 1000000UL
-#define TERA 1000000000000ULL
-
 static const struct regmap_range adxl355_read_reg_range[] = {
 	regmap_reg_range(ADXL355_DEVID_AD_REG, ADXL355_FIFO_DATA_REG),
 	regmap_reg_range(ADXL355_OFFSET_X_H_REG, ADXL355_SELF_TEST_REG),
-- 
2.34.1

