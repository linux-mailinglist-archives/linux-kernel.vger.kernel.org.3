Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3765C546D36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350298AbiFJTXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348545AbiFJTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:23:38 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC7B19A711;
        Fri, 10 Jun 2022 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654889015; x=1686425015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=S+DeJ3MsyXef9jo7MlX4F9bDqqCTfY+AdSWc6kyR9DU=;
  b=ncy1UTC5atH6gW77/v/eQAPDyQK9dErNoTeO9y0XPdZGqiz1kTxCgaSU
   KY6a2M2ydId3Ivbp/9YYMt7YTBTW/YbddmDi2XguXN5Y9UdaXJbRQfny1
   6G2F3R5yPfFOXFCh7Xma4zUoLuoWLfhJcp9e64u0yRHhCMY/QXFL6yNYY
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jun 2022 12:23:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 12:23:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 12:23:33 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 12:23:33 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 2/2] remoteproc: core: Introduce rproc_mem_entry_free
Date:   Fri, 10 Jun 2022 12:23:05 -0700
Message-ID: <1654888985-3846-3-git-send-email-quic_clew@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654888985-3846-1-git-send-email-quic_clew@quicinc.com>
References: <1654888985-3846-1-git-send-email-quic_clew@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a helper to free the rproc_mem_entry allocated by
rproc_mem_entry_init(). This helper is to help manage rproc carveouts
added to an rproc outside of remoteproc.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/remoteproc/remoteproc_core.c | 13 +++++++++++++
 include/linux/remoteproc.h           |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ee71fccae970..161691fd2e96 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1069,6 +1069,19 @@ rproc_mem_entry_init(struct device *dev,
 EXPORT_SYMBOL(rproc_mem_entry_init);
 
 /**
+ * rproc_mem_entry_free() - free a rproc_mem_entry struct
+ * @mem: rproc_mem_entry allocated by rproc_mem_entry_init()
+ *
+ * This function frees a rproc_mem_entry_struct that was allocated by
+ * rproc_mem_entry_init().
+ */
+void rproc_mem_entry_free(struct rproc_mem_entry *mem)
+{
+	kfree(mem);
+}
+EXPORT_SYMBOL(rproc_mem_entry_free);
+
+/**
  * rproc_of_resm_mem_entry_init() - allocate and initialize rproc_mem_entry struct
  * from a reserved memory phandle
  * @dev: pointer on device struct
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 43112aa78ffe..9b039f37da12 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -666,6 +666,7 @@ rproc_mem_entry_init(struct device *dev,
 		     int (*alloc)(struct rproc *, struct rproc_mem_entry *),
 		     int (*release)(struct rproc *, struct rproc_mem_entry *),
 		     const char *name, ...);
+void rproc_mem_entry_free(struct rproc_mem_entry *mem);
 
 struct rproc_mem_entry *
 rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
-- 
2.7.4

