Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0046E9BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhLIOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:20:04 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:61611 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhLIOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639059390; x=1670595390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=AzPD1WoFBGnMhjs5plCLFR7JEN6Rj7aU/8x0LI3lULk=;
  b=vcEi8RHk/j+KbxBAkO4rxgtyf0JYW31//lSXTEfk1F+hJNhuj274rlB4
   xVgb9dgnNLD3USoI0QPQ9J5Tic4JyitWfpX9027h/qnSxj9vpnT8hLGQs
   bf/a/ioK2mPNX0dJqlt8Vq/7WKuOwonGC7mjPDtWXSqLhIhZA6RH8gowT
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Dec 2021 06:16:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:16:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:29 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:25 -0800
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
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 1/9] Use IDR to maintain all the enabled sources' paths.
Date:   Thu, 9 Dec 2021 22:15:35 +0800
Message-ID: <20211209141543.21314-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
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
 1 file changed, 26 insertions(+), 50 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 8a18c71df37a..cc6b6cabf85f 100644
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
 
@@ -1180,21 +1163,13 @@ void coresight_disable(struct coresight_device *csdev)
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
-	}
+	hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
+	/* Find the path by the hash length. */
+	path = idr_find(&path_idr, hash);
+	if (path == NULL)
+		return;
 
+	idr_remove(&path_idr, hash);
 	coresight_disable_path(path);
 	coresight_release_path(path);
 
@@ -1779,6 +1754,7 @@ static int __init coresight_init(void)
 
 static void __exit coresight_exit(void)
 {
+	idr_destroy(&path_idr);
 	cscfg_exit();
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
-- 
2.17.1

