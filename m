Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9555918EE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiHMFdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiHMFcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:32:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D0715FF3;
        Fri, 12 Aug 2022 22:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660368773; x=1691904773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ujapPqCP6LNQD4pVgOc/QM3lsFWW4iUgs8vdQKKRFAw=;
  b=mHF/kz7XdomU2t7Ka4EjwiGG3ckuXYH7YqEnPPJIzAlZX0Rkf03h80Rw
   ME60iDLwvKohqNTawpTtxbcBPxeDGzR5Z4jJ/3WdXWN+j7YQDz/fYAiTc
   8chbmelWe1YRgCu3cAlzfiGXTazOn1HQ2euO8SPAIj2H5BAwkvaUxkY/D
   /g4KuKwOUV7cyzIA+YNjC4aY1vhFKoPUNtfir9CxR2dfB3iYndVu6F31i
   JmS2R7KTdbFsjVAw9aTifC/x4Qvtc9hsi+FR0hrtI0/sLwA3cXiGEKG8l
   q8ulbt4974uM2ZTjAFgt0WAg9luZg5R/YHAItroEdzETL14K7J3+UDVrm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292525193"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292525193"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="709235721"
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
Subject: [RFC PATCH 8/9] cxl/test: Add specific events
Date:   Fri, 12 Aug 2022 22:32:42 -0700
Message-Id: <20220813053243.757363-9-ira.weiny@intel.com>
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

Each type of event has different trace point outputs.

Add mock General Media Event, DRAM event, and Memory Module Event
records to the mock list of events returned.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/cxl/test/mem.c | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 87196d62acf5..c5d7857ae2e5 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -391,6 +391,70 @@ struct cxl_event_record_raw hardware_replace = {
 	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 };
 
+struct cxl_evt_gen_media gen_media = {
+	.hdr = {
+		.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
+				0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
+		.flags_length = cpu_to_le32((CXL_EVENT_RECORD_FLAG_PERMANENT << 8) |
+					     sizeof(struct cxl_evt_gen_media)),
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0),
+	},
+	.phys_addr = cpu_to_le64(0x2000),
+	.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
+	.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
+	.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
+	.validity_flags = cpu_to_le16(CXL_GMER_VALID_CHANNEL |
+				      CXL_GMER_VALID_RANK),
+	.channel = 1,
+	.rank = 30
+};
+
+struct cxl_evt_dram_rec dram_rec = {
+	.hdr = {
+		.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
+				0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
+		.flags_length = cpu_to_le32((CXL_EVENT_RECORD_FLAG_PERF_DEGRADED << 8) |
+					     sizeof(struct cxl_evt_dram_rec)),
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0),
+	},
+	.phys_addr = cpu_to_le64(0x8000),
+	.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
+	.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
+	.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
+	.validity_flags = cpu_to_le16(CXL_DER_VALID_CHANNEL |
+				      CXL_DER_VALID_BANK_GROUP |
+				      CXL_DER_VALID_BANK |
+				      CXL_DER_VALID_COLUMN),
+	.channel = 1,
+	.bank_group = 5,
+	.bank = 2,
+	.column = cpu_to_le16(1024)
+};
+
+struct cxl_evt_mem_mod_rec mem_mod_rec = {
+	.hdr = {
+		.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
+				0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
+		.flags_length = cpu_to_le32(sizeof(struct cxl_evt_mem_mod_rec)),
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0),
+	},
+	.event_type = CXL_MMER_TEMP_CHANGE,
+	.info = {
+		.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
+		.media_status = CXL_DHI_MS_ALL_DATA_LOST,
+		.add_status = (CXL_DHI_AS_CRITICAL << 2) |
+			      (CXL_DHI_AS_WARNING << 4) |
+			      (CXL_DHI_AS_WARNING << 5),
+		.device_temp = cpu_to_le16(1000),
+		.dirty_shutdown_cnt = cpu_to_le32(30000),
+		.cor_vol_err_cnt = cpu_to_le32(30100),
+		.cor_per_err_cnt = cpu_to_le32(40100),
+	}
+};
+
 static void devm_cxl_mock_event_logs(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
@@ -414,8 +478,14 @@ static void devm_cxl_mock_event_logs(struct cxl_memdev *cxlmd)
 	es->cxlds = cxlmd->cxlds;
 
 	event_store_add_event(es, CXL_EVENT_TYPE_INFO, &maint_needed);
+	event_store_add_event(es, CXL_EVENT_TYPE_INFO,
+			      (struct cxl_event_record_raw *)&gen_media);
+	event_store_add_event(es, CXL_EVENT_TYPE_INFO,
+			      (struct cxl_event_record_raw *)&mem_mod_rec);
 
 	event_store_add_event(es, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+	event_store_add_event(es, CXL_EVENT_TYPE_FATAL,
+			      (struct cxl_event_record_raw *)&dram_rec);
 
 	store_event_store(es);
 }
-- 
2.35.3

