Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C05AE330
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbiIFIlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiIFIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:40:54 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D2F7A532;
        Tue,  6 Sep 2022 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453466; x=1693989466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RTIQugJMBx86KeCOkkBfTbxPV094MtRi64y0zr8uTrg=;
  b=KKhzi/w/YXLB+mMgfH+dCVyenK/tx7WKLgG1UJIyObpw7l0wQXYdV+cp
   BVAGHWqVjsTnTp7+1BK3h0X0xgMDtXB3CxNgxaGxtdU1ssUqoce9ArapN
   mQTOBv90ivhgJE6S3ZMSeCXis2M1vOdl8xzY6QZQCl4AdVMpPJ/68OZoh
   E=;
X-IronPort-AV: E=Sophos;i="5.93,293,1654560000"; 
   d="scan'208";a="127144277"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com (Postfix) with ESMTPS id 940D7C0FF0;
        Tue,  6 Sep 2022 08:34:36 +0000 (UTC)
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:33:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 6 Sep 2022 08:33:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:33:59 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id C9A8E4D77; Tue,  6 Sep 2022 08:33:56 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 05/21] hwmon: (mr75203) fix voltage equation for negative source input
Date:   Tue, 6 Sep 2022 08:33:40 +0000
Message-ID: <20220906083356.21067-6-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
is used it results in -1 (0xf...fffff).

This change fixes the sign problem and supports negative values by
casting n to long and replacing the shift right with div operation.

Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for Moortec MR75203 PVT controller")
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3:
- Remove unrelated change (add of empty line).

V3 -> V2:
- Fix equation to support negative values instead of limiting value to
  zero.

 drivers/hwmon/mr75203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index a209f5d95f4b..78dc471e843c 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -202,7 +202,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 
 		n &= SAMPLE_DATA_MSK;
 		/* Convert the N bitstream count into voltage */
-		*val = (PVT_N_CONST * n - PVT_R_CONST) >> PVT_CONV_BITS;
+		*val = (PVT_N_CONST * (long)n - PVT_R_CONST) / (1 << PVT_CONV_BITS);
 
 		return 0;
 	default:
-- 
2.37.1

