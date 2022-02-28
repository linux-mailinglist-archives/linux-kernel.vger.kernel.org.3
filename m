Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C974C7D94
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiB1WkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiB1WkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:40:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6203512552D;
        Mon, 28 Feb 2022 14:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646087966; x=1677623966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7KW5r5qAfPKAahouBoRxbP98/SFsYhZNNzFD4JTPQyQ=;
  b=Pg3Hszf/wEHWGlSgE8HsE4Bpb7g1FYERLyQ1CydHkh3PWQ4t2PYrSSsm
   X++3nP+/+PM0JqLnirbM0/m7wdHVaOUltOhDLTqf7eANKc49yVzTovJIA
   X3G3+SkWS+5eRJOpRo1WQ9wDF7Y+LN1qm9IzYgg+uqPajhm6AlonaJtIb
   xCQwwK4rlg+Coa87Z548qP6bJdy3E5mgpW5GN0tygLfUCDC/7tz8X/JxY
   09a3ItuDGVmto3rY9QqrsPmJv27hQQhU6ccTz15Yvkim334l5tqnjB6gj
   lNn5OYi1SmkPhjPNajwfBXDi3OlR/8ZWP+dC0omBmfUwwLPNbGBoSBQsm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251835911"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="251835911"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="593387226"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2022 14:39:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 13E5442; Tue,  1 Mar 2022 00:39:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/7] ACPI: enumeration: Update UART serial bus resource documentation
Date:   Tue,  1 Mar 2022 00:39:31 +0200
Message-Id: <20220228223936.54310-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
References: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
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

In some cases UART serial bus resource may be represented by struct
serdev_device.

Fixes: 53c7626356c7 ("serdev: Add ACPI support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 3b221cc9ff5f..f4bb5ddca528 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -19,16 +19,17 @@ possible we decided to do following:
     platform devices.
 
   - Devices behind real busses where there is a connector resource
-    are represented as struct spi_device or struct i2c_device
-    (standard UARTs are not busses so there is no struct uart_device).
+    are represented as struct spi_device or struct i2c_device. Note
+    that standard UARTs are not busses so there is no struct uart_device,
+    although some of them may be represented by sturct serdev_device.
 
 As both ACPI and Device Tree represent a tree of devices (and their
 resources) this implementation follows the Device Tree way as much as
 possible.
 
-The ACPI implementation enumerates devices behind busses (platform, SPI and
-I2C), creates the physical devices and binds them to their ACPI handle in
-the ACPI namespace.
+The ACPI implementation enumerates devices behind busses (platform, SPI,
+I2C, and in some cases UART), creates the physical devices and binds them
+to their ACPI handle in the ACPI namespace.
 
 This means that when ACPI_HANDLE(dev) returns non-NULL the device was
 enumerated from ACPI namespace. This handle can be used to extract other
-- 
2.34.1

