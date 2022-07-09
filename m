Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3718656C56C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiGIAH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiGIAHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:07:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDCF66B85;
        Fri,  8 Jul 2022 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657325229; x=1688861229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cpONHfvICP0pLZXFSpNN1+uSymjEqhVrTSEJEUFETFI=;
  b=kUqRGrkshvFWGaxINcdFvZsGEVFUoHgehsmv1AUvshWSA2ThYv1CYbHW
   0iFEKWcvyAXG+PipFD54k+Dvo/6xzkCU4drBx4vLHDivbVuX2j8xdKWq0
   nROOjQx4t4FGWpcrBXm1Rw/Wmum9q99ifWLCmQ2/Y3xK9As7eJTtPCwAH
   z2e0GRV9oHOIqWO88xQudxSAejtJ78/mfu6QrKDxuekVjelezfL9aH5tR
   6C1gHZWEU3AzZncjMgPenryH4sz1AAw5q/zeFaarCxPj21wpW6GGL9iKa
   8R6k7Fem5lgGNh4JZAwJhyM+YAsFynemrTxq88yiPfiIepeKVKzpChLv3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="284411926"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="284411926"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="840459575"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jul 2022 17:07:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C44D1CE; Sat,  9 Jul 2022 03:07:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: propagate error code to the caller of acpi_spi_device_alloc()
Date:   Sat,  9 Jul 2022 03:07:08 +0300
Message-Id: <20220709000709.35622-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since acpi_spi_device_alloc() has been designed to return an error
pointer we may now properly propagate error codes to the caller of
it. It helps debugging a lot.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0690f018c413..d4a8665410ea 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2565,7 +2565,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 
 	if (ret < 0)
 		/* Found SPI in _CRS but it points to another controller */
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(ret);
 
 	if (!lookup.max_speed_hz &&
 	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
-- 
2.35.1

