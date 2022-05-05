Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7163051C65F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382798AbiEERp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiEERpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:45:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5E64C8;
        Thu,  5 May 2022 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651772504; x=1683308504;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ScniDQeyViqXsNKboACYzMfjH1l8ZsslcEthdej/xUg=;
  b=sTPpkUQaZ2E7O4Ps/P2lEtSl9Jf+5wD6pjeZfnSoBg1kiEeVB9NcaR8O
   8C3Fdw8zPiySHPb6A6ShKObDm8UzZ2fBuXM4C0zd53VwT0VW4Zo4mkKMM
   v0D6eXuVfEe56Da/1uYda4qDhKIo2UO1qoRvH+bc+CVLWfkZQBthKZseS
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 05 May 2022 10:41:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:41:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:41:28 -0700
Received: from hu-ylal-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:41:25 -0700
From:   Yogesh Lal <quic_ylal@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <quic_sibis@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Subject: [PATCH 1/2] remoteproc: core: Export the rproc coredump APIs
Date:   Thu, 5 May 2022 23:11:13 +0530
Message-ID: <1651772474-18197-1-git-send-email-quic_ylal@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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

