Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A41576517
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiGOQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGOQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:06:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561FC63939;
        Fri, 15 Jul 2022 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657901200; x=1689437200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RA6Wj2dcAYMvgXRrD1UGRGBL8oXhBhwHgtqU/ENlld0=;
  b=YFZ4C7G+clKGVktGJR/i1YjLx9OuraZjpm4M54otmDidmME7HmSYk39b
   8iQ3/XOTq6VXJMkayQF8h52mhiNgdhwl8E1Px5GkDwmooS1Z1yBF6F8Vk
   Pt6MnGSLf7pPTUplXoHAjol30mQcdIRd4+QNW6kJhvDVpILuKocVEijzw
   Yd6hUS13fzaUKkqKBmyRZfzISGzwgGSEI2+mSYwqIZn+hFCS7CBGYDrqB
   RiItqn+/jybnBc1YALh3pUnSOId4ALXrDATsVGGozQ5UFc4Nqf07M7W/H
   sw4Ej7Lqnigje9WAk4KQbsdE0LBMp1JSfyT1jVbJJACTFOVQhkUX5o62t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="349791396"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="349791396"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 09:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="738704952"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jul 2022 09:06:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CDF2AF1; Fri, 15 Jul 2022 19:06:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] media: atomisp_gmin_platform: Switch to use acpi_evaluate_dsm_typed()
Date:   Fri, 15 Jul 2022 19:06:41 +0300
Message-Id: <20220715160641.73526-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index bf527b366ab3..d4cfda07f7fb 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -1207,16 +1207,13 @@ static int gmin_get_config_dsm_var(struct device *dev,
 	if (!strcmp(var, "CamClk"))
 		return -EINVAL;
 
-	obj = acpi_evaluate_dsm(handle, &atomisp_dsm_guid, 0, 0, NULL);
+	/* Return on unexpected object type */
+	obj = acpi_evaluate_dsm_typed(handle, &atomisp_dsm_guid, 0, 0, NULL, ACPI_TYPE_PACKAGE);
 	if (!obj) {
 		dev_info_once(dev, "Didn't find ACPI _DSM table.\n");
 		return -EINVAL;
 	}
 
-	/* Return on unexpected object type */
-	if (obj->type != ACPI_TYPE_PACKAGE)
-		return -EINVAL;
-
 #if 0 /* Just for debugging purposes */
 	for (i = 0; i < obj->package.count; i++) {
 		union acpi_object *cur = &obj->package.elements[i];
-- 
2.35.1

