Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4224C7D90
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiB1WkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiB1WkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:40:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0F312558E;
        Mon, 28 Feb 2022 14:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646087967; x=1677623967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z3cuSidlSplrkPzS0iAKkjA4oiCL66X8tnB9pZSBsV4=;
  b=fLUPhKYbsdkGxitMzipIio+TUVfL+xwBF+qY09i5DDEtTkClzSS8nDB+
   ScHl2VR0VMqm1maWk/ZlA1CSmSwEJq+ebkIXqRf5e+qvOzpxDFuOBQ0PW
   Zznv1Uh2W7M0yQzRboqfw67fFVLdZjRRYbfFduPFK16xwoOtIba4Vpk1Z
   /nwE4z2MgtpAx5MEL3s8FDIrty3z57Ao6yBwiEgqNQg3+IJzTn2+fRlOD
   BEyrAE1p2W3SzbvdYzH2phncsk+j8L2XK69HyB46vjV6KfXfKVYS36ddw
   c1y+q62Ae4Da+xSOrMU1eRsoy7sUnpZyLx5QcmL4PphQwzToA5oW6Tc/g
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251835914"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="251835914"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="629799062"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Feb 2022 14:39:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 08036142; Tue,  1 Mar 2022 00:39:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/7] ACPI: enumeration: Discourage to use custom _DSM methods
Date:   Tue,  1 Mar 2022 00:39:30 +0200
Message-Id: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have _DSD established and specified (ACPI v5.1+) there is no
need to use custom _DSM methods. Rewrite documentation to use _DSD.

Fixes: f60e7074902a ("misc: at25: Make use of device property API")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../firmware-guide/acpi/enumeration.rst       | 48 ++++++++-----------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index d0022567c022..3b221cc9ff5f 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -227,43 +227,37 @@ to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
 	};
 
 Note that this driver actually needs more information like page size of the
-eeprom etc. but at the time writing this there is no standard way of
-passing those. One idea is to return this in _DSM method like::
+eeprom, etc. This information can be passed via _DSD method like::
 
 	Device (EEP0)
 	{
 		...
-		Method (_DSM, 4, NotSerialized)
+		Name (_DSD, Package ()
 		{
-			Store (Package (6)
+			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+			Package ()
 			{
-				"byte-len", 1024,
-				"addr-mode", 2,
-				"page-size, 32
-			}, Local0)
-
-			// Check UUIDs etc.
-
-			Return (Local0)
-		}
-
-Then the at25 SPI driver can get this configuration by calling _DSM on its
-ACPI handle like::
-
-	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_object_list input;
-	acpi_status status;
+				Package () { "size", 1024 },
+				Package () { "pagesize", 32 },
+				Package () { "address-width", 16 },
+			}
+		})
+	}
 
-	/* Fill in the input buffer */
+Then the at25 SPI driver can get this configuration by calling device property
+APIs during ->probe() phase like::
 
-	status = acpi_evaluate_object(ACPI_HANDLE(&spi->dev), "_DSM",
-				      &input, &output);
-	if (ACPI_FAILURE(status))
-		/* Handle the error */
+	err = device_property_read_u32(dev, "size", &size);
+	if (err)
+		...error handling...
 
-	/* Extract the data here */
+	err = device_property_read_u32(dev, "pagesize", &page_size);
+	if (err)
+		...error handling...
 
-	kfree(output.pointer);
+	err = device_property_read_u32(dev, "address-width", &addr_width);
+	if (err)
+		...error handling...
 
 I2C serial bus support
 ======================
-- 
2.34.1

