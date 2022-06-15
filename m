Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADE154BEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbiFOALF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbiFOAKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:10:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3392CDD9;
        Tue, 14 Jun 2022 17:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655251852; x=1686787852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rgzx0VAJN0GDKGJ7XNvOIp3dKw4QY0igqjHzJxj6vHE=;
  b=YrNSU0F1Cd3cgM0gMzdMHStjMPvHa4KyfCzmg6bvAM3lkgnbrEAKEMHA
   O0cUpP3r3YWqmCW7vc+gTM0m/5XFLnukMuduMsboxiuch8Ro+afFQxNFP
   RNBxO8f4ysxlNrhh86IGUVTvzjhDE9ujkhWrJL9opaFCUOY08S/a08AZf
   mhXncsXNvwRt6u3NOodSdkpY4MjEyUZFSlwMK9lV0IivQQmxuardSyMuf
   7uMzJJ8JtHAcXa5pnAQKujY0NmaP9GXx2mkt/Jz08CDvHPD9hkP/8xALj
   0eHoHRBCmwF38bwazgSEi668vRTSuXw4cpZK9hLV7ZX55gwkR6mgTjQx5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="278825453"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="278825453"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:10:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640662892"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:10:51 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Date:   Tue, 14 Jun 2022 17:10:27 -0700
Message-Id: <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655250669.git.alison.schofield@intel.com>
References: <cover.1655250669.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices that support persistent memory maintain a list of locations
that are poisoned or result in poison if the addresses are accessed by
the host.

Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
list as a set of  Media Error Records that include the source of the
error, the starting device physical address and length. The length is
the number of adjacent DPAs in the record and is in units of 64 bytes.

Retrieve the list and log each Media Error Record as a trace event of
type cxl_poison_list.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/cxlmem.h    | 43 +++++++++++++++++++++++
 drivers/cxl/core/mbox.c | 75 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 60d10ee1e7fc..29cf0459b44a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -174,6 +174,7 @@ struct cxl_endpoint_dvsec_info {
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @lsa_size: Size of Label Storage Area
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
+ * @poison_max_mer: maximum Media Error Records tracked in Poison List
  * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
  * @enabled_cmds: Hardware commands found enabled in CEL.
@@ -204,6 +205,7 @@ struct cxl_dev_state {
 
 	size_t payload_size;
 	size_t lsa_size;
+	u32 poison_max;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
@@ -317,6 +319,46 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+struct cxl_mbox_poison_payload_in {
+	__le64 offset;
+	__le64 length;
+} __packed;
+
+struct cxl_mbox_poison_payload_out {
+	u8 flags;
+	u8 rsvd1;
+	__le64 overflow_timestamp;
+	__le16 count;
+	u8 rsvd2[0x14];
+	struct cxl_poison_record {
+		__le64 address;
+		__le32 length;
+		__le32 rsvd;
+	} __packed record[];
+} __packed;
+
+/* CXL 8.2.9.5.4.1 Get Poison List: payload out flags: */
+#define CXL_POISON_FLAG_MORE            BIT(0)
+#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
+#define CXL_POISON_FLAG_SCANNING        BIT(2)
+
+/* CXL 8.2.9.5.4.1 Get Poison List: Error is encoded in record.address[2:0] */
+#define CXL_POISON_SOURCE_MASK		GENMASK(2, 0)
+#define	CXL_POISON_SOURCE_UNKNOWN	0
+#define	CXL_POISON_SOURCE_EXTERNAL	1
+#define	CXL_POISON_SOURCE_INTERNAL	2
+#define	CXL_POISON_SOURCE_INJECTED	3
+#define	CXL_POISON_SOURCE_VENDOR	7
+
+/* Software define */
+#define	CXL_POISON_SOURCE_INVALID	99
+#define CXL_POISON_SOURCE_VALID(x)		\
+	(((x) == CXL_POISON_SOURCE_UNKNOWN)  ||	\
+	 ((x) == CXL_POISON_SOURCE_EXTERNAL) ||	\
+	 ((x) == CXL_POISON_SOURCE_INTERNAL) ||	\
+	 ((x) == CXL_POISON_SOURCE_INJECTED) ||	\
+	 ((x) == CXL_POISON_SOURCE_VENDOR))
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -351,6 +393,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+int cxl_mem_get_poison_list(struct device *dev);
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 54f434733b56..c10c7020ebc2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -9,6 +9,9 @@
 
 #include "core.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/cxl.h>
+
 static bool cxl_raw_allow_all;
 
 /**
@@ -755,6 +758,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 {
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
+	__le32 val = 0;
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
@@ -783,6 +787,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
 
+	memcpy(&val, id.poison_list_max_mer, 3);
+	cxlds->poison_max = le32_to_cpu(val);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
@@ -826,6 +833,74 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
 
+int cxl_mem_get_poison_list(struct device *dev)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_poison_payload_out *po;
+	struct cxl_mbox_poison_payload_in pi;
+	int nr_records = 0;
+	int rc, i;
+
+	if (range_len(&cxlds->pmem_range)) {
+		pi.offset = cpu_to_le64(cxlds->pmem_range.start);
+		pi.length = cpu_to_le64(range_len(&cxlds->pmem_range));
+	} else {
+		return -ENXIO;
+	}
+
+	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
+	if (!po)
+		return -ENOMEM;
+
+	do {
+		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
+				       sizeof(pi), po, cxlds->payload_size);
+		if (rc)
+			goto out;
+
+		if (po->flags & CXL_POISON_FLAG_OVERFLOW) {
+			time64_t o_time = le64_to_cpu(po->overflow_timestamp);
+
+			dev_err(dev, "Poison list overflow at %ptTs UTC\n",
+				&o_time);
+			rc = -ENXIO;
+			goto out;
+		}
+
+		if (po->flags & CXL_POISON_FLAG_SCANNING) {
+			dev_err(dev, "Scan Media in Progress\n");
+			rc = -EBUSY;
+			goto out;
+		}
+
+		for (i = 0; i < le16_to_cpu(po->count); i++) {
+			u64 addr = le64_to_cpu(po->record[i].address);
+			u32 len = le32_to_cpu(po->record[i].length);
+			int source = FIELD_GET(CXL_POISON_SOURCE_MASK, addr);
+
+			if (!CXL_POISON_SOURCE_VALID(source)) {
+				dev_dbg(dev, "Invalid poison source %d",
+					source);
+				source = CXL_POISON_SOURCE_INVALID;
+			}
+
+			trace_cxl_poison_list(dev, source, addr, len);
+		}
+
+		/* Protect against an uncleared _FLAG_MORE */
+		nr_records = nr_records + le16_to_cpu(po->count);
+		if (nr_records >= cxlds->poison_max)
+			goto out;
+
+	} while (po->flags & CXL_POISON_FLAG_MORE);
+
+out:
+	kvfree(po);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison_list, CXL);
+
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 {
 	struct cxl_dev_state *cxlds;
-- 
2.31.1

