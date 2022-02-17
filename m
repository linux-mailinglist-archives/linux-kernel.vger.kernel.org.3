Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6F4BA4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbiBQPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:48:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbiBQPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:48:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A29F15C64D;
        Thu, 17 Feb 2022 07:48:32 -0800 (PST)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jzzjg2fklz67m9x;
        Thu, 17 Feb 2022 23:47:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 16:48:30 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 15:48:25 +0000
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
Subject: [PATCH v2 02/18] scsi: libsas: Use enum for response frame DATAPRES field
Date:   Thu, 17 Feb 2022 23:42:30 +0800
Message-ID: <1645112566-115804-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
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

As defined in table 126 of the SAS spec 1.1, use an enum for the DATAPRES
field, which makes reading the code easier.

Also change sas_ssp_task_response() to use a switch statement, which is
more suitable (than if-else), as suggested by Christoph.

Suggested-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
---
 drivers/scsi/aic94xx/aic94xx_tmf.c |  2 +-
 drivers/scsi/isci/request.c        |  7 ++++---
 drivers/scsi/libsas/sas_task.c     | 14 +++++++++-----
 drivers/scsi/mvsas/mv_sas.c        |  2 +-
 include/scsi/sas.h                 |  7 +++++++
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
index 0eb6e206a2b4..2ba91eaaf0ee 100644
--- a/drivers/scsi/aic94xx/aic94xx_tmf.c
+++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
@@ -287,7 +287,7 @@ static int asd_get_tmf_resp_tasklet(struct asd_ascb *ascb,
 	fh = edb->vaddr + 16;
 	ru = edb->vaddr + 16 + sizeof(*fh);
 	res = ru->status;
-	if (ru->datapres == 1)	  /* Response data present */
+	if (ru->datapres == SAS_DATAPRES_RESPONSE_DATA)
 		res = ru->resp_data[3];
 #if 0
 	ascb->tag = fh->tag;
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 92394884fbeb..ac17e3a35d2c 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -1047,7 +1047,8 @@ request_started_state_tc_event(struct isci_request *ireq,
 		resp_iu = &ireq->ssp.rsp;
 		datapres = resp_iu->datapres;
 
-		if (datapres == 1 || datapres == 2) {
+		if (datapres == SAS_DATAPRES_RESPONSE_DATA ||
+		    datapres == SAS_DATAPRES_SENSE_DATA) {
 			ireq->scu_status = SCU_TASK_DONE_CHECK_RESPONSE;
 			ireq->sci_status = SCI_FAILURE_IO_RESPONSE_VALID;
 		} else {
@@ -1730,8 +1731,8 @@ sci_io_request_frame_handler(struct isci_request *ireq,
 
 			resp_iu = &ireq->ssp.rsp;
 
-			if (resp_iu->datapres == 0x01 ||
-			    resp_iu->datapres == 0x02) {
+			if (resp_iu->datapres == SAS_DATAPRES_RESPONSE_DATA ||
+			    resp_iu->datapres == SAS_DATAPRES_SENSE_DATA) {
 				ireq->scu_status = SCU_TASK_DONE_CHECK_RESPONSE;
 				ireq->sci_status = SCI_FAILURE_CONTROLLER_SPECIFIC_IO_ERR;
 			} else {
diff --git a/drivers/scsi/libsas/sas_task.c b/drivers/scsi/libsas/sas_task.c
index 2966ead1d421..e9d291007817 100644
--- a/drivers/scsi/libsas/sas_task.c
+++ b/drivers/scsi/libsas/sas_task.c
@@ -15,11 +15,14 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
 
 	tstat->resp = SAS_TASK_COMPLETE;
 
-	if (iu->datapres == 0)
+	switch (iu->datapres) {
+	case SAS_DATAPRES_NO_DATA:
 		tstat->stat = iu->status;
-	else if (iu->datapres == 1)
+		break;
+	case SAS_DATAPRES_RESPONSE_DATA:
 		tstat->stat = iu->resp_data[3];
-	else if (iu->datapres == 2) {
+		break;
+	case SAS_DATAPRES_SENSE_DATA:
 		tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		tstat->buf_valid_size =
 			min_t(int, SAS_STATUS_BUF_SIZE,
@@ -29,10 +32,11 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
 		if (iu->status != SAM_STAT_CHECK_CONDITION)
 			dev_warn(dev, "dev %016llx sent sense data, but stat(0x%x) is not CHECK CONDITION\n",
 				 SAS_ADDR(task->dev->sas_addr), iu->status);
-	}
-	else
+		break;
+	default:
 		/* when datapres contains corrupt/unknown value... */
 		tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
+	}
 }
 EXPORT_SYMBOL_GPL(sas_ssp_task_response);
 
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index a8d1f3dd607a..b48ae26e29a9 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1638,7 +1638,7 @@ static void mvs_set_sense(u8 *buffer, int len, int d_sense,
 static void mvs_fill_ssp_resp_iu(struct ssp_response_iu *iu,
 				u8 key, u8 asc, u8 asc_q)
 {
-	iu->datapres = 2;
+	iu->datapres = SAS_DATAPRES_SENSE_DATA;
 	iu->response_data_len = 0;
 	iu->sense_data_len = 17;
 	iu->status = 02;
diff --git a/include/scsi/sas.h b/include/scsi/sas.h
index 64154c1fed02..332a463d08ef 100644
--- a/include/scsi/sas.h
+++ b/include/scsi/sas.h
@@ -191,6 +191,13 @@ enum sas_gpio_reg_type {
 	SAS_GPIO_REG_TX_GP = 4,
 };
 
+/* Response frame DATAPRES field */
+enum {
+	SAS_DATAPRES_NO_DATA		= 0,
+	SAS_DATAPRES_RESPONSE_DATA	= 1,
+	SAS_DATAPRES_SENSE_DATA		= 2,
+};
+
 struct  dev_to_host_fis {
 	u8     fis_type;	  /* 0x34 */
 	u8     flags;
-- 
2.26.2

