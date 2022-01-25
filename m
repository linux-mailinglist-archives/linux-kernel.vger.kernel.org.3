Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9850249B311
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382677AbiAYLnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:43:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4492 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382059AbiAYLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:38:43 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlGK2Rlqz67kws;
        Tue, 25 Jan 2022 19:38:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:38:22 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:38:18 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
Date:   Tue, 25 Jan 2022 19:32:36 +0800
Message-ID: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLDD TMF code is almost identical between hisi_sas, pm8001, and mvsas
drivers.

This series factors out that code into libsas, thus reducing much
duplication and giving a net reduction of ~250 LoC.

There are some subtle differences between the core TMF handler and each
of the LLDDs old implementation, so any review and testing is appreciated.

Some other minor patches are thrown in:
- Delete unused macro in hisi_sas driver
- Delete unused libsas callback
- Add enum for response frame datapres field

I have another follow-up series to factor out the internal abort code,
which is common to hisi_sas and pm8001 drivers.

Based on v5.17-rc1

John Garry (16):
  scsi: libsas: Use enum for response frame DATAPRES field
  scsi: libsas: Delete lldd_clear_aca callback
  scsi: hisi_sas: Delete unused I_T_NEXUS_RESET_PHYUP_TIMEOUT
  scsi: libsas: Move SMP task handlers to core
  scsi: libsas: Add struct sas_tmf_task
  scsi: libsas: Add sas_task.tmf
  scsi: libsas: Add sas_execute_tmf()
  scsi: libsas: Add sas_execute_ssp_tmf()
  scsi: libsas: Add TMF handler exec complete callback
  scsi: libsas: Add TMF handler aborted callback
  scsi: libsas: Add sas_abort_task_set()
  scsi: libsas: Add sas_clear_task_set()
  scsi: libsas: Add sas_lu_reset()
  scsi: libsas: Add sas_query_task()
  scsi: libsas: Add sas_abort_task()
  scsi: libsas: Add sas_execute_ata_cmd()

 Documentation/scsi/libsas.rst          |   2 -
 drivers/scsi/aic94xx/aic94xx.h         |   1 -
 drivers/scsi/aic94xx/aic94xx_init.c    |   1 -
 drivers/scsi/aic94xx/aic94xx_tmf.c     |   9 -
 drivers/scsi/hisi_sas/hisi_sas.h       |   9 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 235 ++++---------------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   9 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   2 +-
 drivers/scsi/isci/init.c               |   1 -
 drivers/scsi/isci/task.c               |  18 --
 drivers/scsi/isci/task.h               |   4 -
 drivers/scsi/libsas/sas_ata.c          |   8 +
 drivers/scsi/libsas/sas_expander.c     |  24 +--
 drivers/scsi/libsas/sas_internal.h     |   6 +
 drivers/scsi/libsas/sas_scsi_host.c    | 220 +++++++++++++++++++++++
 drivers/scsi/libsas/sas_task.c         |  12 +-
 drivers/scsi/mvsas/mv_defs.h           |   5 -
 drivers/scsi/mvsas/mv_init.c           |   5 +-
 drivers/scsi/mvsas/mv_sas.c            | 177 +------------------
 drivers/scsi/mvsas/mv_sas.h            |   3 -
 drivers/scsi/pm8001/pm8001_hwi.c       |   4 +-
 drivers/scsi/pm8001/pm8001_init.c      |   4 +-
 drivers/scsi/pm8001/pm8001_sas.c       | 180 +++----------------
 drivers/scsi/pm8001/pm8001_sas.h       |  13 +-
 include/scsi/libsas.h                  |  23 ++-
 26 files changed, 353 insertions(+), 624 deletions(-)

-- 
2.26.2

