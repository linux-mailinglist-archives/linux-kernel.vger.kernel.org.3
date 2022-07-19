Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C9579018
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiGSBvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiGSBvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:51:22 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A99219;
        Mon, 18 Jul 2022 18:51:20 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IMdcX5011679;
        Mon, 18 Jul 2022 18:27:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=7VmFkG8+6gcOskHL/t2k80ZjODg183bvO+6+/+nliyQ=;
 b=ZmeoPX+MHZX7fBQUlUlY2xefMvRKSJKaJ/gQb3uvOBEsyuDcy88L1x693Bzw7tHbNb3R
 AhfPbokkucriXdpv/bDWFisk1hNkSM9hhIPbCaiPth24s8nrIKqRYL3uW7Gfh+TRFKDg
 ZcADEsEg90M2QgTJTTmB8fcqVH8JC9xi+UjWA8jl4oG9YewPKVG73L3ZPwNo8+B8P4Sl
 K8Gqjv/h6/Ut+0Mkmlwz4vtPA5U9HaW6DqJrT52ra3Zgwg+9gpAn7/6Udg3kibr4sea7
 9onAUC/lat4pi4gRNS3wcwy3Ts1kBDb7LTlP3pIpWW3qq5wC9XabW2zD5WOK5+gRyT7I kQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5whpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:53 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 149E0C0649;
        Tue, 19 Jul 2022 01:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194073; bh=k1PpIrVAGNI15QgEMmyoYc15szdzFTiIjkWRmlBBZAM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=IYu3W1seEybbWYAksBfL5htPGbPDjY4fsOzvmZnFpbJ8p5kBil/3avtTLrn+mHpRo
         l06Gd1fsPHea3FoVlDccjlP3Ca28BXk1BCd3XlqIdQ/kB+SfBNwCv7nBa8k0XX++nh
         +gTy3b/mcI0h1gx7VjE5pa4adFAMHfXkUlLaWN2qgwvGO03iqwYY2g7X21QERp4TGk
         CBKeiATlshMC3YLEyJJMLp4yLzHk3u6DPiAIahg4i6XdvB3cohfGvJDnOu6iWuaBH+
         d3+cyfREsncwH6sG0JjRx0Dffh3RuBm9ZreXBsMIKh0jGpZ8rj8owPodOrOwl+RbaB
         1zoo6Ku3LP3+A==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id CE22EA0096;
        Tue, 19 Jul 2022 01:27:51 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:51 -0700
Date:   Mon, 18 Jul 2022 18:27:51 -0700
Message-Id: <099a4bd5ed02f4c48f4640347379b5127075e453.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 17/25] usb: gadget: f_tcm: Handle abort command
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: 4Rcy1KGt19VMc1GOKIQ84T6pnh3igkga
X-Proofpoint-ORIG-GUID: 4Rcy1KGt19VMc1GOKIQ84T6pnh3igkga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=926 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
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

Implemented aborted_task to cancel outstanding request.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index d7318c84af98..8f7eb7045e64 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1278,6 +1278,22 @@ static void usbg_queue_tm_rsp(struct se_cmd *se_cmd)
 
 static void usbg_aborted_task(struct se_cmd *se_cmd)
 {
+	struct usbg_cmd *cmd = container_of(se_cmd, struct usbg_cmd, se_cmd);
+	struct f_uas *fu = cmd->fu;
+	struct uas_stream *stream = cmd->stream;
+	int ret = 0;
+
+	if (stream->req_out->status == -EINPROGRESS)
+		ret = usb_ep_dequeue(fu->ep_out, stream->req_out);
+	else if (stream->req_in->status == -EINPROGRESS)
+		ret = usb_ep_dequeue(fu->ep_in, stream->req_in);
+	else if (stream->req_status->status == -EINPROGRESS)
+		ret = usb_ep_dequeue(fu->ep_status, stream->req_status);
+
+	if (ret)
+		pr_err("Unable to dequeue se_cmd out %p\n", se_cmd);
+
+	cmd->state = UASP_QUEUE_COMMAND;
 }
 
 static const char *usbg_check_wwn(const char *name)
-- 
2.28.0

