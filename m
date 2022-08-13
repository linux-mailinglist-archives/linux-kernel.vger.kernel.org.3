Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54F05918EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiHMFd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbiHMFcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:32:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF0EE0B;
        Fri, 12 Aug 2022 22:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660368772; x=1691904772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KS09Ureev+x8AiPXriOsrbPJglvnTPySNu4gk0iotoU=;
  b=VeR5SpTT2dwQTg7ZpsWuCYQIyVGw0GXXSbA1ehgOB8elOzf1SRueX1PK
   1wDe8BIaQTBoGIL1+TzkFSOVyH5GyWJk9sYYfvQHcbL03mPB4Cay7wMNS
   QF5mSWsvXXDR1MaHIIG48aF0u/N/ckK38eIVc3SAmc2SqEBLD4wJHLX2r
   ypBFpUxPHlNdaXbayVRN6FTtNyANFJU8dlTgmpmPuu9PRmprgXL98U7le
   d9pYgpdpnwhxK7SOGIqiMjqcEe7sn0ViLyxKCSLSYoHN78Pwdrfhn8O7f
   ywHt0oAuwAl15BI1iPXVhk8UAGAbNnMKYWBhZFkMqZZvj9irHEHqXOcKH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278684321"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="278684321"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="674310980"
Received: from jchen8-mobl.amr.corp.intel.com (HELO localhost) ([10.212.10.85])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:49 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [RFC PATCH 5/9] cxl/mem: Trace DRAM Event Record
Date:   Fri, 12 Aug 2022 22:32:39 -0700
Message-Id: <20220813053243.757363-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220813053243.757363-1-ira.weiny@intel.com>
References: <20220813053243.757363-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL v3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.

Determine if the event read is a DRAM event record and if so trace the
record.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
This record has a very odd byte layout with 2 - 16 bit fields
(validity_flags and column) aligned on an odd byte boundary.  In
addition nibble_mask and row are oddly aligned.

I've made my best guess as to how the endianess of these fields should
be resolved.  But I'm happy to hear from other folks if what I have is
wrong.

struct cxl_evt_dram_rec {
	struct cxl_event_record_hdr hdr;
	__le64 phys_addr;
	u8 descriptor;
	u8 type;
	u8 transaction_type;
	u16 validity_flags;
	u8 channel;
	u8 rank;
	u8 nibble_mask[CXL_EVT_DER_NIBBLE_MASK_SIZE];
	u8 bank_group;
	u8 bank;
	u8 row[CXL_EVT_DER_ROW_SIZE];
	u16 column;
	u8 correction_mask[CXL_EVT_DER_CORRECTION_MASK_SIZE];
} __packed;
---
 drivers/cxl/core/mbox.c           |  16 +++++
 drivers/cxl/cxlmem.h              |  24 +++++++
 include/trace/events/cxl-events.h | 114 ++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0e433f072163..6414588a3c7b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -717,6 +717,14 @@ static const uuid_t gen_media_event_uuid =
 	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
 		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
 
+/*
+ * DRAM Event Record
+ * CXL v3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+static const uuid_t dram_event_uuid =
+	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
+		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
+
 static void cxl_trace_event_record(const char *dev_name,
 				   enum cxl_event_log_type type,
 				   struct cxl_get_event_payload *payload)
@@ -731,6 +739,14 @@ static void cxl_trace_event_record(const char *dev_name,
 		return;
 	}
 
+	if (uuid_equal(id, &dram_event_uuid)) {
+		struct cxl_evt_dram_rec *rec =
+				(struct cxl_evt_dram_rec *)&payload->record;
+
+		trace_cxl_dram_event(dev_name, type, rec);
+		return;
+	}
+
 	/* For unknown record types print just the header */
 	trace_cxl_event(dev_name, type, &payload->record);
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 33669459ae4b..50536c0a7850 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -421,6 +421,30 @@ struct cxl_evt_gen_media {
 	u8 component_id[CXL_EVT_GEN_MED_COMP_ID_SIZE];
 } __packed;
 
+/*
+ * DRAM Event Record - DER
+ * CXL v3.0 section 8.2.9.2.1.2; Table 3-44
+ */
+#define CXL_EVT_DER_NIBBLE_MASK_SIZE		3
+#define CXL_EVT_DER_ROW_SIZE			3
+#define CXL_EVT_DER_CORRECTION_MASK_SIZE	0x20
+struct cxl_evt_dram_rec {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u16 validity_flags;
+	u8 channel;
+	u8 rank;
+	u8 nibble_mask[CXL_EVT_DER_NIBBLE_MASK_SIZE];
+	u8 bank_group;
+	u8 bank;
+	u8 row[CXL_EVT_DER_ROW_SIZE];
+	u16 column;
+	u8 correction_mask[CXL_EVT_DER_CORRECTION_MASK_SIZE];
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
index b51c51fd4e62..db9b34ddd240 100644
--- a/include/trace/events/cxl-events.h
+++ b/include/trace/events/cxl-events.h
@@ -244,6 +244,120 @@ TRACE_EVENT(cxl_gen_media_event,
 		)
 );
 
