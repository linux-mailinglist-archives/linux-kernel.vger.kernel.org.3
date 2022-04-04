Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436B14F17C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378345AbiDDPBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378318AbiDDPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:00:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C62DEE2;
        Mon,  4 Apr 2022 07:58:54 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXDQH0Xx4z67ms2;
        Mon,  4 Apr 2022 22:57:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:58:52 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 15:58:50 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/2] libata: A tagging improvement and related code reorg
Date:   Mon, 4 Apr 2022 22:53:08 +0800
Message-ID: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to the series at [0] to fix SCSI device tagging and
use the per-device token as the libata qc tag.

I added the changes Christoph shared on the list to move
the functionality from ata_qc_new_init() into libata-scsi.c

Please do not apply on a kernel which does not include
"scsi: core: Fix sbitmap depth in scsi_realloc_sdev_budget_map()"

v5.18-rc2 should be the release to include that patch.

[0] https://lore.kernel.org/linux-ide/1647340746-17600-1-git-send-email-john.garry@huawei.com/

Christoph Hellwig (1):
  libata: Inline ata_qc_new_init() in ata_scsi_qc_new()

John Garry (1):
  libata: Use scsi cmnd budget token for qc tag for SAS host

 Documentation/driver-api/libata.rst | 11 -------
 drivers/ata/libata-core.c           | 48 +----------------------------
 drivers/ata/libata-sata.c           | 25 ---------------
 drivers/ata/libata-scsi.c           | 45 ++++++++++++++++++++-------
 drivers/ata/libata.h                | 13 --------
 include/linux/libata.h              |  1 -
 6 files changed, 35 insertions(+), 108 deletions(-)

-- 
2.26.2

