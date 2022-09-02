Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5438F5ABAE1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiIBWnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIBWnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:43:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592BE725F;
        Fri,  2 Sep 2022 15:43:11 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282M6pse016054;
        Fri, 2 Sep 2022 22:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vAMNCIKRVFQHCXEyzaLDtmizfdIaJQud6DgrW+L9g18=;
 b=AX8bc7niQ0qeDs2zUhOORme6zBMVXqbL+1Hz6SGtB33jMq/0gtZAl3a4vS5mVnoUqPzY
 tefjTREzXWUaLK3rjGzv8AlO1s1on86xKGFEsXawHNxJRDSQK90Dib4chvJtoPWWh/d+
 TpmFKyZBUQXgiOGOYHTKFciQluV7MjH/BzB8InwI523gkEGdsiUKsGYjzLoP1XJs5j+O
 ow3I6E7v6g/IHmFNCUq3rRhALh/G6RMLSVvcH1hEQm/cA+DFcmXK21N1FVGW/Dg8ZZfs
 vc+dlq9Rmzo7YQQSogxuY5Pe6KXq3tBexJzwKHggD0juRT+6uv250KDgVX7fgF1evnHy lQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbhw0sq13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 22:42:54 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282MgrIH014306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 22:42:53 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 2 Sep 2022 15:42:53 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <quic_cang@quicinc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 1/4] ufs: core: prepare ufs for multi circular queue support
Date:   Fri, 2 Sep 2022 15:41:37 -0700
Message-ID: <757bbfe36629b7c31ef2630971f8678a7801223f.1662157846.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1662157846.git.quic_asutoshd@quicinc.com>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rwLZvFzHCRktNFpJMvj4rhw8cRkmy2N6
X-Proofpoint-GUID: rwLZvFzHCRktNFpJMvj4rhw8cRkmy2N6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparatory changes for upcoming multi circular queue.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 99 +++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f4f8ded..b119f45 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -249,7 +249,7 @@ static int ufshcd_reset_and_restore(struct ufs_hba *hba);
 static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd);
 static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag);
 static void ufshcd_hba_exit(struct ufs_hba *hba);
-static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params);
+static int ufshcd_probe_hba(struct ufs_hba *hba, bool initial_boot);
 static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
 static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
 static int ufshcd_host_reset_and_restore(struct ufs_hba *hba);
@@ -310,10 +310,11 @@ static void ufshcd_scsi_block_requests(struct ufs_hba *hba)
 		scsi_block_requests(hba->host);
 }
 
-static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
+static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba,
+				      struct ufshcd_lrb *lrbp,
 				      enum ufs_trace_str_t str_t)
 {
-	struct utp_upiu_req *rq = hba->lrb[tag].ucd_req_ptr;
+	struct utp_upiu_req *rq = lrbp->ucd_req_ptr;
 	struct utp_upiu_header *header;
 
 	if (!trace_ufshcd_upiu_enabled())
@@ -322,7 +323,7 @@ static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 	if (str_t == UFS_CMD_SEND)
 		header = &rq->header;
 	else
-		header = &hba->lrb[tag].ucd_rsp_ptr->header;
+		header = &lrbp->ucd_rsp_ptr->header;
 
 	trace_ufshcd_upiu(dev_name(hba->dev), str_t, header, &rq->sc.cdb,
 			  UFS_TSF_CDB);
@@ -379,13 +380,13 @@ static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
 }
 
-static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
+static void ufshcd_add_command_trace(struct ufs_hba *hba,
+				     struct ufshcd_lrb *lrbp,
 				     enum ufs_trace_str_t str_t)
 {
 	u64 lba = 0;
 	u8 opcode = 0, group_id = 0;
 	u32 intr, doorbell;
-	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct scsi_cmnd *cmd = lrbp->cmd;
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	int transfer_len = -1;
@@ -394,7 +395,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 		return;
 
 	/* trace UPIU also */
-	ufshcd_add_cmd_upiu_trace(hba, tag, str_t);
+	ufshcd_add_cmd_upiu_trace(hba, lrbp, str_t);
 	if (!trace_ufshcd_command_enabled())
 		return;
 
@@ -419,7 +420,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 
 	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
+	trace_ufshcd_command(dev_name(hba->dev), str_t, lrbp->task_tag,
 			doorbell, transfer_len, intr, lba, opcode, group_id);
 }
 
