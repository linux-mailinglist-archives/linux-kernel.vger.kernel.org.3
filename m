Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742DB5790D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiGSC0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiGSC0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:26:47 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A85F3AE76;
        Mon, 18 Jul 2022 19:26:46 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J1JOUZ002282;
        Mon, 18 Jul 2022 18:28:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=ZELufq2Y8q9hAay4jmJM1QEnlK1jv++ZwEONvskwPCo=;
 b=IFpR/nr1mzePRHVe5Vy1CxxhsIIdzBqdbj+G6s2CHhijNfgW8KPA8wimt4XhDSCNbU4l
 aFP/PsZ/5IOPMdGmgRbPRVkcaH2PEO2hKI4E2XYwSaMBF2xPXv9T9FxaWcdLDcY4c1aA
 2FjaK6Kr3a9Nm0H6//izU1z9W9I7mKSnbYOdEAVIKgANaI26V2N0qNT430/tF/hD5LiS
 eVaRNRe3tzIeubmtLvLYhC8aBF2Tg+0jAq9btll7/YP1WqGe1LxYK3cHId/cR3JDXF80
 RpH6YDIVwCvD2iOXvJ4GNRiBYGcaUJzb2Y2oPjNc+dcT6atM4TWKJmAsOFKfbBMOoN5v iw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvbmwhvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:28:30 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B2B904008A;
        Tue, 19 Jul 2022 01:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194109; bh=IuLkUSf4/N0Op0xK4G/uDW4KdpKVrzDZox9PRZ7HwKc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Xp7QTpTyPwx0qu3wvL8p5UWXG8YWPjIDxSbDFb5x63lMccPNtndSEaY8RCSIFhf/f
         DKYe4ly9jJ5XZkJT7byp3srbM+tLWefEu5VkBVa0Gf42uX4ayX9y5f/A12blevZHPU
         GnD5mfxVHgOsLbiyd+pqxAHQwiAP5IelOFoCRcj8kyeY8ADI07VrwwztiH08nkIH1V
         jKdyRxVZYo74JgPRxMV6LImh2+6uAyRfHvVBuJKlBPsuixeKWqi6fgHp+iRz2JXdno
         PRm9wGkNz9YmCSehNoyWLIk6WqHMKLp+7+emPVva1vg+H58EokqhFtZBvxbWqgz+rQ
         wbRYoKy5OFVuA==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 89A3EA006D;
        Tue, 19 Jul 2022 01:28:28 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:28:28 -0700
Date:   Mon, 18 Jul 2022 18:28:28 -0700
Message-Id: <4b16a01640798df3561965de0dc5755d370dd0c7.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 23/25] usb: gadget: f_tcm: Handle TASK_MANAGEMENT commands
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: 37RUzTze6vhSJN4H6PDI55tPj3J-L6hQ
X-Proofpoint-ORIG-GUID: 37RUzTze6vhSJN4H6PDI55tPj3J-L6hQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle target_core_fabric_ops TASK MANAGEMENT functions and their
response. If a TASK MANAGEMENT command is received, the driver will
interpret the function TMF_*, translate to TMR_*, and fire off a command
work executing target_submit_tmr(). On completion, it will handle the
TASK MANAGEMENT response through uasp_send_tm_response().

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Splitted into smaller change. Remove handling of overlapped tag.
 - Directly respond to host if f_tcm detected failure with response IU rather
   than reporting to target core.

 drivers/usb/gadget/function/f_tcm.c | 206 +++++++++++++++++++++++++---
 drivers/usb/gadget/function/tcm.h   |   7 +-
 2 files changed, 193 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 116be1c47ac9..8b99ee07df87 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/configfs.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/composite.h>
 #include <linux/usb/gadget.h>
