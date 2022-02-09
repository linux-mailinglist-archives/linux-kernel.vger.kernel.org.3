Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19184AF073
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiBIL64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiBIL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:33 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234B4C03C1A8;
        Wed,  9 Feb 2022 02:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644404256; x=1675940256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3kiFpI07EnzwZ5nN8FzjjtnDT53hUSR362ANVvAN0S0=;
  b=sKz2GFkc8W2n901MsQzmjenZ8zOwBdJf+/4hOwt+aZS+cBRgFyo8CFMi
   6qo87IfsFQvKnR0RcZXlMSHf166kF1F22HJu93+K4R/nOciQ70UZQD8MQ
   b7klHCq8jT8xlXu2pEKTJ7qUvJrj6tF6H5CM2Ph8jrTt+u6wRx8DuL465
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 02:57:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 02:57:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:57:33 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:57:29 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 01/10] Use IDR to maintain all the enabled sources' paths.
Date:   Wed, 9 Feb 2022 18:56:57 +0800
Message-ID: <20220209105706.18852-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Use hash length of the source's device name to map to the pointer
of the enabled path. Using IDR will be more efficient than using
the list. And there could be other sources except STM and CPU etms
in the new HWs. It is better to maintain all the paths together.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 76 +++++++-------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 88653d1c06a4..a90097f88425 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -26,6 +27,12 @@
 static DEFINE_MUTEX(coresight_mutex);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
 
+/*
+ * Use IDR to map the hash length of the source's device name
+ * to the pointer of path for the source
+ */
+static DEFINE_IDR(path_idr);
+
 /**
  * struct coresight_node - elements of a path, from source to sink
  * @csdev:	Address of an element.
@@ -36,20 +43,6 @@ struct coresight_node {
 	struct list_head link;
 };
 
-/*
- * When operating Coresight drivers from the sysFS interface, only a single
- * path can exist from a tracer (associated to a CPU) to a sink.
- */
-static DEFINE_PER_CPU(struct list_head *, tracer_path);
-
-/*
- * As of this writing only a single STM can be found in CS topologies.  Since
- * there is no way to know if we'll ever see more and what kind of
- * configuration they will enact, for the time being only define a single path
- * for STM.
- */
-static struct list_head *stm_path;
-
 /*
  * When losing synchronisation a new barrier packet needs to be inserted at the
  * beginning of the data collected in a buffer.  That way the decoder knows that
@@ -1088,10 +1081,11 @@ static int coresight_validate_source(struct coresight_device *csdev,
 
 int coresight_enable(struct coresight_device *csdev)
 {
-	int cpu, ret = 0;
+	int ret = 0;
 	struct coresight_device *sink;
 	struct list_head *path;
 	enum coresight_dev_subtype_source subtype;
+	u32 hash;
 
 	subtype = csdev->subtype.source_subtype;
 
@@ -1133,26 +1127,14 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto err_source;
 
-	switch (subtype) {
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
-		/*
-		 * When working from sysFS it is important to keep track
-		 * of the paths that were created so that they can be
-		 * undone in 'coresight_disable()'.  Since there can only
-		 * be a single session per tracer (when working from sysFS)
-		 * a per-cpu variable will do just fine.
-		 */
-		cpu = source_ops(csdev)->cpu_id(csdev);
-		per_cpu(tracer_path, cpu) = path;
-		break;
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
-		stm_path = path;
-		break;
-	default:
-		/* We can't be here */
-		break;
-	}
-
+	/*
+	 * Use the hash length of source's device name as ID
+	 * and map the ID to the pointer of the path.
+	 */
+	hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
+	ret = idr_alloc_u32(&path_idr, path, &hash, hash, GFP_KERNEL);
+	if (ret)
+		goto err_source;
 out:
 	mutex_unlock(&coresight_mutex);
 	return ret;
@@ -1168,8 +1150,9 @@ EXPORT_SYMBOL_GPL(coresight_enable);
 
 void coresight_disable(struct coresight_device *csdev)
 {
-	int cpu, ret;
+	int ret;
 	struct list_head *path = NULL;
+	u32 hash;
 
 	mutex_lock(&coresight_mutex);
 
@@ -1180,21 +1163,16 @@ void coresight_disable(struct coresight_device *csdev)
 	if (!csdev->enable || !coresight_disable_source(csdev))
 		goto out;
 
-	switch (csdev->subtype.source_subtype) {
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
-		cpu = source_ops(csdev)->cpu_id(csdev);
-		path = per_cpu(tracer_path, cpu);
-		per_cpu(tracer_path, cpu) = NULL;
-		break;
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
-		path = stm_path;
-		stm_path = NULL;
-		break;
-	default:
-		/* We can't be here */
-		break;
+	hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
+	/* Find the path by the hash length. */
+	path = idr_find(&path_idr, hash);
+	if (path == NULL) {
+		dev_info(&csdev->dev, "Path is not found for %s\n",
+				dev_name(&csdev->dev));
+		return;
 	}
 
+	idr_remove(&path_idr, hash);
 	coresight_disable_path(path);
 	coresight_release_path(path);
 
-- 
2.17.1

