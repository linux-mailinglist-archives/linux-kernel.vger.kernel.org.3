Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19EE475AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbhLOOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:43:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4285 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243427AbhLOOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:02 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDdGB50Qkz67mKT;
        Wed, 15 Dec 2021 22:40:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 15:42:59 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:42:57 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/8] hisi_sas: Some misc patches
Date:   Wed, 15 Dec 2021 22:37:33 +0800
Message-ID: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small series of misc patches. Please consider for 5.17.

Briefly the series covers:
- Factoring out the common and internal abort delivery code
- Fix some races with controller reset (again!)
- Fix out-of-order interrupt handling on FPGA

I also included a pretty straightforward libsas tidy-up.

This series conflicts with [0], so whoever gets accepted second
needs to rebase.

[0] https://lore.kernel.org/linux-scsi/ba7b63a4-16f9-8b2d-e2d7-8f6fdbbe965e@hisilicon.com/T/#m3e21275f70f62bb123cb56f1db2cc25334d5117f

Thanks in advance!

John Garry (5):
  scsi: hisi_sas: Start delivery hisi_sas_task_exec() directly
  scsi: hisi_sas: Make internal abort have no task proto
  scsi: hisi_sas: Pass abort structure for internal abort
  scsi: hisi_sas: Factor out task prep and delivery code
  scsi: libsas: Decode SAM status and host byte codes

Qi Liu (3):
  scsi: hisi_sas: Prevent parallel controller reset and control phy
    command
  scsi: hisi_sas: Prevent parallel FLR and controller reset
  scsi: hisi_sas: Fix phyup timeout on FPGA

 drivers/scsi/hisi_sas/hisi_sas.h       |   5 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 339 ++++++++++++-------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  11 +-
 drivers/scsi/libsas/sas_scsi_host.c    |   7 +-
 4 files changed, 176 insertions(+), 186 deletions(-)

-- 
2.26.2

