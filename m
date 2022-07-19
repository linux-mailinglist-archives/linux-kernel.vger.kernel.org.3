Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60054579023
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiGSBy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGSByV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:54:21 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A265C1;
        Mon, 18 Jul 2022 18:54:20 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IMdcX9011679;
        Mon, 18 Jul 2022 18:28:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=dsx0v3KZyRAXYLFDkxI6YesZPcTkabKtSF1bHFjFvH0=;
 b=F8tVV0eG0TFaV1/QIEiyZGXvz2CxFs1kYi0K0usv13sDVeNQYg20H5c1dXVIXcX7GhX9
 Ol7Y+RIVmjqutiLWqZ36TI7HZaVZV1NO/3yPwUmI4FD8qC6hbiHLM8xwYD8oJLxPTWSi
 WwPARLv+7yUYmmOnBSfZCaEHH4tJNLRzguT474CBfZ3+s0yHA78ImHs4fuautXf8nAxW
 c2f7gaCenjUN6R79+O6d28VSAO+vuNN/KqrenUTZpNORl5zq3q//c+Qm3FW1SwgoNb0j
 GDddrNyuwd2I/uPyIIyfnBtqxN6KKkChuyguj6pcmPdC4Dj9z4B7tuWntVLr4ImWkNiE Hw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5whrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:28:36 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EB53BC0649;
        Tue, 19 Jul 2022 01:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194116; bh=sz9bKv1KPILgNQcgqxf2ikPC+5xnOP2hP/v91jBj7dU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=IjYCixwhFMA0CmOXKFZvkz6YqyexUAAEAQQqAVJqqJDZ0orEP/QiJSwZ2MRWDh3hn
         BJzgo9SbPAuFyqkbzv0t3jtEgVQBI8QeQGk97D4BWF5dUQWwLZ5bbqrGIIhARh7msN
         FTNY+fu6q2ZQVqyZDZTAOWOnrGTkO0hPbtj99HeIl6zqX7DIHlVCwWFo+qIciyk5Eh
         9Rq87o2QFSdyJ0+NSujAyLHfAT8JG5YF6TNbYH8B/hE1uDZ/jvSgfJ1hLb8B0h8HIq
         aBE/e0oI4bAB+2AkTo/vc78sYEokh0ZXGWYR2svt4O/E2jHQANKPDIbL8G64HzSsDV
         ZA8SLk7t0l8vA==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id AD17FA006D;
        Tue, 19 Jul 2022 01:28:34 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:28:34 -0700
Date:   Mon, 18 Jul 2022 18:28:34 -0700
Message-Id: <0150d7b669ad80e94596b371cbce0460a327ce7c.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 24/25] usb: gadget: f_tcm: Check overlapped command
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: Bi9Hoo4uTMd3TW6s4mx5mSgnAMd-9i5C
X-Proofpoint-ORIG-GUID: Bi9Hoo4uTMd3TW6s4mx5mSgnAMd-9i5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there's an overlapped command tag, cancel the command and respond
with RC_OVERLAPPED_TAG to host.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - New patch. It was part of TASK MANAGEMENT change.
 - Directly respond to host on overlapped tag instead of reporting to target
   core.

 drivers/usb/gadget/function/f_tcm.c | 75 ++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 8b99ee07df87..dfa3e7c043a3 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -692,6 +692,15 @@ static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 		break;
 
 	case UASP_QUEUE_COMMAND:
+		/*
+		 * Overlapped command detected and cancelled.
+		 * So send overlapped attempted status.
+		 */
+		if (cmd->tmr_rsp == RC_OVERLAPPED_TAG &&
+		    req->status == -ECONNRESET) {
+			uasp_send_tm_response(cmd);
+			return;
+		}
 
 		stream->cmd = NULL;
 
@@ -700,7 +709,8 @@ static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 		 * bitmap index. This is for the cases where f_tcm handles
 		 * status response instead of the target core.
 		 */
