Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB1575505
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbiGNSaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiGNSaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:30:04 -0400
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22E06B252;
        Thu, 14 Jul 2022 11:30:01 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.156.207])
        by sinmsgout02.his.huawei.com (SkyGuard) with ESMTP id 4LkNL60NFLz9v7J0;
        Fri, 15 Jul 2022 02:29:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 20:29:51 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 19:29:48 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/5] scsi: libsas: Resume SAS host for phy reset or enable via sysfs
Date:   Fri, 15 Jul 2022 02:23:22 +0800
Message-ID: <1657823002-139010-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
References: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Currently if a phy reset or enable phy is issued via sysfs when controller
is suspended, those operations will be ignored as SAS_HA_REGISTERED is
cleared. If RPM is enabled then we may aggressively suspend automatically.
In this case it may be difficult to enable or reset a phy via sysfs, so
resume the host in these scenarios.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index dc35f0f8eae3..e4f77072a58d 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -531,6 +531,7 @@ static int queue_phy_reset(struct sas_phy *phy, int hard_reset)
 	if (!d)
 		return -ENOMEM;
 
+	pm_runtime_get_sync(ha->dev);
 	/* libsas workqueue coordinates ata-eh reset with discovery */
 	mutex_lock(&d->event_lock);
 	d->reset_result = 0;
@@ -544,6 +545,7 @@ static int queue_phy_reset(struct sas_phy *phy, int hard_reset)
 	if (rc == 0)
 		rc = d->reset_result;
 	mutex_unlock(&d->event_lock);
+	pm_runtime_put_sync(ha->dev);
 
 	return rc;
 }
@@ -558,6 +560,7 @@ static int queue_phy_enable(struct sas_phy *phy, int enable)
 	if (!d)
 		return -ENOMEM;
 
+	pm_runtime_get_sync(ha->dev);
 	/* libsas workqueue coordinates ata-eh reset with discovery */
 	mutex_lock(&d->event_lock);
 	d->enable_result = 0;
@@ -571,6 +574,7 @@ static int queue_phy_enable(struct sas_phy *phy, int enable)
 	if (rc == 0)
 		rc = d->enable_result;
 	mutex_unlock(&d->event_lock);
+	pm_runtime_put_sync(ha->dev);
 
 	return rc;
 }
-- 
2.35.3

