Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B983F585B32
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiG3P7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiG3P67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:58:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85FADF55;
        Sat, 30 Jul 2022 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659196738; x=1690732738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9cKOU+81t6KkSi6zCm5L/gkHl9usaGGFPm85VfGl91U=;
  b=Zm2CmG7c9OBLbshXPAXQ8CX98Gl1SjnM5qWfbzK0pezMEcplPCsZbKyp
   foB4HDaVhxOA5wS5oPD5jukeyLdDvjUx1l4u5MzE+xKePLeuG/IMn/2hP
   v5/XxpG7TZefCGQl9/BHx76RsZKdd1MqPZDFaeZBQZ5QMu3Mxm9zyFsUM
   k5891SL1cwiWhDbfuy3AjD4JYwAFeqgRxBvm+2xxa7seBKKFA3KiXVqOq
   nZbIi2YomMojqUtNCdMSnCDcb5kLWbPgyk7iPSS5sBgL1F+YWq6gHXVNp
   MEqpnaBBXKw0DDiHaFs94ciJrBodP9/RLhKiumPqFPrnzbTKImUAOneA/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="288939832"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="288939832"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 08:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="728024568"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2022 08:58:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9A9CAF1; Sat, 30 Jul 2022 18:59:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] media: atomisp_gmin_platform: Switch to use acpi_evaluate_dsm_typed()
Date:   Sat, 30 Jul 2022 18:59:04 +0300
Message-Id: <20220730155905.90091-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
v2: fixed 80 character overgo (Sakari)
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index bf527b366ab3..f7fc5137199c 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -1207,16 +1207,14 @@ static int gmin_get_config_dsm_var(struct device *dev,
 	if (!strcmp(var, "CamClk"))
 		return -EINVAL;
 
-	obj = acpi_evaluate_dsm(handle, &atomisp_dsm_guid, 0, 0, NULL);
+	/* Return on unexpected object type */
+	obj = acpi_evaluate_dsm_typed(handle, &atomisp_dsm_guid, 0, 0, NULL,
+				      ACPI_TYPE_PACKAGE);
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

