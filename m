Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05565918E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiHMFdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiHMFcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:32:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C27EE0B;
        Fri, 12 Aug 2022 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660368770; x=1691904770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D6VnTO6wFUzvwPIr6RrrOgbRnQbphIg09pNi3QgmP+I=;
  b=Esjb4z22AJXUC2nR1tSch/mbd7lGB/yoW0etkEhwIAlNa2ZG9Q+JL2We
   OgBKKG9dizIisYXFFiZxb15xS4PxWvVgH/Go2MIRHCm3HeSWFiOE0L4xk
   SIeq5pZTbEnOQQT/lbM1Elqh+qXtOuhNK0PSIre7eKclPSBRTLBMSxhqV
   3KyJCyye3nLKOUAaut/9Tax7TmtezCaLU7p6JLPyz/Rn4SL/xkwAQS4Tk
   M59LMZBNmMJLrVORNWOmNmN664j8kL6t6RE6hwojuJwXOYwmnyzrgV3VN
   6relQe+GUk8y9nbT8ShdaLeCkTaz+JQlE5wgMRiNmiaQzEry/XpL8nCqe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="317706339"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="317706339"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="609456066"
Received: from jchen8-mobl.amr.corp.intel.com (HELO localhost) ([10.212.10.85])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:50 -0700
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
Subject: [RFC PATCH 6/9] cxl/mem: Trace Memory Module Event Record
Date:   Fri, 12 Aug 2022 22:32:40 -0700
Message-Id: <20220813053243.757363-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220813053243.757363-1-ira.weiny@intel.com>
References: <20220813053243.757363-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL v3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.

Determine if the event read is memory module record and if so trace the
record.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c           |  16 +++
 drivers/cxl/cxlmem.h              |  25 +++++
 include/trace/events/cxl-events.h | 155 ++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6414588a3c7b..99b09bfeaff5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -725,6 +725,14 @@ static const uuid_t dram_event_uuid =
 	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
 		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
 
+/*
+ * Memory Module Event Record
+ * CXL v3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+static const uuid_t mem_mod_event_uuid =
+	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
+		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
+
 static void cxl_trace_event_record(const char *dev_name,
 				   enum cxl_event_log_type type,
 				   struct cxl_get_event_payload *payload)
@@ -747,6 +755,14 @@ static void cxl_trace_event_record(const char *dev_name,
 		return;
 	}
 
+	if (uuid_equal(id, &mem_mod_event_uuid)) {
+		struct cxl_evt_mem_mod_rec *rec =
+				(struct cxl_evt_mem_mod_rec *)&payload->record;
+
+		trace_cxl_mem_mod_event(dev_name, type, rec);
+		return;
+	}
+
 	/* For unknown record types print just the header */
 	trace_cxl_event(dev_name, type, &payload->record);
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 50536c0a7850..a02a41dfd988 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -445,6 +445,31 @@ struct cxl_evt_dram_rec {
 	u8 correction_mask[CXL_EVT_DER_CORRECTION_MASK_SIZE];
 } __packed;
 
