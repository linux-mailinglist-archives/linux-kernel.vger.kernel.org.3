Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4BE564F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGDIM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiGDIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:12:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E582CAE57
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:12:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b26so12301327wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RD0yzf+F/wW0874+yGj00tt1sAsOODbCCotfldJYXsg=;
        b=hcEcJ7ns/gDL/SPp/Q9o35fae7VnIMiUSrjHnnvnbdRHvCyC1Q5lL5UZ7a5yYfucD5
         dNiPfF3xc1mhZhnrMP9+lJCag31oL+3s85nFsUn82h9i5sFOT3iLlnJ0SWSsQr8uA0aS
         BZRyFt1jK9VgYkMKyS6D4Nz+hEhsVgGUkPEOJY5ayb1EWcBFdVqELF/6D86PwPTA7FMp
         ynczGVyXKE/ptYSZkDtEB7Ef+JDowffpSJ1eQFuyq5uxppKfOZbVkl2T+Q1h08xperFx
         jSVLCZNbIk2JsdnzmQGw9a0Kh65h74eyTGE761E3w14LS1+VppAUog1BFhC6aeJl8rR9
         rK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RD0yzf+F/wW0874+yGj00tt1sAsOODbCCotfldJYXsg=;
        b=DQFJB91aMwEdWtQHL6PQa3JAdPmQz+1pEW44BlU/M1GQEb/Z+N2wQDn66jXHXKQl6I
         qh8mezh7VikYKCtmELXqR9AO1GuLfLDPEwCP9XN+hQzO75QIBrooRKY97Eoj65mlOKy6
         KbT9EFPpOel47QBo0y4oyH49CpSlmlTZsqk2GFUDSYAR/nw7uRjdQ7ZRsJGnIyxKof2U
         ki2QNnRcjE+z7wF1XFXdUXJrocxJDPFkASnLR2ye8NCaq+uj75SfzCXEjx1pXbHsUNX/
         eu9f9Yzt+oD/B3p5HbW9l5C3ACzjx4n3OhJ7Xo9snnZLXNiPMgWOLgZxXd3Pwm29ZfPv
         Yj4w==
X-Gm-Message-State: AJIora82dLUQm/Sx5n2CdJx0Q2NMGls4jpD351+MXqHy2CmBx3tKMKUE
        gxqcUBnqV3H68mWy38O0cvICZQ==
X-Google-Smtp-Source: AGRyM1v2EdBohgY7Hcu9Zs15xs8AkLH6u4h7mC1gnbQmE4uwovpy9Ig2GJdmRhweyx5rQeV2j6QoDQ==
X-Received: by 2002:adf:dd0d:0:b0:21d:666b:298e with SMTP id a13-20020adfdd0d000000b0021d666b298emr6601500wrm.412.1656922319480;
        Mon, 04 Jul 2022 01:11:59 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:59 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 08/13] perf: cs-etm: Move mapping of Trace ID and cpu into helper function
Date:   Mon,  4 Jul 2022 09:11:44 +0100
Message-Id: <20220704081149.16797-9-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704081149.16797-1-mike.leach@linaro.org>
References: <20220704081149.16797-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The information to associate Trace ID and CPU will be changing.
Drivers will start outputting this as a hardware ID packet in the data
file and setting the value in AUXINFO to an unused value.

To prepare for this, we only map Trace ID and CPU data from AUXINFO if the
header version and values are valid, and move the mapping into a
helper function.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/util/cs-etm.c | 53 +++++++++++++++++++++++++++-------------
 tools/perf/util/cs-etm.h | 14 +++++++++--
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b95fb3c4d7b..df9d67901f8d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -193,6 +193,30 @@ int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
 	return 0;
 }
 
+static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
+{
+	struct int_node *inode;
+
+	/* Get an RB node for this CPU */
+	inode = intlist__findnew(traceid_list, trace_chan_id);
+
+	/* Something went wrong, no need to continue */
+	if (!inode)
+		return -ENOMEM;
+
+	/*
+	 * The node for that CPU should not be taken.
+	 * Back out if that's the case.
+	 */
+	if (inode->priv)
+		return -EINVAL;
+
+	/* All good, associate the traceID with the metadata pointer */
+	inode->priv = cpu_metadata;
+
+	return 0;
+}
+
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id)
 {
@@ -2886,7 +2910,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct cs_etm_auxtrace *etm = NULL;
-	struct int_node *inode;
 	unsigned int pmu_type;
 	int event_header_size = sizeof(struct perf_event_header);
 	int info_header_size;
@@ -2898,6 +2921,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	u64 *ptr, *hdr = NULL;
 	u64 **metadata = NULL;
 	u64 hdr_version;
+	u8 trace_chan_id;
 
 	/*
 	 * sizeof(auxtrace_info_event::type) +
@@ -2991,25 +3015,20 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 			goto err_free_metadata;
 		}
 
-		/* Get an RB node for this CPU */
-		inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
-
-		/* Something went wrong, no need to continue */
-		if (!inode) {
-			err = -ENOMEM;
-			goto err_free_metadata;
-		}
-
 		/*
-		 * The node for that CPU should not be taken.
-		 * Back out if that's the case.
+		 * Associate a trace ID with metadata.
+		 * Later versions of the drivers will make this association using a
+		 * hardware ID packet in the data file, setting the value in AUXINFO to an
+		 * invalid trace ID value. Only map here if the value is valid.
 		 */
-		if (inode->priv) {
-			err = -EINVAL;
-			goto err_free_metadata;
+		if (hdr_version <  CS_AUX_HW_ID_VERSION_MIN) {
+			trace_chan_id = metadata[j][trcidr_idx];
+			if (CS_IS_VALID_TRACE_ID(trace_chan_id)) {
+				err = cs_etm__map_trace_id(trace_chan_id, metadata[j]);
+				if (err)
+					goto err_free_metadata;
+			}
 		}
-		/* All good, associate the traceID with the metadata pointer */
-		inode->priv = metadata[j];
 	}
 
 	/*
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 90c83f932d9a..712a6f855f0e 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -28,13 +28,17 @@ enum {
 /*
  * Update the version for new format.
  *
- * New version 1 format adds a param count to the per cpu metadata.
+ * Version 1: format adds a param count to the per cpu metadata.
  * This allows easy adding of new metadata parameters.
  * Requires that new params always added after current ones.
  * Also allows client reader to handle file versions that are different by
  * checking the number of params in the file vs the number expected.
+ *
+ * Version 2: Drivers will use PERF_RECORD_AUX_OUTPUT_HW_ID to output
+ * CoreSight Trace ID. ...TRACEIDR metadata will be set to unused ID.
  */
-#define CS_HEADER_CURRENT_VERSION 1
+#define CS_HEADER_CURRENT_VERSION	2
+#define CS_AUX_HW_ID_VERSION_MIN	2
 
 /* Beginning of header common to both ETMv3 and V4 */
 enum {
@@ -85,6 +89,12 @@ enum {
 	CS_ETE_PRIV_MAX
 };
 
+/*
+ * Check for valid CoreSight trace ID. If an invalid value is present in the metadata,
+ * then IDs are present in the hardware ID packet in the data file.
+ */
+#define CS_IS_VALID_TRACE_ID(id) ((id > 0) && (id < 0x70))
+
 /*
  * ETMv3 exception encoding number:
  * See Embedded Trace Macrocell specification (ARM IHI 0014Q)
-- 
2.17.1

