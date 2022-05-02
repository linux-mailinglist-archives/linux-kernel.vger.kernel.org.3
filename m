Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EB2516DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384326AbiEBJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384356AbiEBJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:54:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4259EDED;
        Mon,  2 May 2022 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651485067; x=1683021067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lW0lO5z5VpH64eO+G5VofuHf7b1zIUUWm2f++1r8rig=;
  b=O2/J2nOfNDpHI5WStXPH3wOuUgwogm13yBJ7nwbHIA92ptydj9p9d1sH
   ExK8yjuHGv80ZkSczcIqmoOrVZN5NI1ODYXywi4nxoUn/BnSrFoC8wQym
   igQ7C6/iOXC3crmuPBuaXw/AEw7PDTJ6MtfA54KcwUP6EAJLXmQy8FWR8
   lsiUC0UDhWtJJLblgN3bmMRfLGX4YJZsddf5DU2Y32tI84BwctIc+ip7p
   1EBpRzw7jRLVMFx/9rWYk/rGma5R1BloxbSLj+TFY44smP9m1xuHPds/G
   EdNvgViFFg84ctXGtRck5CxheJxEB1xCp6s8t4WL768bHDoqmUem8A3Uk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="353598688"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="353598688"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 02:51:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="652757630"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 May 2022 02:51:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3A4C8179; Mon,  2 May 2022 12:51:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] device property: Advertise fwnode and device property count API calls
Date:   Mon,  2 May 2022 12:51:01 +0300
Message-Id: <20220502095101.46920-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of fwnode and device property array API calls isn't
pointing out to the shortcuts to count the number of elements of size
in an array. Amend the documentation to advertise fwnode and device
property count API calls.

Reported-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f289f582209c..836124f54332 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -68,6 +68,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_present);
  * Function reads an array of u8 properties with @propname from the device
  * firmware description and stores them to @val if found.
  *
+ * It's recommended to call device_property_count_u8() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -93,6 +96,9 @@ EXPORT_SYMBOL_GPL(device_property_read_u8_array);
  * Function reads an array of u16 properties with @propname from the device
  * firmware description and stores them to @val if found.
  *
+ * It's recommended to call device_property_count_u16() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -118,6 +124,9 @@ EXPORT_SYMBOL_GPL(device_property_read_u16_array);
  * Function reads an array of u32 properties with @propname from the device
  * firmware description and stores them to @val if found.
  *
+ * It's recommended to call device_property_count_u32() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -143,6 +152,9 @@ EXPORT_SYMBOL_GPL(device_property_read_u32_array);
  * Function reads an array of u64 properties with @propname from the device
  * firmware description and stores them to @val if found.
  *
+ * It's recommended to call device_property_count_u64() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -168,6 +180,9 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
  * Function reads an array of string properties with @propname from the device
  * firmware description and stores them to @val if found.
  *
+ * It's recommended to call device_property_string_array_count() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values read on success if @val is non-NULL,
  *	   number of values available on success if @val is NULL,
  *	   %-EINVAL if given arguments are not valid,
@@ -256,6 +271,9 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
  * Read an array of u8 properties with @propname from @fwnode and stores them to
  * @val if found.
  *
+ * It's recommended to call fwnode_property_count_u8() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -282,6 +300,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
  * Read an array of u16 properties with @propname from @fwnode and store them to
  * @val if found.
  *
+ * It's recommended to call fwnode_property_count_u16() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -308,6 +329,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
  * Read an array of u32 properties with @propname from @fwnode store them to
  * @val if found.
  *
+ * It's recommended to call fwnode_property_count_u32() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -334,6 +358,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
  * Read an array of u64 properties with @propname from @fwnode and store them to
  * @val if found.
  *
+ * It's recommended to call fwnode_property_count_u64() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -360,6 +387,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
  * Read an string list property @propname from the given firmware node and store
  * them to @val if found.
  *
+ * It's recommended to call fwnode_property_string_array_count() instead of calling
+ * this function with @val equals %NULL and @nval equals 0.
+ *
  * Return: number of values read on success if @val is non-NULL,
  *	   number of values available on success if @val is NULL,
  *	   %-EINVAL if given arguments are not valid,
-- 
2.35.1

