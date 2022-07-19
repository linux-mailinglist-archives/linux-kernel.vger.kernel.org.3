Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE4579040
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiGSB57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiGSB5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:57:55 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9094127B17;
        Mon, 18 Jul 2022 18:57:54 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILfl1k029330;
        Mon, 18 Jul 2022 18:26:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=DTLVMFxbtnKtLzNLUzmmwdnWVf2t1U1qJ+NQUnwA82Q=;
 b=Td5NjD8bCFa117eZgcU4XA/W4JPkg+UZ8lSs70M1gKaHKpX5UMDn7DazUzH4P4dZXihH
 WlCJg2zuevh4fSA2yGp3C14zo1HI3yIcmO+LXn+ArRs8Ji95rPOiMyqYq1IY4P/M73TM
 0upm3SJ6OKdmajOcAq3GwgbZAhzA0sThysnK0X5Q+y01qd0nnOboSPdozko6wL1jEyLa
 rIl+x6w6CMP8xeId+zLQHbCxXd0P9ylwzQ34fyU154gsTvfcl6lUOrX7LiFLlNvThewg
 I7T2wFexMVEhw5D1L1qUNSGJTQ5Fd0sRurnXBGwV5zF7oVbVjqvWNEs7559bfjJuGThI +w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6dec5f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:26:44 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 27F8EC0649;
        Tue, 19 Jul 2022 01:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194003; bh=3yP8H4UW+LN/RDlXQUz7ixouteSYRQT6QCwxxucIo8g=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=GfiS7EpV6YWTqhU9W0C82ldkirZbYnDu/gnjeSRN3J33BKseWYJ0Ymwg/0ggNsF/5
         OZanebpEGbBLX52guzt5Ppa6o9n+gBOrljdc+q5FplFTsq/jhJaemJ/amcK3A1PE9z
         LiDzi4tOWgmXBdEHGeDKCLustY6BRQ2/tiIlxIOrkDiQF2vhhIaK8ndS1sTSSMWLui
         gGvkQBMpaa2lV/kWhqXGaUgwe45WSMPs/oVeQHtrT3gLo9pRFXX4lW76liMOMX4HEU
         puJPOwprFwVuXh5ZcN+fXIRvqbyJRliQg7Igbc5IvltOG20bSN3ItkzMe0lGSBnBKa
         saRFJZKIPHZSQ==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id B5426A0068;
        Tue, 19 Jul 2022 01:26:41 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:26:41 -0700
Date:   Mon, 18 Jul 2022 18:26:41 -0700
Message-Id: <8e0fa7c61240a934870c5866989ca13d070d9d59.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 06/25] usb: gadget: f_tcm: Allocate matching number of commands to streams
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-ORIG-GUID: Obgl_4WHFiqYDDCscWLcpis0vbs1RNR8
X-Proofpoint-GUID: Obgl_4WHFiqYDDCscWLcpis0vbs1RNR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can handle multiple commands concurently. Each command services a
stream id. At the moment, the driver will handle 32 outstanding streams,
which is equivalent to 32 commands. Make sure to allocate a matching
number of commands to the number of streams.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 110 ++++++++++++++--------------
 drivers/usb/gadget/function/tcm.h   |   8 +-
 2 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 7721216dc9bc..6e0b54985932 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -50,7 +50,7 @@ static int bot_enqueue_cmd_cbw(struct f_uas *fu)
 	if (fu->flags & USBG_BOT_CMD_PEND)
 		return 0;
 
-	ret = usb_ep_queue(fu->ep_out, fu->cmd.req, GFP_ATOMIC);
+	ret = usb_ep_queue(fu->ep_out, fu->cmd[0].req, GFP_ATOMIC);
 	if (!ret)
 		fu->flags |= USBG_BOT_CMD_PEND;
 	return ret;
@@ -136,7 +136,7 @@ static void bot_send_bad_status(struct usbg_cmd *cmd)
 		}
 		req->complete = bot_err_compl;
 		req->context = cmd;
