Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D444ACDBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbiBHBLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344279AbiBHAyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:54:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF8EC061A73;
        Mon,  7 Feb 2022 16:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281687; x=1675817687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FKZpxN94keCG8q9Xl8fDpZlA96f3DeEIZGUBglYWAiY=;
  b=n7F4lIzpBLAUvp+cyS4yoXv/6hGUPfm6jtaaydppxsRgavlW30BtUWQR
   WZCBQl9utHsUUv/rNFYCVJ2fryDdAW7JmHkSJj3oA73J5AZNxNdwD/pb4
   QMm9zmHYJutMPWDOePg1FdbArt2/VeZP2rzoPrlOQONdpszjc6/fywwtx
   QCZJnaLX5LDYwsv/PXeSkGLP6tdBJKbi+wmFgcjQJwIH1NBq4riWhLwBF
   wtUfSh+PZRCpLYWa2NdP/y8qQfctBoPcibSYMfvIMzrno9k9lJD0IhyeL
   IqVIoG9i30oC/K1w2eV6cD2e285rbpSzUi1gbNxuiRscfAS55HTjbrffk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="249051630"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="249051630"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="585018501"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2022 16:54:46 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.183.65])
        by linux.intel.com (Postfix) with ESMTP id 9389A58094D;
        Mon,  7 Feb 2022 16:54:46 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH V6 1/3] platform/x86: Add Intel Software Defined Silicon driver
Date:   Mon,  7 Feb 2022 16:54:42 -0800
Message-Id: <20220208005444.487209-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208005444.487209-1-david.e.box@linux.intel.com>
References: <20220208005444.487209-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
activating additional silicon features. Features are enabled through a
license activation process.  The SDSi driver provides a per socket, sysfs
attribute interface for applications to perform 3 main provisioning
functions:

1. Provision an Authentication Key Certificate (AKC), a key written to
   internal NVRAM that is used to authenticate a capability specific
   activation payload.

2. Provision a Capability Activation Payload (CAP), a token authenticated
   using the AKC and applied to the CPU configuration to activate a new
   feature.

3. Read the SDSi State Certificate, containing the CPU configuration
   state.

The operations perform function specific mailbox commands that forward the
requests to SDSi hardware to perform authentication of the payloads and
enable the silicon configuration (to be made available after power
cycling).

The SDSi device itself is enumerated as an auxiliary device from the
intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.

Link: https://github.com/intel/intel-sdsi
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Mark Gross <markgross@kernel.org>
---
V6
  - Replace,
              return (ret < 0) ? ret : size;
    with,
              if (ret)
                   return ret;
              return size

    Besides the style change (suggested by GKH) this fixes a klocwork
    warning.

V5
  - Update kernel version to 5.18 in API doc and copyrights to 2022.
  - Remove unneeded prototypes.
  - In binary attribute handlers where ret is only used for errors,
    replace,
              return (ret < 0) ? ret : size;
    with,
              return ret ?: size;

V4
  - Replace dropped semicolon on sdsi_aux_driver struct.
V3
  - In state_certificate_read(), return the actual size instead of the
    requested count. Return 0 if offset is non-zero so that subsequent
    calls attempting to read the rest of the count end.
  - s/folder/directory in ABI documentation.
  - Add comment that all driver resources are devm managed so remove()
    is not needed.
V2
  - Use sysfs_emit() in guid_show()
  - Fix language in ABI, suggested by Bjorn
  - Fix wrong directory name in ABI doc

 .../ABI/testing/sysfs-driver-intel_sdsi       |  77 +++
 MAINTAINERS                                   |   5 +
 drivers/platform/x86/intel/Kconfig            |  12 +
 drivers/platform/x86/intel/Makefile           |   2 +
 drivers/platform/x86/intel/sdsi.c             | 574 ++++++++++++++++++
 drivers/platform/x86/intel/vsec.c             |  12 +-
 6 files changed, 681 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
 create mode 100644 drivers/platform/x86/intel/sdsi.c