+/*
+ * DRAM Event Record - DER
+ *
+ * CXL v2.0 section 8.2.9.1.1.2; Table 155
+ */
+/*
+ * DRAM Event Record defines many fields the same as the General Media Event
+ * Record.  Reuse those definitions as appropriate.
+ */
+#define CXL_DER_VALID_CHANNEL				BIT(0)
+#define CXL_DER_VALID_RANK				BIT(1)
+#define CXL_DER_VALID_NIBBLE				BIT(2)
+#define CXL_DER_VALID_BANK_GROUP			BIT(3)
+#define CXL_DER_VALID_BANK				BIT(4)
+#define CXL_DER_VALID_ROW				BIT(5)
+#define CXL_DER_VALID_COLUMN				BIT(6)
+#define CXL_DER_VALID_CORRECTION_MASK			BIT(7)
+#define show_dram_valid_flags(flags)	__print_flags(flags, "|",			   \
+	{ CXL_DER_VALID_CHANNEL,			"CHANNEL"		}, \
+	{ CXL_DER_VALID_RANK,				"RANK"			}, \
+	{ CXL_DER_VALID_NIBBLE,				"NIBBLE"		}, \
+	{ CXL_DER_VALID_BANK_GROUP,			"BANK GROUP"		}, \
+	{ CXL_DER_VALID_BANK,				"BANK"			}, \
+	{ CXL_DER_VALID_ROW,				"ROW"			}, \
+	{ CXL_DER_VALID_COLUMN,				"COLUMN"		}, \
+	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}  \
+)
+
+TRACE_EVENT(cxl_dram_event,
+
+	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
+		 struct cxl_evt_dram_rec *rec),
+
+	TP_ARGS(dev_name, log, rec),
+
+	TP_STRUCT__entry(
+		/* Common */
+		__string(dev_name, dev_name)
+		__field(int, log)
+		__array(u8, id, UUID_SIZE)
+		__field(u32, flags)
+		__field(u16, handle)
+		__field(u16, related_handle)
+		__field(u64, timestamp)
+
+		/* DRAM */
+		__field(u64, phys_addr)
+		__field(u8, descriptor)
+		__field(u8, type)
+		__field(u8, transaction_type)
+		__field(u8, channel)
+		__field(u16, validity_flags)
+		__field(u16, column)	/* Out of order to pack trace record */
+		__field(u32, nibble_mask)
+		__field(u32, row)
+		__array(u8, cor_mask, CXL_EVT_DER_CORRECTION_MASK_SIZE)
+		__field(u8, rank)	/* Out of order to pack trace record */
+		__field(u8, bank_group)	/* Out of order to pack trace record */
+		__field(u8, bank)	/* Out of order to pack trace record */
+	),
+
+	TP_fast_assign(
+		/* Common */
+		__assign_str(dev_name, dev_name);
+		memcpy(__entry->id, &rec->hdr.id, UUID_SIZE);
+		__entry->log = log;
+		__entry->flags = le32_to_cpu(rec->hdr.flags_length) >> 8;
+		__entry->handle = le16_to_cpu(rec->hdr.handle);
+		__entry->related_handle = le16_to_cpu(rec->hdr.related_handle);
+		__entry->timestamp = le64_to_cpu(rec->hdr.timestamp);
+
+		/* DRAM */
+		__entry->phys_addr = le64_to_cpu(rec->phys_addr);
+		__entry->descriptor = rec->descriptor;
+		__entry->type = rec->type;
+		__entry->transaction_type = rec->transaction_type;
+		__entry->validity_flags = le16_to_cpu(rec->validity_flags);
+		__entry->channel = rec->channel;
+		__entry->rank = rec->rank;
+		__entry->nibble_mask = rec->nibble_mask[0] << 24 |
+				       rec->nibble_mask[1] << 16 |
+				       rec->nibble_mask[2] << 8; /* 3 byte LE ? */
+		__entry->nibble_mask = le32_to_cpu(__entry->nibble_mask);
+		__entry->bank_group = rec->bank_group;
+		__entry->bank = rec->bank;
+		__entry->row = rec->row[0] << 24 |
+			       rec->row[1] << 16 |
+			       rec->row[2] << 8; /* 3 byte LE ? */
+		__entry->row = le32_to_cpu(__entry->row);
+		__entry->column = le16_to_cpu(rec->column);
+		memcpy(__entry->cor_mask, &rec->correction_mask,
+			CXL_EVT_DER_CORRECTION_MASK_SIZE);
+	),
+
+	TP_printk("%s: %s time=%llu id=%pUl handle=%x related_handle=%x hdr_flags='%s': " \
+		  "phys_addr=%llx volatile=%s desc='%s' type='%s' trans_type='%s' channel=%u " \
+		  "rank=%u nibble_mask=%x bank_group=%u bank=%u row=%u column=%u " \
+		  "cor_mask=%s valid_flags='%s'",
+		__get_str(dev_name), show_log_type(__entry->log),
+		__entry->timestamp, __entry->id, __entry->handle,
+		__entry->related_handle, show_hdr_flags(__entry->flags),
+		__entry->phys_addr & ~CXL_GMER_PHYS_ADDR_MASK,
+		(__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
+		show_event_desc_flags(__entry->descriptor),
+		show_mem_event_type(__entry->type),
+		show_trans_type(__entry->transaction_type),
+		__entry->channel, __entry->rank, __entry->nibble_mask,
+		__entry->bank_group, __entry->bank,
+		__entry->row, __entry->column,
+		__print_hex(__entry->cor_mask, CXL_EVT_DER_CORRECTION_MASK_SIZE),
+		show_dram_valid_flags(__entry->validity_flags)
+		)
+);
+
 #endif /* _CXL_TRACE_EVENTS_H */
 
 /* This part must be outside protection */
-- 
2.35.3

