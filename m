Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357185790BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiGSCS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbiGSCSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:18:54 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F73C8E9;
        Mon, 18 Jul 2022 19:18:52 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILoCF8020763;
        Mon, 18 Jul 2022 18:26:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=MtkL5HtVzu1AN/MUKIOAzTNp5lPvcuXSXw6ukmlraiA=;
 b=O41UM5yyqiIFG2UePAX9b6+bmaekA88pimIs4SdsojbZODzoBtY4Iig9XWNPVZ3UV3Ri
 cIWTlVvQqY3SNB+8XvmyOoWqBV9BmlW2Qt8eeD0p8u6cCKb83txh+gHeE082AFezorda
 ac8tkGuI28WqwqjdEXDFVdfwsVFQURBvz7pVbv10BxGRfw6CwkxlO7KCD5avBwrwQaQH
 e+dq3T2OSTzFTEbnTtbp/DND+22uo1AVMBA4lvFDL3Iyfyj4wn2sSd6QgrDV5MSLGv7H
 qmmERH6iW8jheCHMEw5dDdQ7fzCGDDoFcaFpD9hjmZE+4JvCtPVOlgL7BnCxvL2yC5nX gQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3hc6c344wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:26:37 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D3D2FC0649;
        Tue, 19 Jul 2022 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658193996; bh=JhsO1p/dFQs74XyIe0gssm1C8LZABLQ+B+PPL+9af98=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=lH3Dwnem7Z6tCz8PUq6Wk+ziBIEuT015RauWjZLMoH4ceVsFhzWwJAcsXsBDz50iM
         r78HEY339840ILH2StMRmzJBhytaahzRL1ZRGKkyYk4f3LCUvXikrshJErCuAG2Xl3
         xSme2ZO5B3GmBjzARrqSDfbcoKkZXMSh5KTaBWD9cXRx4La7X4WnH5uR7OBP1E94fq
         9mLubC1qeyvQ6voEEXhbNFJCcSrJ8ILJ3zBWpAZ8+0+hz834dVW6CAsKmgwzTXeTGr
         pTlYhdYvETaK12zO1DjQy5Z3InfIHgp+OqFg7mf/2Fjm+u+6K42x1qsOxMABMM7YM8
         1Q50E5YAEevpw==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 98801A0096;
        Tue, 19 Jul 2022 01:26:35 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:26:35 -0700
Date:   Mon, 18 Jul 2022 18:26:35 -0700
Message-Id: <1ca4811d61c50e5b9ff81e2b181544ae0ac3106a.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 05/25] usb: gadget: f_tcm: Don't set static stream_id
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-ORIG-GUID: 9p4-WGYie49SZDCX9BLCYq5hNt4wWpxr
X-Proofpoint-GUID: 9p4-WGYie49SZDCX9BLCYq5hNt4wWpxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=946 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host can assign stream ID value greater than number of streams
allocated. The tcm function needs to keep track of which stream is
available to assign the stream ID. This patch doesn't track that, but at
least it makes sure that there's no Oops if the host send tag with a
value greater than the number of supported streams.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 32 +++++------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 270ec631481d..7721216dc9bc 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -532,6 +532,7 @@ static int uasp_prepare_r_request(struct usbg_cmd *cmd)
 	}
 
 	stream->req_in->is_last = 1;
+	stream->req_in->stream_id = cmd->tag;
 	stream->req_in->complete = uasp_status_data_cmpl;
 	stream->req_in->length = se_cmd->data_length;
 	stream->req_in->context = cmd;
@@ -556,6 +557,7 @@ static void uasp_prepare_status(struct usbg_cmd *cmd)
 	iu->len = cpu_to_be16(se_cmd->scsi_sense_length);
 	iu->status = se_cmd->scsi_status;
 	stream->req_status->is_last = 1;
+	stream->req_status->stream_id = cmd->tag;
 	stream->req_status->context = cmd;
 	stream->req_status->length = se_cmd->scsi_sense_length + 16;
 	stream->req_status->buf = iu;
@@ -786,19 +788,6 @@ static int uasp_alloc_cmd(struct f_uas *fu)
 	return -ENOMEM;
 }
 
-static void uasp_setup_stream_res(struct f_uas *fu, int max_streams)
-{
-	int i;
-
-	for (i = 0; i < max_streams; i++) {
-		struct uas_stream *s = &fu->stream[i];
-
-		s->req_in->stream_id = i + 1;
-		s->req_out->stream_id = i + 1;
-		s->req_status->stream_id = i + 1;
-	}
-}
-
 static int uasp_prepare_reqs(struct f_uas *fu)
 {
 	int ret;
@@ -819,7 +808,6 @@ static int uasp_prepare_reqs(struct f_uas *fu)
 	ret = uasp_alloc_cmd(fu);
 	if (ret)
 		goto err_free_stream;
-	uasp_setup_stream_res(fu, max_streams);
 
 	ret = usb_ep_queue(fu->ep_cmd, fu->cmd.req, GFP_ATOMIC);
 	if (ret)
@@ -995,6 +983,7 @@ static int usbg_prepare_w_request(struct usbg_cmd *cmd, struct usb_request *req)
 	}
 
 	req->is_last = 1;
+	req->stream_id = cmd->tag;
 	req->complete = usbg_data_write_cmpl;
 	req->length = se_cmd->data_length;
 	req->context = cmd;
@@ -1125,16 +1114,8 @@ static int usbg_submit_command(struct f_uas *fu,
 	}
 	memcpy(cmd->cmd_buf, cmd_iu->cdb, cmd_len);
 
-	if (fu->flags & USBG_USE_STREAMS) {
-		if (cmd->tag > UASP_SS_EP_COMP_NUM_STREAMS)
-			goto err;
-		if (!cmd->tag)
-			cmd->stream = &fu->stream[0];
-		else
-			cmd->stream = &fu->stream[cmd->tag - 1];
-	} else {
-		cmd->stream = &fu->stream[0];
-	}
+	cmd->stream = &fu->stream[cmd->tag %
+		UASP_SS_EP_COMP_NUM_STREAMS];
 
 	switch (cmd_iu->prio_attr & 0x7) {
 	case UAS_HEAD_TAG:
@@ -1161,9 +1142,6 @@ static int usbg_submit_command(struct f_uas *fu,
 	queue_work(tpg->workqueue, &cmd->work);
 
 	return 0;
-err:
-	usbg_release_cmd(&cmd->se_cmd);
-	return -EINVAL;
 }
 
 static void bot_cmd_work(struct work_struct *work)
-- 
2.28.0

