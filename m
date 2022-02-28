Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6D4C7D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiB1WkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiB1WkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:40:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EB9124C2C;
        Mon, 28 Feb 2022 14:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646087966; x=1677623966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YLC9rgC4ZBM6Z/PdSXcXp2iSqN22GTMuevEcbQk15QU=;
  b=IMpHbmNqg3DYPVGHBkylvekpJHq0N4ouwZ2jBcMs4elsBLlDvvOPCvGL
   S4ccNZZdOrbqKus/KWMsLg/5Zhna48CHm+ul0L8nJDYzz6DUNsMyF3eyt
   QTb3iWLQpDNwt1IOf37A2deaN64sDQ1fvJd6EVzptfmh5/CLC7dF/ui1X
   yyRJnV1QhzcxcZ2LazR0IiPFg9Ce61D3VSa7+0WaDm4qG7ctrqde26Jr2
   JQxRdakGcztl9HQ1cXj/5zu0EMDV8Em9HdI8FqmuLcO5YZxqFJ19emi0e
   pP+7BftAOgpIl/OSEtNt498Y472yCXcEb6Q2cXUgtzkXG/pQtX9u81kME
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236511704"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="236511704"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="550445547"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 Feb 2022 14:39:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 346711C9; Tue,  1 Mar 2022 00:39:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 5/7] ACPI: enumeration: Drop ugly ifdeffery from the examples
Date:   Tue,  1 Mar 2022 00:39:34 +0200
Message-Id: <20220228223936.54310-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
References: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ifdeffery around ACPI ID tables are ugly and in some cases
even less valuable than plain definitions. Drop them for good
to avoid spreading rather bad pattern.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 96179d2a8871..93fdc04de9c3 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -47,18 +47,16 @@ some minor changes.
 Adding ACPI support for an existing driver should be pretty
 straightforward. Here is the simplest example::
 
-	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id mydrv_acpi_match[] = {
 		/* ACPI IDs here */
 		{ }
 	};
 	MODULE_DEVICE_TABLE(acpi, mydrv_acpi_match);
-	#endif
 
 	static struct platform_driver my_driver = {
 		...
 		.driver = {
-			.acpi_match_table = ACPI_PTR(mydrv_acpi_match),
+			.acpi_match_table = mydrv_acpi_match,
 		},
 	};
 
@@ -212,18 +210,16 @@ The SPI device drivers only need to add ACPI IDs in a similar way than with
 the platform device drivers. Below is an example where we add ACPI support
 to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
 
-	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id at25_acpi_match[] = {
 		{ "AT25", 0 },
 		{ },
 	};
 	MODULE_DEVICE_TABLE(acpi, at25_acpi_match);
-	#endif
 
 	static struct spi_driver at25_driver = {
 		.driver = {
 			...
-			.acpi_match_table = ACPI_PTR(at25_acpi_match),
+			.acpi_match_table = at25_acpi_match,
 		},
 	};
 
@@ -271,20 +267,18 @@ registered.
 Below is an example of how to add ACPI support to the existing mpu3050
 input driver::
 
-	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id mpu3050_acpi_match[] = {
 		{ "MPU3050", 0 },
 		{ },
 	};
 	MODULE_DEVICE_TABLE(acpi, mpu3050_acpi_match);
-	#endif
 
 	static struct i2c_driver mpu3050_i2c_driver = {
 		.driver	= {
 			.name	= "mpu3050",
 			.pm	= &mpu3050_pm,
 			.of_match_table = mpu3050_of_match,
-			.acpi_match_table = ACPI_PTR(mpu3050_acpi_match),
+			.acpi_match_table = mpu3050_acpi_match,
 		},
 		.probe		= mpu3050_probe,
 		.remove		= mpu3050_remove,
-- 
2.34.1

