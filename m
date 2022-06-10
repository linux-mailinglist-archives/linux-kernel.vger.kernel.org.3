Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA4546B15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbiFJQwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343590AbiFJQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:52:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761FF07;
        Fri, 10 Jun 2022 09:52:46 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LKRkX0vl6z6855X;
        Sat, 11 Jun 2022 00:49:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 18:52:43 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:52:40 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>, <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/4] pm8001 driver improvements
Date:   Sat, 11 Jun 2022 00:46:38 +0800
Message-ID: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series includes the following:
- Rework how some shost values are set
- Fix a longstanding bug that the driver attempts to use tags before they
  are configured
- Stop using {set, clear}_bit()
- Expose HW queues

Any testing would be appreciated as this driver is still broken for my
arm64 system, i.e. just broken.

John Garry (4):
  scsi: pm8001: Rework shost initial values
  scsi: pm8001: Setup tags before using them
  scsi: pm8001: Use non-atomic bitmap ops for tag alloc + free
  scsi: pm8001: Expose HW queues for pm80xx hw

 drivers/scsi/pm8001/pm8001_hwi.c  |  5 +++
 drivers/scsi/pm8001/pm8001_init.c | 73 +++++++++++++++++++++----------
 drivers/scsi/pm8001/pm8001_sas.c  | 10 +++--
 drivers/scsi/pm8001/pm8001_sas.h  |  3 ++
 drivers/scsi/pm8001/pm80xx_hwi.c  | 46 +++++++++++++++----
 5 files changed, 101 insertions(+), 36 deletions(-)

-- 
2.26.2