diff --git a/Documentation/ABI/testing/sysfs-driver-intel_sdsi b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
new file mode 100644
index 000000000000..ab122125ff9a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
@@ -0,0 +1,77 @@
+What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	"David E. Box" <david.e.box@linux.intel.com>
+Description:
+		This directory contains interface files for accessing Intel
+		Software Defined Silicon (SDSi) features on a CPU. X
+		represents the socket instance (though not the socket ID).
+		The socket ID is determined by reading the registers file
+		and decoding it per the specification.
+
+		Some files communicate with SDSi hardware through a mailbox.
+		Should the operation fail, one of the following error codes
+		may be returned:
+
+		Error Code	Cause
+	        ----------	-----
+	        EIO		General mailbox failure. Log may indicate cause.
+	        EBUSY		Mailbox is owned by another agent.
+	        EPERM		SDSI capability is not enabled in hardware.
+	        EPROTO		Failure in mailbox protocol detected by driver.
+				See log for details.
+	        EOVERFLOW	For provision commands, the size of the data
+				exceeds what may be written.
+	        ESPIPE		Seeking is not allowed.
+	        ETIMEDOUT	Failure to complete mailbox transaction in time.
+
+What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/guid
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	"David E. Box" <david.e.box@linux.intel.com>
+Description:
+		(RO) The GUID for the registers file. The GUID identifies
+		the layout of the registers file in this directory.
+		Information about the register layouts for a particular GUID
+		is available at http://github.com/intel/intel-sdsi
+
+What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/registers
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	"David E. Box" <david.e.box@linux.intel.com>
+Description:
+		(RO) Contains information needed by applications to provision
+		a CPU and monitor status information. The layout of this file
+		is determined by the GUID in this directory. Information about
+		the layout for a particular GUID is available at
+		http://github.com/intel/intel-sdsi
+
+What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/provision_akc
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	"David E. Box" <david.e.box@linux.intel.com>
+Description:
+		(WO) Used to write an Authentication Key Certificate (AKC) to
+		the SDSi NVRAM for the CPU. The AKC is used to authenticate a
+		Capability Activation Payload. Mailbox command.
+
+What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/provision_cap
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	"David E. Box" <david.e.box@linux.intel.com>
+Description:
+		(WO) Used to write a Capability Activation Payload (CAP) to the
+		SDSi NVRAM for the CPU. CAPs are used to activate a given CPU
+		feature. A CAP is validated by SDSi hardware using a previously
+		provisioned AKC file. Upon successful authentication, the CPU
+		configuration is updated. A cold reboot is required to fully
+		activate the feature. Mailbox command.
+
+What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/state_certificate
+Date:		Feb 2022
+KernelVersion:	5.18
+Contact:	"David E. Box" <david.e.box@linux.intel.com>
+Description:
+		(RO) Used to read back the current State Certificate for the CPU
+		from SDSi hardware. The State Certificate contains information
+		about the current licenses on the CPU. Mailbox command.
diff --git a/MAINTAINERS b/MAINTAINERS
index 69a2935daf6c..29d0945f5a63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9869,6 +9869,11 @@ S:	Maintained
 F:	arch/x86/include/asm/intel_scu_ipc.h
 F:	drivers/platform/x86/intel_scu_*
 
+INTEL SDSI DRIVER
+M:	David E. Box <david.e.box@linux.intel.com>
+S:	Supported
+F:	drivers/platform/x86/intel/sdsi.c
+
 INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
 M:	Daniel Scally <djrscally@gmail.com>
 S:	Maintained
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 8e65086bb6c8..99c8834ec979 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -134,6 +134,18 @@ config INTEL_RST
 	  firmware will copy the memory contents back to RAM and resume the OS
 	  as usual.
 