+/*
+ * Get Health Info Record
+ * CXL v3.0 section 8.2.9.8.3.1; Table 8-100
+ */
+struct cxl_get_health_info {
+	u8 health_status;
+	u8 media_status;
+	u8 add_status;
+	u8 life_used;
+	u16 device_temp;
+	u32 dirty_shutdown_cnt;
+	u32 cor_vol_err_cnt;
+	u32 cor_per_err_cnt;
+} __packed;
+
+/*
+ * Memory Module Event Record
+ * CXL v3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+struct cxl_evt_mem_mod_rec {
+	struct cxl_event_record_hdr hdr;
+	u8 event_type;
+	struct cxl_get_health_info info;
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
diff --git a/include/trace/events/cxl-events.h b/include/trace/events/cxl-events.h
index db9b34ddd240..dbbe25fee25c 100644
--- a/include/trace/events/cxl-events.h
+++ b/include/trace/events/cxl-events.h
@@ -358,6 +358,161 @@ TRACE_EVENT(cxl_dram_event,
 		)
 );
 
+/*
+ * Memory Module Event Record - MMER
+ *
+ * CXL v2.0 section 8.2.9.1.1.3; Table 156, Table 181
+ *
+ * Device Health Information - DHI; Table 181
+ */
+#define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
+#define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
+#define CXL_MMER_LIFE_USED_CHANGE		0x02
+#define CXL_MMER_TEMP_CHANGE			0x03
+#define CXL_MMER_DATA_PATH_ERROR		0x04
+#define CXL_MMER_LAS_ERROR			0x05
+#define show_dev_evt_type(type)	__print_symbolic(type,			   \
+	{ CXL_MMER_HEALTH_STATUS_CHANGE,	"Health Status Change"	}, \
+	{ CXL_MMER_MEDIA_STATUS_CHANGE,		"Media Status Change"	}, \
+	{ CXL_MMER_LIFE_USED_CHANGE,		"Life Used Change"	}, \
+	{ CXL_MMER_TEMP_CHANGE,			"Temperature Change"	}, \
+	{ CXL_MMER_DATA_PATH_ERROR,		"Data Path Error"	}, \
+	{ CXL_MMER_LAS_ERROR,			"LSA Error"		}  \
+)
+
+#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
+#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
+#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
+#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
+	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"Maintenance Needed"	}, \
+	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"Performance Degraded"	}, \
+	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"Replacement Needed"	}  \
+)
+
+#define CXL_DHI_MS_NORMAL							0x00
+#define CXL_DHI_MS_NOT_READY							0x01
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOST					0x02
+#define CXL_DHI_MS_ALL_DATA_LOST						0x03
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS			0x04
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN			0x05
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT				0x06
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS				0x07
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN				0x08
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT					0x09
+#define show_media_status(ms)	__print_symbolic(ms,			   \
+	{ CXL_DHI_MS_NORMAL,						   \
+		"Normal"						}, \
+	{ CXL_DHI_MS_NOT_READY,						   \
+		"Not Ready"						}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOST,				   \
+		"Write Persistency Lost"				}, \
+	{ CXL_DHI_MS_ALL_DATA_LOST,					   \
+		"All Data Lost"						}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS,		   \
+		"Write Persistency Loss in the Event of Power Loss"	}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN,		   \
+		"Write Persistency Loss in Event of Shutdown"		}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT,			   \
+		"Write Persistency Loss Imminent"			}, \
+	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS,		   \
+		"All Data Loss in Event of Power Loss"			}, \
+	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN,		   \
+		"All Data loss in the Event of Shutdown"		}, \
+	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT,			   \
+		"All Data Loss Imminent"				}  \
+)
+
+#define CXL_DHI_AS_NORMAL		0x0
+#define CXL_DHI_AS_WARNING		0x1
+#define CXL_DHI_AS_CRITICAL		0x2
+#define show_add_status(as) __print_symbolic(as,	   \
+	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
+	{ CXL_DHI_AS_WARNING,		"Warning"	}, \
+	{ CXL_DHI_AS_CRITICAL,		"Critical"	}  \
+)
+
+#define CXL_DHI_AS_LIFE_USED(as)			(as & 0x3)
+#define CXL_DHI_AS_DEV_TEMP(as)				((as & 0xC) >> 2)
+#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)			((as & 0x10) >> 4)
+#define CXL_DHI_AS_COR_PER_ERR_CNT(as)			((as & 0x20) >> 5)
+
+TRACE_EVENT(cxl_mem_mod_event,
+
+	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
+		 struct cxl_evt_mem_mod_rec *rec),
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
+		/* Memory Module Event */
+		__field(u8, event_type)
+
+		/* Device Health Info */
+		__field(u8, health_status)
+		__field(u8, media_status)
+		__field(u8, life_used)
+		__field(u32, dirty_shutdown_cnt)
+		__field(u32, cor_vol_err_cnt)
+		__field(u32, cor_per_err_cnt)
+		__field(s16, device_temp)
+		__field(u8, add_status)
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
+		/* Memory Module Event */
+		__entry->event_type = rec->event_type;
+
+		/* Device Health Info */
+		__entry->health_status = rec->info.health_status;
+		__entry->media_status = rec->info.media_status;
+		__entry->life_used = rec->info.life_used;
+		__entry->dirty_shutdown_cnt = le32_to_cpu(rec->info.dirty_shutdown_cnt);
+		__entry->cor_vol_err_cnt = le32_to_cpu(rec->info.cor_vol_err_cnt);
+		__entry->cor_per_err_cnt = le32_to_cpu(rec->info.cor_per_err_cnt);
+		__entry->device_temp = le16_to_cpu(rec->info.device_temp);
+		__entry->add_status = rec->info.add_status;
+	),
+
+	TP_printk("%s: %s time=%llu id=%pUl handle=%x related_handle=%x hdr_flags='%s': " \
+		  "evt_type='%s' health_status='%s' media_status='%s' as_life_used=%s " \
+		  "as_dev_temp=%s as_cor_vol_err_cnt=%s as_cor_per_err_cnt=%s " \
+		  "life_used=%u dev_temp=%d dirty_shutdown_cnt=%u cor_vol_err_cnt=%u " \
+		  "cor_per_err_cnt=%u",
+		__get_str(dev_name), show_log_type(__entry->log),
+		__entry->timestamp, __entry->id, __entry->handle,
+		__entry->related_handle, show_hdr_flags(__entry->flags),
+
+		show_dev_evt_type(__entry->event_type),
+		show_health_status_flags(__entry->health_status),
+		show_media_status(__entry->media_status),
+		show_add_status(CXL_DHI_AS_LIFE_USED(__entry->add_status)),
+		show_add_status(CXL_DHI_AS_DEV_TEMP(__entry->add_status)),
+		show_add_status(CXL_DHI_AS_COR_VOL_ERR_CNT(__entry->add_status)),
+		show_add_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
+		__entry->life_used, __entry->device_temp,
+		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
+		__entry->cor_per_err_cnt)
+);
+
+
 #endif /* _CXL_TRACE_EVENTS_H */
 
 /* This part must be outside protection */
-- 
2.35.3