@@ -462,6 +463,51 @@ static int usbg_bot_setup(struct usb_function *f,
 
 /* Start uas.c code */
 
+static int tcm_to_uasp_response(enum tcm_tmrsp_table code)
+{
+	switch (code) {
+	case TMR_FUNCTION_FAILED:
+		return RC_TMF_FAILED;
+	case TMR_FUNCTION_COMPLETE:
+	case TMR_TASK_DOES_NOT_EXIST:
+		return RC_TMF_COMPLETE;
+	case TMR_LUN_DOES_NOT_EXIST:
+		return RC_INCORRECT_LUN;
+	case TMR_OVERLAPPED_TAG_ATTEMPTED:
+		return RC_OVERLAPPED_TAG;
+	case TMR_FUNCTION_REJECTED:
+	case TMR_TASK_MGMT_FUNCTION_NOT_SUPPORTED:
+	default:
+		return RC_TMF_NOT_SUPPORTED;
+	}
+}
+
+static unsigned char uasp_to_tcm_func(int code)
+{
+	switch (code) {
+	case TMF_ABORT_TASK:
+		return TMR_ABORT_TASK;
+	case TMF_ABORT_TASK_SET:
+		return TMR_ABORT_TASK_SET;
+	case TMF_CLEAR_TASK_SET:
+		return TMR_CLEAR_TASK_SET;
+	case TMF_LOGICAL_UNIT_RESET:
+		return TMR_LUN_RESET;
+	case TMF_I_T_NEXUS_RESET:
+		return TMR_I_T_NEXUS_RESET;
+	case TMF_CLEAR_ACA:
+		return TMR_CLEAR_ACA;
+	case TMF_QUERY_TASK:
+		return TMR_QUERY_TASK;
+	case TMF_QUERY_TASK_SET:
+		return TMR_QUERY_TASK_SET;
+	case TMF_QUERY_ASYNC_EVENT:
+		return TMR_QUERY_ASYNC_EVENT;
+	default:
+		return TMR_UNKNOWN;
+	}
+}
+
 static void uasp_cleanup_one_stream(struct f_uas *fu, struct uas_stream *stream)
 {
 	/* We have either all three allocated or none */
@@ -581,6 +627,33 @@ static void uasp_prepare_status(struct usbg_cmd *cmd)
 	stream->req_status->complete = uasp_status_data_cmpl;
 }
 
+static void uasp_prepare_response(struct usbg_cmd *cmd)
+{
+	struct se_cmd *se_cmd = &cmd->se_cmd;
+	struct response_iu *rsp_iu = &cmd->response_iu;
+	struct uas_stream *stream = uasp_get_stream_by_tag(cmd->fu, cmd->tag);
+
+	cmd->state = UASP_QUEUE_COMMAND;
+	rsp_iu->iu_id = IU_ID_RESPONSE;
+	rsp_iu->tag = cpu_to_be16(cmd->tag);
+
+	if (cmd->tmr_rsp != RC_RESPONSE_UNKNOWN)
+		rsp_iu->response_code = cmd->tmr_rsp;
+	else
+		rsp_iu->response_code =
+			tcm_to_uasp_response(se_cmd->se_tmr_req->response);
+
+	stream->req_status->is_last = 1;
+	stream->req_status->stream_id = cmd->tag;
+	stream->req_status->context = cmd;
+	stream->req_status->length = sizeof(struct response_iu);
+	stream->req_status->buf = rsp_iu;
+	stream->req_status->complete = uasp_status_data_cmpl;
+}
+
+static void usbg_release_cmd(struct se_cmd *se_cmd);
+static int uasp_send_tm_response(struct usbg_cmd *cmd);
+
 static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 {
 	struct usbg_cmd *cmd = req->context;
@@ -619,9 +692,26 @@ static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 		break;
 
 	case UASP_QUEUE_COMMAND:
-		transport_generic_free_cmd(&cmd->se_cmd, 0);
-		usb_ep_queue(fu->ep_cmd, cmd->req, GFP_ATOMIC);
 
+		stream->cmd = NULL;
+
+		/*
+		 * If no command submitted to target core here, just free the
+		 * bitmap index. This is for the cases where f_tcm handles
+		 * status response instead of the target core.
+		 */
+		if (cmd->tmr_rsp != RC_RESPONSE_UNKNOWN) {
+			struct se_session *se_sess;
+
+			se_sess = fu->tpg->tpg_nexus->tvn_se_sess;
+			sbitmap_queue_clear(&se_sess->sess_tag_pool,
+					    cmd->se_cmd.map_tag,
+					    cmd->se_cmd.map_cpu);
+		} else {
+			transport_generic_free_cmd(&cmd->se_cmd, 0);
+		}
+
+		usb_ep_queue(fu->ep_cmd, cmd->req, GFP_ATOMIC);
 		break;
 
 	default:
@@ -630,6 +720,7 @@ static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 	return;
 
 cleanup:
+	stream->cmd = NULL;
 	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
@@ -645,6 +736,18 @@ static int uasp_send_status_response(struct usbg_cmd *cmd)
 	return usb_ep_queue(fu->ep_status, stream->req_status, GFP_ATOMIC);
 }
 
+static int uasp_send_tm_response(struct usbg_cmd *cmd)
+{
+	struct f_uas *fu = cmd->fu;
+	struct uas_stream *stream = uasp_get_stream_by_tag(fu, cmd->tag);
+	struct response_iu *iu = &cmd->response_iu;
+
+	iu->tag = cpu_to_be16(cmd->tag);
+	cmd->fu = fu;
+	uasp_prepare_response(cmd);
+	return usb_ep_queue(fu->ep_status, stream->req_status, GFP_ATOMIC);
+}
+
 static int uasp_send_read_response(struct usbg_cmd *cmd)
 {
 	struct f_uas *fu = cmd->fu;
@@ -1045,9 +1148,24 @@ static int usbg_send_read_response(struct se_cmd *se_cmd)
 		return uasp_send_read_response(cmd);
 }
 
-static void usbg_cmd_work(struct work_struct *work)
+static void usbg_submit_tmr(struct usbg_cmd *cmd)
 {
 	struct usbg_cmd *cmd = container_of(work, struct usbg_cmd, work);
+	struct se_session *se_sess;
+	struct se_cmd *se_cmd;
+	int flags = TARGET_SCF_ACK_KREF;
+
+	se_cmd = &cmd->se_cmd;
+	se_sess = cmd->fu->tpg->tpg_nexus->tvn_se_sess;
+
+	target_submit_tmr(se_cmd, se_sess,
+			  cmd->response_iu.add_response_info,
+			  cmd->unpacked_lun, NULL, cmd->tmr_func,
+			  GFP_ATOMIC, cmd->tag, flags);
+}
+
+static void usbg_submit_cmd(struct usbg_cmd *cmd)
+{
 	struct se_cmd *se_cmd;
 	struct tcm_usbg_nexus *tv_nexus;
 	struct usbg_tpg *tpg;
@@ -1076,6 +1194,29 @@ static void usbg_cmd_work(struct work_struct *work)
 			TCM_UNSUPPORTED_SCSI_OPCODE, 0);
 }
 
