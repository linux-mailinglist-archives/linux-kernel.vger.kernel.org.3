Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF89A4CB6FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiCCGae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiCCGac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:30:32 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08B0167FB0;
        Wed,  2 Mar 2022 22:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646288984; x=1677824984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JxW/cNGiDiuc38M1iDSHugyuC3xEZxjHQYXLYh5sKgg=;
  b=M4xA37NsxT2sOHUamhEDoiu7lnzIN7XbGOYl0foOFNoZwbAq9PbdnJDd
   Bny8HKMYDJ1bmufOSp7PRR5bg4Af2BUlEPKXWv0LDZkmIVVFEQVbjqyI2
   chMtKdd7fmvJkv7kWCSiCdE/gkjKLGR2Pcx1/orRNIYvaBIVUCnrn9a43
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Mar 2022 22:29:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 22:29:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 22:29:43 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 22:29:38 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@codeaurora.org>,
        <vkoul@kernel.org>, <quic_schowdhu@quicinc.com>
Subject: [PATCH V7 2/7] soc: qcom: dcc:Add driver support for Data Capture and Compare unit(DCC)
Date:   Thu, 3 Mar 2022 11:57:20 +0530
Message-ID: <bc8504bdaf24d98762e2dbad7d084ca247380f06.1646285069.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1646285069.git.quic_schowdhu@quicinc.com>
References: <cover.1646285069.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCC is a DMA Engine designed to capture and store data
during system crash or software triggers. The DCC operates
based on user inputs via the sysfs interface. The user gives
addresses as inputs and these addresses are stored in the
dcc sram. In case of a system crash or a manual software
trigger by the user through the debugfs interface,
the dcc captures and stores the values at these addresses.
This patch contains the driver which has all the methods
pertaining to the debugfs interface, auxiliary functions to
support all the four fundamental operations of dcc namely
read, write, read/modify/write and loop. The probe method
here instantiates all the resources necessary for dcc to
operate mainly the dedicated dcc sram where it stores the
values. The DCC driver can be used for debugging purposes
without going for a reboot since it can perform software
triggers as well based on user inputs.

Also added the documentation for debugfs entries and explained
the functionalities of each debugfs file that has been created
for dcc.

The following is the justification of using debugfs interface
over the other alternatives like sysfs/ioctls

i) As can be seen from the debugfs attribute descriptions,
some of the debugfs attribute files here contains multiple
arguments which needs to be accepted from the user. This goes
against the design style of sysfs.

ii) The user input patterns have been made simple and convenient
in this case with the use of debugfs interface as user doesn't
need to shuffle between different files to execute one instruction
as was the case on using other alternatives.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 Documentation/ABI/testing/debugfs-driver-dcc |  124 +++
 drivers/soc/qcom/Kconfig                     |    8 +
 drivers/soc/qcom/Makefile                    |    1 +
 drivers/soc/qcom/dcc.c                       | 1465 ++++++++++++++++++++++++++
 4 files changed, 1598 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
 create mode 100644 drivers/soc/qcom/dcc.c

diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
new file mode 100644
index 0000000..70029ab
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-driver-dcc
@@ -0,0 +1,124 @@
+What:          /sys/kernel/debug/dcc/.../trigger
+Date:          March 2022
+Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This is the debugfs interface for manual software
+		triggers. The user can simply enter a 1 against
+		the debugfs file and enable a manual trigger.
+		Example:
+		echo  1 > /sys/kernel/debug/dcc/.../trigger
+
+What:          /sys/kernel/debug/dcc/.../enable
+Date:          March 2022
+Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This debugfs interface is used for enabling the
+		the dcc hardware. On enabling the dcc, all the
+		addresses entered by the user is written into
+		dcc sram which is read by the dcc hardware on
+		manual or crash induced triggers.
+		Example:
+		echo  0 > /sys/bus/platform/devices/.../enable
+		(disable dcc)
+		echo  1 > /sys/bus/platform/devices/.../enable
+		(enable dcc)
+
+What:          /sys/kernel/debug/dcc/.../config_read
+Date:          March 2022
+Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This stores the addresses of the registers which
+		needs to be read in case of a hardware crash or
+		manual software triggers. The address entered here
+		are considered under read type instruction.
+		Example:
+		echo <1> <2> <3> >/sys/kernel/debug/dcc/../config_read
+		1->Address to be considered for reading the value.
+		2->The word count of the addresses, read n words
+		   starting from address <1>.
+		3->Can be a 1 or 0 which indicates if it is apb or ahb
+		bus respectively.
+
+What:          /sys/kernel/debug/dcc/.../config_write
+Date:          March 2022
+Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This file allows user to write a value to the register
+		address given as argument. The reason for this feature
+		of dcc is that for accessing certain registers it is
+		necessary to set some bits of some other register.
+		Example:
+		echo <1> <2> <3> > /sys/bus/platform/devices/.../config_write
+		1->Address to be considered for writing the value.
+		2->The value that needs to be written at the location.
+		3->Can be a 1 or 0 which indicates if it is apb or ahb
+		bus respectively.
+
+What:          /sys/kernel/debug/dcc/.../config_reset
+Date:          March 2022
+Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This file is used to reset the configuration of
+		a dcc driver to the default configuration. This
+		means that all the previous addresses stored in
+		the driver gets removed and user needs to enter
+		the address values from the start.
+		Example:
+		echo  1 > /sys/bus/platform/devices/.../config_reset
+
+What:          /sys/kernel/debug/dcc/.../config_loop
+Date:		March 2022
+Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This file is used to enter the loop type addresses for
+		dcc. DCC hardware provides feature to loop among multiple
+		addresses. For debugging purposes register values need to
+		be captured repeatedly in a loop. On giving the loop count
+		as n, the value at address will be captured n times in a
+		loop. At most 8 loop addresses can be configured at once.
+		Example:
+		echo <1> <2> <3> > /sys/kernel/debug/dcc/../config_loop
+		1->The loop count, the number of times the value of the
+		   addresses will be captured.
+		2->The address count, total number of addresses to be
+		   entered in this instruction.
+		3->The series of addresses to be entered separated by a
+		   space like <addr1> <addr2>... and so on.
+
+What:          /sys/kernel/debug/dcc/.../config_read_write
+Date:          March 2022
+Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This file is used to read the value of the register
+		and then write the value given as an argument to the
+		register address. The address argument should be given
+		of the form <addr> <mask> <value>.For debugging purposes
+		sometimes we need to first read from a register and then
+		set some values to the register.
+		Example:
+		echo <1> <2> <3> > /sys/kernel/debug/dcc/.../config_read_write
+		1->The address which needs to be considered for read then write.
+		2->The value that needs to be written on the address.
+		3->The mask of the value to be written.
+
+What:		/sys/kernel/debug/dcc/.../ready
+Date:		March 2022
+Contact	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This file is used to check the status of the dcc
+		hardware if it's ready to take the inputs. A 0
+		here indicates dcc is in a ready condition.
+		Example:
+		cat /sys/kernel/debug/dcc/.../ready
+
+What:		/sys/kernel/debug/dcc/.../curr_list
+Date:		March 2022
+Contact:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This attribute is used to enter the linklist to be
+		used while appending addresses. The range of values
+		for this is advertised either by a register or is
+		predefined. Max value for this can be till 8.
+		Example:
+		echo 0 > /sys/kernel/debug/dcc/...curr_list
+
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 79b568f..5101912 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -69,6 +69,14 @@ config QCOM_LLCC
 	  SDM845. This provides interfaces to clients that use the LLCC.
 	  Say yes here to enable LLCC slice driver.

