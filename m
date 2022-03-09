Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16B44D30EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiCIOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiCIOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:23:22 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643F10663D;
        Wed,  9 Mar 2022 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646835743; x=1678371743;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=utZudFEG5bj1HKs2HiMq3ks1vgQFbEKEBct6iAdjyKU=;
  b=tkRNtRRlrB4V9yaQOnsj1Zyz2fgfBkPlBz23xRqHqRCPGYsoziMMKELa
   uxuBRnkrexs6M0733EpCeb1yLl68IIP56FBx0/xcpJWx/lSjFnP3pbRQI
   dBb+uqFsFTeRje1NExrCkcjmD1xXopiGgneYdW9wiWQpDssICJ9yuNZ0m
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 09 Mar 2022 06:22:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 06:22:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 06:22:22 -0800
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 06:22:22 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v3] coresight: core: Fix coresight device probe failure issue
Date:   Wed, 9 Mar 2022 06:22:06 -0800
Message-ID: <20220309142206.15632-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
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

It is possibe that probe failure issue happens when the device
and its child_device's probe happens at the same time.
In coresight_make_links, has_conns_grp is true for parent, but
has_conns_grp is false for child device as has_conns_grp is set
to true in coresight_create_conns_sysfs_group. The probe of parent
device will fail at this condition. Add has_conns_grp check for
child device before make the links and make the process from
device_register to connection_create be atomic to avoid this
probe failure issue.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Suggested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 33 +++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 88653d1c06a4..7fed6e9c0ca1 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1382,7 +1382,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
 			continue;
 		conn->child_dev =
 			coresight_find_csdev_by_fwnode(conn->child_fwnode);
-		if (conn->child_dev) {
+		if (conn->child_dev && conn->child_dev->has_conns_grp) {
 			ret = coresight_make_links(csdev, conn,
 						   conn->child_dev);
 			if (ret)
@@ -1574,6 +1574,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	int nr_refcnts = 1;
 	atomic_t *refcnts = NULL;
 	struct coresight_device *csdev;
+	bool registered = false;
 
 	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
 	if (!csdev) {
@@ -1594,7 +1595,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
 	if (!refcnts) {
 		ret = -ENOMEM;
-		goto err_free_csdev;
+		kfree(csdev);
+		goto err_out;
 	}
 
 	csdev->refcnt = refcnts;
@@ -1619,6 +1621,13 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
 	dev_set_name(&csdev->dev, "%s", desc->name);
 
+	/*
+	 * Make sure the device registration and the connection fixup
+	 * are synchronised, so that we don't see uninitialised devices
+	 * on the coresight bus while trying to resolve the connections.
+	 */
+	mutex_lock(&coresight_mutex);
+
 	ret = device_register(&csdev->dev);
 	if (ret) {
 		put_device(&csdev->dev);
@@ -1626,7 +1635,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		 * All resources are free'd explicitly via
 		 * coresight_device_release(), triggered from put_device().
 		 */
-		goto err_out;
+		goto out_unlock;
 	}
 
 	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
@@ -1641,11 +1650,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 			 * from put_device(), which is in turn called from
 			 * function device_unregister().
 			 */
-			goto err_out;
+			goto out_unlock;
 		}
 	}
-
-	mutex_lock(&coresight_mutex);
+	/* Device is now registered */
+	registered = true;
 
 	ret = coresight_create_conns_sysfs_group(csdev);
 	if (!ret)
@@ -1655,16 +1664,18 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	if (!ret && cti_assoc_ops && cti_assoc_ops->add)
 		cti_assoc_ops->add(csdev);
 
+out_unlock:
 	mutex_unlock(&coresight_mutex);
-	if (ret) {
+	/* Success */
+	if (!ret)
+		return csdev;
+
+	/* Unregister the device if needed */
+	if (registered) {
 		coresight_unregister(csdev);
 		return ERR_PTR(ret);
 	}
 
-	return csdev;
-
-err_free_csdev:
-	kfree(csdev);
 err_out:
 	/* Cleanup the connection information */
 	coresight_release_platform_data(NULL, desc->pdata);
-- 
2.17.1

