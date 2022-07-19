Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34857907E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiGSCHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiGSCG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:06:58 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314D23C8F6;
        Mon, 18 Jul 2022 19:06:58 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J0KFhM029346;
        Mon, 18 Jul 2022 18:27:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=EJyimqz53Z0T6wkrPrc8lFhAbEkc9ytvO6P5ConP0C0=;
 b=V9/prvsaFea9IAzldImSOmFTzluHFRh45/K7n5stYkUcDrR8kSC9xagy8t1hvlaRfIjO
 cFU3gevrMvx43dg3lljBR31dgAXjsC7Y0jN3ciLSSw+bi8ONxS9cNcmn38dtq4NqDUE9
 EUNEZLujD8tFGryu5fsiv1s+HhiE4LLfsanraBd1anZWUb7hK3kgvS+iXyQ/Hh7zVLQx
 k5LmPJ8jLuYQY9P6iTDi/zrdOyI9u47gaut9WBA0Y7Sdzwfi00/RdF/kOc+MemAbpqZs
 /4o6eQDkJ7nX/4guM7ubVPiCwXGVRrdg/x90IM0FCYjzzAj3/4ryR/OGcxvMEpl7V+EJ 7Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6dec5h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:02 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 60BFE4008A;
        Tue, 19 Jul 2022 01:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194021; bh=IyeW+hiZulNtLHbEM02GHa7eRIJF78uaYlraYY09p+g=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=NGDU90r7k75Ps4+1Q81huYDF6Pc5Wk3TrhAX6Ff8XPR3Ijc38r6JNtdOXA5UHgklc
         8Qhe9jAQUre+y9EcDOSclXsIYUBBV26pWSImw+kXALTg6l8yYlRTb6iHXUR186v8VL
         0PveTwPkDsXzc9Qc3/ed4g7yavH8RQfsaq75aW4wkz8gKVvW4cqKQqe3Pwo4VpNxoI
         6O8MrPXyhN6FBH7b9mAJ/M586+YwtsvIBOCjmwBi6EqkygfKDltH3NT7lgOFcyfHrX
         mLwtBE4uI37Rg4IQOn3DMapoUxfVMF2lgWaz8VA6EyNaHGm03dP7EuVFaRTlXGyTzz
         aGeKaXpY7u+xg==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 3F2CEA0068;
        Tue, 19 Jul 2022 01:27:00 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:00 -0700
Date:   Mon, 18 Jul 2022 18:27:00 -0700
Message-Id: <3310604a0940fd3029404b9d7ba3cdf2800f6cf4.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 09/25] usb: gadget: f_tcm: Use extra number of commands
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-ORIG-GUID: iP87kAFGM-EMiXa5S4qBH4EVUQdHyXnI
X-Proofpoint-GUID: iP87kAFGM-EMiXa5S4qBH4EVUQdHyXnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=662 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
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

To properly respond to host sending more commands than the number of
streams the device advertises, the device needs to be able to reject the
command with a response. Allocate an extra request to handle 1 more
command than the number of streams.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/tcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index df768559fb60..c7e6d36afd3a 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -16,7 +16,7 @@
 #define UASP_SS_EP_COMP_LOG_STREAMS 5
 #define UASP_SS_EP_COMP_NUM_STREAMS (1 << UASP_SS_EP_COMP_LOG_STREAMS)
 
-#define USBG_NUM_CMDS		UASP_SS_EP_COMP_NUM_STREAMS
+#define USBG_NUM_CMDS		(UASP_SS_EP_COMP_NUM_STREAMS + 1)
 
 enum {
 	USB_G_STR_INT_UAS = 0,
-- 
2.28.0

