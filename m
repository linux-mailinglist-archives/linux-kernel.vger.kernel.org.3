Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27D14D6186
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348503AbiCKMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiCKMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:30:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9246C13D7B;
        Fri, 11 Mar 2022 04:29:41 -0800 (PST)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KFQFG4cvgz67MgZ;
        Fri, 11 Mar 2022 20:28:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 13:29:39 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 12:29:35 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/4] scsi: libsas and users: Factor out internal abort code
Date:   Fri, 11 Mar 2022 20:23:48 +0800
Message-ID: <1647001432-239276-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

This is a follow-on from the series to factor out the TMF code shared
between libsas LLDDs.

The hisi_sas and pm8001 have an internal abort feature to abort pending
commands in the host controller, prior to being sent to the target. The
driver support implementation is naturally quite similar, so factor it
out.

Again, testing and review would be appreciated.

This is based on mkp-scsi 5.18 staging queue @ commit 2bd3b6b75946

Changes since v1:
- fixup small coding issues (Damien)
- Add Tested-by tags (thanks!)

John Garry (4):
  scsi: libsas: Add sas_execute_internal_abort_single()
  scsi: libsas: Add sas_execute_internal_abort_dev()
  scsi: pm8001: Use libsas internal abort support
  scsi: hisi_sas: Use libsas internal abort support

 drivers/scsi/hisi_sas/hisi_sas.h       |   8 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 453 +++++++++----------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  11 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  18 +-
 drivers/scsi/libsas/sas_scsi_host.c    |  89 +++++
 drivers/scsi/pm8001/pm8001_hwi.c       |  27 +-
 drivers/scsi/pm8001/pm8001_hwi.h       |   5 -
 drivers/scsi/pm8001/pm8001_sas.c       | 178 +++-------
 drivers/scsi/pm8001/pm8001_sas.h       |   6 +-
 drivers/scsi/pm8001/pm80xx_hwi.h       |   5 -
 include/scsi/libsas.h                  |  24 ++
 include/scsi/sas.h                     |   2 +
 12 files changed, 360 insertions(+), 466 deletions(-)

-- 
2.26.2