-		req->buf = fu->cmd.buf;
+		req->buf = fu->cmd[0].buf;
 		usb_ep_queue(ep, req, GFP_KERNEL);
 	} else {
 		bot_enqueue_sense_code(fu, cmd);
@@ -314,8 +314,8 @@ static int bot_prepare_reqs(struct f_uas *fu)
 	if (!fu->bot_req_out)
 		goto err_out;
 
-	fu->cmd.req = usb_ep_alloc_request(fu->ep_out, GFP_KERNEL);
-	if (!fu->cmd.req)
+	fu->cmd[0].req = usb_ep_alloc_request(fu->ep_out, GFP_KERNEL);
+	if (!fu->cmd[0].req)
 		goto err_cmd;
 
 	fu->bot_status.req = usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
@@ -327,27 +327,27 @@ static int bot_prepare_reqs(struct f_uas *fu)
 	fu->bot_status.req->complete = bot_status_complete;
 	fu->bot_status.csw.Signature = cpu_to_le32(US_BULK_CS_SIGN);
 
-	fu->cmd.buf = kmalloc(fu->ep_out->maxpacket, GFP_KERNEL);
-	if (!fu->cmd.buf)
+	fu->cmd[0].buf = kmalloc(fu->ep_out->maxpacket, GFP_KERNEL);
+	if (!fu->cmd[0].buf)
 		goto err_buf;
 
-	fu->cmd.req->complete = bot_cmd_complete;
-	fu->cmd.req->buf = fu->cmd.buf;
-	fu->cmd.req->length = fu->ep_out->maxpacket;
-	fu->cmd.req->context = fu;
+	fu->cmd[0].req->complete = bot_cmd_complete;
+	fu->cmd[0].req->buf = fu->cmd[0].buf;
+	fu->cmd[0].req->length = fu->ep_out->maxpacket;
+	fu->cmd[0].req->context = fu;
 
 	ret = bot_enqueue_cmd_cbw(fu);
 	if (ret)
 		goto err_queue;
 	return 0;
 err_queue:
-	kfree(fu->cmd.buf);
-	fu->cmd.buf = NULL;
+	kfree(fu->cmd[0].buf);
+	fu->cmd[0].buf = NULL;
 err_buf:
 	usb_ep_free_request(fu->ep_in, fu->bot_status.req);
 err_sts:
-	usb_ep_free_request(fu->ep_out, fu->cmd.req);
-	fu->cmd.req = NULL;
+	usb_ep_free_request(fu->ep_out, fu->cmd[0].req);
+	fu->cmd[0].req = NULL;
 err_cmd:
 	usb_ep_free_request(fu->ep_out, fu->bot_req_out);
 	fu->bot_req_out = NULL;
@@ -372,16 +372,16 @@ static void bot_cleanup_old_alt(struct f_uas *fu)
 
 	usb_ep_free_request(fu->ep_in, fu->bot_req_in);
 	usb_ep_free_request(fu->ep_out, fu->bot_req_out);
-	usb_ep_free_request(fu->ep_out, fu->cmd.req);
+	usb_ep_free_request(fu->ep_out, fu->cmd[0].req);
 	usb_ep_free_request(fu->ep_in, fu->bot_status.req);
 
-	kfree(fu->cmd.buf);
+	kfree(fu->cmd[0].buf);
 
 	fu->bot_req_in = NULL;
 	fu->bot_req_out = NULL;
-	fu->cmd.req = NULL;
+	fu->cmd[0].req = NULL;
 	fu->bot_status.req = NULL;
-	fu->cmd.buf = NULL;
+	fu->cmd[0].buf = NULL;
 }
 
 static void bot_set_alt(struct f_uas *fu)
@@ -482,10 +482,14 @@ static void uasp_cleanup_one_stream(struct f_uas *fu, struct uas_stream *stream)
 
 static void uasp_free_cmdreq(struct f_uas *fu)
 {
-	usb_ep_free_request(fu->ep_cmd, fu->cmd.req);
-	kfree(fu->cmd.buf);
-	fu->cmd.req = NULL;
-	fu->cmd.buf = NULL;
+	int i;
+
+	for (i = 0; i < USBG_NUM_CMDS; i++) {
+		usb_ep_free_request(fu->ep_cmd, fu->cmd[i].req);
+		kfree(fu->cmd[i].buf);
+		fu->cmd[i].req = NULL;
+		fu->cmd[i].buf = NULL;
+	}
 }
 
 static void uasp_cleanup_old_alt(struct f_uas *fu)
