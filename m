Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D2F56737B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiGEPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiGEPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:51:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E811C918;
        Tue,  5 Jul 2022 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657036206; x=1688572206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CFNIOwaDkCzbnASrMA4cPR9PW21VMxxDpRm8cF+EVbg=;
  b=GZT1LsXS4soBfE12JxOStcbyw94O8jhssOQGjbcnytGTr9wlysXIfcf3
   NZs4E81xaAJLZif+5UZyvdXsFGM64VDPKJ/Bm5V0RbN1kldzYOlraxsY3
   my1/DD73gBWnw/KeQHz4XtfLWQhxxsoG0e2XxTK3v4IA1Mcr/AVGj77pU
   6h4n5G5ipYS28UHHN1Gv54N5QtYreuK/JLdM4Y1KhmqJegq+dy1attXyC
   GhKqHIaH/jN5K8HznUFV779JTbob4Ci4hwVTLliXmM0BKWkNFUt+kiHfm
   41B8qkvxVsjZQALS06qI2GLeh+DMX0rUxDlFYoNMAVqOHETxULR8bGUvA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283414786"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="283414786"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:50:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="919766561"
Received: from amangla-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.184])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:50:01 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V13 6/9] cxl/port: Read CDAT table
Date:   Tue,  5 Jul 2022 08:49:29 -0700
Message-Id: <20220705154932.2141021-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220705154932.2141021-1-ira.weiny@intel.com>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
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

From: Ira Weiny <ira.weiny@intel.com>

The OS will need CDAT data from CXL devices to properly set up
interleave sets.  Currently this is supported through a DOE mailbox
which supports CDAT.

Search the DOE mailboxes available, query CDAT data, and cache the data
for later parsing.

Provide a sysfs binary attribute to allow dumping of the CDAT.

Binary dumping is modeled on /sys/firmware/ACPI/tables/

The ability to dump this table will be very useful for emulation of real
devices once they become available as QEMU CXL type 3 device emulation will
be able to load this file in.

This does not support table updates at runtime. It will always provide
whatever was there when first cached. Handling of table updates can be
implemented later.

Finally create a complete list of CDAT defines within cdat.h for code
wishing to decode the CDAT table.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V12:
	Fix checking for task.rv for errors
	Ensure no over run of non-DW aligned buffer length's

Changes from V11:
	Adjust for the use of DOE mailbox xarray
	Dan Williams:
		Remove unnecessary get/put device
		Use new BIN_ATTR_ADMIN_RO macro
		Flag that CDAT was supported
			If there is a read error then the CDAT sysfs
			will return a 0 length entry

Changes from V10:
	Ben Widawsky
		Failure to find CDAT should be a debug message not error
		Remove reference to cdat_mb from the port object
	Dropped [PATCH V10 5/9] cxl/port: Find a DOE mailbox which supports
		CDAT
		Iterate the mailboxes for the CDAT one each time.
	Define CXL_DOE_TABLE_ACCESS_LAST_ENTRY and add comment about
		it's use.

Changes from V9:
	Add debugging output
	Jonathan Cameron
		Move read_cdat to port probe by using dev_groups for the
		sysfs attributes.  This avoids issues with using devm
		before the driver is loaded while making sure the CDAT
		binary is available.

Changes from V8:
	Fix length print format
	Incorporate feedback from Jonathan
	Move all this to cxl_port which can help support switches when
	the time comes.

Changes from V6:
	Fix issue with devm use
		Move cached cdat data to cxl_dev_state
	Use new pci_doe_submit_task()
	Ensure the aux driver is locked while processing tasks
	Rebased on cxl-pending

Changes from V5:
	Add proper guards around cdat.h
	Split out finding the CDAT DOE mailbox
	Use cxl_cdat to group CDAT data together
	Adjust to use auxiliary_find_device() to find the DOE device
		which supplies the CDAT protocol.
	Rebased to latest
	Remove dev_dbg(length)
	Remove unneeded DOE Table access defines
	Move CXL_DOE_PROTOCOL_TABLE_ACCESS define into this patch where
		it is used

Changes from V4:
	Split this into it's own patch
	Rearchitect this such that the memdev driver calls into the DOE
	driver via the cxl_mem state object.  This allows CDAT data to
	come from any type of cxl_mem object not just PCI DOE.
	Rebase on new struct cxl_dev_state
