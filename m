Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B524B4E90
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351619AbiBNLc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:32:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351709AbiBNLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:30:13 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6398A40A00
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:11:53 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220214111151epoutp01367e0b46ec1990c5c4b1817d6972e68c~ToqNzoIxg1889318893epoutp01E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:11:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220214111151epoutp01367e0b46ec1990c5c4b1817d6972e68c~ToqNzoIxg1889318893epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644837111;
        bh=rQEv8A94KwKqju5KY7Ptdnt3AHdeZLS2w//+3n7Lkbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orbcaSiRfFQIfnTcAoIqqm++aPA/jcJJodcrUZGxASH4uLvFS8ABHFBnVWb7gfczC
         V8xNuPlMxZ1GJt7vfvAH2ZbqeRXqu2RbhwkE0j3y1KD4Hz9y77qMJn0I3ttfyNI8Va
         FU/56Ft8KQHZU5O5asJlJ2x4q9HvueEW4AhsVdrU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220214111151epcas2p3cb16f64dbb9dc2f061af47c2c7f29b70~ToqNa1WqK0748407484epcas2p3j;
        Mon, 14 Feb 2022 11:11:51 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jy1kt0KW9z4x9Py; Mon, 14 Feb
        2022 11:11:50 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.0D.51767.5F83A026; Mon, 14 Feb 2022 20:11:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220214111149epcas2p29b9e39b84d7203572422531beb3c39ed~ToqL3RoqX2621226212epcas2p2I;
        Mon, 14 Feb 2022 11:11:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220214111149epsmtrp1f54907ccfcfe88c1521ea8295a033d16~ToqL2YkXp1541015410epsmtrp1N;
        Mon, 14 Feb 2022 11:11:49 +0000 (GMT)
X-AuditID: b6c32a45-45dff7000000ca37-ad-620a38f58d8b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.A6.29871.5F83A026; Mon, 14 Feb 2022 20:11:49 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220214111149epsmtip115d81f37d38f278caa3aa904346c061e~ToqLttWOf2598625986epsmtip1e;
        Mon, 14 Feb 2022 11:11:49 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list),
        Daehwan Jung <dh10.jung@samsung.com>, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: [PATCH v2 2/2] usb: dwc3: Prevent cleanup cancelled requests at the
 same time.