+static void usbg_cmd_work(struct work_struct *work)
+{
+	struct usbg_cmd *cmd = container_of(work, struct usbg_cmd, work);
+
+	/*
+	 * Failure is detected by f_tcm here. Skip submitting the command to the
+	 * target core if we already know the failing response and send the usb
+	 * response to the host directly.
+	 */
+	if (cmd->tmr_rsp != RC_RESPONSE_UNKNOWN)
+		goto skip;
+
+	if (cmd->tmr_func)
+		usbg_submit_tmr(cmd);
+	else
+		usbg_submit_cmd(cmd);
+
+	return;
+
+skip:
+	uasp_send_tm_response(cmd);
+}
+
 static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
 		struct tcm_usbg_nexus *tv_nexus, u32 scsi_tag)
 {
@@ -1102,37 +1243,63 @@ static void usbg_release_cmd(struct se_cmd *);
 
 static int usbg_submit_command(struct f_uas *fu, struct usb_request *req)
 {
-	struct command_iu *cmd_iu = req->buf;
+	struct iu *iu = req->buf;
 	struct usbg_cmd *cmd;
 	struct usbg_tpg *tpg = fu->tpg;
 	struct tcm_usbg_nexus *tv_nexus;
+	struct uas_stream *stream;
+	struct command_iu *cmd_iu;
 	u32 cmd_len;
 	u16 scsi_tag;
 
-	if (cmd_iu->iu_id != IU_ID_COMMAND) {
-		pr_err("Unsupported type %d\n", cmd_iu->iu_id);
-		return -EINVAL;
-	}
-
 	tv_nexus = tpg->tpg_nexus;
 	if (!tv_nexus) {
 		pr_err("Missing nexus, ignoring command\n");
 		return -EINVAL;
 	}
 
-	cmd_len = (cmd_iu->len & ~0x3) + 16;
-	if (cmd_len > USBG_MAX_CMD)
-		return -EINVAL;
-
-	scsi_tag = be16_to_cpup(&cmd_iu->tag);
+	scsi_tag = be16_to_cpup(&iu->tag);
 	cmd = usbg_get_cmd(fu, tv_nexus, scsi_tag);
 	if (IS_ERR(cmd)) {
 		pr_err("usbg_get_cmd failed\n");
 		return -ENOMEM;
 	}
-	memcpy(cmd->cmd_buf, cmd_iu->cdb, cmd_len);
 
-	cmd->stream = &fu->stream[cmd->tag % USBG_NUM_CMDS];
+	cmd->req = req;
+	cmd->fu = fu;
+	cmd->tag = scsi_tag;
+	cmd->se_cmd.tag = scsi_tag;
+	cmd->tmr_func = 0;
+	cmd->tmr_rsp = RC_RESPONSE_UNKNOWN;
+
+	cmd_iu = (struct command_iu *)iu;
+
+	/* Command and Task Management IUs share the same LUN offset */
+	cmd->unpacked_lun = scsilun_to_int(&cmd_iu->lun);
+
+	if (iu->iu_id != IU_ID_COMMAND && iu->iu_id != IU_ID_TASK_MGMT) {
+		cmd->tmr_rsp = RC_INVALID_INFO_UNIT;
+		goto skip;
+	}
+
+	stream->cmd = cmd;
+
+	if (iu->iu_id == IU_ID_TASK_MGMT) {
+		struct task_mgmt_iu *tm_iu;
+
+		tm_iu = (struct task_mgmt_iu *)iu;
+		cmd->tmr_func = uasp_to_tcm_func(tm_iu->function);
+		goto skip;
+	}
+
+	cmd_len = (cmd_iu->len & ~0x3) + 16;
+	if (cmd_len > USBG_MAX_CMD) {
+		pr_err("invalid len %d\n", cmd_len);
+		target_free_tag(tv_nexus->tvn_se_sess, &cmd->se_cmd);
+		stream->cmd = NULL;
+		return -EINVAL;
+	}
+	memcpy(cmd->cmd_buf, cmd_iu->cdb, cmd_len);
 
 	switch (cmd_iu->prio_attr & 0x7) {
 	case UAS_HEAD_TAG:
@@ -1153,9 +1320,7 @@ static int usbg_submit_command(struct f_uas *fu, struct usb_request *req)
 		break;
 	}
 
-	cmd->unpacked_lun = scsilun_to_int(&cmd_iu->lun);
-	cmd->req = req;
-
+skip:
 	INIT_WORK(&cmd->work, usbg_cmd_work);
 	queue_work(tpg->workqueue, &cmd->work);
 
@@ -1301,6 +1466,9 @@ static int usbg_get_cmd_state(struct se_cmd *se_cmd)
 
 static void usbg_queue_tm_rsp(struct se_cmd *se_cmd)
 {
+	struct usbg_cmd *cmd = container_of(se_cmd, struct usbg_cmd, se_cmd);
+
+	uasp_send_tm_response(cmd);
 }
 
 static void usbg_aborted_task(struct se_cmd *se_cmd)
diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index 5157af1b166b..7fafc4336984 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -82,8 +82,11 @@ struct usbg_cmd {
 	u16 tag;
 	u16 prio_attr;
 	struct sense_iu sense_iu;
+	struct response_iu response_iu;
 	enum uas_state state;
-	struct uas_stream *stream;
+	int tmr_func;
+	int tmr_rsp;
+#define	RC_RESPONSE_UNKNOWN 0xff
 
 	/* BOT only */
 	__le32 bot_tag;
@@ -96,6 +99,8 @@ struct uas_stream {
 	struct usb_request	*req_in;
 	struct usb_request	*req_out;
 	struct usb_request	*req_status;
+
+	struct usbg_cmd		*cmd;
 };
 
 struct usbg_cdb {
-- 
2.28.0