@@ -500,7 +504,7 @@ static void uasp_cleanup_old_alt(struct f_uas *fu)
 	usb_ep_disable(fu->ep_status);
 	usb_ep_disable(fu->ep_cmd);
 
-	for (i = 0; i < UASP_SS_EP_COMP_NUM_STREAMS; i++)
+	for (i = 0; i < USBG_NUM_CMDS; i++)
 		uasp_cleanup_one_stream(fu, &fu->stream[i]);
 	uasp_free_cmdreq(fu);
 }
@@ -603,7 +607,8 @@ static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 
 	case UASP_QUEUE_COMMAND:
 		transport_generic_free_cmd(&cmd->se_cmd, 0);
-		usb_ep_queue(fu->ep_cmd, fu->cmd.req, GFP_ATOMIC);
+		usb_ep_queue(fu->ep_cmd, cmd->req, GFP_ATOMIC);
+
 		break;
 
 	default:
@@ -718,7 +723,7 @@ static int uasp_send_write_request(struct usbg_cmd *cmd)
 	return ret;
 }
 
-static int usbg_submit_command(struct f_uas *, void *, unsigned int);
+static int usbg_submit_command(struct f_uas *, struct usb_request *);
 
 static void uasp_cmd_complete(struct usb_ep *ep, struct usb_request *req)
 {
@@ -728,7 +733,7 @@ static void uasp_cmd_complete(struct usb_ep *ep, struct usb_request *req)
 	if (req->status < 0)
 		return;
 
-	ret = usbg_submit_command(fu, req->buf, req->actual);
+	ret = usbg_submit_command(fu, req);
 	/*
 	 * Once we tune for performance enqueue the command req here again so
 	 * we can receive a second command while we processing this one. Pay
@@ -737,7 +742,7 @@ static void uasp_cmd_complete(struct usb_ep *ep, struct usb_request *req)
 	 */
 	if (!ret)
 		return;
-	usb_ep_queue(fu->ep_cmd, fu->cmd.req, GFP_ATOMIC);
+	usb_ep_queue(fu->ep_cmd, req, GFP_ATOMIC);
 }
 
 static int uasp_alloc_stream_res(struct f_uas *fu, struct uas_stream *stream)
@@ -766,24 +771,24 @@ static int uasp_alloc_stream_res(struct f_uas *fu, struct uas_stream *stream)
 	return -ENOMEM;
 }
 
-static int uasp_alloc_cmd(struct f_uas *fu)
+static int uasp_alloc_cmd(struct f_uas *fu, int i)
 {
-	fu->cmd.req = usb_ep_alloc_request(fu->ep_cmd, GFP_KERNEL);
-	if (!fu->cmd.req)
+	fu->cmd[i].req = usb_ep_alloc_request(fu->ep_cmd, GFP_KERNEL);
+	if (!fu->cmd[i].req)
 		goto err;
 
-	fu->cmd.buf = kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL);
-	if (!fu->cmd.buf)
+	fu->cmd[i].buf = kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL);
+	if (!fu->cmd[i].buf)
 		goto err_buf;
 
-	fu->cmd.req->complete = uasp_cmd_complete;
-	fu->cmd.req->buf = fu->cmd.buf;
-	fu->cmd.req->length = fu->ep_cmd->maxpacket;
-	fu->cmd.req->context = fu;
+	fu->cmd[i].req->complete = uasp_cmd_complete;
+	fu->cmd[i].req->buf = fu->cmd[i].buf;
+	fu->cmd[i].req->length = fu->ep_cmd->maxpacket;
+	fu->cmd[i].req->context = fu;
 	return 0;
 
 err_buf:
-	usb_ep_free_request(fu->ep_cmd, fu->cmd.req);
+	usb_ep_free_request(fu->ep_cmd, fu->cmd[i].req);
 err:
 	return -ENOMEM;
 }