@@ -2134,14 +2135,14 @@ static void ufshcd_update_monitor(struct ufs_hba *hba, const struct ufshcd_lrb *
  * @task_tag: Task tag of the command
  */
 static inline
-void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
+void ufshcd_send_command(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 {
-	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
+	int task_tag = lrbp->task_tag;
 	unsigned long flags;
 
 	lrbp->issue_time_stamp = ktime_get();
 	lrbp->compl_time_stamp = ktime_set(0, 0);
-	ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
+	ufshcd_add_command_trace(hba, lrbp, UFS_CMD_SEND);
 	ufshcd_clk_scaling_start_busy(hba);
 	if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
 		ufshcd_start_monitor(hba, lrbp);
@@ -2553,9 +2554,10 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufshcd_lrb *lrbp, u8 upiu_flags)
 	/* command descriptor fields */
 	ucd_req_ptr->header.dword_0 = UPIU_HEADER_DWORD(
 				UPIU_TRANSACTION_COMMAND, upiu_flags,
-				lrbp->lun, lrbp->task_tag);
+				lrbp->lun, lrbp->task_tag & 0xff);
 	ucd_req_ptr->header.dword_1 = UPIU_HEADER_DWORD(
-				UPIU_COMMAND_SET_TYPE_SCSI, 0, 0, 0);
+				UPIU_COMMAND_SET_TYPE_SCSI, 0, 0,
+				(lrbp->task_tag & 0xf00) << 4);
 
 	/* Total EHS length and Data segment length will be zero */
 	ucd_req_ptr->header.dword_2 = 0;
@@ -2845,7 +2847,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		goto out;
 	}
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, lrbp);
 
 out:
 	rcu_read_unlock();
@@ -2971,7 +2973,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 
 	if (!time_left) {
 		err = -ETIMEDOUT;
-		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
+		dev_err(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
 		if (!ufshcd_clear_cmds(hba, 1U << lrbp->task_tag))
 			/* successfully cleared the command, retry if needed */
@@ -3021,7 +3023,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, lrbp);
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
@@ -4513,6 +4515,7 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)
 			REG_UTP_TRANSFER_REQ_LIST_BASE_L);
 	ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
 			REG_UTP_TRANSFER_REQ_LIST_BASE_H);
+
 	ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
 			REG_UTP_TASK_REQ_LIST_BASE_L);
 	ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
@@ -5320,6 +5323,32 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 	ufshcd_clk_scaling_update_busy(hba);
 }
 
+void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag)
+{
+	struct ufshcd_lrb *lrbp;
+	struct scsi_cmnd *cmd;
+
+	lrbp = &hba->lrb[task_tag];
+	lrbp->compl_time_stamp = ktime_get();
+	cmd = lrbp->cmd;
+	if (cmd) {
+		if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
+			ufshcd_update_monitor(hba, lrbp);
+		ufshcd_add_command_trace(hba, lrbp, UFS_CMD_COMP);
+		cmd->result = ufshcd_transfer_rsp_status(hba, lrbp);
+		ufshcd_release_scsi_cmd(hba, lrbp);
+		/* Do not touch lrbp after scsi done */
+		scsi_done(cmd);
+	} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
+		   lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
+		if (hba->dev_cmd.complete) {
+			ufshcd_add_command_trace(hba, lrbp, UFS_DEV_COMP);
+			complete(hba->dev_cmd.complete);
+			ufshcd_clk_scaling_update_busy(hba);
+		}
+	}
+}
+
 /**
  * __ufshcd_transfer_req_compl - handle SCSI and query command completion
  * @hba: per adapter instance
@@ -5328,32 +5357,10 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 					unsigned long completed_reqs)
 {
-	struct ufshcd_lrb *lrbp;
-	struct scsi_cmnd *cmd;
-	int index;
-
-	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
-		lrbp = &hba->lrb[index];
-		lrbp->compl_time_stamp = ktime_get();
-		cmd = lrbp->cmd;
-		if (cmd) {
-			if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
-				ufshcd_update_monitor(hba, lrbp);
-			ufshcd_add_command_trace(hba, index, UFS_CMD_COMP);
-			cmd->result = ufshcd_transfer_rsp_status(hba, lrbp);
-			ufshcd_release_scsi_cmd(hba, lrbp);
-			/* Do not touch lrbp after scsi done */
-			scsi_done(cmd);
-		} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
-			lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
-			if (hba->dev_cmd.complete) {
-				ufshcd_add_command_trace(hba, index,
-							 UFS_DEV_COMP);
-				complete(hba->dev_cmd.complete);
-				ufshcd_clk_scaling_update_busy(hba);
-			}
-		}
-	}
+	int tag;
+
+	for_each_set_bit(tag, &completed_reqs, hba->nutrs)
+		ufshcd_compl_one_cqe(hba, tag);
 }
 
 /*
@@ -6869,7 +6876,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, lrbp);
 	/*
 	 * ignore the returning value here - ufshcd_check_query_response is
 	 * bound to fail since dev_cmd.query and dev_cmd.type were left empty.
@@ -8138,11 +8145,11 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 /**
  * ufshcd_probe_hba - probe hba to detect device and initialize it
  * @hba: per-adapter instance
- * @init_dev_params: whether or not to call ufshcd_device_params_init().
+ * @initial_boot: Whether or not from initial bootup
  *
  * Execute link-startup and verify device initialization
  */
-static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
+static int ufshcd_probe_hba(struct ufs_hba *hba, bool initial_boot)
 {
 	int ret;
 	unsigned long flags;
@@ -8177,7 +8184,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	 * Initialize UFS device parameters used by driver, these
 	 * parameters are associated with UFS descriptors.
 	 */
-	if (init_dev_params) {
+	if (initial_boot) {
 		ret = ufshcd_device_params_init(hba);
 		if (ret)
 			goto out;
-- 
2.7.4

