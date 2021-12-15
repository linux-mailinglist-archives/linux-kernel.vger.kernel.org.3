Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085E5475AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbhLOOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:43:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4291 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbhLOOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:18 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDdCw5SgLz67wcQ;
        Wed, 15 Dec 2021 22:38:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 15:43:13 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:43:08 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Qi Liu <liuqi115@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/8] scsi: hisi_sas: Prevent parallel controller reset and control phy command
Date:   Wed, 15 Dec 2021 22:37:38 +0800
Message-ID: <1639579061-179473-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
References: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

A user may issue a control phy command from sysfs at any time, even if the
controller is resetting.

If a phy is disabled by hardreset/linkreset command before calling
get_phys_state() in the reset path, the saved phy state may be incorrect.

To avoid incorrectly recording the phy state, use hisi_hba.sem to ensure
that the controller reset may not run at the same time as when the phy
control function is running.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 8df1fd680eac..977911580d8f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1148,6 +1148,7 @@ static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
 	u8 sts = phy->phy_attached;
 	int ret = 0;
 
+	down(&hisi_hba->sem);
 	phy->reset_completion = &completion;
 
 	switch (func) {
@@ -1191,6 +1192,7 @@ static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
 out:
 	phy->reset_completion = NULL;
 
+	up(&hisi_hba->sem);
 	return ret;
 }
 
-- 
2.26.2

