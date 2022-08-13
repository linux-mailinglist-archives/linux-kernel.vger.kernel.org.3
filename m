Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1299D5918ED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiHMFdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiHMFcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:32:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87815FF6;
        Fri, 12 Aug 2022 22:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660368773; x=1691904773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tWwKqwlwjZMGb4gFh11czex8oobZlhqsXrYY+JH8bzQ=;
  b=k2SeLI8BW4s66qIdMeTUiac8ca7zsVjL06Kq1wlKObVflXzdLmWXiD/3
   aW+bW7H9vSzb5y422cjIu5wB8Lr85JXj/ACCBM6HMkiAMUekejNCCsChG
   6e4jndccIfnQUGpC/NceurTmgVxVhjqsiPiMzlkuMJZEAHcJqqD03Imwe
   JU4wmmmHJM0yFclIPgEOPmHPw3RALJt//YSKcx3ChRIn3IEuiOoGR4BE6
   nE2HYyoKDA+GV5LY9wOpDDJ771bbpeeSNngNhNkjpslF+LL1ysnpNAAXf
   vX2ld4HHSQmDGWruYpgBOSB6ibTu6vSqpzKnLsmjWyI2v1DZGMvNi4qur
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278684328"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="278684328"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="582320729"
Received: from jchen8-mobl.amr.corp.intel.com (HELO localhost) ([10.212.10.85])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:52 -0700
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
Subject: [RFC PATCH 9/9] cxl/test: Simulate event log overflow
Date:   Fri, 12 Aug 2022 22:32:43 -0700
Message-Id: <20220813053243.757363-10-ira.weiny@intel.com>
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

Log overflow is marked by a separate trace message.

Simulate a log with lots of messages and flag overflow until it is
drained a bit.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/cxl/test/mem.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index c5d7857ae2e5..87e6b10896c9 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -244,6 +244,15 @@ static void event_store_add_event(struct mock_event_store *es,
 	log->nr_events++;
 }
 
+static u16 log_overflow(struct mock_event_log *log)
+{
+	int cnt = log_rec_left(log) - 5;
+
+	if (cnt < 0)
+		return 0;
+	return cnt;
+}
+
 /*
  * Get and clear event only handle 1 record at a time as this is what is
  * currently implemented in the main code.
@@ -253,6 +262,7 @@ static int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
 	u8 log_type;
+	u16 nr_overflow;
 
 	/* Valid request? */
 	if (cmd->size_in != 1)
@@ -278,6 +288,20 @@ static int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	if (log_rec_left(log) > 1)
 		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
 
+	nr_overflow = log_overflow(log);
+	if (nr_overflow) {
+		u64 ns;
+
+		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
+		pl->overflow_err_count = cpu_to_le16(nr_overflow);
+		ns = ktime_get_real_ns();
+		ns -= 5000000000; /* 5s ago */
+		pl->first_overflow_timestamp = cpu_to_le64(ns);
+		ns = ktime_get_real_ns();
+		ns -= 1000000000; /* 1s ago */
+		pl->last_overflow_timestamp = cpu_to_le64(ns);
+	}
+
 	memcpy(&pl->record, get_cur_event(log), sizeof(pl->record));
 	pl->record.hdr.handle = get_cur_event_handle(log);
 	return 0;
@@ -483,6 +507,18 @@ static void devm_cxl_mock_event_logs(struct cxl_memdev *cxlmd)
 	event_store_add_event(es, CXL_EVENT_TYPE_INFO,
 			      (struct cxl_event_record_raw *)&mem_mod_rec);
 
+	event_store_add_event(es, CXL_EVENT_TYPE_FAIL, &maint_needed);
+	event_store_add_event(es, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(es, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&dram_rec);
+	event_store_add_event(es, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&gen_media);
+	event_store_add_event(es, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&mem_mod_rec);
+	event_store_add_event(es, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(es, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&dram_rec);
+
 	event_store_add_event(es, CXL_EVENT_TYPE_FATAL, &hardware_replace);
 	event_store_add_event(es, CXL_EVENT_TYPE_FATAL,
 			      (struct cxl_event_record_raw *)&dram_rec);
-- 
2.35.3

