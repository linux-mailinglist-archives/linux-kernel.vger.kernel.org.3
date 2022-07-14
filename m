Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656CF5754F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbiGNS3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiGNS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:29:46 -0400
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731E275EF;
        Thu, 14 Jul 2022 11:29:45 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.156.149])
        by sinmsgout01.his.huawei.com (SkyGuard) with ESMTP id 4LkNFF60MVz9xF8b;
        Fri, 15 Jul 2022 02:24:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 20:29:39 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 19:29:37 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] hisi_sas/libsas: Some misc patches
Date:   Fri, 15 Jul 2022 02:23:17 +0800
Message-ID: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
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

Hi Martin,

This is just some random patches which I have collected for the hisi_sas
driver and libsas over the last cycle, described briefly as follows:
- Remove some duplication in slave_configure_v3_hw()
- Some DMA mapping API usage tidying
- v3 HW SATA completion error processing improvement
- For libsas, resume host when changing phy settings via sysfs - our test
  guys seem to find it useful.

Thanks in advance, John

John Garry (1):
  scsi: hisi_sas: Call hisi_sas_slave_configure() from
    slave_configure_v3_hw()

Xiang Chen (3):
  scsi: hisi_sas: Remove unnecessary variable to hold DMA map elements
  scsi: hisi_sas: Relocate DMA unmap of SMP task
  scsi: libsas: Resume SAS host for phy reset or enable via sysfs

Xingui Yang (1):
  scsi: hisi_sas: Modify v3 HW SATA completion error processing

 drivers/scsi/hisi_sas/hisi_sas_main.c  | 49 ++++++++++++--------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  2 --
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  2 --
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 16 +++++----
 drivers/scsi/libsas/sas_init.c         |  4 +++
 5 files changed, 36 insertions(+), 37 deletions(-)

-- 
2.35.3

