Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5846D579037
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiGSB5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiGSB5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:57:10 -0400
X-Greylist: delayed 126 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 18:56:54 PDT
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0943AB15;
        Mon, 18 Jul 2022 18:56:54 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J0KFhO029346;
        Mon, 18 Jul 2022 18:27:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=a7LvvtmsDCzq5sgn7YADzX4n9vJFy5h9YpSPqPmsSoc=;
 b=X42QkjNQ7dbxfkfa9IVirwPWrNTfIuTtWYHHwi0ZsBDRLY+CYPqIYYB9t4RpCkF0XUWx
 qYEYRMB/7aiVPM8/SzHWilABIvYf67nFMw2l5IAaU1A7DpiGxfrFyT2lr/Q6pzR+VuXI
 Va9O8N9YJNB/PWR8IeE6GvOcyROU9Xju4b/xhCfcsllGhyn9MrtDW/Lf90v6q2TG/Mgv
 aKtEJegKNlYQPANdapYuZB++yGJllnZ/Ex9CxbI0zgO6aNxjUyBVSc/8Lshw+bBzqcRn
 lzKTTXrhGH9li+WPxM3MRcBLdiUyTjfHYnB4YRBfn6VWEiPA0Qc1nEukyV3n4Mw21XK7 BA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6dec5hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:15 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7EF884008A;
        Tue, 19 Jul 2022 01:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194034; bh=HR+//0OTCdoeUXuBkPE2suel5h52O0aLq+A26bTyDp4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ACZ2dylA6K7PLVGRw3l2IUmYpxVOxGmS/Qubu7SCQ+4WWSBIeoTRMjPOnyaIny+dk
         wkjMSWZHwyVuKei/S/F12RI8f8K1z7f5uAio39u7bNMJTfPxIkGJSe5mMDBzX3GtRk
         FHCEQBBOo4f8K1zRffA7e//NwmM6thHFsTdlXQtS45gl7SaD2/VvWVfKTlPaolCkHS
         UHevXONCbHe4+hXqXynH6e9RZco7xhyYzKGHyNWTsgxLhertNKWDaXLlm8xXLM2H3B
         UuwlgEUpf83hESC/CEvmxgH3SYoiuukew2ugCtcqE35jbTZRWmyG/rOIzLIpkiIp+j
         0APpdzgApTj+A==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id CBC85A006D;
        Tue, 19 Jul 2022 01:27:12 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:12 -0700
Date:   Mon, 18 Jul 2022 18:27:12 -0700
Message-Id: <b030d10834c13aa09bbbba7b33b1957d5ba3664c.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 11/25] usb: gadget: f_tcm: Execute command on write completion
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-ORIG-GUID: CZESAK36mznakSqxAX5nFh2OGbrPNBUn
X-Proofpoint-GUID: CZESAK36mznakSqxAX5nFh2OGbrPNBUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=947 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
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

Don't just wait for the data write completion and execute the target
command. We need to verify if the request completed successfully and not
just sending invalid data. The verification is done in the write request
completion routine, so we can just run target_execute_cmd() there. The
wait for the data write is not needed.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 8 +-------
 drivers/usb/gadget/function/tcm.h   | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 6fea80afe2d7..ec83f2f9a858 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -248,7 +248,6 @@ static int bot_send_write_request(struct usbg_cmd *cmd)
 	struct usb_gadget *gadget = fuas_to_gadget(fu);
 	int ret;
 
-	init_completion(&cmd->write_complete);
 	cmd->fu = fu;
 
 	if (!cmd->data_len) {
@@ -279,8 +278,6 @@ static int bot_send_write_request(struct usbg_cmd *cmd)
 	if (ret)
 		pr_err("%s(%d)\n", __func__, __LINE__);
 
-	wait_for_completion(&cmd->write_complete);
-	target_execute_cmd(se_cmd);
 cleanup:
 	return ret;
 }
@@ -685,7 +682,6 @@ static int uasp_send_write_request(struct usbg_cmd *cmd)
 	struct sense_iu *iu = &cmd->sense_iu;
 	int ret;
 
-	init_completion(&cmd->write_complete);
 	cmd->fu = fu;
 
 	iu->tag = cpu_to_be16(cmd->tag);
@@ -717,8 +713,6 @@ static int uasp_send_write_request(struct usbg_cmd *cmd)
 			pr_err("%s(%d)\n", __func__, __LINE__);
 	}
 
-	wait_for_completion(&cmd->write_complete);
-	target_execute_cmd(se_cmd);
 cleanup:
 	return ret;
 }
@@ -955,7 +949,7 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 				se_cmd->data_length);
 	}
 
-	complete(&cmd->write_complete);
+	target_execute_cmd(se_cmd);
 	return;
 
 cleanup:
diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index c7e6d36afd3a..5157af1b166b 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -74,7 +74,6 @@ struct usbg_cmd {
 	struct se_cmd se_cmd;
 	void *data_buf; /* used if no sg support available */
 	struct f_uas *fu;
-	struct completion write_complete;
 	struct kref ref;
 
 	struct usb_request *req;
-- 
2.28.0

