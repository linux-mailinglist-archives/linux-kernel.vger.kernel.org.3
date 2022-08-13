Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F085918EA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiHMFdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiHMFcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:32:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015D615FE2;
        Fri, 12 Aug 2022 22:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660368772; x=1691904772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pn2fg2bmNYzozNOwWHkpbnlSV9dGlikakyRWLSJKPDw=;
  b=GUvDBlmsmFu7uBGSQVdWqMsm5vTGioixLm2EhTmv8VVdnftNqzbmLB7M
   dI5suFwTvVSNKCGNMClHmrxpLT4IKQqXz3Jpmmx3E0M4CC3bzl/ExJJ3o
   eqY99aH/fClKPRD9hRcQZ1hKWsoDPzviot0b9xUuZ/ItklRoQ5ZEJvQ8p
   QhfE/SrSci22Io3hyvzBEX2txc0DXg+hZa2dm3eDYxkDf2u4WL/QCZcVO
   lk18BRLs5vjv08pC2r1v2ddnpL9AJGmLBtWqbYdvua8oENnYkMF0Wi6vj
   RZdrLixeE+ptTR89gqiiUaYuuIhkz1f4o9y9nE6/2X6X7sTG9/KYZgFEP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292525192"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292525192"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="709235717"
Received: from jchen8-mobl.amr.corp.intel.com (HELO localhost) ([10.212.10.85])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:51 -0700
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
Subject: [RFC PATCH 7/9] cxl/test: Add generic mock events
Date:   Fri, 12 Aug 2022 22:32:41 -0700
Message-Id: <20220813053243.757363-8-ira.weiny@intel.com>
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

Facilitate testing basic Get/Clear Event functionality by creating
multiple logs and generic events with made up UUID's.

Data is completely made up with data patterns which should be easy to
spot in trace output.

Test traces are easy to obtain with a small script such as this:

	#!/bin/bash -x

	devices=`find /sys/devices/platform -name cxl_mem*`

	# Generate fake events if reset is passed in
	if [ "$1" == "reset" ]; then
	        for device in $devices; do
	                echo 1 > $device/mem*/event_reset
	        done
	fi

	# Turn on tracing
	echo "" > /sys/kernel/tracing/trace
	echo 1 > /sys/kernel/tracing/events/cxl_events/enable
	echo 1 > /sys/kernel/tracing/tracing_on

	# Generate fake interrupt
	for device in $devices; do
	        echo 1 > $device/mem*/event_trigger
	        # just trigger 1
	        break;
	done

	# Turn off tracing and report events
	echo 0 > /sys/kernel/tracing/tracing_on
	cat /sys/kernel/tracing/trace

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/cxl/test/mem.c | 291 +++++++++++++++++++++++++++++++++++
 1 file changed, 291 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index e2f5445d24ff..87196d62acf5 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -9,6 +9,8 @@
 #include <linux/bits.h>
 #include <cxlmem.h>
 
