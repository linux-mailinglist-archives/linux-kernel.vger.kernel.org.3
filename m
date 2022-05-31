Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0106D5392F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbiEaOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345005AbiEaOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:11:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7719265422;
        Tue, 31 May 2022 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654006282; x=1685542282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2Sm7KR4WlYANKzzxvSs11cMHFq39jJccsP/ycyK3bY=;
  b=oHemOSvPp4APn+z/NUfMWYfS4mreiS17DozPYsGCaryUHbXA5Am3NyD6
   4LQs5MNu1ggXWFPmRPmA65GhfI+oz71UZySQeFKBnJv9WHxJ4IcecWUD9
   MOyYzA4ZfKHw/61y1l/Fe1grNEVGkm3f2ddKHxzznG1yhAtsPEua+UMpM
   C5EWr64Q+f/b/26OuEDk9VnqxwMV8T7DT+jdYYOw/156wpl3RhqaE7+qe
   wwzHezQOSFvmoHKjrU/ScSDu6CFuMM1bURYfjZ6XdQ74giA6EdvlKI7L4
   uyy8q4FPgsj4qr9+Iu3XEZ23rNJpk2zh0J0X/qscJnLIOA2qgarzjvefy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="272831554"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="272831554"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 07:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="562335391"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 31 May 2022 07:11:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C9E2165; Tue, 31 May 2022 17:11:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] iio: adc: xilinx-xadc: Drop duplicate NULL check in xadc_parse_dt()
Date:   Tue, 31 May 2022 17:11:18 +0300
Message-Id: <20220531141118.64540-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
References: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fwnode_for_each_child_node() is NULL-aware, no need to check
its parameters outside. Drop duplicate NULL check in xadc_parse_dt().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 38 ++++++++++++++----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e883f95f0cda..1b247722ba25 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1247,30 +1247,28 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 	chan = &channels[9];
 
 	chan_node = device_get_named_child_node(dev, "xlnx,channels");
-	if (chan_node) {
-		fwnode_for_each_child_node(chan_node, child) {
-			if (num_channels >= max_channels) {
-				fwnode_handle_put(child);
-				break;
-			}
+	fwnode_for_each_child_node(chan_node, child) {
+		if (num_channels >= max_channels) {
+			fwnode_handle_put(child);
+			break;
+		}
 
-			ret = fwnode_property_read_u32(child, "reg", &reg);
-			if (ret || reg > 16)
-				continue;
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret || reg > 16)
+			continue;
 
-			if (fwnode_property_read_bool(child, "xlnx,bipolar"))
-				chan->scan_type.sign = 's';
+		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
+			chan->scan_type.sign = 's';
 
-			if (reg == 0) {
-				chan->scan_index = 11;
-				chan->address = XADC_REG_VPVN;
-			} else {
-				chan->scan_index = 15 + reg;
-				chan->address = XADC_REG_VAUX(reg - 1);
-			}
-			num_channels++;
-			chan++;
+		if (reg == 0) {
+			chan->scan_index = 11;
+			chan->address = XADC_REG_VPVN;
+		} else {
+			chan->scan_index = 15 + reg;
+			chan->address = XADC_REG_VAUX(reg - 1);
 		}
+		num_channels++;
+		chan++;
 	}
 	fwnode_handle_put(chan_node);
 
-- 
2.35.1