Date:   Mon, 14 Feb 2022 20:08:53 +0900
Message-Id: <1644836933-141376-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmhe5XC64kg00tNhbH2p6wW9xZMI3J
        onnxejaLy7vmsFksWtbKbLHr3yImi027+1gtVi04wO7A4bFpVSebx/65a9g9Ju6p8+jbsorR
        Y8v+z4wenzfJBbBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
        +AToumXmAN2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tL
        LbEyNDAwMgUqTMjO+PohquCYcMXCtZ2MDYzbBboYOTkkBEwkvv1qZe9i5OIQEtjBKHHkSyMr
        hPOJUaLn/06ozDdGiT+zf7LDtOzdcYsNIrGXUeLr2laolh+MEt+3fmTsYuTgYBPQkvi+kBGk
        QUQgTGLisn0sIDXMIA1N++6ygiSEBSIl/t5fwwRSzyKgKrHlOhdImFfATaL3xl+oZXISN891
        MoPYnALuEl131jGCzJEQuMYucffGaqgiF4lpc9+yQNjCEq+Ob4GKS0m87G+Dsosldn1qZYJo
        bmCUaHxwghkiYSwx61k72NHMApoS63fpg5gSAsoSR26BjWQW4JPoOAxyD0iYV6KjTQiiUVli
        +uUJrBC2pMTB1+egBnpIzL89Fxo+sxglGt7NZZ/AKDcLYcECRsZVjGKpBcW56anFRgWG8AhL
        zs/dxAhOblquOxgnv/2gd4iRiYPxEKMEB7OSCG/cWc4kId6UxMqq1KL8+KLSnNTiQ4ymwLCb
        yCwlmpwPTK95JfGGJpYGJmZmhuZGpgbmSuK8XikbEoUE0hNLUrNTUwtSi2D6mDg4pRqYSq+p
        XPU0iz+VLfxRufc6y1J3XvOdC0LOlTrVsP8x0T4uad1yzdbWdrKwYNv3wCtfeFv+vOTbE+If
        wbXa+teSOZ5zj6x5+PjpZTnRdvF9j02095psbFwpwnPpsZ5XSPWBxQuS/kidNCq5t+3XY/cb
        i5nm/DPLz5ZaMjWeO/DVTd1PU9fEuPoyL3iS+PNSl803f79/p+qYnpalrxe7/uhZzeOTZ98U
        X1uh4Bw15YJG9A7R/DfJvSXnaiR+y3tYO/dwGhQ8VfqWsP/kLYaZi1r+Htfq3FD/7FPcBcVJ
        f/7ol03U9di8t2CjSeWhNuta81ernml3Gqv9fD1bP69vin+y/8Wrz7atPXzVIfOLnUT2biWW
        4oxEQy3mouJEANto6Yn3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSnO5XC64kgzVXNSyOtT1ht7izYBqT
        RfPi9WwWl3fNYbNYtKyV2WLXv0VMFpt297FarFpwgN2Bw2PTqk42j/1z17B7TNxT59G3ZRWj
        x5b9nxk9Pm+SC2CL4rJJSc3JLEst0rdL4Mr4+iGq4JhwxcK1nYwNjNsFuhg5OSQETCT27rjF
        1sXIxSEksJtR4ua0x2wQCUmJpXNvsEPYwhL3W46wQhR9Y5Q4N72fsYuRg4NNQEvi+0JGkBoR
        gTCJf48usoDUMAscZpRoebsLbJCwQLhEy6FdrCD1LAKqEluuc4GEeQXcJHpv/IWaLydx81wn
        M4jNKeAu0XVnHdhMIaCaN3tvs09g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93
        EyM4CLU0dzBuX/VB7xAjEwfjIUYJDmYlEd64s5xJQrwpiZVVqUX58UWlOanFhxilOViUxHkv
        dJ2MFxJITyxJzU5NLUgtgskycXBKNTAdZxVbvG0ha8Xytz93RWypv9ccftaR+wb/Wy5+qziB
        R7dnPu+pP8BwLrz67zT++ES7OQ+X6Xm2Sjz8f0DBafs9x43HIsN+NS46/PzBirI1ZWqfjCfz
        T0xt4Nwn87H+8ffm26dWd3c8//Bw/0KOA1dPCjZGz2X8bShnFvL5/Y4jR+IvtMwMmOn8Tpvr
        zOzQ37un7Vwds/rDlOk7Zy//p6DrWWlXutfJStWSuYaTd3dj3pOJfBWBDvbzV314MvtKxqyr
        C5e2Nbwzzd0cP2+xI3OaEWvJ6qpFAv+bOe/+36hy7sa6Azcnvih+Wm4d0lNTPkHDv3H6e27W
        1OMb2vkFb9qsXbLDOTD1Quq8vgeiRREuS5VYijMSDbWYi4oTAQM0I+GxAgAA
X-CMS-MailID: 20220214111149epcas2p29b9e39b84d7203572422531beb3c39ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214111149epcas2p29b9e39b84d7203572422531beb3c39ed
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214111149epcas2p29b9e39b84d7203572422531beb3c39ed@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We added cleanup cancelled requests when ep cmd timeout on ep dequeue
because there's no complete interrupt then. But, we find out new case
that complete interrupt comes up later. list_for_each_entry_safe is
used when cleanup cancelled requests and it has vulnerabilty on multi-core
environment. dwc3_gadget_giveback unlocks dwc->lock temporarily and other
core(ISR) can get lock and try to cleanup them again. It could cause
list_del corruption and we use DWC3_EP_END_TRANSFER_PENDING to prevent it.

1. MTP server cancels -> ep dequeue -> ep cmd timeout(END_TRANSFER)
	-> cleanup cancelled requests -> dwc3_gadget_giveback ->
	list_del -> release lock temporarily
2. Complete with END_TRANSFER -> ISR(dwc3_gadget_endpoint_command_complete)
	gets lock -> cleanup cancelled requests -> dwc3_gadget_giveback
	-> list_del
3. MTP server process gets lock again
	-> tries to access POISON list(list_del corruption)

[2: MtpServer: 5032] dwc3 10b00000.dwc3: request cancelled
						with wrong reason:5
[2: MtpServer: 5032] list_del corruption,
		ffffff88b6963968->next is LIST_POISON1 (dead000000000100)

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/dwc3/gadget.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3ad3bc5813ca..bac3814894e2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2046,8 +2046,11 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 			/* If ep cmd fails, then force to giveback cancelled requests here */
 			if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING)) {
-				dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+				dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 				dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+
+				dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+				dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 			}
 
 			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
@@ -3426,9 +3429,11 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 	if (dep->stream_capable)
 		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
 
+	if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+		dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+
 	dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
 
 	if (dep->flags & DWC3_EP_PENDING_CLEAR_STALL) {
 		struct dwc3 *dwc = dep->dwc;
-- 
2.31.1

