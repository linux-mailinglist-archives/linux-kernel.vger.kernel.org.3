Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67947F2F0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 11:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhLYKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 05:19:34 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30109 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhLYKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 05:19:33 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JLfwL5rNQz1DJkm;
        Sat, 25 Dec 2021 18:16:18 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 18:19:31 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 25 Dec
 2021 18:19:30 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>, Wu Bo <wubo40@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH] scsi: Do not break scan luns loop if add single lun failed
Date:   Sat, 25 Dec 2021 18:29:12 -0500
Message-ID: <20211225232911.1117843-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failed to add a single lun does not mean all luns are unaccessible,
if we break the scan luns loop, the other luns reported by REPORT LUNS
command would not be probed any more.

In this case, we might loss some luns which are accessible.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/scsi_scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 23e1c0acdeae..fee7ce082103 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1476,13 +1476,13 @@ static int scsi_report_lun_scan(struct scsi_target *starget, blist_flags_t bflag
 				lun, NULL, NULL, rescan, NULL);
 			if (res == SCSI_SCAN_NO_RESPONSE) {
 				/*
-				 * Got some results, but now none, abort.
+				 * Got some results, but now none, abort this lun
 				 */
 				sdev_printk(KERN_ERR, sdev,
 					"Unexpected response"
 					" from lun %llu while scanning, scan"
 					" aborted\n", (unsigned long long)lun);
-				break;
+				continue;
 			}
 		}
 	}
-- 
2.32.0