@@ -792,26 +797,22 @@ static int uasp_prepare_reqs(struct f_uas *fu)
 {
 	int ret;
 	int i;
-	int max_streams;
-
-	if (fu->flags & USBG_USE_STREAMS)
-		max_streams = UASP_SS_EP_COMP_NUM_STREAMS;
-	else
-		max_streams = 1;
 
-	for (i = 0; i < max_streams; i++) {
+	for (i = 0; i < USBG_NUM_CMDS; i++) {
 		ret = uasp_alloc_stream_res(fu, &fu->stream[i]);
 		if (ret)
 			goto err_cleanup;
 	}
 
-	ret = uasp_alloc_cmd(fu);
-	if (ret)
-		goto err_free_stream;
+	for (i = 0; i < USBG_NUM_CMDS; i++) {
+		ret = uasp_alloc_cmd(fu, i);
+		if (ret)
+			goto err_free_stream;
 
-	ret = usb_ep_queue(fu->ep_cmd, fu->cmd.req, GFP_ATOMIC);
-	if (ret)
-		goto err_free_stream;
+		ret = usb_ep_queue(fu->ep_cmd, fu->cmd[i].req, GFP_ATOMIC);
+		if (ret)
+			goto err_free_stream;
+	}
 
 	return 0;
 
@@ -1081,10 +1082,9 @@ static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
 
 static void usbg_release_cmd(struct se_cmd *);
 
-static int usbg_submit_command(struct f_uas *fu,
-		void *cmdbuf, unsigned int len)
+static int usbg_submit_command(struct f_uas *fu, struct usb_request *req)
 {
-	struct command_iu *cmd_iu = cmdbuf;
+	struct command_iu *cmd_iu = req->buf;
 	struct usbg_cmd *cmd;
 	struct usbg_tpg *tpg = fu->tpg;
 	struct tcm_usbg_nexus *tv_nexus;
@@ -1114,8 +1114,7 @@ static int usbg_submit_command(struct f_uas *fu,
 	}
 	memcpy(cmd->cmd_buf, cmd_iu->cdb, cmd_len);
 
-	cmd->stream = &fu->stream[cmd->tag %
-		UASP_SS_EP_COMP_NUM_STREAMS];
+	cmd->stream = &fu->stream[cmd->tag % USBG_NUM_CMDS];
 
 	switch (cmd_iu->prio_attr & 0x7) {
 	case UAS_HEAD_TAG:
@@ -1137,6 +1136,7 @@ static int usbg_submit_command(struct f_uas *fu,
 	}
 
 	cmd->unpacked_lun = scsilun_to_int(&cmd_iu->lun);
+	cmd->req = req;
 
 	INIT_WORK(&cmd->work, usbg_cmd_work);
 	queue_work(tpg->workqueue, &cmd->work);
diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index 6cb05dcd19ff..bcbe35bb5015 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -16,6 +16,8 @@
 #define UASP_SS_EP_COMP_LOG_STREAMS 5
 #define UASP_SS_EP_COMP_NUM_STREAMS (1 << UASP_SS_EP_COMP_LOG_STREAMS)
 
+#define USBG_NUM_CMDS		UASP_SS_EP_COMP_NUM_STREAMS
+
 enum {
 	USB_G_STR_INT_UAS = 0,
 	USB_G_STR_INT_BBB,
@@ -75,6 +77,8 @@ struct usbg_cmd {
 	struct completion write_complete;
 	struct kref ref;
 
+	struct usb_request *req;
+
 	/* UAS only */
 	u16 tag;
 	u16 prio_attr;
@@ -117,14 +121,14 @@ struct f_uas {
 #define USBG_IS_BOT		(1 << 3)
 #define USBG_BOT_CMD_PEND	(1 << 4)
 
-	struct usbg_cdb		cmd;
+	struct usbg_cdb		cmd[USBG_NUM_CMDS];
 	struct usb_ep		*ep_in;
 	struct usb_ep		*ep_out;
 
 	/* UAS */
 	struct usb_ep		*ep_status;
 	struct usb_ep		*ep_cmd;
-	struct uas_stream	stream[UASP_SS_EP_COMP_NUM_STREAMS];
+	struct uas_stream	stream[USBG_NUM_CMDS];
 
 	/* BOT */
 	struct bot_status	bot_status;
-- 
2.28.0

