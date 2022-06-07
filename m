Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1892453EB41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbiFFQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241420AbiFFQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:03:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B635A15D;
        Mon,  6 Jun 2022 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654531424; x=1686067424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JVYxxJCuLZw22rExwuLC+9v72YKwgo13Zo0Ba4HDWss=;
  b=Wf1KhN8CpI98P+xgKT0LvhhJ+MKWhZIdQtnypK27T3RKiOonmt0SQxt5
   y9G4uzHPM/WETJwvhakE5GJryHtkJmrqUQBeddJxQVUG9VFU3DeSIlpS9
   GNpFmPjQgnEnzVVJvir4YFhAs7SaXn8rQXRlN9dF70ZcgSy+Qh+Zn3Dgx
   onmyzFIDiQLfae7Rew9txuSi6AfjWXaLwr5X8EByqBZGlCpALVUglkBxp
   kmCbfxtIWKuqqkJPWKS6x2bkWzKvqUnNqNkgTbu1U6/GNtppzvIkSrXMD
   J6Eup+uymZlMRFwui0KhmwXlUFf+zNtNptYlx8Cx6WfjyQJwj/AzhmvZ5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="340027635"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="340027635"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 09:00:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="906607951"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.255.231.138])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 09:00:35 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v23 2/5] fpga: m10bmc-sec: create max10 bmc secure update
Date:   Mon,  6 Jun 2022 09:00:35 -0700
Message-Id: <20220606160038.846236-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606160038.846236-1-russell.h.weight@intel.com>
References: <20220606160038.846236-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a sub-driver for the FPGA Card BMC in order to support secure
updates.  This patch creates the Max10 BMC Secure Update driver and
provides sysfs files for displaying the root entry hashes (REH) for the
FPGA static region (SR), the FPGA Partial Reconfiguration (PR) region,
and the card BMC.

The Intel MAX10 BMC Root of Trust (RoT) requires that all BMC Nios firmware
and FPGA images are authenticated using ECDSA before loading and executing
on the card. Code Signing Keys (CSK) are used to sign images. CSKs are
signed by a root key. The root entry hash is created from the root public
key.

The RoT provides authentication by storing an REH bitstream to a write-once
location. Image signatures are verified against the hash.

Reviewed-by: Tom Rix <trix@redhat.com>
Tested-by: Tianfei Zhang <tianfei.zhang@intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v23:
  - Rebased for 5.19-rc1
v22:
  - Added Tested-by tag from Tianfei and Acked-by tag from Yilun.
  - Updated KernelVersion and Date in ABI documentation to 5.20 and
    Sep 2022 respectively.
v21:
  - No change
v20:
  - Added text to the commit message to describe Root Entry Hashes.
  - Use reverse christmas tree format for local variable declarations in
    show_root_entry_hash().
  - Remove WARN_ON() from show_root_entry_hash() and return -EINVAL if 
    sha_num_bytes is not a multiple of stride.
  - Move MODULE_DEVICE_TABLE() macro to just beneath the definition of
    intel_m10bmc_sec_ids[].
v19:
  - Change "card bmc" naming back to "m10 bmc" naming to be consistent
    with the parent driver.
v18:
  - Changed the ABI documentation for the Root Entry Hashes to specify
    string as the format for the output.
  - Updated comments, strings and config options to more consistently
    refer to the driver as the Intel FPGA Card BMC Secure Update driver.
  - Removed an instance of dev_dbg().
  - Deferred the call to firmware_upload_register() to a later patch
    where the required ops are provided. The bmc_sec_remove() function is
    also removed from this patch and added in a later patch.
  - Switched from MODULE_ALIAS() to MODULE_DEVICE_TABLE() in anticipation
    of additional cards to be supported by the same driver.
v17:
  - Update the Date and KernelVersion for the ABI documentation to Jul 2022
    and 5.19 respectively.
  - Updated the copyright end-date to 2022 for the secure update driver.
  - Change m10bmc to cardbmc to reflect the fact that the future devices
    will not necessarily use the MAX10. This affects filenames, configs, and
    symbol names.
  - Removed references to the FPGA Image Load class driver and replaced
    them with the new firmware-upload service from the firmware loader.
  - Firmware upload requires a unique name for the firmware device. Use
    xarray_alloc to generate a unique number to append to the name.
  - Changed the license from GPL to GPLv2 per commit bf7fbeeae6db: 'module:
    Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity'