+#include <trace/events/cxl-events.h>
+
 #define LSA_SIZE SZ_128K
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
@@ -137,6 +139,287 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+/*
+ * Mock Events
+ */
+struct mock_event_log {
+	int cur_event;
+	int nr_events;
+	struct xarray events;
+};
+
+struct mock_event_store {
+	struct cxl_dev_state *cxlds;
+	struct mock_event_log *mock_logs[CXL_EVENT_TYPE_MAX];
+};
+
+DEFINE_XARRAY(mock_cxlds_event_store);
+
+void delete_event_store(void *ds)
+{
+	xa_store(&mock_cxlds_event_store, (unsigned long)ds, NULL, GFP_KERNEL);
+}
+
+void store_event_store(struct mock_event_store *es)
+{
+	struct cxl_dev_state *cxlds = es->cxlds;
+
+	if (xa_insert(&mock_cxlds_event_store, (unsigned long)cxlds, es,
+		      GFP_KERNEL)) {
+		dev_err(cxlds->dev, "Event store not available for %s\n",
+			dev_name(cxlds->dev));
+		return;
+	}
+
+	devm_add_action_or_reset(cxlds->dev, delete_event_store, cxlds);
+}
+
+struct mock_event_log *find_event_log(struct cxl_dev_state *cxlds, int log_type)
+{
+	struct mock_event_store *es = xa_load(&mock_cxlds_event_store,
+					      (unsigned long)cxlds);
+
+	if (!es || log_type >= CXL_EVENT_TYPE_MAX)
+		return NULL;
+	return es->mock_logs[log_type];
+}
+
+struct cxl_event_record_raw *get_cur_event(struct mock_event_log *log)
+{
+	return xa_load(&log->events, log->cur_event);
+}
+
+__le16 get_cur_event_handle(struct mock_event_log *log)
+{
+	return cpu_to_le16(log->cur_event);
+}
+
+static bool log_empty(struct mock_event_log *log)
+{
+	return log->cur_event == log->nr_events;
+}
+
+static int log_rec_left(struct mock_event_log *log)
+{
+	return log->nr_events - log->cur_event;
+}
+
+static void xa_events_destroy(void *l)
+{
+	struct mock_event_log *log = l;
+
+	xa_destroy(&log->events);
+}
+
+static void event_store_add_event(struct mock_event_store *es,
+				  enum cxl_event_log_type log_type,
+				  struct cxl_event_record_raw *event)
+{
+	struct mock_event_log *log;
+	struct device *dev = es->cxlds->dev;
+	int rc;
+
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return;
+
+	log = es->mock_logs[log_type];
+	if (!log) {
+		log = devm_kzalloc(dev, sizeof(*log), GFP_KERNEL);
+		if (!log) {
+			dev_err(dev, "Failed to create %s log\n",
+				cxl_event_log_type_str(log_type));
+			return;
+		}
+		xa_init(&log->events);
+		devm_add_action(dev, xa_events_destroy, log);
+		es->mock_logs[log_type] = log;
+	}
+
+	rc = xa_insert(&log->events, log->nr_events, event, GFP_KERNEL);
+	if (rc) {
+		dev_err(dev, "Failed to store event %s log\n",
+			cxl_event_log_type_str(log_type));
+		return;
+	}
+	log->nr_events++;
+}
+
+/*
+ * Get and clear event only handle 1 record at a time as this is what is
+ * currently implemented in the main code.
+ */
+static int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_get_event_payload *pl;
+	struct mock_event_log *log;
+	u8 log_type;
+
+	/* Valid request? */
+	if (cmd->size_in != 1)
+		return -EINVAL;
+
+	log_type = *((u8 *)cmd->payload_in);
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return -EINVAL;
+
+	log = find_event_log(cxlds, log_type);
+	if (!log || log_empty(log))
+		goto no_data;
+
+	/* Don't handle more than 1 record at a time */
+	if (cmd->size_out < sizeof(*pl))
+		return -EINVAL;
+
+	pl = cmd->payload_out;
+	memset(pl, 0, sizeof(*pl));
+
+	pl->record_count = cpu_to_le16(1);
+
+	if (log_rec_left(log) > 1)
+		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
+
+	memcpy(&pl->record, get_cur_event(log), sizeof(pl->record));
+	pl->record.hdr.handle = get_cur_event_handle(log);
+	return 0;
+
+no_data:
+	/* Room for header? */
+	if (cmd->size_out < (sizeof(*pl) - sizeof(pl->record)))
+		return -EINVAL;
+
+	memset(cmd->payload_out, 0, cmd->size_out);
+	return 0;
+}
+
+/*
+ * Get and clear event only handle 1 record at a time as this is what is
+ * currently implemented in the main code.
+ */
+static int mock_clear_event(struct cxl_dev_state *cxlds,
+			    struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
+	struct mock_event_log *log;
+	u8 log_type = pl->event_log;
+
+	/* Don't handle more than 1 record at a time */
+	if (pl->nr_recs != 1)
+		return -EINVAL;
+
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return -EINVAL;
+
+	log = find_event_log(cxlds, log_type);
+	if (!log)
+		return 0; /* No mock data in this log */
+
+	/*
+	 * The current code clears events as they are read
+	 * Test that behavior; not clearning from the middle of the log
+	 */
+	if (log->cur_event != le16_to_cpu(pl->handle)) {
+		dev_err(cxlds->dev, "Clearing events out of order\n");
+		return -EINVAL;
+	}
+
+	log->cur_event++;
+	return 0;
+}
+
+static ssize_t event_reset_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct cxl_memdev *cxlmd = container_of(dev, struct cxl_memdev, dev);
+	int i;
+
+	for (i = CXL_EVENT_TYPE_INFO; i < CXL_EVENT_TYPE_MAX; i++) {
+		struct mock_event_log *log;
+
+		log = find_event_log(cxlmd->cxlds, i);
+		if (log)
+			log->cur_event = 0;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(event_reset);
+
+static ssize_t event_trigger_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct cxl_memdev *cxlmd = container_of(dev, struct cxl_memdev, dev);
+
+	cxl_mem_get_event_records(cxlmd->cxlds);
+
+	return count;
+}
+static DEVICE_ATTR_WO(event_trigger);
+
+static struct attribute *cxl_mock_event_attrs[] = {
+	&dev_attr_event_reset.attr,
+	&dev_attr_event_trigger.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(cxl_mock_event);
+
+void remove_mock_event_groups(void *dev)
+{
+	device_remove_groups(dev, cxl_mock_event_groups);
+}
+
+struct cxl_event_record_raw maint_needed = {
+	.hdr = {
+		.id = UUID_INIT(0xDEADBEEF, 0xCAFE, 0xBABE, 0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
+		.flags_length = cpu_to_le32((CXL_EVENT_RECORD_FLAG_MAINT_NEEDED << 8) |
+					      sizeof(struct cxl_event_record_raw)),
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0xa5b6),
+	},
+	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
+};
+
+struct cxl_event_record_raw hardware_replace = {
+	.hdr = {
+		.id = UUID_INIT(0xBABECAFE, 0xBEEF, 0xDEAD, 0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
+		.flags_length = cpu_to_le32((CXL_EVENT_RECORD_FLAG_HW_REPLACE << 8) |
+					     sizeof(struct cxl_event_record_raw)),
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0xb6a5),
+	},
+	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
+};
+
+static void devm_cxl_mock_event_logs(struct cxl_memdev *cxlmd)
+{
+	struct device *dev = &cxlmd->dev;
+	struct mock_event_store *es;
+
+	/*
+	 * The memory device gets the sysfs attributes such that the cxlmd
+	 * pointer can be used to get to a cxlds pointer.
+	 */
+	if (device_add_groups(dev, cxl_mock_event_groups))
+		return;
+	if (devm_add_action_or_reset(dev, remove_mock_event_groups, dev))
+		return;
+
+	/*
+	 * All the mock event data hangs off the device itself.
+	 */
+	es = devm_kzalloc(cxlmd->cxlds->dev, sizeof(*es), GFP_KERNEL);
+	if (!es)
+		return;
+	es->cxlds = cxlmd->cxlds;
+
+	event_store_add_event(es, CXL_EVENT_TYPE_INFO, &maint_needed);
+
+	event_store_add_event(es, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+
+	store_event_store(es);
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -224,6 +507,12 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_PARTITION_INFO:
 		rc = mock_partition_info(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_GET_EVENT_RECORD:
+		rc = mock_get_event(cxlds, cmd);
+		break;
+	case CXL_MBOX_OP_CLEAR_EVENT_RECORD:
+		rc = mock_clear_event(cxlds, cmd);
+		break;
 	case CXL_MBOX_OP_SET_LSA:
 		rc = mock_set_lsa(cxlds, cmd);
 		break;
@@ -285,6 +574,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	devm_cxl_mock_event_logs(cxlmd);
+
 	cxl_mem_get_event_records(cxlds);
 
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
-- 
2.35.3

