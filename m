Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87626578FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGSBrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGSBrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:47:51 -0400
X-Greylist: delayed 197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 18:47:50 PDT
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA331B7A9;
        Mon, 18 Jul 2022 18:47:50 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J15LEr011685;
        Mon, 18 Jul 2022 18:28:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=nuHVSWCgl9dwD0wByFXYvmOFMYvn1dm33E7o/YfdqrY=;
 b=b4Smb5ZFNadz6txMBipOo46sdJ3CaFE63gOYfnJWcwSoRua4xxZYySvhvKCb6zsNSZRq
 g85UHtxAuNCfM0nVxa0CVdCpHpNCUNhC1ZeoDW9nz4Zf2n2hAnt0K10RdfbcxfhQZEwe
 oz9YVB69o0rCSWBLX7BFgekHNpurCiBXcnGq/LVnX/0Fd+I9YOyaDUw9UTd4N1bjx1Bl
 JJCEc4wq171MmvcIEeEiq901MbrotZFa4FczZNb0I/J+TDMk/3eg6v4Jmz92ijD+H1pu
 D2Cmn7BBeCXf4wpmiNIlx4460NqrEJ+nKkIQaE9QtOfLVrvhWdOM6VUnjo7/tU5WPKne 5g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5whs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:28:42 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 10A6BC0649;
        Tue, 19 Jul 2022 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194122; bh=HXpi+zxefL7ycJivlkZYu4nzewzzTh6ZNR2/6Q/0HNU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=C8SUhXbjLJ3if4wFdDLLFvdmLTKOdNAA3ZJHB8CUVF8EKUXzizs0hP94IOK27QyqF
         52Yko+tCl0Nz/E4n92fl+aHxyxB1gxfMreqNh7enX+vpTb5gN26FY2UKo27k+4FFCl
         cKjlvyeEcLsEflsTRd6T1zSYTyRIPQXXCAaS6Z8vdKjBXuGjk6SdRsag92YdfGRS5K
         6hJsi5JzHOwzK6+6q+eamTI9UHXwfh5w6jjh1LVAL7575LuYklIyfY9DgI7IBRc/eG
         a9gLiEtbFkh2+qDzttS//72h3wc4P8PNhh7EiuvPxUT8JTg/9TSCjT85nWw3sHdqFY
         /8ew9dSLhhYiA==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id C92F8A006D;
        Tue, 19 Jul 2022 01:28:40 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:28:40 -0700
Date:   Mon, 18 Jul 2022 18:28:40 -0700
Message-Id: <dc2225ef078a08eccbd3fa9b06c760f85b88fc16.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 25/25] usb: gadget: f_tcm: Comply with UAS Task Management requirement
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: _F5FVp5rpwqkwXYASrUTrMfRvAALCqWr
X-Proofpoint-ORIG-GUID: _F5FVp5rpwqkwXYASrUTrMfRvAALCqWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=987 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
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

The UASP driver must support all the task management functions listed in
Table 20 of UAS-r04. However, not all of them are implemented in the
Target core. To remain compliant while indicate that the TMR did not go
through, report RC_TMF_FAILED instead of RC_TMF_NOT_SUPPORTED and print
a warning to the user.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index dfa3e7c043a3..727d7c3e61c2 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -643,6 +643,30 @@ static void uasp_prepare_response(struct usbg_cmd *cmd)
 		rsp_iu->response_code =
 			tcm_to_uasp_response(se_cmd->se_tmr_req->response);
 
+	/*
+	 * The UASP driver must support all the task management functions listed
+	 * in Table 20 of UAS-r04. To remain compliant while indicate that the
+	 * TMR did not go through, report RC_TMF_FAILED instead of
+	 * RC_TMF_NOT_SUPPORTED and print a warning to the user.
+	 */
+	switch (cmd->tmr_func) {
+	case TMR_ABORT_TASK:
+	case TMR_ABORT_TASK_SET:
+	case TMR_CLEAR_TASK_SET:
+	case TMR_LUN_RESET:
+	case TMR_I_T_NEXUS_RESET:
+	case TMR_CLEAR_ACA:
+	case TMR_QUERY_TASK:
+	case TMR_QUERY_TASK_SET:
+	case TMR_QUERY_ASYNC_EVENT:
+		if (rsp_iu->response_code == RC_TMF_NOT_SUPPORTED) {
+			pr_warn("TMR function %d not supported\n",
+				cmd->tmr_func);
+			rsp_iu->response_code = RC_TMF_FAILED;
+		}
+		break;
+	}
+
 	stream->req_status->is_last = 1;
 	stream->req_status->stream_id = cmd->tag;
 	stream->req_status->context = cmd;
-- 
2.28.0