v16:
  - No Change
v15:
  - Updated the Dates and KernelVersions in the ABI documentation
  - Change driver name from "n3000bmc-secure" to "n3000bmc-sec-update".
  - Change CONFIG_FPGA_M10_BMC_SECURE to CONFIG_FPGA_M10_BMC_SEC_UPDATE.
  - Change instances of *bmc-secure to *bmc-sec-update in file name
    and symbol names.
  - Change instances of *m10bmc_secure* to *m10bmc-sec_update* in symbol
    names.
  - Change instances of *lops* to *ops* in symbol names.
v14:
  - Changed symbol and text references to reflect the renaming of the
    Security Manager Class driver to FPGA Image Load.
v13:
  - Updated copyright to 2021
  - Updated ABI documentation date and kernel version
  - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
    functions instead of devm_fpga_sec_mgr_create() and
    devm_fpga_sec_mgr_register().
v12:
  - Updated Date and KernelVersion fields in ABI documentation
v11:
  - Added Reviewed-by tag
v10:
  - Changed the path expressions in the sysfs documentation to
    replace the n3000 reference with something more generic to
    accomodate other devices that use the same driver.
v9:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v8:
  - Previously patch 2/6, otherwise no change
v7:
  - Updated Date and KernelVersion in ABI documentation
v6:
  - Added WARN_ON() call for (sha_num_bytes / stride) to assert
    that the proper count is passed to regmap_bulk_read().
v5:
  - No change
v4:
  - Moved sysfs files for displaying the root entry hashes (REH)
    from the FPGA Security Manager class driver to here. The
    m10bmc_reh() and m10bmc_reh_size() functions are removed and
    the functionality from these functions is moved into a
    show_root_entry_hash() function for displaying the REHs.
  - Added ABI documentation for the new sysfs entries:
    sysfs-driver-intel-m10-bmc-secure
  - Updated the MAINTAINERS file to add the new ABI documentation
    file: sysfs-driver-intel-m10-bmc-secure
  - Removed unnecessary ret variable from m10bmc_secure_probe()
  - Incorporated new devm_fpga_sec_mgr_register() function into
    m10bmc_secure_probe() and removed the m10bmc_secure_remove()
    function.
v3:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
    Update driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
  - Changed "_root_entry_hash" to "_reh", with a comment explaining
    what reh is.
v2:
  - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
  - Switched to GENMASK(31, 16) for a couple of mask definitions.
  - Moved MAX10 BMC address and function definitions to a separate
    patch.
  - Replaced small function-creation macros with explicit function
    declarations.
  - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
  - Adapted to changes in the Intel FPGA Security Manager by splitting
    the single call to ifpga_sec_mgr_register() into two function
    calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
---
 .../sysfs-driver-intel-m10-bmc-sec-update     |  29 ++++
 MAINTAINERS                                   |   7 +
 drivers/fpga/Kconfig                          |  12 ++
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/intel-m10-bmc-sec-update.c       | 134 ++++++++++++++++++
 5 files changed, 185 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
 create mode 100644 drivers/fpga/intel-m10-bmc-sec-update.c

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
new file mode 100644
index 000000000000..a208367e6956
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
@@ -0,0 +1,29 @@
+What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_root_entry_hash
+Date:		Sep 2022
+KernelVersion:	5.20
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the root entry hash for the static
+		region if one is programmed, else it returns the
+		string: "hash not programmed".  This file is only
+		visible if the underlying device supports it.
+		Format: string.
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_root_entry_hash
+Date:		Sep 2022
+KernelVersion:	5.20
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the root entry hash for the partial
+		reconfiguration region if one is programmed, else it
+		returns the string: "hash not programmed".  This file
+		is only visible if the underlying device supports it.
+		Format: string.
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_root_entry_hash
+Date:		Sep 2022
+KernelVersion:	5.20
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the root entry hash for the BMC image
+		if one is programmed, else it returns the string:
+		"hash not programmed".  This file is only visible if the
+		underlying device supports it.
+		Format: string.
diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..8f270acf0844 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7807,6 +7807,13 @@ F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
 
+INTEL MAX10 BMC SECURE UPDATES
+M:	Russ Weight <russell.h.weight@intel.com>
+L:	linux-fpga@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
+F:	drivers/fpga/intel-m10-bmc-sec-update.c
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 991b3f361ec9..0831eecc9a09 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -243,4 +243,16 @@ config FPGA_MGR_VERSAL_FPGA
 	  configure the programmable logic(PL).
 
 	  To compile this as a module, choose M here.
