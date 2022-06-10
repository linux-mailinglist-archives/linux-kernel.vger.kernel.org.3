Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445B546D35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350250AbiFJTXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348431AbiFJTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:23:38 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514D319A716;
        Fri, 10 Jun 2022 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654889014; x=1686425014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cbrgv8TDzoatHjPZVFim5i2LawHczsWot+p66zxC0K0=;
  b=XVd2CSTYzl3LZobVdcFDTg+fA8SVCaNn2svdc8eKLxgDNd7WvK8N2sJ9
   KQznoI4Cz44I7XOyec+tgO9JyiLmzm3iWAEi9KIB1QhVaDNYx6HQwJDMy
   yQkoCPLRhdhrAu4ZJXaJ/AemJa60efXkeheKVf2bH9wOdUJsZ+Aa3A5Z2
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jun 2022 12:23:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 12:23:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 12:23:33 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 12:23:32 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 1/2] remoteproc: core: Introduce rproc_del_carveout
Date:   Fri, 10 Jun 2022 12:23:04 -0700
Message-ID: <1654888985-3846-2-git-send-email-quic_clew@quicinc.com>
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

To mirror the exported rproc_add_carveout(), add a rproc_del_carveout()
so memory carveout resources added by devices outside of remoteproc can
manage the resource lifetime more accurately.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/remoteproc/remoteproc_core.c | 20 ++++++++++++++++++++
 include/linux/remoteproc.h           |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 02a04ab34a23..ee71fccae970 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1001,6 +1001,26 @@ void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
 EXPORT_SYMBOL(rproc_add_carveout);
 
 /**
+ * rproc_del_carveout() - remove an allocated carveout region
+ * @rproc: rproc handle
+ * @mem: memory entry to register
+ *
+ * This function removes specified memory entry in @rproc carveouts list.
+ */
+void rproc_del_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
+{
+	struct rproc_mem_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
+		if (entry == mem) {
+			list_del(&mem->node);
+			return;
+		}
+	}
+}
+EXPORT_SYMBOL(rproc_del_carveout);
+
+/**
  * rproc_mem_entry_init() - allocate and initialize rproc_mem_entry struct
  * @dev: pointer on device struct
  * @va: virtual address
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 7c943f0a2fc4..43112aa78ffe 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -658,6 +658,7 @@ struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
 int devm_rproc_add(struct device *dev, struct rproc *rproc);
 
 void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
+void rproc_del_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
 
 struct rproc_mem_entry *
 rproc_mem_entry_init(struct device *dev,
-- 
2.7.4