+config INTEL_SDSI
+	tristate "Intel Software Defined Silicon Driver"
+	depends on INTEL_VSEC
+	depends on X86_64
+	help
+	  This driver enables access to the Intel Software Defined Silicon
+	  interface used to provision silicon features with an authentication
+	  certificate and capability license.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_sdsi.
+
 config INTEL_SMARTCONNECT
 	tristate "Intel Smart Connect disabling driver"
 	depends on ACPI
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 35f2066578b2..a765d60b6002 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -26,6 +26,8 @@ intel_int0002_vgpio-y			:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 intel_oaktrail-y			:= oaktrail.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
+intel_sdsi-y				:= sdsi.o
+obj-$(CONFIG_INTEL_SDSI)		+= intel_sdsi.o
 intel_vsec-y				:= vsec.o
 obj-$(CONFIG_INTEL_VSEC)		+= intel_vsec.o
 
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
new file mode 100644
index 000000000000..b1569738e4a3
--- /dev/null
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Software Defined Silicon driver
+ *
+ * Copyright (c) 2022, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Author: "David E. Box" <david.e.box@linux.intel.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#include "vsec.h"
+
+#define ACCESS_TYPE_BARID		2
+#define ACCESS_TYPE_LOCAL		3
+
+#define SDSI_MIN_SIZE_DWORDS		276
+#define SDSI_SIZE_CONTROL		8
+#define SDSI_SIZE_MAILBOX		1024
+#define SDSI_SIZE_REGS			72
+#define SDSI_SIZE_CMD			sizeof(u64)
+
+/*
+ * Write messages are currently up to the size of the mailbox
+ * while read messages are up to 4 times the size of the
+ * mailbox, sent in packets
+ */
+#define SDSI_SIZE_WRITE_MSG		SDSI_SIZE_MAILBOX
+#define SDSI_SIZE_READ_MSG		(SDSI_SIZE_MAILBOX * 4)
+
+#define SDSI_ENABLED_FEATURES_OFFSET	16
+#define SDSI_ENABLED			BIT(3)
+#define SDSI_SOCKET_ID_OFFSET		64
+#define SDSI_SOCKET_ID			GENMASK(3, 0)
+
+#define SDSI_MBOX_CMD_SUCCESS		0x40
+#define SDSI_MBOX_CMD_TIMEOUT		0x80
+
+#define MBOX_TIMEOUT_US			2000
+#define MBOX_TIMEOUT_ACQUIRE_US		1000
+#define MBOX_POLLING_PERIOD_US		100
+#define MBOX_MAX_PACKETS		4
+
+#define MBOX_OWNER_NONE			0x00
+#define MBOX_OWNER_INBAND		0x01
+
+#define CTRL_RUN_BUSY			BIT(0)
+#define CTRL_READ_WRITE			BIT(1)
+#define CTRL_SOM			BIT(2)
+#define CTRL_EOM			BIT(3)
+#define CTRL_OWNER			GENMASK(5, 4)
+#define CTRL_COMPLETE			BIT(6)
+#define CTRL_READY			BIT(7)
+#define CTRL_STATUS			GENMASK(15, 8)
+#define CTRL_PACKET_SIZE		GENMASK(31, 16)
+#define CTRL_MSG_SIZE			GENMASK(63, 48)
+
+#define DISC_TABLE_SIZE			12
+#define DT_ACCESS_TYPE			GENMASK(3, 0)
+#define DT_SIZE				GENMASK(27, 12)
+#define DT_TBIR				GENMASK(2, 0)
+#define DT_OFFSET(v)			((v) & GENMASK(31, 3))
+
+enum sdsi_command {
+	SDSI_CMD_PROVISION_AKC		= 0x04,
+	SDSI_CMD_PROVISION_CAP		= 0x08,
+	SDSI_CMD_READ_STATE		= 0x10,
+};
+
+struct sdsi_mbox_info {
+	u64	*payload;
+	u64	*buffer;
+	int	size;
+};
+
+struct disc_table {
+	u32	access_info;
+	u32	guid;
+	u32	offset;
+};
+
+struct sdsi_priv {
+	struct mutex		mb_lock;	/* Mailbox access lock */
+	struct device		*dev;
+	void __iomem		*control_addr;
+	void __iomem		*mbox_addr;
+	void __iomem		*regs_addr;
+	u32			guid;
+	bool			sdsi_enabled;
+};
+
+/* SDSi mailbox operations must be performed using 64bit mov instructions */
+static __always_inline void
+sdsi_memcpy64_toio(u64 __iomem *to, const u64 *from, size_t count_bytes)
+{
+	size_t count = count_bytes / sizeof(*to);
+	int i;
+
+	for (i = 0; i < count; i++)
+		writeq(from[i], &to[i]);
+}
+
+static __always_inline void
+sdsi_memcpy64_fromio(u64 *to, const u64 __iomem *from, size_t count_bytes)
+{
+	size_t count = count_bytes / sizeof(*to);
+	int i;
+
+	for (i = 0; i < count; i++)
+		to[i] = readq(&from[i]);
+}
+
+static inline void sdsi_complete_transaction(struct sdsi_priv *priv)
+{
+	u64 control = FIELD_PREP(CTRL_COMPLETE, 1);
+
+	lockdep_assert_held(&priv->mb_lock);
+	writeq(control, priv->control_addr);
+}
+
+static int sdsi_status_to_errno(u32 status)
+{
+	switch (status) {
+	case SDSI_MBOX_CMD_SUCCESS:
+		return 0;
+	case SDSI_MBOX_CMD_TIMEOUT:
+		return -ETIMEDOUT;
+	default:
+		return -EIO;
+	}
+}
+
+static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			      size_t *data_size)
+{
+	struct device *dev = priv->dev;
+	u32 total, loop, eom, status, message_size;
+	u64 control;
+	int ret;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	/* Format and send the read command */
+	control = FIELD_PREP(CTRL_EOM, 1) |
+		  FIELD_PREP(CTRL_SOM, 1) |
+		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+	writeq(control, priv->control_addr);
+
+	/* For reads, data sizes that are larger than the mailbox size are read in packets. */
+	total = 0;
+	loop = 0;
+	do {
+		int offset = SDSI_SIZE_MAILBOX * loop;
+		void __iomem *addr = priv->mbox_addr + offset;
+		u64 *buf = info->buffer + offset / SDSI_SIZE_CMD;
+		u32 packet_size;
+
+		/* Poll on ready bit */
+		ret = readq_poll_timeout(priv->control_addr, control, control & CTRL_READY,
+					 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_US);
+		if (ret)
+			break;
+
+		eom = FIELD_GET(CTRL_EOM, control);
+		status = FIELD_GET(CTRL_STATUS, control);
+		packet_size = FIELD_GET(CTRL_PACKET_SIZE, control);
+		message_size = FIELD_GET(CTRL_MSG_SIZE, control);
+
+		ret = sdsi_status_to_errno(status);
+		if (ret)
+			break;
+
+		/* Only the last packet can be less than the mailbox size. */
+		if (!eom && packet_size != SDSI_SIZE_MAILBOX) {
+			dev_err(dev, "Invalid packet size\n");
+			ret = -EPROTO;
+			break;
+		}
+
+		if (packet_size > SDSI_SIZE_MAILBOX) {
+			dev_err(dev, "Packet size to large\n");
+			ret = -EPROTO;
+			break;
+		}
+
+		sdsi_memcpy64_fromio(buf, addr, round_up(packet_size, SDSI_SIZE_CMD));
+
+		total += packet_size;
+
+		sdsi_complete_transaction(priv);
+	} while (!eom && ++loop < MBOX_MAX_PACKETS);
+
+	if (ret) {
+		sdsi_complete_transaction(priv);
+		return ret;
+	}
+
+	if (!eom) {
+		dev_err(dev, "Exceeded read attempts\n");
+		return -EPROTO;
+	}
+
+	/* Message size check is only valid for multi-packet transfers */
+	if (loop && total != message_size)
+		dev_warn(dev, "Read count %d differs from expected count %d\n",
+			 total, message_size);
+
+	*data_size = total;
+
+	return 0;
+}
+
+static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+{
+	u64 control;
+	u32 status;
+	int ret;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	/* Write rest of the payload */
+	sdsi_memcpy64_toio(priv->mbox_addr + SDSI_SIZE_CMD, info->payload + 1,
+			   info->size - SDSI_SIZE_CMD);
+
+	/* Format and send the write command */
+	control = FIELD_PREP(CTRL_EOM, 1) |
+		  FIELD_PREP(CTRL_SOM, 1) |
+		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
+		  FIELD_PREP(CTRL_READ_WRITE, 1) |
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+	writeq(control, priv->control_addr);
+
+	/* Poll on run_busy bit */
+	ret = readq_poll_timeout(priv->control_addr, control, !(control & CTRL_RUN_BUSY),
+				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_US);
+
+	if (ret)
+		goto release_mbox;
+
+	status = FIELD_GET(CTRL_STATUS, control);
+	ret = sdsi_status_to_errno(status);
+
+release_mbox:
+	sdsi_complete_transaction(priv);
+
+	return ret;
+}
+
+static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+{
+	u64 control;
+	u32 owner;
+	int ret;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	/* Check mailbox is available */
+	control = readq(priv->control_addr);
+	owner = FIELD_GET(CTRL_OWNER, control);
+	if (owner != MBOX_OWNER_NONE)
+		return -EBUSY;
+
+	/* Write first qword of payload */
+	writeq(info->payload[0], priv->mbox_addr);
+
+	/* Check for ownership */
+	ret = readq_poll_timeout(priv->control_addr, control,
+				 FIELD_GET(CTRL_OWNER, control) & MBOX_OWNER_INBAND,
+				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_ACQUIRE_US);
+
+	return ret;
+}
+
+static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+{
+	int ret;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	ret = sdsi_mbox_acquire(priv, info);
+	if (ret)
+		return ret;
+
+	return sdsi_mbox_cmd_write(priv, info);
+}
+
+static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, size_t *data_size)
+{
+	int ret;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	ret = sdsi_mbox_acquire(priv, info);
+	if (ret)
+		return ret;
+
+	return sdsi_mbox_cmd_read(priv, info, data_size);
+}
+
+static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
+			      enum sdsi_command command)
+{
+	struct sdsi_mbox_info info;
+	int ret;
+
+	if (!priv->sdsi_enabled)
+		return -EPERM;
+
+	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
+		return -EOVERFLOW;
+
+	/* Qword aligned message + command qword */
+	info.size = round_up(count, SDSI_SIZE_CMD) + SDSI_SIZE_CMD;
+
+	info.payload = kzalloc(info.size, GFP_KERNEL);
+	if (!info.payload)
+		return -ENOMEM;
+
+	/* Copy message to payload buffer */
+	memcpy(info.payload, buf, count);
+
+	/* Command is last qword of payload buffer */
+	info.payload[(info.size - SDSI_SIZE_CMD) / SDSI_SIZE_CMD] = command;
+
+	ret = mutex_lock_interruptible(&priv->mb_lock);
+	if (ret)
+		goto free_payload;
+	ret = sdsi_mbox_write(priv, &info);
+	mutex_unlock(&priv->mb_lock);
+
+free_payload:
+	kfree(info.payload);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t provision_akc_write(struct file *filp, struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf, loff_t off,
+				   size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+
+	if (off)
+		return -ESPIPE;
+
+	return sdsi_provision(priv, buf, count, SDSI_CMD_PROVISION_AKC);
+}
+static BIN_ATTR_WO(provision_akc, SDSI_SIZE_WRITE_MSG);
+
+static ssize_t provision_cap_write(struct file *filp, struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf, loff_t off,
+				   size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+
+	if (off)
+		return -ESPIPE;
+
+	return sdsi_provision(priv, buf, count, SDSI_CMD_PROVISION_CAP);
+}
+static BIN_ATTR_WO(provision_cap, SDSI_SIZE_WRITE_MSG);
+
+static long state_certificate_read(struct file *filp, struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf, loff_t off,
+				   size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+	u64 command = SDSI_CMD_READ_STATE;
+	struct sdsi_mbox_info info;
+	size_t size;
+	int ret;
+
+	if (!priv->sdsi_enabled)
+		return -EPERM;
+
+	if (off)
+		return 0;
+
+	/* Buffer for return data */
+	info.buffer = kmalloc(SDSI_SIZE_READ_MSG, GFP_KERNEL);
+	if (!info.buffer)
+		return -ENOMEM;
+
+	info.payload = &command;
+	info.size = sizeof(command);
+
+	ret = mutex_lock_interruptible(&priv->mb_lock);
+	if (ret)
+		goto free_buffer;
+	ret = sdsi_mbox_read(priv, &info, &size);
+	mutex_unlock(&priv->mb_lock);
+	if (ret < 0)
+		goto free_buffer;
+
+	if (size > count)
+		size = count;
+
+	memcpy(buf, info.buffer, size);
+
+free_buffer:
+	kfree(info.buffer);
+
+	if (ret)
+		return ret;
+
+	return size;
+}
+static BIN_ATTR(state_certificate, 0400, state_certificate_read, NULL, SDSI_SIZE_READ_MSG);
+
+static ssize_t registers_read(struct file *filp, struct kobject *kobj,
+			      struct bin_attribute *attr, char *buf, loff_t off,
+			      size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+	void __iomem *addr = priv->regs_addr;
+
+	memcpy_fromio(buf, addr + off, count);
+
+	return count;
+}
+static BIN_ATTR(registers, 0400, registers_read, NULL, SDSI_SIZE_REGS);
+
+static struct bin_attribute *sdsi_bin_attrs[] = {
+	&bin_attr_registers,
+	&bin_attr_state_certificate,
+	&bin_attr_provision_akc,
+	&bin_attr_provision_cap,
+	NULL
+};
+
+static ssize_t guid_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "0x%x\n", priv->guid);
+}
+static DEVICE_ATTR_RO(guid);
+
+static struct attribute *sdsi_attrs[] = {
+	&dev_attr_guid.attr,
+	NULL
+};
+
+static const struct attribute_group sdsi_group = {
+	.attrs = sdsi_attrs,
+	.bin_attrs = sdsi_bin_attrs,
+};
+__ATTRIBUTE_GROUPS(sdsi);
+
+static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *parent,
+				   struct disc_table *disc_table, struct resource *disc_res)
+{
+	u32 access_type = FIELD_GET(DT_ACCESS_TYPE, disc_table->access_info);
+	u32 size = FIELD_GET(DT_SIZE, disc_table->access_info);
+	u32 tbir = FIELD_GET(DT_TBIR, disc_table->offset);
+	u32 offset = DT_OFFSET(disc_table->offset);
+	u32 features_offset;
+	struct resource res = {};
+
+	/* Starting location of SDSi MMIO region based on access type */
+	switch (access_type) {
+	case ACCESS_TYPE_LOCAL:
+		if (tbir) {
+			dev_err(priv->dev, "Unsupported BAR index %d for access type %d\n",
+				tbir, access_type);
+			return -EINVAL;
+		}
+
+		/*
+		 * For access_type LOCAL, the base address is as follows:
+		 * base address = end of discovery region + base offset + 1
+		 */
+		res.start = disc_res->end + offset + 1;
+		break;
+
+	case ACCESS_TYPE_BARID:
+		res.start = pci_resource_start(parent, tbir) + offset;
+		break;
+
+	default:
+		dev_err(priv->dev, "Unrecognized access_type %d\n", access_type);
+		return -EINVAL;
+	}
+
+	res.end = res.start + size * sizeof(u32) - 1;
+	res.flags = IORESOURCE_MEM;
+
+	priv->control_addr = devm_ioremap_resource(priv->dev, &res);
+	if (IS_ERR(priv->control_addr))
+		return PTR_ERR(priv->control_addr);
+
+	priv->mbox_addr = priv->control_addr + SDSI_SIZE_CONTROL;
+	priv->regs_addr = priv->mbox_addr + SDSI_SIZE_MAILBOX;
+
+	features_offset = readq(priv->regs_addr + SDSI_ENABLED_FEATURES_OFFSET);
+	priv->sdsi_enabled = !!(features_offset & SDSI_ENABLED);
+
+	return 0;
+}
+
+static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
+{
+	struct intel_vsec_device *intel_cap_dev = auxdev_to_ivdev(auxdev);
+	struct disc_table disc_table;
+	struct resource *disc_res;
+	void __iomem *disc_addr;
+	struct sdsi_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&auxdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &auxdev->dev;
+	mutex_init(&priv->mb_lock);
+	auxiliary_set_drvdata(auxdev, priv);
+
+	/* Get the SDSi discovery table */
+	disc_res = &intel_cap_dev->resource[0];
+	disc_addr = devm_ioremap_resource(&auxdev->dev, disc_res);
+	if (IS_ERR(disc_addr))
+		return PTR_ERR(disc_addr);
+
+	memcpy_fromio(&disc_table, disc_addr, DISC_TABLE_SIZE);
+
+	priv->guid = disc_table.guid;
+
+	/* Map the SDSi mailbox registers */
+	ret = sdsi_map_mbox_registers(priv, intel_cap_dev->pcidev, &disc_table, disc_res);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct auxiliary_device_id sdsi_aux_id_table[] = {
+	{ .name = "intel_vsec.sdsi" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, sdsi_aux_id_table);
+
+static struct auxiliary_driver sdsi_aux_driver = {
+	.driver = {
+		.dev_groups = sdsi_groups,
+	},
+	.id_table	= sdsi_aux_id_table,
+	.probe		= sdsi_probe,
+	/* No remove. All resources are handled under devm */
+};
+module_auxiliary_driver(sdsi_aux_driver);
+
+MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
+MODULE_DESCRIPTION("Intel Software Defined Silicon driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index c3bdd75ed690..bed436bf181f 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -32,6 +32,7 @@
 #define TABLE_OFFSET_SHIFT		3
 
 static DEFINE_IDA(intel_vsec_ida);
+static DEFINE_IDA(intel_vsec_sdsi_ida);
 
 /**
  * struct intel_vsec_header - Common fields of Intel VSEC and DVSEC registers.
@@ -63,12 +64,14 @@ enum intel_vsec_id {
 	VSEC_ID_TELEMETRY	= 2,
 	VSEC_ID_WATCHER		= 3,
 	VSEC_ID_CRASHLOG	= 4,
+	VSEC_ID_SDSI		= 65,
 };
 
 static enum intel_vsec_id intel_vsec_allow_list[] = {
 	VSEC_ID_TELEMETRY,
 	VSEC_ID_WATCHER,
 	VSEC_ID_CRASHLOG,
+	VSEC_ID_SDSI,
 };
 
 static const char *intel_vsec_name(enum intel_vsec_id id)
@@ -83,6 +86,9 @@ static const char *intel_vsec_name(enum intel_vsec_id id)
 	case VSEC_ID_CRASHLOG:
 		return "crashlog";
 
+	case VSEC_ID_SDSI:
+		return "sdsi";
+
 	default:
 		return NULL;
 	}
@@ -211,7 +217,11 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	intel_vsec_dev->resource = res;
 	intel_vsec_dev->num_resources = header->num_entries;
 	intel_vsec_dev->quirks = quirks;
-	intel_vsec_dev->ida = &intel_vsec_ida;
+
+	if (header->id == VSEC_ID_SDSI)
+		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
+	else
+		intel_vsec_dev->ida = &intel_vsec_ida;
 
 	return intel_vsec_add_aux(pdev, intel_vsec_dev, intel_vsec_name(header->id));
 }
-- 
2.25.1

