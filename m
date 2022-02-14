Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9FE4B47D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiBNJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:52:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245519AbiBNJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:49:14 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D41AD82
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:40:59 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220214094045epoutp035ab674503c0963b9029d8d0ceaf49834~TnaqrWa0Y0454904549epoutp03C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:40:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220214094045epoutp035ab674503c0963b9029d8d0ceaf49834~TnaqrWa0Y0454904549epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644831645;
        bh=SflWUT3MSnU+DzFR1WmiJra5Ky7Db65Ttcox2ZzhX0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ieSmqkIgh86dbNzomF3S6ihcwuIINTx4lUwXvIPS5cFAFPLbXYD8vcyHLz/5WJ7tg
         e5wjjJ0YzDkRhOzEi72TIKUHv50AHFlQMEDxOIU2+TtYQ0pzyt6Ae1BFT7ag/ibIqJ
         mHn++aufP6Be/V2gXJF4JPf0Yns7wEJ2mHTdcD1c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220214094044epcas2p1df083cafe6518adb46b1494f3581a64c~TnaqPLvuj1972419724epcas2p1D;
        Mon, 14 Feb 2022 09:40:44 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jxzjl1tQ7z4x9Q7; Mon, 14 Feb
        2022 09:40:43 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.19.12141.A932A026; Mon, 14 Feb 2022 18:40:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220214094042epcas2p118ac06692ad14f321a3fd59e57bcf1d5~TnaoNW2UJ1972419724epcas2p18;
        Mon, 14 Feb 2022 09:40:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220214094042epsmtrp18668e522fd1f887f37fe744b8a53a3bd~TnaoMk2LF2665426654epsmtrp1D;
        Mon, 14 Feb 2022 09:40:42 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-3b-620a239afeb9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.8F.29871.A932A026; Mon, 14 Feb 2022 18:40:42 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220214094042epsmtip18d5a380e01357722bf01d4d805e2fdaa~TnaoEF7dT0562805628epsmtip1I;
        Mon, 14 Feb 2022 09:40:42 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list),
        Daehwan Jung <dh10.jung@samsung.com>, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: [PATCH v1 2/2] usb: dwc3: Prevent cleanup cancelled requests at the
 same time.
