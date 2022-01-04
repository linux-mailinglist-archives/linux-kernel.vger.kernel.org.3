Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4F4847E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiADScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:32:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4333 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiADScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:32:06 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JT1N45Rwdz686rg;
        Wed,  5 Jan 2022 02:28:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 19:32:04 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 18:32:01 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <Ajish.Koshy@microchip.com>,
        <Viswas.G@microchip.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>, <vishakhavc@google.com>,
        <ipylypiv@google.com>, <Ruksar.devadi@microchip.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFT] scsi: pm8001: Fix FW crash for maxcpus=1
Date:   Wed, 5 Jan 2022 02:26:20 +0800
Message-ID: <1641320780-81620-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comment in check_fw_ready() we should not check the
IOP1_READY field in register SCRATCH_PAD_1 for 8008 or 8009 controllers.

However we check this very field in process_oq() for processing the highest
index interrupt vector. Change that function to not check IOP1_READY for
those mentioned controllers, but do check ILA_READY in both cases.

The reason I assume that this was not hit earlier was because we always
allocated 64 MSI(X), and just did not pass the vector index check in
process_oq(), i.e.  the handler never ran for vector index 63.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 2101fc5761c3..77b8bb30615b 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4162,9 +4162,16 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 	u32 regval;
 
 	if (vec == (pm8001_ha->max_q_num - 1)) {
+		u32 mipsall_ready;
+
+		if ((pm8001_ha->chip_id == chip_8008) ||
+		    (pm8001_ha->chip_id == chip_8009))
+			mipsall_ready = SCRATCH_PAD_MIPSALL_READY_8PORT;
+		else
+			mipsall_ready = SCRATCH_PAD_MIPSALL_READY_16PORT;
+
 		regval = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
-		if ((regval & SCRATCH_PAD_MIPSALL_READY) !=
-					SCRATCH_PAD_MIPSALL_READY) {
+		if ((regval & mipsall_ready) != mipsall_ready) {
 			pm8001_ha->controller_fatal_error = true;
 			pm8001_dbg(pm8001_ha, FAIL,
 				   "Firmware Fatal error! Regval:0x%x\n",
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
index c7e5d93bea92..c41ed039c92a 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -1405,8 +1405,12 @@ typedef struct SASProtocolTimerConfig SASProtocolTimerConfig_t;
 #define SCRATCH_PAD_BOOT_LOAD_SUCCESS	0x0
 #define SCRATCH_PAD_IOP0_READY		0xC00
 #define SCRATCH_PAD_IOP1_READY		0x3000
-#define SCRATCH_PAD_MIPSALL_READY	(SCRATCH_PAD_IOP1_READY | \
+#define SCRATCH_PAD_MIPSALL_READY_16PORT	(SCRATCH_PAD_IOP1_READY | \
 					SCRATCH_PAD_IOP0_READY | \
+					SCRATCH_PAD_ILA_READY | \
+					SCRATCH_PAD_RAAE_READY)
+#define SCRATCH_PAD_MIPSALL_READY_8PORT	(SCRATCH_PAD_IOP0_READY | \
+					SCRATCH_PAD_ILA_READY | \
 					SCRATCH_PAD_RAAE_READY)
 
 /* boot loader state */
-- 
2.26.2

