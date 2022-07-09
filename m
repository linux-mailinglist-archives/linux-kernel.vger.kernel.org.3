Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0956CB9C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiGIV3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIV3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:29:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F1A1EAEB;
        Sat,  9 Jul 2022 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657402194; x=1688938194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JqqCIX6BzWrb0wRSLBHBCbSD+Lo6FJrWps5xHRHZg+E=;
  b=O55zKGoxlzu8Snes40fvEQJq95ocoYMiakqh1b+Wbh8S5vVX03MHjl3W
   /GHHAQWyJBCfCmPk4wMHfv8Bw2P8xSuOsaZs0eTDh6NQpvlRu04NUef54
   gQizCtC/f46CB5IFgKDRWx0+P2fGKQ+/B33b1Nhr9LwRxgANjRShtyCyR
   F7TnJpKvvUdh6xBqlGd1vajjeYZx23eCQ5U80UAQaRIeqVRbJ2GXtYU4s
   38Zn0d+YKO7d8xNZlR/2lZQa6tgb5s1YOy3K4bxyUU53sUQrXaDnUMLfB
   /Pe5axyR16DcmhAtv7mkc1Z2FyxoBrDAXxLHglz8J41kUUtNBk0NBElhY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="348445719"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="348445719"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 14:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="921352980"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2022 14:29:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F25541A0; Sun, 10 Jul 2022 00:29:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Return deferred probe error when controller isn't yet available
Date:   Sun, 10 Jul 2022 00:29:56 +0300
Message-Id: <20220709212956.25530-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the controller is not available, it might be in the future and
we would like to re-probe the peripheral again. For that purpose
return deferred probe.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215993
Fixes: 87e59b36e5e2 ("spi: Support selection of the index of the ACPI Spi Resource before alloc")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9b080dafa52c..119a2de8a8cb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2478,7 +2478,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 
 				ctlr = acpi_spi_find_controller_by_adev(adev);
 				if (!ctlr)
-					return -ENODEV;
+					return -EPROBE_DEFER;
 
 				lookup->ctlr = ctlr;
 			}
-- 
2.35.1

