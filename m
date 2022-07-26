Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B685812C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiGZMGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiGZMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:05:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F72AE08;
        Tue, 26 Jul 2022 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658837155; x=1690373155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dErGB4TIKDepZJW1i+iaXrBp16cjYh5ghvqazNtEIuM=;
  b=ThAJQc1V671PPDzSSd7RTI/Yn1RpvpD8KhFii4/YurGBOegskw9rOsn2
   3ISK3nWueUqkBnu5GZ8NwfH3QumyB0FBay9voa0O0iwIxW4TKnLjVtiT/
   3XvhDhboH0OSsUaO5egpJ0f/AdNTMaoD0X99Cb50a3zgzop2Xja/+CdMI
   LV+wHdemf4qwZRK/4tACeESPwSB2R/YoDUgDv5b7dzdS3WFnhyv5p6SWL
   uV1urYE88HmyvBVHhu/L903Esh0wznT98YJCV8xm9B7XlUFu8nXUzZsn+
   Qlcj4heICAXyloCTOgSlUYt5I4hRsQXf7OgHwatizSaRxmilfI1b+Z8n0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="274804291"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="274804291"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="667879823"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2022 05:05:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6BCAC1D0; Tue, 26 Jul 2022 15:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 4/8] media: ov2740: Remove duplicate check for NULL fwnode
Date:   Tue, 26 Jul 2022 15:05:52 +0300
Message-Id: <20220726120556.2881-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwnode API does proper checks and returns correct codes, no need
to repeat it in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ov2740.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index 9420258c6073..07fe8fda274e 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -1009,9 +1009,6 @@ static int ov2740_check_hwcfg(struct device *dev)
 	int ret;
 	unsigned int i, j;
 
-	if (!fwnode)
-		return -ENXIO;
-
 	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
 	if (ret)
 		return ret;
-- 
2.35.1

