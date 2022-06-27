Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF4155CAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiF0NSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiF0NS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:18:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5E7C6F;
        Mon, 27 Jun 2022 06:18:24 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LWp8t22bkz6H8NV;
        Mon, 27 Jun 2022 21:14:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 15:18:22 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 14:18:19 +0100
From:   John Garry <john.garry@huawei.com>
To:     <s.shtylyov@omp.ru>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] ata: pata_cs5535: Fix W=1 warnings
Date:   Mon, 27 Jun 2022 21:12:20 +0800
Message-ID: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

x86_64 allmodconfig build with W=1 gives these warnings:

drivers/ata/pata_cs5535.c: In function ‘cs5535_set_piomode’:
drivers/ata/pata_cs5535.c:93:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
  u32 reg, dummy;
           ^~~~~
drivers/ata/pata_cs5535.c: In function ‘cs5535_set_dmamode’:
drivers/ata/pata_cs5535.c:132:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
  u32 reg, dummy;
           ^~~~~
cc1: all warnings being treated as errors

Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
stubbed, which is the same as what we already do in pata_cs5536.c .

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 6725931f3c35..c2c3238ff84b 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -90,7 +90,7 @@ static void cs5535_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	static const u16 pio_cmd_timings[5] = {
 		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
 	};
-	u32 reg, dummy;
+	u32 reg, __maybe_unused dummy;
 	struct ata_device *pair = ata_dev_pair(adev);
 
 	int mode = adev->pio_mode - XFER_PIO_0;
@@ -129,7 +129,7 @@ static void cs5535_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	static const u32 mwdma_timings[3] = {
 		0x7F0FFFF3, 0x7F035352, 0x7F024241
 	};
-	u32 reg, dummy;
+	u32 reg, __maybe_unused dummy;
 	int mode = adev->dma_mode;
 
 	rdmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, dummy);
-- 
2.35.3