Date:   Mon, 14 Feb 2022 18:37:18 +0900
Message-Id: <1644831438-125403-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644831438-125403-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmue4sZa4kg8ON5hbH2p6wW9xZMI3J
        onnxejaLy7vmsFksWtbKbLHr3yImi027+1gtVi04wO7A4bFpVSebx/65a9g9Ju6p8+jbsorR
        Y8v+z4wenzfJBbBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
        +AToumXmAN2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tL
        LbEyNDAwMgUqTMjO+DTTrqBPtOLb/n2MDYyvBLsYOTkkBEwkdsz7xdbFyMUhJLCDUeJl+yom
        COcTo8SLdfdYIZxvjBLLZy9hg2n5N2UpVGIvo8S+g7NYQRJCAj8YJS595Oxi5OBgE9CS+L6Q
        ESQsIhAmMXHZPhaQemaQ+qZ9d8HqhQUiJf78vcoOYrMIqEp0nT/BAmLzCrhJ7Jj5CWqZnMTN
        c53MIDangLvEnf3H2UEGSQhcY5d42H6MGaLIReJK309WCFtY4tXxLewQtpTEy/42KLtYYten
        ViaI5gZGicYHJ6CajSVmPWtnBLmaWUBTYv0ufRBTQkBZ4sgtsHuYBfgkOg7/ZYcI80p0tAlB
        NCpLTL88AWqrpMTB1+egBnpITH/SxQwJn1mMEnvvzGCawCg3C2HBAkbGVYxiqQXFuempxUYF
        JvAIS87P3cQITm5aHjsYZ7/9oHeIkYmD8RCjBAezkghv3FnOJCHelMTKqtSi/Pii0pzU4kOM
        psDAm8gsJZqcD0yveSXxhiaWBiZmZobmRqYG5krivF4pGxKFBNITS1KzU1MLUotg+pg4OKUa
        mJrPhayL/aD3kpnnP9Oa4nYey09fy9k8NkUcVlwg+q6YN/aOqUPGi3Uz6tu3xa/aG3MmbdPO
        q5s+MLYucRa0lwiOnWwgf/SGqLpmr+oq4b1LPI8zLayZvttlHe+LrU9W13kV3y86dvLn45wt
        ClPDra2XiXmn3z1uNK/UWSy/LeKk19G+/RzVBV1Lz1sekJa76SB1mzW3+8btzP0+LJk3rVYl
        qpfXOm+4/y3rmcJRUwk/2TOtisEvBWsmunIfWyaUl/U+aVb4MRsO5Rsbj/5s23ihhu9nZ+YJ
        60OzUpc4WNd/3lt6fvsM0weOJot+1LEv6ftZH8/ldNb+f163/t8nniqn533RlA5LcV3G0v3f
        UYmlOCPRUIu5qDgRAHIbSHH3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSnO4sZa4kg88XFS2OtT1ht7izYBqT
        RfPi9WwWl3fNYbNYtKyV2WLXv0VMFpt297FarFpwgN2Bw2PTqk42j/1z17B7TNxT59G3ZRWj
        x5b9nxk9Pm+SC2CL4rJJSc3JLEst0rdL4Mr4NNOuoE+04tv+fYwNjK8Euxg5OSQETCT+TVnK
        CmILCexmlDh6SwIiLimxdO4NdghbWOJ+yxGgGi6gmm9ANa8msnUxcnCwCWhJfF/ICFIjIhAm
        8e/RRRaQGmaBw4wSLW93gdUIC4RL9M7NAqlhEVCV6Dp/ggXE5hVwk9gx8xMbxHw5iZvnOplB
        bE4Bd4k7+4+zQ9zjJtHzYDnzBEa+BYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcx
        gkNQS3MH4/ZVH/QOMTJxMB5ilOBgVhLhjTvLmSTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LX
        yXghgfTEktTs1NSC1CKYLBMHp1QDk/GaNwc9v6sr1rzcsWeZu9vvr68/NZr9f6OyfVpMx733
        XyTaRSMWcYhdSeAQvyIdNWenbc9nv5W51vxbOPS2FP3IOK57wbj01C/9rAfub376nub9mrRT
        uOT4Hu2q+8k8AhouutLh4VPCVS8FRG/t2iUceMK6XbPmqtGVl9bhPq+yWeaw7eisTRGLODnt
        erRIfuXJFbZKk44u47OV3bVZv9LwW1Bm4PMrE+ZrGd2cK3+C3V1hf8y1u3unXF/DPo+j/vfm
        q6z/zLNzxH0fnHrXYJB00LrvftkapwtfN2otk16ff89m0efJLb8mfiy2N1k4pSt8lnRi+3JF
        R3O+Myu2T879qn1J78HJcpkL/64k5CqxFGckGmoxFxUnAgDI1znIsAIAAA==
X-CMS-MailID: 20220214094042epcas2p118ac06692ad14f321a3fd59e57bcf1d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214094042epcas2p118ac06692ad14f321a3fd59e57bcf1d5
References: <1644831438-125403-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214094042epcas2p118ac06692ad14f321a3fd59e57bcf1d5@epcas2p1.samsung.com>
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
   -> cleanup cancelled requests -> dwc3_gadget_giveback -> list_del -> release lock temporarily
2. Complete with END_TRANSFER -> ISR(dwc3_gadget_endpoint_command_complete) gets lock
   -> cleanup cancelled requests -> dwc3_gadget_giveback -> list_del
3. MTP server process gets lock again -> tries to access POISON list(list_del corruption)

[  205.014697] [2:      MtpServer: 5032] dwc3 10b00000.dwc3: request cancelled with wrong reason:5
[  205.014719] [2:      MtpServer: 5032] list_del corruption, ffffff88b6963968->next is LIST_POISON1 (dead000000000100)

Change-Id: I9df055c6c04855edd09e330300914454a6657a23
Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>

Change-Id: If87c88c3bb4c17ea1a5bde2bfec1382769f7ecab
Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/dwc3/gadget.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3ad3bc5813ca..2e0183512d5b 100644
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
@@ -3426,9 +3429,12 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 	if (dep->stream_capable)
 		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
 
+	if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING)) {
+		dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+	}
+
 	dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
 
 	if (dep->flags & DWC3_EP_PENDING_CLEAR_STALL) {
 		struct dwc3 *dwc = dep->dwc;
-- 
2.31.1

