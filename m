Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA54B0B57
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbiBJKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:48:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240064AbiBJKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:48:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07047FFE;
        Thu, 10 Feb 2022 02:48:49 -0800 (PST)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JvYQ0087zz6892w;
        Thu, 10 Feb 2022 18:48:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 11:48:46 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 10:48:43 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <hch@lst.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH 0/2] scsi: libsas: Drop SAS_TASK_AT_INITIATOR
Date:   Thu, 10 Feb 2022 18:43:22 +0800
Message-ID: <1644489804-85730-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from some isci driver code, flag SAS_TASK_AT_INITIATOR is only set,
so drop usage in that driver and then everywhere else.

This solves a use-after-free in the pm8001 queue path.

John Garry (2):
  scsi: isci: Drop SAS_TASK_AT_INITIATOR check in isci_task_abort_task()
  scsi: libsas: Drop SAS_TASK_AT_INITIATOR

 drivers/scsi/aic94xx/aic94xx_task.c    |  9 ---------
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  8 +-------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  3 +--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  3 +--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  3 +--
 drivers/scsi/isci/request.c            | 15 +++++----------
 drivers/scsi/isci/request.h            |  5 ++++-
 drivers/scsi/isci/task.c               | 23 +++++++++--------------
 drivers/scsi/mvsas/mv_sas.c            |  6 +-----
 drivers/scsi/pm8001/pm8001_hwi.c       |  7 -------
 drivers/scsi/pm8001/pm8001_sas.c       |  4 ----
 drivers/scsi/pm8001/pm80xx_hwi.c       |  5 -----
 include/scsi/libsas.h                  |  1 -
 13 files changed, 23 insertions(+), 69 deletions(-)

-- 
2.26.2

