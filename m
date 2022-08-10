Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9695758EC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiHJMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiHJMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CCF7695E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB4761351
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AE4C433C1;
        Wed, 10 Aug 2022 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660134796;
        bh=qHEafz/4L4clx0/D8+u1J80ED+oGx2biQ1HzFcvOY7c=;
        h=From:To:Cc:Subject:Date:From;
        b=HIGmfjHONYeIQ/REnkNqDODzQz3rSLYtEbeIkfRJQP1Ca1nMKAgDhbU1D5wd5E0Qn
         6+Rh5tA+AQWGc1NOxrLxl/3RCytQnPCWbJuIwxd67ZCbJYNYlZHLyBFuOmu9DeaM/8
         ZR9R3jUvBfFqqsfqbQmk7hzqkw8uzQRyW2xpsCVIQU37f7I69HrE1rOxiUX+g8g2L1
         5IXqvNHAh5e0s8YO+bh7ZnZRe99WoxgEjbcMJCHnInxNmsLIwXTiVBFtrrYmfWRdmW
         GUAvcavVoDxdXJnbkfiIGoTRXbWN+yLdcsLd/3v2uWcbyEqfU5FWu9IITITKm04ivJ
         YmmGXP/WwDTOA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/3] habanalabs: expose device security status through sysfs
Date:   Wed, 10 Aug 2022 15:33:10 +0300
Message-Id: <20220810123312.1683716-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order for the user to know if he is running on a secured device
or not, a sysfs node is added.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-habanalabs |  6 ++++++
 drivers/misc/habanalabs/common/sysfs.c            | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 96646fb2e7a1..6963640a2615 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -176,6 +176,12 @@ KernelVersion:  5.1
 Contact:        ogabbay@kernel.org
 Description:    Version of the device's preboot F/W code
 
+What:           /sys/class/habanalabs/hl<n>/security_enabled
+Date:           Oct 2022
+KernelVersion:  6.1
+Contact:        obitton@habana.ai
+Description:    Displays the device's security status
+
 What:           /sys/class/habanalabs/hl<n>/soft_reset
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 6c5271f01160..36e9814139d1 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -375,6 +375,14 @@ static ssize_t eeprom_read_handler(struct file *filp, struct kobject *kobj,
 	return max_size;
 }
 
+static ssize_t security_enabled_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", hdev->asic_prop.fw_security_enabled);
+}
+
 static DEVICE_ATTR_RO(armcp_kernel_ver);
 static DEVICE_ATTR_RO(armcp_ver);
 static DEVICE_ATTR_RO(cpld_ver);
@@ -393,6 +401,7 @@ static DEVICE_ATTR_RO(status);
 static DEVICE_ATTR_RO(thermal_ver);
 static DEVICE_ATTR_RO(uboot_ver);
 static DEVICE_ATTR_RO(fw_os_ver);
+static DEVICE_ATTR_RO(security_enabled);
 
 static struct bin_attribute bin_attr_eeprom = {
 	.attr = {.name = "eeprom", .mode = (0444)},
@@ -417,6 +426,7 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_thermal_ver.attr,
 	&dev_attr_uboot_ver.attr,
 	&dev_attr_fw_os_ver.attr,
+	&dev_attr_security_enabled.attr,
 	NULL,
 };
 
-- 
2.25.1

