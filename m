Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0147E484EA7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiAEHSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:18:53 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16686 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiAEHSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:18:52 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JTLNW3m2ZzZdjt;
        Wed,  5 Jan 2022 15:15:23 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 15:18:50 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 15:18:50 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v2] ata: libata-scsi: Make __ata_scsi_queuecmd() parameters check more clearly
Date:   Wed, 5 Jan 2022 15:27:48 -0500
Message-ID: <20220105202747.1963919-1-haowenchao@huawei.com>
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

This is just a clean code. Since each branch of "if" state would check
scmd->cmd_len, so move the check of scmd->cmd_len out of "if" state to
simplify input parameters check.

And remove redundant init of xlat_func at hand

The patch do not change origin function logic.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/ata/libata-scsi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 313e9475507b..ab8a2833dfec 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4023,16 +4023,15 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 	ata_xlat_func_t xlat_func;
 	int rc = 0;
 
+	if (unlikely(!scmd->cmd_len))
+		goto bad_cdb_len;
+
 	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
-		if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len))
+		if (unlikely(scmd->cmd_len > dev->cdb_len))
 			goto bad_cdb_len;
 
 		xlat_func = ata_get_xlat_func(dev, scsi_op);
 	} else {
-		if (unlikely(!scmd->cmd_len))
-			goto bad_cdb_len;
-
-		xlat_func = NULL;
 		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
 			/* relay SCSI command to ATAPI device */
 			int len = COMMAND_SIZE(scsi_op);
-- 
2.32.0

