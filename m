Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF304D8763
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbiCNOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiCNOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:51:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD83A5D4;
        Mon, 14 Mar 2022 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647269445; x=1678805445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N+G6beZi59FUQo88au8V4FELbIxpTKtqSnWPAPTyaIM=;
  b=n19Rs+vZFf2As8hlTueSqnNnI+ksR4HC7DGK+/672kC+VHMrb0SWhVPk
   pYO0AzwDqnBxct6IP+SmkU2RtAF2GvkEWCxhl0Q05/l+dra0PvbB3m40V
   Oj0IOu/XXVqlSizH3WITygHnswuVWk3WKMTU8d5+uQnCz8EYooUk+HPKa
   8qc15F6FjxVwNZXbvAwBDE0vl9OSDmqb2WszQyhePCs6TWcLsQANz99Ib
   DjrXGIN99C/8GmYoSq0QgslekUBTugSxGfhJnHl4GLNI6JTiG94jYqAd/
   rpfKLtu7iueGLkwUINBC9xE4jaAxtmTu3lfY9XA4V2SS7XFq7ZZZGtibw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="280807337"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="280807337"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 07:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="818998801"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 14 Mar 2022 07:50:44 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthewgarrett@google.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: Update OS policy capability
Date:   Mon, 14 Mar 2022 07:50:43 -0700
Message-Id: <20220314145043.928617-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the firmware with OS supported policies mask, so	that firmware can
relinquish its internal controls. Without this update several Tiger Lake
laptops gets performance limited with in few seconds of executing in
turbo region.

The existing way of enumerating firmware policies via IDSP method and
selecting policy by directly writing those policy UUIDS via _OSC method
is not supported in newer generation of hardware.

There is a new UUID "B23BA85D-C8B7-3542-88DE-8DE2FFCFD698" is defined for
updating policy capabilities. As part of ACPI _OSC method:

Arg0 - UUID: B23BA85D-C8B7-3542-88DE-8DE2FFCFD698
Arg1 - Rev ID: 1
Arg2 - Count: 2
Arg3 - Capability buffers: Array of Arg2 DWORDS

DWORD1: As defined in the ACPI 5.0 Specification
- Bit 0: Query Flag
- Bits 1-3: Always 0
- Bits 4-31: Reserved

DWORD2 and beyond:
- Bit0: set to 1 to indicate Intel(R) Dynamic Tuning is active, 0 to
indicate it is disabled and legacy thermal mechanism should
be enabled.
- Bit1: set to 1 to indicate Intel(R) Dynamic Tuning is controlling
active cooling, 0 to indicate bios shall enable legacy thermal
zone with active trip point.
- Bit2: set to 1 to indicate Intel(R) Dynamic Tuning is controlling
passive cooling, 0 to indicate bios shall enable legacy thermal
zone with passive trip point.
- Bit3: set to 1 to indicate Intel(R) Dynamic Tuning is handling
critical trip point, 0 to indicate bios shall enable legacy
thermal zone with critical trip point.
- Bits 4:31: Reserved

From sysfs interface, there is an existing interface to update policy
UUID using attribute "current_uuid". User space can write the same UUID
for ACTIVE, PASSIVE and CRITICAL policy. Driver converts these UUIDs to
DWORD2 Bit 1 to Bit 3. When any of the policy is activated by user
space it is assumed that dynamic tuning is active.

For example
$cd /sys/bus/platform/devices/INTC1040:00/uuids
To support active policy
$echo "3A95C389-E4B8-4629-A526-C52C88626BAE" > current_uuid
To support passive policy
$echo "42A441D6-AE6A-462b-A84B-4A8CE79027D3" > current_uuid
To support critical policy
$echo "97C68AE7-15FA-499c-B8C9-5DA81D606E0A" > current_uuid

To check all the supported policies
$cat current_uuid
3A95C389-E4B8-4629-A526-C52C88626BAE
42A441D6-AE6A-462b-A84B-4A8CE79027D3
97C68AE7-15FA-499c-B8C9-5DA81D606E0A

To match the bit format for DWORD2, rearranged enum int3400_thermal_uuid
and int3400_thermal_uuids[] by swapping current INT3400_THERMAL_ACTIVE
and INT3400_THERMAL_PASSIVE_1.