-		if (cmd->tmr_rsp != RC_RESPONSE_UNKNOWN) {
+		if (cmd->tmr_rsp != RC_OVERLAPPED_TAG &&
+		    cmd->tmr_rsp != RC_RESPONSE_UNKNOWN) {
 			struct se_session *se_sess;
 
 			se_sess = fu->tpg->tpg_nexus->tvn_se_sess;
@@ -1080,6 +1090,14 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 
 cleanup:
 	target_put_sess_cmd(se_cmd);
+
+	/* Command was aborted due to overlapped tag */
+	if (cmd->state == UASP_QUEUE_COMMAND &&
+	    cmd->tmr_rsp == RC_OVERLAPPED_TAG) {
+		uasp_send_tm_response(cmd);
+		return;
+	}
+
 	transport_send_check_condition_and_sense(se_cmd,
 			TCM_CHECK_CONDITION_ABORT_CMD, 0);
 }
@@ -1148,9 +1166,10 @@ static int usbg_send_read_response(struct se_cmd *se_cmd)
 		return uasp_send_read_response(cmd);
 }
 
+static void usbg_aborted_task(struct se_cmd *se_cmd);
+
 static void usbg_submit_tmr(struct usbg_cmd *cmd)
 {
-	struct usbg_cmd *cmd = container_of(work, struct usbg_cmd, work);
 	struct se_session *se_sess;
 	struct se_cmd *se_cmd;
 	int flags = TARGET_SCF_ACK_KREF;
@@ -1214,6 +1233,51 @@ static void usbg_cmd_work(struct work_struct *work)
 	return;
 
 skip:
+	if (cmd->tmr_rsp == RC_OVERLAPPED_TAG) {
+		struct se_session *se_sess;
+		struct uas_stream *stream;
+
+		se_sess = cmd->fu->tpg->tpg_nexus->tvn_se_sess;
+		stream = uasp_get_stream_by_tag(cmd->fu, cmd->tag);
+
+		/*
+		 * There's no guarantee of a matching completion order between
+		 * different endpoints. i.e. The device may receive a new (CDB)
+		 * command request completion of the command endpoint before it
+		 * gets notified of the previous command status completion from
+		 * a status endpoint. The driver still needs to detect
+		 * misbehaving host and respond with an overlap command tag. To
+		 * prevent false overlapped tag failure, give the active and
+		 * matching stream id a short time (1ms) to complete before
+		 * respond with overlapped command failure.
+		 */
+		msleep(1);
+
+		/* If the stream is completed, retry the command. */
+		if (!stream->cmd) {
+			usbg_submit_command(cmd->fu, cmd->req);
+			return;
+		}
+
+		/*
+		 * The command isn't submitted to the target core, so we're safe
+		 * to remove the bitmap index from the session tag pool.
+		 */
+		sbitmap_queue_clear(&se_sess->sess_tag_pool,
+				    cmd->se_cmd.map_tag,
+				    cmd->se_cmd.map_cpu);
+
+		/*
+		 * Overlap command tag detected. Cancel any pending transfer of
+		 * the command submitted to target core.
+		 */
+		stream->cmd->tmr_rsp = RC_OVERLAPPED_TAG;
+		usbg_aborted_task(&stream->cmd->se_cmd);
+
+		/* Send the response after the transfer is aborted. */
+		return;
+	}
+
 	uasp_send_tm_response(cmd);
 }
 
@@ -1282,6 +1346,13 @@ static int usbg_submit_command(struct f_uas *fu, struct usb_request *req)
 		goto skip;
 	}
 
+	stream = uasp_get_stream_by_tag(fu, scsi_tag);
+	if (stream->cmd) {
+		pr_err("Command tag %d overlapped\n", scsi_tag);
+		cmd->tmr_rsp = RC_OVERLAPPED_TAG;
+		goto skip;
+	}
+
 	stream->cmd = cmd;
 
 	if (iu->iu_id == IU_ID_TASK_MGMT) {
-- 
2.28.0