+
+config FPGA_M10_BMC_SEC_UPDATE
+	tristate "Intel MAX10 BMC Secure Update driver"
+	depends on MFD_INTEL_M10_BMC && FW_UPLOAD
+	help
+	  Secure update support for the Intel MAX10 board management
+	  controller.
+
+	  This is a subdriver of the Intel MAX10 board management controller
+	  (BMC) and provides support for secure updates for the BMC image,
+	  the FPGA image, the Root Entry Hashes, etc.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 5935b3d0abd5..139ac1b573d3 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -22,6 +22,9 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
 
+# FPGA Secure Update Drivers
+obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
+
 # FPGA Bridge Drivers
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
new file mode 100644
index 000000000000..f9f39d2cfe5b
--- /dev/null
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel MAX10 Board Management Controller Secure Update Driver
+ *
+ * Copyright (C) 2019-2022 Intel Corporation. All rights reserved.
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct m10bmc_sec {
+	struct device *dev;
+	struct intel_m10bmc *m10bmc;
+};
+
+/* Root Entry Hash (REH) support */
+#define REH_SHA256_SIZE		32
+#define REH_SHA384_SIZE		48
+#define REH_MAGIC		GENMASK(15, 0)
+#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
+
+static ssize_t
+show_root_entry_hash(struct device *dev, u32 exp_magic,
+		     u32 prog_addr, u32 reh_addr, char *buf)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	int sha_num_bytes, i, ret, cnt = 0;
+	u8 hash[REH_SHA384_SIZE];
+	unsigned int stride;
+	u32 magic;
+
+	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
+		return sysfs_emit(buf, "hash not programmed\n");
+
+	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
+	if ((sha_num_bytes % stride) ||
+	    (sha_num_bytes != REH_SHA256_SIZE &&
+	     sha_num_bytes != REH_SHA384_SIZE))   {
+		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
+			sha_num_bytes);
+		return -EINVAL;
+	}
+
+	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
+			       hash, sha_num_bytes / stride);
+	if (ret) {
+		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
+			reh_addr, sha_num_bytes / stride, ret);
+		return ret;
+	}
+
+	for (i = 0; i < sha_num_bytes; i++)
+		cnt += sprintf(buf + cnt, "%02x", hash[i]);
+	cnt += sprintf(buf + cnt, "\n");
+
+	return cnt;
+}
+
+#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
+static ssize_t _name##_root_entry_hash_show(struct device *dev, \
+					    struct device_attribute *attr, \
+					    char *buf) \
+{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
+static DEVICE_ATTR_RO(_name##_root_entry_hash)
+
+DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
+DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
+DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
+
+static struct attribute *m10bmc_security_attrs[] = {
+	&dev_attr_bmc_root_entry_hash.attr,
+	&dev_attr_sr_root_entry_hash.attr,
+	&dev_attr_pr_root_entry_hash.attr,
+	NULL,
+};
+
+static struct attribute_group m10bmc_security_attr_group = {
+	.name = "security",
+	.attrs = m10bmc_security_attrs,
+};
+
+static const struct attribute_group *m10bmc_sec_attr_groups[] = {
+	&m10bmc_security_attr_group,
+	NULL,
+};
+
+#define SEC_UPDATE_LEN_MAX 32
+static int m10bmc_sec_probe(struct platform_device *pdev)
+{
+	struct m10bmc_sec *sec;
+
+	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return -ENOMEM;
+
+	sec->dev = &pdev->dev;
+	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
+	dev_set_drvdata(&pdev->dev, sec);
+
+	return 0;
+}
+
+static const struct platform_device_id intel_m10bmc_sec_ids[] = {
+	{
+		.name = "n3000bmc-sec-update",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
+
+static struct platform_driver intel_m10bmc_sec_driver = {
+	.probe = m10bmc_sec_probe,
+	.driver = {
+		.name = "intel-m10bmc-sec-update",
+		.dev_groups = m10bmc_sec_attr_groups,
+	},
+	.id_table = intel_m10bmc_sec_ids,
+};
+module_platform_driver(intel_m10bmc_sec_driver);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
+MODULE_LICENSE("GPL");
-- 
2.25.1