If the policies are enumerated via IDSP method then legacy method is
used, if not the new method is used to update policy support.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 146 ++++++++++++------
 1 file changed, 97 insertions(+), 49 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index c2d3df302214..d5f065c4d209 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -17,8 +17,8 @@
 #define INT3400_KEEP_ALIVE 0xA0
 
 enum int3400_thermal_uuid {
+	INT3400_THERMAL_ACTIVE = 0,
 	INT3400_THERMAL_PASSIVE_1,
-	INT3400_THERMAL_ACTIVE,
 	INT3400_THERMAL_CRITICAL,
 	INT3400_THERMAL_ADAPTIVE_PERFORMANCE,
 	INT3400_THERMAL_EMERGENCY_CALL_MODE,
@@ -31,8 +31,8 @@ enum int3400_thermal_uuid {
 };
 
 static char *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
-	"42A441D6-AE6A-462b-A84B-4A8CE79027D3",
 	"3A95C389-E4B8-4629-A526-C52C88626BAE",
+	"42A441D6-AE6A-462b-A84B-4A8CE79027D3",
 	"97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
 	"63BE270F-1C11-48FD-A6F7-3AF253FF3E2D",
 	"5349962F-71E6-431D-9AE8-0A635B710AEE",
@@ -59,6 +59,7 @@ struct int3400_thermal_priv {
 	char *data_vault;
 	int odvp_count;
 	int *odvp;
+	u16 os_uuid_mask;
 	struct odvp_attr *odvp_attrs;
 };
 
@@ -142,12 +143,55 @@ static ssize_t current_uuid_show(struct device *dev,
 				 struct device_attribute *devattr, char *buf)
 {
 	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
+	int i, length = 0;
+
+	if (priv->current_uuid_index > 0)
+		return sprintf(buf, "%s\n",
+			       int3400_thermal_uuids[priv->current_uuid_index]);
+
+	for (i = 0; i <= INT3400_THERMAL_CRITICAL; i++) {
+		if (priv->os_uuid_mask & BIT(i))
+			length += scnprintf(&buf[length],
+					    PAGE_SIZE - length,
+					    "%s\n",
+					    int3400_thermal_uuids[i]);
+	}
 
-	if (priv->current_uuid_index == -1)
-		return sprintf(buf, "INVALID\n");
+	if (length)
+		return length;
 
-	return sprintf(buf, "%s\n",
-		       int3400_thermal_uuids[priv->current_uuid_index]);
+	return sprintf(buf, "INVALID\n");
+}
+
+static int int3400_thermal_run_osc(acpi_handle handle, char *uuid_str, int *enable)
+{
+	u32 ret, buf[2];
+	acpi_status status;
+	int result = 0;
+	struct acpi_osc_context context = {
+		.uuid_str = NULL,
+		.rev = 1,
+		.cap.length = 8,
+	};
+
+	context.uuid_str = uuid_str;
+
+	buf[OSC_QUERY_DWORD] = 0;
+	buf[OSC_SUPPORT_DWORD] = *enable;
+
+	context.cap.pointer = buf;
+
+	status = acpi_run_osc(handle, &context);
+	if (ACPI_SUCCESS(status)) {
+		ret = *((u32 *)(context.ret.pointer + 4));
+		if (ret != *enable)
+			result = -EPERM;
+	} else
+		result = -EPERM;
+
+	kfree(context.ret.pointer);
+
+	return result;
 }
 
 static ssize_t current_uuid_store(struct device *dev,
@@ -164,16 +208,47 @@ static ssize_t current_uuid_store(struct device *dev,
 			 * If we have a list of supported UUIDs, make sure
 			 * this one is supported.
 			 */
-			if (priv->uuid_bitmap &&
-			    !(priv->uuid_bitmap & (1 << i)))
+			if (priv->uuid_bitmap & BIT(i)) {
+				priv->current_uuid_index = i;
+				return count;
+			}
+
+			/*
+			 * There is support of only 3 policies via the new
+			 * _OSC to inform OS capability:
+			 * INT3400_THERMAL_ACTIVE
+			 * INT3400_THERMAL_PASSIVE_1
+			 * INT3400_THERMAL_CRITICAL
+			 */
+
+			if (i > INT3400_THERMAL_CRITICAL)
 				return -EINVAL;
 
-			priv->current_uuid_index = i;
-			return count;
+			priv->os_uuid_mask |= BIT(i);
+
+			break;
 		}
 	}
 
-	return -EINVAL;
+	if (priv->os_uuid_mask) {
+		int cap, ret;
+
+		/*
+		 * Capability bits:
+		 * Bit 0: set to 1 to indicate DPTF is active
+		 * Bi1 1: set to 1 to active cooling is supported by user space daemon
+		 * Bit 2: set to 1 to passive cooling is supported by user space daemon
+		 * Bit 3: set to 1 to critical trip is handled by user space daemon
+		 */
+		cap = ((priv->os_uuid_mask << 1) | 0x01);
+		ret = int3400_thermal_run_osc(priv->adev->handle,
+					      "b23ba85d-c8b7-3542-88de-8de2ffcfd698",
+					      &cap);
+		if (ret)
+			return ret;
+	}
+
+	return count;
 }
 
 static DEVICE_ATTR_RW(current_uuid);
@@ -236,41 +311,6 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
 	return result;
 }
 
-static int int3400_thermal_run_osc(acpi_handle handle,
-				enum int3400_thermal_uuid uuid, bool enable)
-{
-	u32 ret, buf[2];
-	acpi_status status;
-	int result = 0;
-	struct acpi_osc_context context = {
-		.uuid_str = NULL,
-		.rev = 1,
-		.cap.length = 8,
-	};
-
-	if (uuid < 0 || uuid >= INT3400_THERMAL_MAXIMUM_UUID)
-		return -EINVAL;
-
-	context.uuid_str = int3400_thermal_uuids[uuid];
-
-	buf[OSC_QUERY_DWORD] = 0;
-	buf[OSC_SUPPORT_DWORD] = enable;
-
-	context.cap.pointer = buf;
-
-	status = acpi_run_osc(handle, &context);
-	if (ACPI_SUCCESS(status)) {
-		ret = *((u32 *)(context.ret.pointer + 4));
-		if (ret != enable)
-			result = -EPERM;
-	} else
-		result = -EPERM;
-
-	kfree(context.ret.pointer);
-
-	return result;
-}
-
 static ssize_t odvp_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -422,10 +462,18 @@ static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
 	if (!priv)
 		return -EINVAL;
 
-	if (mode != thermal->mode)
+	if (mode != thermal->mode) {
+		int enabled;
+
+		if (priv->current_uuid_index < 0 ||
+		    priv->current_uuid_index >= INT3400_THERMAL_MAXIMUM_UUID)
+			return -EINVAL;
+
+		enabled = (mode == THERMAL_DEVICE_ENABLED);
 		result = int3400_thermal_run_osc(priv->adev->handle,
-						priv->current_uuid_index,
-						mode == THERMAL_DEVICE_ENABLED);
+						 int3400_thermal_uuids[priv->current_uuid_index],
+						 &enabled);
+	}
 
 
 	evaluate_odvp(priv);
-- 
2.31.1

