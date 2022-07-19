Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E625790E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiGSCch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGSCcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:32:36 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7BF13F80;
        Mon, 18 Jul 2022 19:32:34 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IM5U1w002272;
        Mon, 18 Jul 2022 18:27:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=b7MfKPf9nQqlmO/dDxc6MjRx/cnBJnR5IidJCKntjdg=;
 b=jJj62atp918abmoxQFFL17Z3GqYvon6Lsd3M8l+wuNWgMwAVTwpvl05XMijEdA+1s91w
 E0Ux1NGUZZIEIthVoG+0P661JSMiaMXwbgifKd5jKYOE7wAbzMZYWxe9b7fmxaDzYlQ8
 fOaMA94LtU+VYm2YL+JeSeqjAGqPkKtluBXIUylRFjGh5Z9RRSVupTvfo6ee2CI9hDjp
 nDiLdoQa5I/l90rDMuPBC39p/dGmIJ4ZdBgBTKL1MC6R8G5ZtloI3ymze5uduPBfa4aZ
 THA64T0FCGrSS5VktyrdeISWg2S9h6SyCYGSnQQY6Ck6VP2LWo1n3uccStlWd/GbjwLp Tg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvbmwhtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:59 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 17B274008A;
        Tue, 19 Jul 2022 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194079; bh=OrBOJOTlFf/nTJ3m0qhtxxTxNpwmgDDjmhBn0n85VZo=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=bNleh05+dhtViPOLnCBYh7xUbQI3U/dKoHajoIjH8S723gmeeawj8/fsNb0FLtd6J
         9xtxlPduknuKJRfJgKMAlGh3RyEM8IR8Om8Ab7luAfdPDRHwBmYhtrqBQogJ+AQ1f4
         8IWbD49HzePd0lK/8oTymb+UJ/BcWBfI4ITyo0S27PRVEK11GXA5kQk2/ACzl8xiTm
         sza1tvb4LDiIksQTxiTwu6qbqHfQsq2wVCp6gtErQldw33V7YQTvvqAM0WHzV4gwQg
         BST5PgcBRNPz1uz1xsaIGvs+yBg1B2G5+u3O4eiWNdgsTgeVb4VasVgMxNRWjLQ+sV
         +p+jCfk6Tp1vw==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id E95D2A0096;
        Tue, 19 Jul 2022 01:27:57 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:57 -0700
Date:   Mon, 18 Jul 2022 18:27:57 -0700
Message-Id: <782c62e59d8902044e6021fa7dd6c249a4ea4288.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 18/25] usb: gadget: f_tcm: Cleanup requests on ep disable
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: x7H5AlVZrQl5IezmB09RvunRrE48r1NQ
X-Proofpoint-ORIG-GUID: x7H5AlVZrQl5IezmB09RvunRrE48r1NQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=740 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the endpoint is disabled, then free the command. Normally we don't
free a command until it's completed its UASP status (failure or not).

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Use goto cleanup for a cleaner look.

 drivers/usb/gadget/function/f_tcm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 8f7eb7045e64..a8a730e5126d 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -572,7 +572,7 @@ static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 	struct f_uas *fu = cmd->fu;
 	int ret;
 
-	if (req->status < 0)
+	if (req->status == -ESHUTDOWN)
 		goto cleanup;
 
 	switch (cmd->state) {
@@ -936,7 +936,10 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 
 	cmd->state = UASP_QUEUE_COMMAND;
 
-	if (req->status < 0) {
+	if (req->status == -ESHUTDOWN)
+		goto cleanup;
+
+	if (req->status) {
 		pr_err("%s() state %d transfer failed\n", __func__, cmd->state);
 		goto cleanup;
 	}
-- 
2.28.0