+config QCOM_DCC
+	tristate "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This option enables driver for Data Capture and Compare engine. DCC
+	  driver provides interface to configure DCC block and read back
+	  captured data from DCC's internal SRAM.
+
 config QCOM_KRYO_L2_ACCESSORS
 	bool
 	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index ad675a6..0aaf82b 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_CPR)		+= cpr.o
+obj-$(CONFIG_QCOM_DCC) += dcc.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
new file mode 100644
index 0000000..70452757
--- /dev/null
+++ b/drivers/soc/qcom/dcc.c
@@ -0,0 +1,1465 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#define STATUS_READY_TIMEOUT		5000
+
+#define DCC_SRAM_NODE "dcc_sram"
+
+/* DCC registers */
+#define DCC_HW_INFO			0x04
+#define DCC_LL_NUM_INFO			0x10
+#define DCC_STATUS			0x1C
+#define DCC_LL_LOCK(m)			(0x34 + 0x80 * m)
+#define DCC_LL_CFG(m)			(0x38 + 0x80 * m)
+#define DCC_LL_BASE(m)			(0x3c + 0x80 * m)
+#define DCC_FD_BASE(m)			(0x40 + 0x80 * m)
+#define DCC_LL_TIMEOUT(m)		(0x44 + 0x80 * m)
+#define DCC_LL_INT_ENABLE(m)		(0x4C + 0x80 * m)
+#define DCC_LL_INT_STATUS(m)		(0x50 + 0x80 * m)
+#define DCC_LL_SW_TRIGGER(m)		(0x60 + 0x80 * m)
+#define DCC_LL_BUS_ACCESS_STATUS(m)	(0x64 + 0x80 * m)
+
+#define DCC_MAP_LEVEL1			0x18
+#define DCC_MAP_LEVEL2			0x34
+#define DCC_MAP_LEVEL3			0x4C
+
+#define DCC_MAP_OFFSET1		0x10
+#define DCC_MAP_OFFSET2		0x18
+#define DCC_MAP_OFFSET3		0x1C
+#define DCC_MAP_OFFSET4		0x8
+
+#define DCC_FIX_LOOP_OFFSET		16
+#define DCC_VER_INFO_BIT		9
+
+#define DCC_READ			0
+#define DCC_WRITE			1
+#define DCC_LOOP			2
+#define DCC_READ_WRITE			3
+
+#define MAX_DCC_OFFSET			GENMASK(9, 2)
+#define MAX_DCC_LEN			GENMASK(6, 0)
+#define MAX_LOOP_CNT			GENMASK(7, 0)
+#define MAX_LOOP_ADDR			10
+
+#define DCC_ADDR_DESCRIPTOR		0x00
+#define DCC_ADDR_LIMIT			27
+#define DCC_ADDR_OFF_RANGE		8
+#define DCC_ADDR_RANGE			GENMASK(31, 4)
+#define DCC_LOOP_DESCRIPTOR		BIT(30)
+#define DCC_RD_MOD_WR_DESCRIPTOR	BIT(31)
+#define DCC_LINK_DESCRIPTOR		GENMASK(31, 30)
+#define DCC_STATUS_MASK		GENMASK(1, 0)
+#define DCC_LOCK_MASK                  BIT(0)
+#define DCC_LOOP_OFFSET_MASK		BIT(6)
+#define DCC_TRIGGER_MASK		BIT(9)
+
+#define DCC_READ_IND			0x00
+#define DCC_WRITE_IND			(BIT(28))
+
+#define DCC_AHB_IND			0x00
+#define DCC_APB_IND			BIT(29)
+
+#define DCC_MAX_LINK_LIST		8
+#define DCC_INVALID_LINK_LIST		GENMASK(7, 0)
+
+#define DCC_VER_MASK1			GENMASK(6, 0)
+#define DCC_VER_MASK2			GENMASK(5, 0)
+
+#define DCC_RD_MOD_WR_ADDR             0xC105E
+
+/*DCC debugfs directory*/
+static struct dentry	*dcc_dbg;
+
+enum dcc_descriptor_type {
+	DCC_ADDR_TYPE,
+	DCC_LOOP_TYPE,
+	DCC_READ_WRITE_TYPE,
+	DCC_WRITE_TYPE
+};
+
+struct dcc_config_entry {
+	u32				base;
+	u32				offset;
+	u32				len;
+	u32				index;
+	u32				loop_cnt;
+	u32				write_val;
+	u32				mask;
+	bool				apb_bus;
+	enum dcc_descriptor_type	desc_type;
+	struct list_head		list;
+};
+
+/**
+ * struct dcc_drvdata - configuration information related to a dcc device
+ * @base:	       Base Address of the dcc device
+ * @dev:	       The device attached to the driver data
+ * @mutex:	       Lock to protect access and manipulation of dcc_drvdata
+ * @ram_base:         Base address for the SRAM dedicated for the dcc device
+ * @ram_offset:       Offset to the SRAM dedicated for dcc device
+ * @mem_map_ver:      Memory map version of DCC hardware
+ * @ram_cfg:          Used for address limit calculation for dcc
+ * @ram_start:        Starting address of DCC SRAM
+ * @sram_dev:	       Miscellaneous device equivalent of dcc SRAM
+ * @cfg_head:	       Points to the head of the linked list of addresses
+ * @dbg_dir:	       Points to the debugfs directory created for dcc.
+ * @nr_config:        Stores the number of addresses currently configured for a linkedlist
+ * @nr_link_list:     Total number of linkedlists supported by the DCC configuration
+ * @curr_list:        The index of the current linklist with which the driver is working
+ * @loopoff:          Loop offset bits range for the addresses
+ * @enable:           This contains an array of linkedlist enable flags
+ * @interrupt_disable:Flag to enable/disable interrupts
+ */
+struct dcc_drvdata {
+	void __iomem		*base;
+	struct device		*dev;
+	struct mutex		mutex;
+	void __iomem		*ram_base;
+	size_t			ram_size;
+	size_t			ram_offset;
+	int			mem_map_ver;
+	phys_addr_t		ram_cfg;
+	phys_addr_t		ram_start;
+	struct miscdevice	sram_dev;
+	struct list_head	*cfg_head;
+	struct dentry		*dbg_dir;
+	size_t			*nr_config;
+	size_t			nr_link_list;
+	u8			curr_list;
+	u8			loopoff;
+	bool                    *enable;
+	bool                    interrupt_disable;
+};
+
+struct dcc_cfg_attr {
+	u32	addr;
+	u32	prev_addr;
+	u32	prev_off;
+	u32	link;
+	u32	sram_offset;
+};
+
+struct dcc_cfg_loop_attr {
+	u32	loop;
+	u32	loop_cnt;
+	u32	loop_len;
+	u32	loop_off;
+	bool    loop_start;
+};
+
+static size_t dcc_offset_conv(struct dcc_drvdata *drvdata, size_t off)
+{
+	/* If the memory map version is 1, adjust the offset based on
+	 * the dcc version mask. If the memory map version is 2
+	 * adjust the offset if the dcc version mask is greater than
+	 * map level 2.For other conditions, just return the offset.
+	 */
+	if (drvdata->mem_map_ver == 1) {
+		if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL3)
+			return off - DCC_MAP_OFFSET3;
+		if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL2)
+			return off - DCC_MAP_OFFSET2;
+		else if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL1)
+			return off - DCC_MAP_OFFSET1;
+	} else if (drvdata->mem_map_ver == 2) {
+		if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL2)
+			return off - DCC_MAP_OFFSET4;
+	}
+
+	return off;
+}
+
+static inline void dcc_writel(struct dcc_drvdata *drvdata,
+					u32 val, u32 off)
+{
+	writel((val), drvdata->base + dcc_offset_conv(drvdata, off));
+}
+
+static inline u32 dcc_readl(struct dcc_drvdata *drvdata, u32 off)
+{
+	return readl(drvdata->base + dcc_offset_conv(drvdata, off));
+}
+
+static void dcc_sram_writel(struct dcc_drvdata *drvdata,
+					u32 val, u32 *off)
+{
+	writel(val, drvdata->ram_base + *off);
+
+	*off += 4;
+}
+
+static int dcc_read_and_clear(struct dcc_drvdata *drvdata)
+{
+	int i;
+	u32 bus_status;
+	u32 ll_cfg;
+	u32 tmp_ll_cfg;
+
+	for (i = 0; i < drvdata->nr_link_list; i++) {
+		if (!drvdata->enable[i])
+			continue;
+
+		bus_status = dcc_readl(drvdata, DCC_LL_BUS_ACCESS_STATUS(i));
+		if (bus_status) {
+			dev_err(drvdata->dev,
+				"Read access error for list %d err: 0x%x.\n",
+					i, bus_status);
+
+			ll_cfg = dcc_readl(drvdata, DCC_LL_CFG(i));
+			tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
+			dcc_writel(drvdata, tmp_ll_cfg, DCC_LL_CFG(i));
+			dcc_writel(drvdata, DCC_STATUS_MASK,
+				DCC_LL_BUS_ACCESS_STATUS(i));
+			dcc_writel(drvdata, ll_cfg, DCC_LL_CFG(i));
+			return -ENODATA;
+		}
+	}
+
+	return 0;
+}
+
+static int dcc_sw_trigger(struct dcc_drvdata *drvdata)
+{
+	int ret;
+	int i;
+	u32 ll_cfg;
+	u32 tmp_ll_cfg;
+	u32 val;
+
+	mutex_lock(&drvdata->mutex);
+
+	for (i = 0; i < drvdata->nr_link_list; i++) {
+		if (!drvdata->enable[i])
+			continue;
+		ll_cfg = dcc_readl(drvdata, DCC_LL_CFG(i));
+		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
+		dcc_writel(drvdata, tmp_ll_cfg, DCC_LL_CFG(i));
+		dcc_writel(drvdata, 1, DCC_LL_SW_TRIGGER(i));
+		dcc_writel(drvdata, ll_cfg, DCC_LL_CFG(i));
+	}
+
+	if (readl_poll_timeout((drvdata->base + dcc_offset_conv(drvdata, DCC_STATUS)),
+	    val, (FIELD_GET(DCC_STATUS_MASK, val) == 0), 1, STATUS_READY_TIMEOUT)) {
+		dev_err(drvdata->dev,
+			"DCC is busy after receiving sw tigger.\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	ret = dcc_read_and_clear(drvdata);
+
+err:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static void _dcc_ll_cfg_reset_link(struct dcc_cfg_attr *cfg)
+{
+	cfg->addr = 0x00;
+	cfg->link = 0;
+	cfg->prev_off = 0;
+	cfg->prev_addr = cfg->addr;
+}
+
+static void _dcc_emit_read_write(struct dcc_drvdata *drvdata,
+				  struct dcc_config_entry *entry,
+				  struct dcc_cfg_attr *cfg)
+{
+	if (cfg->link) {
+		/*
+		 * write new offset = 1 to continue
+		 * processing the list
+		 */
+
+		dcc_sram_writel(drvdata, cfg->link, &cfg->sram_offset);
+
+		/* Reset link and prev_off */
+		_dcc_ll_cfg_reset_link(cfg);
+	}
+
+	cfg->addr = DCC_RD_MOD_WR_DESCRIPTOR;
+	dcc_sram_writel(drvdata, cfg->addr, &cfg->sram_offset);
+
+	dcc_sram_writel(drvdata, entry->mask, &cfg->sram_offset);
+
+	dcc_sram_writel(drvdata, entry->write_val, &cfg->sram_offset);
+
+	cfg->addr = 0;
+}
+
+static void _dcc_emit_loop(struct dcc_drvdata *drvdata, struct dcc_config_entry *entry,
+			    struct dcc_cfg_attr *cfg,
+			    struct dcc_cfg_loop_attr *cfg_loop,
+			    u32 *total_len)
+{
+	/* Check if we need to write link of prev entry */
+	if (cfg->link)
+		dcc_sram_writel(drvdata, cfg->link, &cfg->sram_offset);
+
+	if (cfg_loop->loop_start) {
+		cfg_loop->loop = (cfg->sram_offset - cfg_loop->loop_off) / 4;
+		cfg_loop->loop |= (cfg_loop->loop_cnt << drvdata->loopoff) &
+		GENMASK(DCC_ADDR_LIMIT, drvdata->loopoff);
+		cfg_loop->loop |= DCC_LOOP_DESCRIPTOR;
+		*total_len += (*total_len - cfg_loop->loop_len) * cfg_loop->loop_cnt;
+
+		dcc_sram_writel(drvdata, cfg_loop->loop, &cfg->sram_offset);
+
+		cfg_loop->loop_start = false;
+		cfg_loop->loop_len = 0;
+		cfg_loop->loop_off = 0;
+	} else {
+		cfg_loop->loop_start = true;
+		cfg_loop->loop_cnt = entry->loop_cnt - 1;
+		cfg_loop->loop_len = *total_len;
+		cfg_loop->loop_off = cfg->sram_offset;
+	}
+
+	/* Reset link and prev_off */
+	_dcc_ll_cfg_reset_link(cfg);
+}
+
+static void _dcc_emit_write(struct dcc_drvdata *drvdata,
+			     struct dcc_config_entry *entry,
+			     struct dcc_cfg_attr *cfg,
+			     u32 *total_len)
+{
+	u32 off;
+
+	if (cfg->link) {
+		/*
+		 * write new offset = 1 to continue
+		 * processing the list
+		 */
+		dcc_sram_writel(drvdata, cfg->link, &cfg->sram_offset);
+
+		/* Reset link and prev_off */
+		cfg->addr = 0x00;
+		cfg->prev_off = 0;
+		cfg->prev_addr = cfg->addr;
+	}
+
+	off = entry->offset/4;
+	/* write new offset-length pair to correct position */
+	cfg->link |= ((off & GENMASK(7, 0)) | BIT(15) | ((entry->len << 8) & GENMASK(14, 8)));
+	cfg->link |= DCC_LINK_DESCRIPTOR;
+
+	/* Address type */
+	cfg->addr = (entry->base >> 4) & GENMASK(DCC_ADDR_LIMIT, 0);
+	if (entry->apb_bus)
+		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_WRITE_IND | DCC_APB_IND;
+	else
+		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_WRITE_IND | DCC_AHB_IND;
+	dcc_sram_writel(drvdata, cfg->addr, &cfg->sram_offset);
+
+	dcc_sram_writel(drvdata, cfg->link, &cfg->sram_offset);
+
+	dcc_sram_writel(drvdata, entry->write_val, &cfg->sram_offset);
+
+	cfg->addr = 0x00;
+	cfg->link = 0;
+}
+
+static int _dcc_emit_read(struct dcc_drvdata *drvdata,
+			       struct dcc_config_entry *entry,
+			       struct dcc_cfg_attr *cfg,
+			       u32 *pos, u32 *total_len)
+{
+	int ret = 0;
+	u32 off;
+	u32 temp_off;
+
+	cfg->addr = (entry->base >> 4) & GENMASK(27, 0);
+
+	if (entry->apb_bus)
+		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_READ_IND | DCC_APB_IND;
+	else
+		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_READ_IND | DCC_AHB_IND;
+
+	off = entry->offset/4;
+
+	*total_len += entry->len * 4;
+
+	if (!cfg->prev_addr || cfg->prev_addr != cfg->addr || cfg->prev_off > off) {
+		/* Check if we need to write prev link entry */
+		if (cfg->link)
+			dcc_sram_writel(drvdata, cfg->link, &cfg->sram_offset);
+		dev_dbg(drvdata->dev, "DCC: sram address 0x%x\n", cfg->sram_offset);
+
+		/* Write address */
+		dcc_sram_writel(drvdata, cfg->addr, &cfg->sram_offset);
+
+		/* Reset link and prev_off */
+		cfg->link = 0;
+		cfg->prev_off = 0;
+	}
+
+	if ((off - cfg->prev_off) > 0xFF || entry->len > MAX_DCC_LEN) {
+		dev_err(drvdata->dev, "DCC: Programming error Base: 0x%x, offset 0x%x\n",
+		entry->base, entry->offset);
+		ret = -EINVAL;
+		return ret;
+	}
+
+	if (cfg->link) {
+		/*
+		 * link already has one offset-length so new
+		 * offset-length needs to be placed at
+		 * bits [29:15]
+		 */
+		*pos = 15;
+
+		/* Clear bits [31:16] */
+		cfg->link &= GENMASK(14, 0);
+	} else {
+		/*
+		 * link is empty, so new offset-length needs
+		 * to be placed at bits [15:0]
+		 */
+		*pos = 0;
+		cfg->link = 1 << 15;
+	}
+
+	/* write new offset-length pair to correct position */
+	temp_off = (off-cfg->prev_off) & GENMASK(7, 0);
+	cfg->link |= temp_off |((entry->len << 8) & GENMASK(14, 8)) << *pos;
+
+	cfg->link |= DCC_LINK_DESCRIPTOR;
+
+	if (*pos) {
+		dcc_sram_writel(drvdata, cfg->link, &cfg->sram_offset);
+		cfg->link = 0;
+	}
+
+	cfg->prev_off  = off + entry->len - 1;
+	cfg->prev_addr = cfg->addr;
+	return ret;
+}
+
+static int __dcc_emit_config(struct dcc_drvdata *drvdata, int curr_list)
+{
+	int ret;
+	u32 total_len, pos;
+	struct dcc_config_entry *entry;
+	struct dcc_cfg_attr cfg;
+	struct dcc_cfg_loop_attr cfg_loop;
+
+	memset(&cfg, 0, sizeof(cfg));
+	memset(&cfg_loop, 0, sizeof(cfg_loop));
+	cfg.sram_offset = drvdata->ram_cfg * 4;
+	total_len = 0;
+
+	list_for_each_entry(entry, &drvdata->cfg_head[curr_list], list) {
+		switch (entry->desc_type) {
+		case DCC_READ_WRITE_TYPE:
+			_dcc_emit_read_write(drvdata, entry, &cfg);
+			break;
+
+		case DCC_LOOP_TYPE:
+			_dcc_emit_loop(drvdata, entry, &cfg, &cfg_loop, &total_len);
+			break;
+
+		case DCC_WRITE_TYPE:
+			_dcc_emit_write(drvdata, entry, &cfg, &total_len);
+			break;
+
+		case DCC_ADDR_TYPE:
+			ret = _dcc_emit_read(drvdata, entry, &cfg, &pos, &total_len);
+			if (ret)
+				goto overstep;
+			break;
+		}
+	}
+
+	if (cfg.link)
+		dcc_sram_writel(drvdata, cfg.link, &cfg.sram_offset);
+
+	if (cfg_loop.loop_start) {
+		dev_err(drvdata->dev, "DCC: Programming error: Loop unterminated\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Handling special case of list ending with a rd_mod_wr */
+	if (cfg.addr == DCC_RD_MOD_WR_DESCRIPTOR) {
+		cfg.addr = (DCC_RD_MOD_WR_ADDR) & GENMASK(27, 0);
+		cfg.addr |= DCC_ADDR_DESCRIPTOR;
+		dcc_sram_writel(drvdata, cfg.addr, &cfg.sram_offset);
+	}
+
+	/* Setting zero to indicate end of the list */
+	cfg.link = DCC_LINK_DESCRIPTOR;
+	dcc_sram_writel(drvdata, cfg.link, &cfg.sram_offset);
+
+	/*Check if sram offset exceeds the ram size*/
+	if (cfg.sram_offset > drvdata->ram_size)
+		goto overstep;
+
+	/* Update ram_cfg and check if the data will overstep */
+	drvdata->ram_cfg = (cfg.sram_offset + total_len) / 4;
+
+	if (cfg.sram_offset + total_len > drvdata->ram_size) {
+		cfg.sram_offset += total_len;
+		goto overstep;
+	}
+
+	drvdata->ram_start = cfg.sram_offset/4;
+	return 0;
+overstep:
+	ret = -EINVAL;
+	memset_io(drvdata->ram_base, 0, drvdata->ram_size);
+
+err:
+	return ret;
+}
+
+static int dcc_valid_list(struct dcc_drvdata *drvdata, int curr_list)
+{
+	u32 lock_reg;
+
+	if (list_empty(&drvdata->cfg_head[curr_list]))
+		return -EINVAL;
+
+	if (drvdata->enable[curr_list]) {
+		dev_err(drvdata->dev, "List %d is already enabled\n",
+				curr_list);
+		return -EINVAL;
+	}
+
+	lock_reg = dcc_readl(drvdata, DCC_LL_LOCK(curr_list));
+	if (lock_reg & 0x1) {
+		dev_err(drvdata->dev, "List %d is already locked\n",
+				curr_list);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool is_dcc_enabled(struct dcc_drvdata *drvdata)
+{
+	bool dcc_enable = false;
+	int list;
+
+	for (list = 0; list < DCC_MAX_LINK_LIST; list++) {
+		if (drvdata->enable[list]) {
+			dcc_enable = true;
+			break;
+		}
+	}
+
+	return dcc_enable;
+}
+
+static int dcc_enable(struct dcc_drvdata *drvdata)
+{
+	int ret;
+	int list;
+	u32 ram_cfg_base;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (!is_dcc_enabled(drvdata)) {
+		memset_io(drvdata->ram_base,
+			0xde, drvdata->ram_size);
+	}
+
+	for (list = 0; list < drvdata->nr_link_list; list++) {
+		if (dcc_valid_list(drvdata, list))
+			continue;
+
+		/* 1. Take ownership of the list */
+		dcc_writel(drvdata, DCC_LOCK_MASK, DCC_LL_LOCK(list));
+
+		/* 2. Program linked-list in the SRAM */
+		ram_cfg_base = drvdata->ram_cfg;
+		ret = __dcc_emit_config(drvdata, list);
+		if (ret) {
+			dcc_writel(drvdata, 0, DCC_LL_LOCK(list));
+			goto err;
+		}
+
+		/* 3. program DCC_RAM_CFG reg */
+		dcc_writel(drvdata, ram_cfg_base +
+			drvdata->ram_offset/4, DCC_LL_BASE(list));
+		dcc_writel(drvdata, drvdata->ram_start +
+			drvdata->ram_offset/4, DCC_FD_BASE(list));
+		dcc_writel(drvdata, 0xFFF, DCC_LL_TIMEOUT(list));
+
+		/* 4. Clears interrupt status register */
+		dcc_writel(drvdata, 0, DCC_LL_INT_ENABLE(list));
+		dcc_writel(drvdata, (BIT(0) | BIT(1) | BIT(2)),
+					DCC_LL_INT_STATUS(list));
+
+		drvdata->enable[list] = true;
+
+		/* 5. Configure trigger */
+		dcc_writel(drvdata, DCC_TRIGGER_MASK, DCC_LL_CFG(list));
+	}
+
+err:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static void dcc_disable(struct dcc_drvdata *drvdata)
+{
+	int curr_list;
+
+	mutex_lock(&drvdata->mutex);
+
+	for (curr_list = 0; curr_list < drvdata->nr_link_list; curr_list++) {
+		if (!drvdata->enable[curr_list])
+			continue;
+		dcc_writel(drvdata, 0, DCC_LL_CFG(curr_list));
+		dcc_writel(drvdata, 0, DCC_LL_BASE(curr_list));
+		dcc_writel(drvdata, 0, DCC_FD_BASE(curr_list));
+		dcc_writel(drvdata, 0, DCC_LL_LOCK(curr_list));
+		drvdata->enable[curr_list] = false;
+	}
+	memset_io(drvdata->ram_base, 0, drvdata->ram_size);
+	drvdata->ram_cfg = 0;
+	drvdata->ram_start = 0;
+	mutex_unlock(&drvdata->mutex);
+}
+
+static ssize_t curr_list_read(struct file *filp, char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	int ret;
+	char buf[20];
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	mutex_lock(&drvdata->mutex);
+	if (drvdata->curr_list == DCC_INVALID_LINK_LIST) {
+		dev_err(drvdata->dev, "curr_list is not set.\n");
+		ret = -EINVAL;
+		return ret;
+	}
+
+	ret = scnprintf(buf, PAGE_SIZE, "%d\n",	drvdata->curr_list);
+	mutex_unlock(&drvdata->mutex);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static ssize_t curr_list_write(struct file *filp,
+				const char __user *user_buf, size_t count,
+				loff_t *ppos)
+{
+	struct dcc_drvdata *drvdata = filp->private_data;
+	int ret;
+	unsigned int val;
+	u32 lock_reg;
+	bool dcc_enable = false;
+
+	ret = kstrtouint_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val >= drvdata->nr_link_list)
+		return -EINVAL;
+
+	mutex_lock(&drvdata->mutex);
+
+	dcc_enable = is_dcc_enabled(drvdata);
+	if (drvdata->curr_list != DCC_INVALID_LINK_LIST	&& dcc_enable) {
+		dev_err(drvdata->dev, "DCC is enabled, please disable it first.\n");
+		mutex_unlock(&drvdata->mutex);
+		return -EINVAL;
+	}
+
+	lock_reg = dcc_readl(drvdata, DCC_LL_LOCK(val));
+	if (lock_reg & 0x1) {
+		dev_err(drvdata->dev, "DCC linked list is already configured\n");
+		mutex_unlock(&drvdata->mutex);
+		return -EINVAL;
+	}
+	drvdata->curr_list = val;
+	mutex_unlock(&drvdata->mutex);
+
+	return count;
+}
+
+static const struct file_operations curr_list_fops = {
+	.read = curr_list_read,
+	.write = curr_list_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static ssize_t trigger_write(struct file *filp,
+			     const char __user *user_buf, size_t count,
+			     loff_t *ppos)
+{
+	int ret = 0;
+	unsigned int val;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	ret = kstrtouint_from_user(user_buf, count, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != 1)
+		return -EINVAL;
+
+	ret = dcc_sw_trigger(drvdata);
+	if (!ret)
+		ret = count;
+
+	return ret;
+}
+
+static const struct file_operations trigger_fops = {
+	.write = trigger_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static ssize_t enable_read(struct file *filp, char __user *userbuf,
+				size_t count, loff_t *ppos)
+{
+	int ret;
+	bool dcc_enable = false;
+	char buf[20];
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	mutex_lock(&drvdata->mutex);
+	if (drvdata->curr_list >= drvdata->nr_link_list) {
+		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	dcc_enable = is_dcc_enabled(drvdata);
+
+	ret = scnprintf(buf, PAGE_SIZE, "%u\n",
+				(unsigned int)dcc_enable);
+err:
+	mutex_unlock(&drvdata->mutex);
+	if (ret > 0)
+		return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+	else
+		return ret;
+}
+
+static ssize_t enable_write(struct file *filp, const char __user *userbuf,
+				size_t count, loff_t *ppos)
+{
+	int ret = 0;
+	unsigned int val;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	ret = kstrtouint_from_user(userbuf, count, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val)
+		ret = dcc_enable(drvdata);
+	else
+		dcc_disable(drvdata);
+
+	if (!ret)
+		ret = count;
+
+	return ret;
+
+}
+
+static const struct file_operations enable_fops = {
+	.read = enable_read,
+	.write = enable_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static ssize_t config_read(struct file *filp, char __user *userbuf,
+				size_t count, loff_t *ppos)
+{
+	struct dcc_drvdata *drvdata = filp->private_data;
+	struct dcc_config_entry *entry;
+	char local_buf[64];
+	int len = 0, tot_len = 0;
+
+	mutex_lock(&drvdata->mutex);
+	if (drvdata->curr_list >= drvdata->nr_link_list) {
+		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
+		tot_len = -EINVAL;
+		goto err;
+	}
+
+	list_for_each_entry(entry,
+	&drvdata->cfg_head[drvdata->curr_list], list) {
+		switch (entry->desc_type) {
+		case DCC_READ_WRITE_TYPE:
+			len = snprintf(local_buf, 64, "Index: 0x%x, mask: 0x%x, val: 0x%x\n",
+				entry->index, entry->mask, entry->write_val);
+			break;
+		case DCC_LOOP_TYPE:
+			len = snprintf(local_buf, 64, "Index: 0x%x, Loop: %d\n",
+				entry->index, entry->loop_cnt);
+			break;
+		case DCC_WRITE_TYPE:
+			len = snprintf(local_buf, 64,
+				"Write Index: 0x%x, Base: 0x%x, Offset: 0x%x, len: 0x%x APB: %d\n",
+				entry->index, entry->base, entry->offset, entry->len,
+				entry->apb_bus);
+			break;
+		case DCC_ADDR_TYPE:
+			len = snprintf(local_buf, 64,
+				"Read Index: 0x%x, Base: 0x%x, Offset: 0x%x, len: 0x%x APB: %d\n",
+				entry->index, entry->base, entry->offset,
+				entry->len, entry->apb_bus);
+		}
+
+		if ((count + len) > PAGE_SIZE) {
+			dev_err(drvdata->dev, "DCC: Couldn't write complete config\n");
+			break;
+		}
+		tot_len += len;
+		simple_read_from_buffer(userbuf, count, ppos, local_buf, len);
+	}
+
+err:
+	mutex_unlock(&drvdata->mutex);
+	return tot_len;
+
+}
+
+static int dcc_config_add(struct dcc_drvdata *drvdata, unsigned int addr,
+				unsigned int len, int apb_bus)
+{
+	int ret = 0;
+	struct dcc_config_entry *entry, *pentry;
+	unsigned int base, offset;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (drvdata->curr_list >= drvdata->nr_link_list) {
+		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (!len || len > (drvdata->ram_size / DCC_ADDR_OFF_RANGE)) {
+		dev_err(drvdata->dev, "DCC: Invalid length\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	base = addr & DCC_ADDR_RANGE;
+
+	if (!list_empty(&drvdata->cfg_head[drvdata->curr_list])) {
+		pentry = list_last_entry(&drvdata->cfg_head[drvdata->curr_list],
+			struct dcc_config_entry, list);
+
+		if (pentry->desc_type == DCC_ADDR_TYPE &&
+				addr >= (pentry->base + pentry->offset) &&
+				addr <= (pentry->base +
+					pentry->offset + MAX_DCC_OFFSET)) {
+
+			/* Re-use base address from last entry */
+			base = pentry->base;
+
+			if ((pentry->len * 4 + pentry->base + pentry->offset)
+					== addr) {
+				len += pentry->len;
+
+				if (len > MAX_DCC_LEN)
+					pentry->len = MAX_DCC_LEN;
+				else
+					pentry->len = len;
+
+				addr = pentry->base + pentry->offset +
+					pentry->len * 4;
+				len -= pentry->len;
+			}
+		}
+	}
+
+	offset = addr - base;
+
+	while (len) {
+		entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
+		if (!entry) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		entry->base = base;
+		entry->offset = offset;
+		entry->len = min_t(u32, len, MAX_DCC_LEN);
+		entry->index = drvdata->nr_config[drvdata->curr_list]++;
+		entry->desc_type = DCC_ADDR_TYPE;
+		entry->apb_bus = apb_bus;
+		INIT_LIST_HEAD(&entry->list);
+		list_add_tail(&entry->list,
+			&drvdata->cfg_head[drvdata->curr_list]);
+
+		len -= entry->len;
+		offset += MAX_DCC_LEN * 4;
+	}
+
+err:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static ssize_t config_write(struct file *filp,
+				const char __user *user_buf, size_t count,
+				loff_t *ppos)
+{
+	int ret, len, apb_bus;
+	unsigned int base;
+	char buf[20];
+	struct dcc_drvdata *drvdata = filp->private_data;
+	int nval;
+
+	ret = copy_from_user(buf, user_buf, count);
+	if (ret)
+		return -EFAULT;
+
+	nval = sscanf(buf, "%x %i %d", &base, &len, &apb_bus);
+	if (nval <= 0 || nval > 3)
+		return -EINVAL;
+
+	if (nval == 1) {
+		len = 1;
+		apb_bus = 0;
+	} else if (nval == 2) {
+		apb_bus = 0;
+	} else {
+		apb_bus = 1;
+	}
+
+	ret = dcc_config_add(drvdata, base, len, apb_bus);
+	if (ret)
+		return ret;
+
+	return count;
+
+}
+
+static const struct file_operations config_fops = {
+	.read = config_read,
+	.write = config_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static void dcc_config_reset(struct dcc_drvdata *drvdata)
+{
+	struct dcc_config_entry *entry, *temp;
+	int curr_list;
+
+	mutex_lock(&drvdata->mutex);
+
+	for (curr_list = 0; curr_list < drvdata->nr_link_list; curr_list++) {
+		list_for_each_entry_safe(entry, temp,
+			&drvdata->cfg_head[curr_list], list) {
+			list_del(&entry->list);
+			devm_kfree(drvdata->dev, entry);
+			drvdata->nr_config[curr_list]--;
+		}
+	}
+	drvdata->ram_start = 0;
+	drvdata->ram_cfg = 0;
+	mutex_unlock(&drvdata->mutex);
+}
+
+static ssize_t config_reset_write(struct file *filp,
+				const char __user *user_buf, size_t count,
+				loff_t *ppos)
+{
+	unsigned int val, ret;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	ret = kstrtouint_from_user(user_buf, count, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val)
+		dcc_config_reset(drvdata);
+
+	return count;
+}
+
+static const struct file_operations config_reset_fops = {
+	.write = config_reset_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static ssize_t ready_read(struct file *filp, char __user *userbuf,
+			size_t count, loff_t *ppos)
+{
+	int ret;
+	char buf[20];
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (drvdata->curr_list >= drvdata->nr_link_list) {
+		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (!drvdata->enable[drvdata->curr_list]) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = scnprintf(buf, PAGE_SIZE, "%u\n",
+			(unsigned int)FIELD_GET(BIT(1), dcc_readl(drvdata, DCC_STATUS)));
+err:
+	mutex_unlock(&drvdata->mutex);
+
+	if (ret > 0)
+		return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+	else
+		return ret;
+}
+
+static const struct file_operations ready_fops = {
+	.read = ready_read,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static int dcc_add_loop(struct dcc_drvdata *drvdata, unsigned long loop_cnt)
+{
+	struct dcc_config_entry *entry;
+
+	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->loop_cnt = min_t(u32, loop_cnt, MAX_LOOP_CNT);
+	entry->index = drvdata->nr_config[drvdata->curr_list]++;
+	entry->desc_type = DCC_LOOP_TYPE;
+	INIT_LIST_HEAD(&entry->list);
+	list_add_tail(&entry->list, &drvdata->cfg_head[drvdata->curr_list]);
+
+	return 0;
+}
+
+static ssize_t loop_write(struct file *filp, const char __user *userbuf,
+			size_t count, loff_t *ppos)
+{
+	int ret, cnt = 2, i = 0;
+	char *token, *input, buf[80];
+	char delim[2] = " ";
+	unsigned int val[MAX_LOOP_ADDR];
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	input = buf;
+
+	if (drvdata->curr_list >= drvdata->nr_link_list) {
+		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = copy_from_user(buf, userbuf, count);
+	if (ret)
+		return -EFAULT;
+
+	if (input[count - 1] == '\n')
+		input[count - 1] = '\0';
+
+	token = strsep(&input, delim);
+	while (token != NULL) {
+		ret = kstrtoint(token, 0, &val[i++]);
+		if (ret)
+			goto err;
+
+		token = strsep(&input, delim);
+	}
+
+	ret = dcc_add_loop(drvdata, val[0]);
+	if (ret)
+		goto err;
+
+	for (i = 0; i < val[1]; i++)
+		dcc_config_add(drvdata, val[cnt++], 1, 0);
+
+	ret = dcc_add_loop(drvdata, 1);
+	if (ret)
+		goto err;
+	ret = count;
+err:
+	return ret;
+}
+
+static const struct file_operations loop_fops = {
+	.write = loop_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static int dcc_rd_mod_wr_add(struct dcc_drvdata *drvdata, unsigned int mask,
+				unsigned int val)
+{
+	int ret = 0;
+	struct dcc_config_entry *entry;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (drvdata->curr_list >= drvdata->nr_link_list) {
+		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (list_empty(&drvdata->cfg_head[drvdata->curr_list])) {
+		dev_err(drvdata->dev, "DCC: No read address programmed\n");
+		ret = -EPERM;
+		goto err;
+	}
+
+	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	entry->desc_type = DCC_READ_WRITE_TYPE;
+	entry->mask = mask;
+	entry->write_val = val;
+	entry->index = drvdata->nr_config[drvdata->curr_list]++;
+	INIT_LIST_HEAD(&entry->list);
+	list_add_tail(&entry->list, &drvdata->cfg_head[drvdata->curr_list]);
+err:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static ssize_t rd_mod_wr_write(struct file *filp, const char __user *userbuf,
+				size_t count, loff_t *ppos)
+{
+	int ret;
+	int nval;
+	char buf[20];
+	unsigned int addr, mask, val;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	ret = copy_from_user(buf, userbuf, count);
+	if (ret)
+		return -EFAULT;
+
+	nval = sscanf(buf, "%x %x %x", &addr, &mask, &val);
+
+	if (nval <= 1 || nval > 3)
+		return -EINVAL;
+
+	ret = dcc_config_add(drvdata, addr, 1, 0);
+	if (ret)
+		return ret;
+
+	ret = dcc_rd_mod_wr_add(drvdata, mask, val);
+	if (ret)
+		return ret;
+
+	return count;
+
+}
+
+static const struct file_operations rd_mod_wr_fops = {
+	.write = rd_mod_wr_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static int dcc_add_write(struct dcc_drvdata *drvdata, unsigned int addr,
+				unsigned int write_val, int apb_bus)
+{
+	struct dcc_config_entry *entry;
+
+	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->desc_type = DCC_WRITE_TYPE;
+	entry->base = addr & GENMASK(31, 4);
+	entry->offset = addr - entry->base;
+	entry->write_val = write_val;
+	entry->index = drvdata->nr_config[drvdata->curr_list]++;
+	entry->len = 1;
+	entry->apb_bus = apb_bus;
+	INIT_LIST_HEAD(&entry->list);
+	list_add_tail(&entry->list, &drvdata->cfg_head[drvdata->curr_list]);
+
+	return 0;
+}
+
+static ssize_t config_wr_write(struct file *filp, const char __user *userbuf,
+				 size_t count, loff_t *ppos)
+{
+	int ret;
+	int nval;
+	char buf[20];
+	unsigned int addr, write_val;
+	int apb_bus = 0;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	ret = copy_from_user(buf, userbuf, count);
+	if (ret)
+		return -EFAULT;
+
+	mutex_lock(&drvdata->mutex);
+
+	nval = sscanf(buf, "%x %x %d", &addr, &write_val, &apb_bus);
+
+	if (nval <= 1 || nval > 3) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (drvdata->curr_list >= drvdata->nr_link_list) {
+		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (nval == 3 && apb_bus != 0)
+		apb_bus = 1;
+
+	ret = dcc_add_write(drvdata, addr, write_val, apb_bus);
+	if (ret)
+		goto err;
+
+	ret = count;
+err:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static const struct file_operations config_wr_fops = {
+	.write = config_wr_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+void dcc_delete_debug_dir(struct dcc_drvdata *dcc)
+{
+	 debugfs_remove_recursive(dcc->dbg_dir);
+};
+
+void dcc_create_debug_dir(struct dcc_drvdata *dcc)
+{
+	struct device *dev = dcc->dev;
+
+	if (debugfs_initialized()) {
+		dcc_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
+		if (!dcc_dbg) {
+			pr_err("can't create debugfs dir\n");
+			return;
+		}
+	}
+
+	dcc->dbg_dir = debugfs_create_dir(dev_name(dev), dcc_dbg);
+	if (!dcc->dbg_dir)
+		return;
+
+	debugfs_create_file("curr_list", 0400, dcc->dbg_dir, dcc, &curr_list_fops);
+	debugfs_create_file("enable", 0400, dcc->dbg_dir, dcc, &enable_fops);
+	debugfs_create_file("trigger", 0400, dcc->dbg_dir, dcc, &trigger_fops);
+	debugfs_create_file("config_read", 0400, dcc->dbg_dir, dcc, &config_fops);
+	debugfs_create_file("config_write", 0400, dcc->dbg_dir, dcc, &config_wr_fops);
+	debugfs_create_file("config_read_write", 0400, dcc->dbg_dir, dcc, &rd_mod_wr_fops);
+	debugfs_create_file("config_loop", 0400, dcc->dbg_dir, dcc, &loop_fops);
+	debugfs_create_file("ready", 0400, dcc->dbg_dir, dcc, &ready_fops);
+	debugfs_create_file("config_reset", 0400, dcc->dbg_dir, dcc, &config_reset_fops);
+}
+
+static ssize_t dcc_sram_read(struct file *file, char __user *data,
+						size_t len, loff_t *ppos)
+{
+	unsigned char *buf;
+	struct dcc_drvdata *drvdata = container_of(file->private_data,
+		struct dcc_drvdata,
+		sram_dev);
+
+	/* EOF check */
+	if (drvdata->ram_size <= *ppos)
+		return 0;
+
+	if ((*ppos + len) > drvdata->ram_size)
+		len = (drvdata->ram_size - *ppos);
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy_fromio(buf, drvdata->ram_base + *ppos, len);
+
+	if (copy_to_user(data, buf, len)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
+	*ppos += len;
+
+	kfree(buf);
+
+	return len;
+}
+
+static const struct file_operations dcc_sram_fops = {
+	.owner		= THIS_MODULE,
+	.read		= dcc_sram_read,
+	.llseek		= no_llseek,
+};
+
+static int dcc_sram_dev_init(struct dcc_drvdata *drvdata)
+{
+	int ret;
+
+	drvdata->sram_dev.minor = MISC_DYNAMIC_MINOR;
+	drvdata->sram_dev.name = DCC_SRAM_NODE;
+	drvdata->sram_dev.fops = &dcc_sram_fops;
+
+	ret = misc_register(&drvdata->sram_dev);
+	return ret;
+}
+
+static void dcc_sram_dev_exit(struct dcc_drvdata *drvdata)
+{
+	misc_deregister(&drvdata->sram_dev);
+}
+
+static int dcc_probe(struct platform_device *pdev)
+{
+	u32 val;
+	int ret = 0, i, enable_size, nr_config_size, cfg_head_size;
+	struct device *dev = &pdev->dev;
+	struct dcc_drvdata *dcc;
+	struct resource *res;
+
+	dcc = devm_kzalloc(dev, sizeof(*dcc), GFP_KERNEL);
+	if (!dcc)
+		return -ENOMEM;
+
+	dcc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, dcc);
+
+	dcc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dcc->base))
+		return PTR_ERR(dcc->base);
+
+	dcc->ram_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
+	if (IS_ERR(dcc->ram_base))
+		return PTR_ERR(dcc->ram_base);
+
+	dcc->ram_size = resource_size(res);
+
+	dcc->ram_offset = (size_t) of_device_get_match_data(&pdev->dev);
+
+	val = dcc_readl(dcc, DCC_HW_INFO);
+
+	if (FIELD_GET(BIT(DCC_VER_INFO_BIT), val)) {
+		dcc->mem_map_ver = 3;
+		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
+		if (dcc->nr_link_list == 0)
+			return	-EINVAL;
+	} else if ((val & DCC_VER_MASK2) == DCC_VER_MASK2) {
+		dcc->mem_map_ver = 2;
+		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
+		if (dcc->nr_link_list == 0)
+			return	-EINVAL;
+	} else {
+		dcc->mem_map_ver = 1;
+		dcc->nr_link_list = DCC_MAX_LINK_LIST;
+	}
+
+	if ((val & DCC_LOOP_OFFSET_MASK) == DCC_LOOP_OFFSET_MASK)
+		dcc->loopoff = DCC_FIX_LOOP_OFFSET;
+	else
+		dcc->loopoff = get_bitmask_order((dcc->ram_size +
+				dcc->ram_offset) / 4 - 1);
+
+	mutex_init(&dcc->mutex);
+	/* Allocate space for all entries at once */
+	enable_size = dcc->nr_link_list * sizeof(bool);
+	nr_config_size = dcc->nr_link_list * sizeof(size_t);
+	cfg_head_size = dcc->nr_link_list * sizeof(struct list_head);
+
+	dcc->enable = devm_kzalloc(dev, enable_size + nr_config_size + cfg_head_size, GFP_KERNEL);
+	if (!dcc->enable)
+		return -ENOMEM;
+
+	dcc->nr_config  = (size_t *)(dcc->enable + dcc->nr_link_list);
+	dcc->cfg_head = (struct list_head *)(dcc->nr_config + dcc->nr_link_list);
+
+	for (i = 0; i < dcc->nr_link_list; i++)
+		INIT_LIST_HEAD(&dcc->cfg_head[i]);
+
+	dcc->curr_list = DCC_INVALID_LINK_LIST;
+
+	ret = dcc_sram_dev_init(dcc);
+	if (ret) {
+		dev_err(dcc->dev, "DCC: sram node not registered.\n");
+		return ret;
+	}
+
+	dcc_create_debug_dir(dcc);
+
+	return 0;
+}
+
+static int dcc_remove(struct platform_device *pdev)
+{
+	struct dcc_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	dcc_sram_dev_exit(drvdata);
+
+	dcc_delete_debug_dir(drvdata);
+
+	dcc_config_reset(drvdata);
+
+	return 0;
+}
+
+static const struct of_device_id dcc_match_table[] = {
+	{ .compatible = "qcom,sm8150-dcc", .data = (void *)0x5000 },
+	{ .compatible = "qcom,sc7280-dcc", .data = (void *)0x12000},
+	{ .compatible = "qcom,sc7180-dcc", .data = (void *)0x6000 },
+	{ .compatible = "qcom,sdm845-dcc", .data = (void *)0x6000 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dcc_match_table);
+
+static struct platform_driver dcc_driver = {
+	.probe = dcc_probe,
+	.remove	= dcc_remove,
+	.driver	= {
+		.name = "qcom-dcc",
+		.of_match_table	= dcc_match_table,
+	},
+};
+
+module_platform_driver(dcc_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Qualcomm Technologies Inc. DCC driver");
+
--
2.7.4

