Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1B56C526
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiGIAH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiGIAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:07:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C0965581;
        Fri,  8 Jul 2022 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657325201; x=1688861201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B2WEj0fZg9Od4iODOdzOgRNHE9v/f0flGvXcbUXJo7c=;
  b=mW13mzB+eVAstlUNx954WPRmBY1Ir7LCaCdFzKECphQlwVz7G0n6QZIY
   CWvs87omlW0NGOimcAnbYmGCdbqe3lbkiEb9V72LiHXaNlLysmSmVDojM
   XRRfft8o++tElA6Rc81xKWTgKkdBXsF4MwJJtMHuRmgJs7L366WzEMo1Q
   d/BoVTZIWEmI7Mns7eYkROX8I1bAJx5evQV8rrgbE8uSBnpcuqCJHof/g
   6bcVKnt4sf5C7Le6RnwXN2ZuwVOWi2mXiwAKS0Onbs1dpPGj82v/yMzmi
   CYysQAjkhepT3yza5MZ5GnjvdWf47sFbUam0M+/o7EYUjyIT213aV//1d
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="267430735"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="267430735"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="594289767"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2022 17:06:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6CFE8CE; Sat,  9 Jul 2022 03:06:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/7] platform/x86: serial-multi-instantiate: return -ENOENT when no resources found
Date:   Sat,  9 Jul 2022 03:06:30 +0300
Message-Id: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distinguish the case when device is present, but there are no resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/serial-multi-instantiate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 1e8063b7c169..97db23243018 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -100,7 +100,7 @@ static int smi_spi_probe(struct platform_device *pdev, struct acpi_device *adev,
 	if (ret < 0)
 		return ret;
 	else if (!ret)
-		return -ENODEV;
+		return -ENOENT;
 
 	count = ret;
 
@@ -184,7 +184,7 @@ static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev,
 	if (ret < 0)
 		return ret;
 	else if (!ret)
-		return -ENODEV;
+		return -ENOENT;
 
 	count = ret;
 
-- 
2.35.1

