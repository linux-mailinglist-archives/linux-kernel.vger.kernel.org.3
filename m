Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329834BF92B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiBVNXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiBVNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:23:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A43917B;
        Tue, 22 Feb 2022 05:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645536203; x=1677072203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Klv6Ezg/JwUk3iPBnhg0wneuAyQoZW+/CZIapYQ3LO0=;
  b=e1YoU3smcsuoQPxm+h50PTZD5sDH6p/r0drH1ni56C+D7jCUJpqoOJNS
   xHjwfYEZBdjZnS44aed5ECdY01fJ1WbquMYNofq11RccGdQ6iaxYzxhrv
   7Y9AaI8+FfIt2U8exL3Ua4I7elhaDqdDbPkcTy7+2M6lzl+c3fQb45Zvh
   ztDMkwaQ/Q11QwAhKK+PafAVdZWUyMgXm6i4DBKtwqOrYg7QjwYYvn4H2
   Z2FfNm03EatdJcYsRwhzEjMq0wHTKe53T3xkBvf9qlkv+CCJ6uCjTdxws
   DC8EmdkQD61ivgpyZV9gtoUrF6tYgsV3C8bbdoaT1eN38vL7E23SGH+3d
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="235220015"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="235220015"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 05:23:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="706608456"
Received: from muni.iind.intel.com ([10.190.201.115])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 05:23:20 -0800
From:   Vikash Chandola <vikash.chandola@linux.intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, iwona.winiarska@intel.com
Cc:     Vikash Chandola <vikash.chandola@linux.intel.com>
Subject: [PATCH v2] hwmon: (pmbus) Clear pmbus fault/warning bits after read
Date:   Tue, 22 Feb 2022 13:12:53 +0000
Message-Id: <20220222131253.2426834-1-vikash.chandola@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all fault/warning bits in pmbus status registers remain set even
after fault/warning condition are removed. As per pmbus specification
these faults must be cleared by user.
Modify hwmon behavior to clear fault/warning bit after fetching data if
fault/warning bit was set. This allows to get fresh data in next read.

Signed-off-by: Vikash Chandola <vikash.chandola@linux.intel.com>
---
changes since v1:
v1 patch was clearing all the faults. That would have lead faults not
getting reported to user at all. This change clears only current fault
and that too after reporting it at least once. This way all the faults
will be reported to user space at least once.

Behaviour has been verified with following PSU
FRU Device Description : IS162F22 (ID 84)
Product Manufacturer   : SOLUM CO., LTD.
Product Name           : IS162F22
Product Part Number    : G36234-015
Product Version        : 10A

 drivers/hwmon/pmbus/pmbus_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 776ee2237be2..ac2fbee1ba9c 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -911,6 +911,11 @@ static int pmbus_get_boolean(struct i2c_client *client, struct pmbus_boolean *b,
 		pmbus_update_sensor_data(client, s2);
 
 	regval = status & mask;
+	if (regval) {
+		ret = pmbus_write_byte_data(client, page, reg, regval);
+		if (ret)
+			goto unlock;
+	}
 	if (s1 && s2) {
 		s64 v1, v2;
 
-- 
2.25.1

