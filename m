Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB5579093
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiGSCJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiGSCJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:09:11 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812173C8DE;
        Mon, 18 Jul 2022 19:09:10 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILqKEe029328;
        Mon, 18 Jul 2022 18:26:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=qkJPrxgGtrbNqfw9s1Vi60239Bt3cH0yMi4lqKGKFLM=;
 b=ksWsU/e6frKTXBg9ufIMu7jHIjcoToMCAo/Mz8i6SaRVQszWIgom5Jj/qm1rwm2AUz/A
 SODLdQUFbFPssTa7wG51DTbb1kaD2Ezk7L65P31OZWGegU2Bv81Y4E2L/yY1fMNkaDcH
 4minQCSS5MnaKS5rPJi9EYGVw4+tkRg6t+8lWPfBy5OonJ42ohDNx+MYfVcJvGQXEdYW
 9jvcdbhLJuM57rPsr6CHD78uB9r4iGK8Na6CDf9UV4PtukAjUPkbqa1WjFB9pjrF7iFq
 HQEdSr1GMmyBkuP8CZbCXGCHDjO2e8qgyD7GH6hF7anrJ8Gbxbzdak0JslaLlNys2qVl tQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6dec5g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:26:56 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4E50D4008A;
        Tue, 19 Jul 2022 01:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194015; bh=/2Vftf4mdEB0AyUJNYx0wby0+U0fRBZYVdKa84rgIMA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=igkUuIo5wyTlfcQ5gCND1+3UnZFZ4gd/e3HAqtakO5qRbFli54IvgqJVBrXlf+8FT
         rY12pNxdN1oE15vuV+T5+t25Lkv2nkI46my+U/SodzD+XLlRmcRQBSWw0C0V/dEr1z
         P2UQHVNQg4uzK+2CLjmA5Fc6Q0s9A8v5w8MWxdxeN2irgDmUO+PqyrWeK62c08/QrU
         6/9LNUSdZW3n8DYP8NicPF1XDiC/l2NpH5mXXHJV0yz/z2mRaLdCZucv41D8M5qEKI
         DygyEoTR1QtKYerm0UEpzfc7QbDFqM6mzR3M1Np240eVY80D9OZ5XyfS6yuXJARkXz
         S64XX4T+RR1Eg==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 226FBA0096;
        Tue, 19 Jul 2022 01:26:54 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:26:54 -0700
Date:   Mon, 18 Jul 2022 18:26:54 -0700
Message-Id: <2562ea25269c4af173382c6e03fde9d423f664d4.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 08/25] usb: gadget: f_tcm: Handle multiple commands in parallel
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-ORIG-GUID: ZiFs0SmjsTFdPmPRYEWOFVQrksZ3aI2R
X-Proofpoint-GUID: ZiFs0SmjsTFdPmPRYEWOFVQrksZ3aI2R
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

Resubmit command on completion to fetch more commands and service them
in parallel. Increase the number of work in a queue. Each work will be
for each command allowing them to be processed concurrently. Also, set
them to be unbounded by cpu to improve performance.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 6e0b54985932..91d853682468 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -728,21 +728,16 @@ static int usbg_submit_command(struct f_uas *, struct usb_request *);
 static void uasp_cmd_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_uas *fu = req->context;
-	int ret;
 
-	if (req->status < 0)
+	if (req->status == -ESHUTDOWN)
 		return;
 
-	ret = usbg_submit_command(fu, req);
-	/*
-	 * Once we tune for performance enqueue the command req here again so
-	 * we can receive a second command while we processing this one. Pay
-	 * attention to properly sync STAUS endpoint with DATA IN + OUT so you
-	 * don't break HS.
-	 */
-	if (!ret)
+	if (req->status < 0) {
+		usb_ep_queue(fu->ep_cmd, req, GFP_ATOMIC);
 		return;
-	usb_ep_queue(fu->ep_cmd, req, GFP_ATOMIC);
+	}
+
+	usbg_submit_command(fu, req);
 }
 
 static int uasp_alloc_stream_res(struct f_uas *fu, struct uas_stream *stream)
@@ -1357,7 +1352,8 @@ static struct se_portal_group *usbg_make_tpg(struct se_wwn *wwn,
 		goto unref_dep;
 	mutex_init(&tpg->tpg_mutex);
 	atomic_set(&tpg->tpg_port_count, 0);
-	tpg->workqueue = alloc_workqueue("tcm_usb_gadget", 0, 1);
+	tpg->workqueue = alloc_workqueue("tcm_usb_gadget",
+					 WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
 	if (!tpg->workqueue)
 		goto free_tpg;
 
-- 
2.28.0

