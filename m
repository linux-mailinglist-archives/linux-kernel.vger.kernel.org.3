Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F895B2254
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiIHPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiIHPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:30:21 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0176350;
        Thu,  8 Sep 2022 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662650972; x=1694186972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dupzsTIu8ztsHP46WQosJM2o1HjY7SxoxCnga0WjaRI=;
  b=hYB7VSgPUrzn3/c/f+SQmESzGFPWJTmgLiUwkXSPNnIWUIs2C9K9czwq
   oAudOcSyCphAogCX4CZ19cG7MXnVTcBePLzwsSzDzSYLnqiEuuBXOa8cI
   TdsryyMI4bvZI++XDD0rnwd3ByHXuUrcFFi+3B+X0xtHqG8IoTwTpDO9V
   c=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="257507790"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:13 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com (Postfix) with ESMTPS id D37831A08F1;
        Thu,  8 Sep 2022 15:25:09 +0000 (UTC)
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:53 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 15:24:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:51 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 7EFBC4D80; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 04/21] hwmon: (mr75203) fix voltage equation for negative source input
Date:   Thu, 8 Sep 2022 15:24:32 +0000
Message-ID: <20220908152449.35457-5-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908152449.35457-1-farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Moortec Embedded Voltage Monitor (MEVM) series 3 data
sheet, the minimum input signal is -100mv and maximum input signal
is +1000mv.

The equation used to convert the digital word to voltage uses mixed
types (*val signed and n unsigned), and on 64 bit machines also has
different size, since sizeof(u32) = 4 and sizeof(long) = 8.

So when measuring a negative input, n will be small enough, such that
PVT_N_CONST * n < PVT_R_CONST, and the result of
(PVT_N_CONST * n - PVT_R_CONST) will overflow to a very big positive
32 bit number. Then when storing the result in *val it will be the same
value just in 64 bit (instead of it representing a negative number which
will what happen when sizeof(long) = 4).

When -1023 <= (PVT_N_CONST * n - PVT_R_CONST) <= -1
dividing the number by 1024 should result of in 0, but because ">> 10"
is used, and the sign bit is used to fill the vacated bit positions, it
results in -1 (0xf...fffff) which is wrong.

This change fixes the sign problem and supports negative values by
casting n to long and replacing the shift right with div operation.

Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for Moortec MR75203 PVT controller")
Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
V5 -> V4:
- Add detailed comment in code explaining the cast and the div instead of right
  shift or use of BIT().

V4 -> V3:
- Remove unrelated change (add of empty line).

V3 -> V2:
- Fix equation to support negative values instead of limiting value to zero.

 drivers/hwmon/mr75203.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 62df0c9498f3..8211d463495d 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -201,8 +201,18 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 			return ret;
 
 		n &= SAMPLE_DATA_MSK;
-		/* Convert the N bitstream count into voltage */
-		*val = (PVT_N_CONST * n - PVT_R_CONST) >> PVT_CONV_BITS;
+		/*
+		 * Convert the N bitstream count into voltage.
+		 * To support negative voltage calculation for 64bit machines
+		 * n must be cast to long, since n and *val differ both in
+		 * signedness and in size.
+		 * Division is used instead of right shift, because for signed
+		 * numbers, the sign bit is used to fill the vacated bit
+		 * positions, and if the number is negative, 1 is used.
+		 * BIT(x) may not be used instead of (1 << x) because it's
+		 * unsigned.
+		 */
+		*val = (PVT_N_CONST * (long)n - PVT_R_CONST) / (1 << PVT_CONV_BITS);
 
 		return 0;
 	default:
-- 
2.37.1

