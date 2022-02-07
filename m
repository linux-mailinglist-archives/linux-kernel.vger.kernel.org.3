Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418864ACAE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiBGVHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiBGVHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:07:19 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699EDC06173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644268038; x=1675804038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVzjpmb1FPWd8E0mBxS5FG2y9Wc8vCGk9FdXkUwJPC8=;
  b=P0ul/baXnYDoknzKbUwpNl5U4q17/uHklv5j4o6CfRoldBcU8piaNutc
   oEHTxZnz5PdVVAhsyE9jNJeSXTRimibhDo/wdjDDrNk/QdlQPQ/yygjBb
   2+Zjapa00yYY7jl6w1MesyKLsYoPX8MEfbLgY+NvfDpGJrNMFUpZWgCpu
   8pbJ9oPRkaxWc5yjrGTBAoTCAUmsrE9Lp0EbokrvZJySLH/0VLXg8uFES
   o5XWlH2FX+Ldi6lZYVGBb7wQdB4VtiR2R+SOn8eGJ0D9Jw943m9YLcugL
   z8sKW+PqHT/L2HmhmJq2qZdAVfnwVbghgHw3E2sRsgR1GnW8xwAyjlB+R
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="309554349"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="309554349"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 13:07:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="628661958"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2022 13:07:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 602B150D; Mon,  7 Feb 2022 23:07:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 net-next 4/6] ptp_pch: Switch to use module_pci_driver() macro
Date:   Mon,  7 Feb 2022 23:07:28 +0200
Message-Id: <20220207210730.75252-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207210730.75252-1-andriy.shevchenko@linux.intel.com>
References: <20220207210730.75252-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate some boilerplate code by using module_pci_driver() instead of
init/exit, and, if needed, moving the salient bits from init into probe.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/ptp/ptp_pch.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ptp_pch.c
index 2eef90147dfe..703dbf237382 100644
--- a/drivers/ptp/ptp_pch.c
+++ b/drivers/ptp/ptp_pch.c
@@ -10,7 +10,6 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -603,24 +602,7 @@ static struct pci_driver pch_driver = {
 	.remove = pch_remove,
 	.driver.pm = &pch_pm_ops,
 };
-
-static void __exit ptp_pch_exit(void)
-{
-	pci_unregister_driver(&pch_driver);
-}
-
-static s32 __init ptp_pch_init(void)
-{
-	s32 ret;
-
-	/* register the driver with the pci core */
-	ret = pci_register_driver(&pch_driver);
-
-	return ret;
-}
-
-module_init(ptp_pch_init);
-module_exit(ptp_pch_exit);
+module_pci_driver(pch_driver);
 
 module_param_string(station,
 		    pch_param.station, sizeof(pch_param.station), 0444);
-- 
2.34.1

