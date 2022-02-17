Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B634BA4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiBQPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:48:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiBQPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:48:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B8154703;
        Thu, 17 Feb 2022 07:48:24 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jzzk12yvBz67bBx;
        Thu, 17 Feb 2022 23:47:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 16:48:21 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 15:48:17 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <damien.lemoal@opensource.wdc.com>,
        <hch@lst.de>
CC:     <Ajish.Koshy@microchip.com>, <yanaijie@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <Viswas.G@microchip.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 00/18] scsi: libsas and users: Factor out LLDD TMF code
Date:   Thu, 17 Feb 2022 23:42:28 +0800
Message-ID: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The LLDD TMF code is almost identical between hisi_sas, pm8001, and mvsas
drivers.

This series factors out that code into libsas, thus reducing much
duplication and giving a net reduction of ~350 LoC.

There are some subtle differences between the core TMF handler and each
of the LLDDs old implementation, so any review and testing is appreciated.

Some other minor patches are thrown in:
- Delete unused macro in hisi_sas driver
- Delete unused libsas callback
- Delete unused SAS_SG_ERR
- Add enum for response frame datapres field
- Handle unrecognised errors in sas_scsi_find_task()

I have another follow-up series to factor out the internal abort code,
which is common to hisi_sas and pm8001 drivers.

Based on mkp-scsi 5.18 staging queue at commit ac2beb4e3bd7

Differences to v1:
- Add Reviewed-by and Tested-by tags (Thanks!)
- Add SAS_SG_ERR patch
- Add sas_scsi_find_task() patch
- Use switch statement in sas_ssp_task_response()
- Add DATAPRES enum in sas.h
- Reword "Add struct sas_tmf_task" patch
- Don't print TMF code in sas_execute_tmf()
- Rebase

John Garry (18):
  scsi: libsas: Handle non-TMF codes in sas_scsi_find_task()
  scsi: libsas: Use enum for response frame DATAPRES field
  scsi: libsas: Delete lldd_clear_aca callback
  scsi: libsas: Delete SAS_SG_ERR
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
 drivers/scsi/aic94xx/aic94xx_tmf.c     |  11 +-
 drivers/scsi/hisi_sas/hisi_sas.h       |   9 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 227 ++++--------------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   9 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   2 +-
 drivers/scsi/isci/init.c               |   1 -
 drivers/scsi/isci/request.c            |   7 +-
 drivers/scsi/isci/task.c               |  18 --
 drivers/scsi/isci/task.h               |   4 -
 drivers/scsi/libsas/sas_ata.c          |  10 +-
 drivers/scsi/libsas/sas_expander.c     |  24 +--
 drivers/scsi/libsas/sas_internal.h     |   6 +
 drivers/scsi/libsas/sas_scsi_host.c    | 229 ++++++++++++++++++++++++-
 drivers/scsi/libsas/sas_task.c         |  14 +-
 drivers/scsi/mvsas/mv_defs.h           |   5 -
 drivers/scsi/mvsas/mv_init.c           |   5 +-
 drivers/scsi/mvsas/mv_sas.c            | 179 +------------------
 drivers/scsi/mvsas/mv_sas.h            |   3 -
 drivers/scsi/pm8001/pm8001_hwi.c       |   4 +-
 drivers/scsi/pm8001/pm8001_init.c      |   5 +-
 drivers/scsi/pm8001/pm8001_sas.c       | 194 ++++-----------------
 drivers/scsi/pm8001/pm8001_sas.h       |  14 +-
 include/scsi/libsas.h                  |  24 ++-
 include/scsi/sas.h                     |   7 +
 28 files changed, 377 insertions(+), 640 deletions(-)

-- 
2.26.2