---
 drivers/cxl/cdat.h     | 100 ++++++++++++++++++++++++
 drivers/cxl/core/pci.c | 170 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |   5 ++
 drivers/cxl/cxlpci.h   |   1 +
 drivers/cxl/port.c     |  51 +++++++++++++
 5 files changed, 327 insertions(+)
 create mode 100644 drivers/cxl/cdat.h

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
new file mode 100644
index 000000000000..c6a48ab326bf
--- /dev/null
+++ b/drivers/cxl/cdat.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CXL_CDAT_H__
+#define __CXL_CDAT_H__
+
+/*
+ * Coherent Device Attribute table (CDAT)
+ *
+ * Specification available from UEFI.org
+ *
+ * Whilst CDAT is defined as a single table, the access via DOE maiboxes is
+ * done one entry at a time, where the first entry is the header.
+ */
+
+#define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
+#define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
+#define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
+#define   CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA	0
+#define CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE	0xffff0000
+#define CXL_DOE_TABLE_ACCESS_LAST_ENTRY		0xffff
+
+/*
+ * CDAT entries are little endian and are read from PCI config space which
+ * is also little endian.
+ * As such, on a big endian system these will have been reversed.
+ * This prevents us from making easy use of packed structures.
+ * Style form pci_regs.h
+ */
+
+#define CDAT_HEADER_LENGTH_DW 4
+#define CDAT_HEADER_LENGTH_BYTES (CDAT_HEADER_LENGTH_DW * sizeof(u32))
+#define CDAT_HEADER_DW0_LENGTH		0xffffffff
+#define CDAT_HEADER_DW1_REVISION	0x000000ff
+#define CDAT_HEADER_DW1_CHECKSUM	0x0000ff00
+/* CDAT_HEADER_DW2_RESERVED	*/
+#define CDAT_HEADER_DW3_SEQUENCE	0xffffffff
+
+/* All structures have a common first DW */
+#define CDAT_STRUCTURE_DW0_TYPE		0x000000ff
+#define   CDAT_STRUCTURE_DW0_TYPE_DSMAS 0
+#define   CDAT_STRUCTURE_DW0_TYPE_DSLBIS 1
+#define   CDAT_STRUCTURE_DW0_TYPE_DSMSCIS 2
+#define   CDAT_STRUCTURE_DW0_TYPE_DSIS 3
+#define   CDAT_STRUCTURE_DW0_TYPE_DSEMTS 4
+#define   CDAT_STRUCTURE_DW0_TYPE_SSLBIS 5
+
+#define CDAT_STRUCTURE_DW0_LENGTH	0xffff0000
+
+/* Device Scoped Memory Affinity Structure */
+#define CDAT_DSMAS_DW1_DSMAD_HANDLE	0x000000ff
+#define CDAT_DSMAS_DW1_FLAGS		0x0000ff00
+#define CDAT_DSMAS_DPA_OFFSET(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSMAS_DPA_LEN(entry) ((u64)((entry)[5]) << 32 | (entry)[4])
+#define CDAT_DSMAS_NON_VOLATILE(flags)  ((flags & 0x04) >> 2)
+
+/* Device Scoped Latency and Bandwidth Information Structure */
+#define CDAT_DSLBIS_DW1_HANDLE		0x000000ff
+#define CDAT_DSLBIS_DW1_FLAGS		0x0000ff00
+#define CDAT_DSLBIS_DW1_DATA_TYPE	0x00ff0000
+#define CDAT_DSLBIS_BASE_UNIT(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSLBIS_DW4_ENTRY_0		0x0000ffff
+#define CDAT_DSLBIS_DW4_ENTRY_1		0xffff0000
+#define CDAT_DSLBIS_DW5_ENTRY_2		0x0000ffff
+
+/* Device Scoped Memory Side Cache Information Structure */
+#define CDAT_DSMSCIS_DW1_HANDLE		0x000000ff
+#define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
+	((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
+
+/* Device Scoped Initiator Structure */
+#define CDAT_DSIS_DW1_FLAGS		0x000000ff
+#define CDAT_DSIS_DW1_HANDLE		0x0000ff00
+
+/* Device Scoped EFI Memory Type Structure */
+#define CDAT_DSEMTS_DW1_HANDLE		0x000000ff
+#define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR	0x0000ff00
+#define CDAT_DSEMTS_DPA_OFFSET(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSEMTS_DPA_LENGTH(entry)	((u64)((entry)[5]) << 32 | (entry)[4])
+
+/* Switch Scoped Latency and Bandwidth Information Structure */
+#define CDAT_SSLBIS_DW1_DATA_TYPE	0x000000ff
+#define CDAT_SSLBIS_BASE_UNIT(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
+#define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
+#define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
+
+#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+
+/**
+ * struct cxl_cdat - CXL CDAT data
+ *
+ * @table: cache of CDAT table
+ * @length: length of cached CDAT table
+ */
+struct cxl_cdat {
+	void *table;
+	size_t length;
+};
+
+#endif /* !__CXL_CDAT_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c4c99ff7b55e..9232b806d051 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -4,10 +4,12 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
+#include "cdat.h"
 
 /**
  * DOC: cxl core pci
@@ -458,3 +460,171 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
+
+static struct pci_doe_mb *find_cdat_mb(struct device *uport)
+{
+	struct cxl_memdev *cxlmd;
+	struct cxl_dev_state *cxlds;
+	unsigned long index;
+	void *entry;
+
+	if (!is_cxl_memdev(uport))
+		return NULL;
+
+	cxlmd = to_cxl_memdev(uport);
+	cxlds = cxlmd->cxlds;
+
+	xa_for_each(&cxlds->doe_mbs, index, entry) {
+		struct pci_doe_mb *cur = entry;
+
+		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
+					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
+			return cur;
+	}
+
+	return NULL;
+}
+
+#define CDAT_DOE_REQ(entry_handle)					\
+	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
+		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
+		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
+
+static void cxl_doe_task_complete(struct pci_doe_task *task)
+{
+	complete(task->private);
+}
+
+static int cxl_cdat_get_length(struct device *dev,
+			       struct pci_doe_mb *cdat_mb,
+			       size_t *length)
+{
+	u32 cdat_request_pl = CDAT_DOE_REQ(0);
+	u32 cdat_response_pl[32];
+	DECLARE_COMPLETION_ONSTACK(c);
+	struct pci_doe_task task = {
+		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
+		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+		.request_pl = &cdat_request_pl,
+		.request_pl_sz = sizeof(cdat_request_pl),
+		.response_pl = cdat_response_pl,
+		.response_pl_sz = sizeof(cdat_response_pl),
+		.complete = cxl_doe_task_complete,
+		.private = &c,
+	};
+	int rc;
+
+	rc = pci_doe_submit_task(cdat_mb, &task);
+	if (rc < 0) {
+		dev_err(dev, "DOE submit failed: %d", rc);
+		return rc;
+	}
+	wait_for_completion(&c);
+	if (task.rv < sizeof(u32))
+		return -EIO;
+
+	*length = cdat_response_pl[1];
+	dev_dbg(dev, "CDAT length %zu\n", *length);
+
+	return 0;
+}
+
+static int cxl_cdat_read_table(struct device *dev,
+			       struct pci_doe_mb *cdat_mb,
+			       struct cxl_cdat *cdat)
+{
+	size_t length = cdat->length;
+	u32 *data = cdat->table;
+	int entry_handle = 0;
+
+	do {
+		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
+		u32 cdat_response_pl[32];
+		DECLARE_COMPLETION_ONSTACK(c);
+		struct pci_doe_task task = {
+			.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
+			.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+			.request_pl = &cdat_request_pl,
+			.request_pl_sz = sizeof(cdat_request_pl),
+			.response_pl = cdat_response_pl,
+			.response_pl_sz = sizeof(cdat_response_pl),
+			.complete = cxl_doe_task_complete,
+			.private = &c,
+		};
+		size_t entry_dw;
+		u32 *entry;
+		int rc;
+
+		rc = pci_doe_submit_task(cdat_mb, &task);
+		if (rc < 0) {
+			dev_err(dev, "DOE submit failed: %d", rc);
+			return rc;
+		}
+		wait_for_completion(&c);
+		/* 1 DW header + 1 DW data min */
+		if (task.rv < (2 * sizeof(u32)))
+			return -EIO;
+
+		/* Get the CXL table access header entry handle */
+		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
+					 cdat_response_pl[0]);
+		entry = cdat_response_pl + 1;
+		entry_dw = task.rv / sizeof(u32);
+		/* Skip Header */
+		entry_dw -= 1;
+		entry_dw = min(length / sizeof(u32), entry_dw);
+		/* Prevent length < 1 DW from causing a buffer overflow */
+		if (entry_dw) {
+			memcpy(data, entry, entry_dw * sizeof(u32));
+			length -= entry_dw * sizeof(u32);
+			data += entry_dw;
+		}
+	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
+
+	return 0;
+}
+
+/**
+ * read_cdat_data - Read the CDAT data on this port
+ * @port: Port to read data from
+ *
+ * This call will sleep waiting for responses from the DOE mailbox.
+ */
+void read_cdat_data(struct cxl_port *port)
+{
+	static struct pci_doe_mb *cdat_mb;
+	struct device *dev = &port->dev;
+	struct device *uport = port->uport;
+	size_t cdat_length;
+	int rc;
+
+	cdat_mb = find_cdat_mb(uport);
+	if (!cdat_mb) {
+		dev_dbg(dev, "No CDAT mailbox\n");
+		return;
+	}
+
+	port->cdat_sup = true;
+
+	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
+		dev_dbg(dev, "No CDAT length\n");
+		return;
+	}
+
+	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
+	if (!port->cdat.table)
+		return;
+
+	port->cdat.length = cdat_length;
+	rc = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
+	if (rc) {
+		/* Don't leave table data allocated on error */
+		devm_kfree(dev, port->cdat.table);
+		port->cdat.table = NULL;
+		port->cdat.length = 0;
+		dev_err(dev, "CDAT data read error\n");
+	}
+}
+EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 140dc3278cde..9a08379000a0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include "cdat.h"
 
 /**
  * DOC: cxl objects
@@ -267,6 +268,8 @@ struct cxl_nvdimm {
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
+ * @cdat: Cached CDAT data
+ * @cdat_sup: Is CDAT supported
  */
 struct cxl_port {
 	struct device dev;
@@ -278,6 +281,8 @@ struct cxl_port {
 	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
+	struct cxl_cdat cdat;
+	bool cdat_sup;
 };
 
 /**
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index fce1c11729c2..eec597dbe763 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
+void read_cdat_data(struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 3cf308f114c4..1ec34a159657 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -49,6 +49,9 @@ static int cxl_port_probe(struct device *dev)
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
+	/* Cache the data early to ensure is_visible() works */
+	read_cdat_data(port);
+
 	if (is_cxl_endpoint(port)) {
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
 		struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -78,10 +81,58 @@ static int cxl_port_probe(struct device *dev)
 	return 0;
 }
 
+static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_port *port = to_cxl_port(dev);
+
+	if (!port->cdat.table)
+		return 0;
+
+	return memory_read_from_buffer(buf, count, &offset,
+				       port->cdat.table,
+				       port->cdat.length);
+}
+
+static BIN_ATTR_ADMIN_RO(cdat, 0);
+
+static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_port *port = to_cxl_port(dev);
+
+	if ((attr == &bin_attr_cdat) && port->cdat_sup)
+		return attr->attr.mode;
+
+	return 0;
+}
+
+static struct bin_attribute *cxl_cdat_bin_attributes[] = {
+	&bin_attr_cdat,
+	NULL,
+};
+
+static struct attribute_group cxl_cdat_attribute_group = {
+	.name = "CDAT",
+	.bin_attrs = cxl_cdat_bin_attributes,
+	.is_bin_visible = cxl_port_bin_attr_is_visible,
+};
+
+static const struct attribute_group *cxl_port_attribute_groups[] = {
+	&cxl_cdat_attribute_group,
+	NULL,
+};
+
 static struct cxl_driver cxl_port_driver = {
 	.name = "cxl_port",
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
+	.drv = {
+		.dev_groups = cxl_port_attribute_groups,
+	},
 };
 
 module_cxl_driver(cxl_port_driver);
-- 
2.35.3

