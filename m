Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97457913F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiGSDUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiGSDUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:20:38 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC38A24F25;
        Mon, 18 Jul 2022 20:20:28 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILeY2P029326;
        Mon, 18 Jul 2022 18:26:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=M180YcUp4LTEpyCxleR4FVpckgymUrgVO89H/11fMPg=;
 b=GQW344vCkoFDSgBVShL5hSEsap/SwqnYUokefgIHtfSTbU4o+ywg4rvDf7P5kU5anvYV
 Qefx6ohxo9S+FylUqTMP32SHlWrsPgXKiefvGyto4Ja/Ex3MRO/6mm/ietKs7ycj5VrF
 NABjyLDh1HRXoPgkNng0nhPtCcctLVUrczFqILygu/HwfEDl2vvCClfacXVvn0Si7Ui6
 Ajg77x4UAT6ENHFnWP6CYm3VjWI9q5NFbnrWXZiOzW34KRwpxcOFwsWdKQc9Ih5GERD4
 M67WN3cJiAr8tsnA3Dc5p18frSmw7iV2gzvZsfQ9IVcDwtGWqzDQxaNW8U4fgpU0FvYo QQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6dec5fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:26:50 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 286CF4008A;
        Tue, 19 Jul 2022 01:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194009; bh=tNgndfD1F79ARxp0mVGVrV9+gTpVlt3d7W6aaKNj5QY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=go8OJejElGgKpXSj0lOdvZudMCsBEc2JNCkOyrKcOlW231kjaSA1O8/UO/vqK14AI
         y6rVO2wSyE3MW9YaHU7y2P6oPAGDG6V45JhM/SxGQLYPh/yeBfCLy0i6iS1VtxABKB
         J4oS5JbpFFUXqCa1McoQ8ZpXkcXoHILEeOnlnBXwNN5P/wFbXjA25WHWMJjZvp16J1
         wbaXZPWUWTdnXKOwowmX+2rzVQYvH5NT4gwekuqHq3wpgkpV0x59HmE7785G/il3ct
         4H7ZXFZJw6AR4YXGZC9CMaAHxzfpzOasNGfPnrhD0KnqaSs3xhPS1XJ0dcc2R/lFBR
         pwz5sDHTyLPAA==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 09316A0068;
        Tue, 19 Jul 2022 01:26:48 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:26:47 -0700
Date:   Mon, 18 Jul 2022 18:26:47 -0700
Message-Id: <d9d1f0a91efdd03cc62acbae11edf92f3fe3dbe7.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 07/25] usb: gadget: f_tcm: Limit number of sessions
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-ORIG-GUID: N8n_EpjNDkF3a89Yh31weB8Mttcz4h-Q
X-Proofpoint-GUID: N8n_EpjNDkF3a89Yh31weB8Mttcz4h-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=908 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
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

Only allocate up to USBG_NUM_CMDS number of session tags. We should not
be using more than USBG_NUM_CMDS of tags due to the number of commands
limit we imposed. Each command uses a unique tag. Any more than that is
unnecessary. By limitting it, we can detect an issue in our driver
immediately should we run out of session tags.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Add more comments in change log for the change reason.

 drivers/usb/gadget/function/tcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index bcbe35bb5015..df768559fb60 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -26,7 +26,7 @@ enum {
 #define USB_G_ALT_INT_BBB       0
 #define USB_G_ALT_INT_UAS       1
 
-#define USB_G_DEFAULT_SESSION_TAGS	128
+#define USB_G_DEFAULT_SESSION_TAGS	USBG_NUM_CMDS
 
 struct tcm_usbg_nexus {
 	struct se_session *tvn_se_sess;
-- 
2.28.0

