Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A1F538DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245335AbiEaJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiEaJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:39:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ABE915BB;
        Tue, 31 May 2022 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653989984; x=1685525984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HpPXMI9Bi3DezPCVTSgROlj04GtrPbd4C+6p/iqFPoY=;
  b=QC9fZP9NuGQIgabhJ1XtHjgBUh4rAh1YjXvkcCTxaoLAbxTPxBX+JQ0l
   gMUSIScZowIxyLHUHIq6plCLa4Uqo95VlmRbNOMoSPaoJRKRbMFQaJak6
   Vv2wwJnehTiEbdGRkHmIKmKGKF20tggvC8j7GhaW+GhPBnZNVI4v9fQlW
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 31 May 2022 02:39:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 02:39:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 02:39:43 -0700
Received: from hu-ylal-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 02:39:40 -0700
From:   Yogesh Lal <quic_ylal@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <quic_sibis@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Yogesh Lal <quic_ylal@quicinc.com>
Subject: [V3 1/2] remoteproc: core: Export the rproc coredump APIs
Date:   Tue, 31 May 2022 15:09:28 +0530
Message-ID: <1653989969-26500-2-git-send-email-quic_ylal@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653989969-26500-1-git-send-email-quic_ylal@quicinc.com>
References: <1653989969-26500-1-git-send-email-quic_ylal@quicinc.com>
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

From: Siddharth Gupta <sidgup@codeaurora.org>

The remoteproc coredump APIs are currently only part of the internal
remoteproc header. This prevents the remoteproc platform drivers from
using these APIs when needed. This change moves the rproc_coredump()
and rproc_coredump_cleanup() APIs to the linux header and marks them
as exported symbols.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
---
 drivers/remoteproc/remoteproc_coredump.c | 2 ++
 drivers/remoteproc/remoteproc_internal.h | 4 ----
 include/linux/remoteproc.h               | 4 ++++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
index aee657c..aa45b68 100644
--- a/drivers/remoteproc/remoteproc_coredump.c
+++ b/drivers/remoteproc/remoteproc_coredump.c
@@ -32,6 +32,7 @@ void rproc_coredump_cleanup(struct rproc *rproc)
 		kfree(entry);
 	}
 }
+EXPORT_SYMBOL(rproc_coredump_cleanup);
 
 /**
  * rproc_coredump_add_segment() - add segment of device memory to coredump
@@ -327,6 +328,7 @@ void rproc_coredump(struct rproc *rproc)
 	 */
 	wait_for_completion(&dump_state.dump_done);
 }
+EXPORT_SYMBOL(rproc_coredump);
 
 /**
  * rproc_coredump_using_sections() - perform coredump using section headers
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index a328e63..a492a41 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -49,10 +49,6 @@ extern struct class rproc_class;
 int rproc_init_sysfs(void);
 void rproc_exit_sysfs(void);
 
-/* from remoteproc_coredump.c */
-void rproc_coredump_cleanup(struct rproc *rproc);
-void rproc_coredump(struct rproc *rproc);
-
 #ifdef CONFIG_REMOTEPROC_CDEV
 void rproc_init_cdev(void);
 void rproc_exit_cdev(void);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 83c09ac..b8c8c3a 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -673,6 +673,10 @@ void rproc_shutdown(struct rproc *rproc);
 int rproc_detach(struct rproc *rproc);
 int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
+
+/* from remoteproc_coredump.c */
+void rproc_coredump_cleanup(struct rproc *rproc);
+void rproc_coredump(struct rproc *rproc);
 void rproc_coredump_using_sections(struct rproc *rproc);
 int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
 int rproc_coredump_add_custom_segment(struct rproc *rproc,
-- 
2.7.4

