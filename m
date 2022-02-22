Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461B84BF86C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiBVM5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBVM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:57:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCF96548;
        Tue, 22 Feb 2022 04:56:34 -0800 (PST)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2zZW4T2yz67ZkT;
        Tue, 22 Feb 2022 20:51:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 13:56:32 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:56:28 +0000
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
Subject: [PATCH v3 00/18] scsi: libsas and users: Factor out LLDD TMF code
Date:   Tue, 22 Feb 2022 20:50:41 +0800
Message-ID: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

This is just an update of the series to fix a build error, as reported
here:
https://lore.kernel.org/lkml/59b538b7-b4c5-8111-d2bf-7fb353ecb19b@huawei.com/

Original cover letter is here:
https://lore.kernel.org/linux-scsi/0d4f988d-881c-3717-f9d8-38739cf17e91@opensource.wdc.com/T/#mcae9d344f2795bdbb8845da29a140b58dbafb6f8

I also included Damien's Tested-by tags.

Baseline is mkp-scsi 5.18/scsi-staging at ac2beb4e3bd7

Damien's following series is based on this series:
https://lore.kernel.org/linux-scsi/20220220031810.738362-1-damien.lemoal@opensource.wdc.com/T/#t

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
 include/scsi/libsas.h                  |  21 ++-
 include/scsi/sas.h                     |   7 +
 include/scsi/sas_ata.h                 |   8 +
 29 files changed, 382 insertions(+), 640 deletions(-)

-- 
2.26.2

