Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1349E334
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiA0NSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:18:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4526 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241634AbiA0NSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:18:33 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jl1Nt4TyKz689Hq;
        Thu, 27 Jan 2022 21:18:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 27 Jan 2022 14:18:31 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 13:18:28 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Viswas.G@microchip.com>, <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/3] scsi: pm8001: Fix warning for undescribed param in process_one_iomb()
Date:   Thu, 27 Jan 2022 21:12:50 +0800
Message-ID: <1643289172-165636-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1643289172-165636-1-git-send-email-john.garry@huawei.com>
References: <1643289172-165636-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 complains of an undescribed function pararm:

drivers/scsi/pm8001/pm80xx_hwi.c:3938: warning: Function parameter or member 'circularQ' not described in 'process_one_iomb'

Fix it.

Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index bbf538fe15b3..ce38a2298e75 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3931,6 +3931,7 @@ static int ssp_coalesced_comp_resp(struct pm8001_hba_info *pm8001_ha,
 /**
  * process_one_iomb - process one outbound Queue memory block
  * @pm8001_ha: our hba card information
+ * @circularQ: outbound circular queue
  * @piomb: IO message buffer
  */
 static void process_one_iomb(struct pm8001_hba_info *pm8001_ha,
-- 
2.26.2

