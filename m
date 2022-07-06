Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CF5685D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiGFKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiGFKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:40:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960D1275D7;
        Wed,  6 Jul 2022 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657104035; x=1688640035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jrQpGvLoGy64S3PaTB+Xyboo+qGQoGMpPkJg+WNQoz0=;
  b=D+2JrQEuzOT30+o4f1wVTOwxSHhrqkZUgQz+ZUx4K5PcHWhESGvbH3w5
   N2t+HfgtZ3j0CvZhafC8jM65qUnGK7KocgFkEB2qpzXucvSmsHWtIF7ol
   TOrJBdjdH0jrN+8fHiL4xYbW1muzqft8GHRCNbhSpV6I+svzPZkYxFTEV
   XcEkIq6TSf9EdfUWdWyXWRfEg0tDoBZE3CgjdFkQmh5Aa0Xk8PE1zmWNq
   AnKU6RXty+BtaPUs7PuooxFmvphu/8AgFryF/sZWc3+6nPtJmbPLbayNx
   42a8nMJAufCBDUXdyrnI+I0rcPJWn0Z8NhxRYlkmPXQ+NzgKzmOXDj6H0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="283734159"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="283734159"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:40:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="597621136"
Received: from gklab-106a-125.igk.intel.com (HELO localhost) ([10.211.106.125])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:40:33 -0700
From:   "Kallas, Pawel" <pawel.kallas@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     iwona.winiarska@intel.com, pawel.kallas@intel.com
Subject: [PATCH 1/3] hwmon: (pmbus) add support for QUERY command
Date:   Wed,  6 Jul 2022 12:40:22 +0200
Message-Id: <20220706104024.3118590-2-pawel.kallas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706104024.3118590-1-pawel.kallas@intel.com>
References: <20220706104024.3118590-1-pawel.kallas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUERY command is used for checking if given command is supported by
the device and what data format it uses. It is needed to check if
READ_EIN and READ_EOUT commands are supported.

Signed-off-by: Kallas, Pawel <pawel.kallas@intel.com>
---
 Documentation/hwmon/pmbus-core.rst |  7 +++++++
 drivers/hwmon/pmbus/pmbus.h        | 14 ++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c   | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
index e7e0c9ef10bec..6ba0a9d86f1f6 100644
--- a/Documentation/hwmon/pmbus-core.rst
+++ b/Documentation/hwmon/pmbus-core.rst
@@ -268,6 +268,13 @@ otherwise.
 This function calls the device specific write_byte function if defined to
 obtain the chip status. Therefore, it must _not_ be called from that function.
 
+::
+
+  int pmbus_query_register(struct i2c_client *client, int reg);
+
+Send pmbus QUERY command for specific register. Returns QUERY command
+response or negative value on fail.
+
 ::
 
   int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info);
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 75aa97b1ecc05..971554f40dba6 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -364,6 +364,19 @@ enum pmbus_fan_mode { percent = 0, rpm };
 #define PB_CML_FAULT_INVALID_DATA	BIT(6)
 #define PB_CML_FAULT_INVALID_COMMAND	BIT(7)
 
+/*
+ * QUERY
+ */
+#define PB_QUERY_COMMAND_MODE_MASK	0x1C
+
+#define PB_QUERY_COMMAND_MODE_LINEAR	0x00
+#define PB_QUERY_COMMAND_MODE_DIRECT	0x0C
+#define PB_QUERY_COMMAND_MODE_VID	0x14
+
+#define PB_QUERY_COMMAND_SUPPORTED_FOR_READ	BIT(5)
+#define PB_QUERY_COMMAND_SUPPORTED_FOR_WRITE	BIT(6)
+#define PB_QUERY_COMMAND_SUPPORTED	BIT(7)
+
 enum pmbus_sensor_classes {
 	PSC_VOLTAGE_IN = 0,
 	PSC_VOLTAGE_OUT,
@@ -492,6 +505,7 @@ int pmbus_update_byte_data(struct i2c_client *client, int page, u8 reg,
 void pmbus_clear_faults(struct i2c_client *client);
 bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
 bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
+int pmbus_query_register(struct i2c_client *client, int reg);
 int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info);
 const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client
 						      *client);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index d462f732f3b40..4bcb70ab9b598 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -648,6 +648,27 @@ static int pmbus_get_status(struct i2c_client *client, int page, int reg)
 	return status;
 }
 
+int pmbus_query_register(struct i2c_client *client, int reg)
+{
+	int rv;
+	union i2c_smbus_data data;
+
+	data.block[0] = 1;
+	data.block[1] = reg;
+
+	rv = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			    I2C_SMBUS_WRITE, PMBUS_QUERY,
+			    I2C_SMBUS_BLOCK_PROC_CALL, &data);
+	if (rv < 0)
+		return rv;
+
+	if (data.block[0] != 1)
+		return -EIO;
+
+	return data.block[1];
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_query_register, PMBUS);
+
 static void pmbus_update_sensor_data(struct i2c_client *client, struct pmbus_sensor *sensor)
 {
 	if (sensor->data < 0 || sensor->update)
