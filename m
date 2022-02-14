Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55E94B4837
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbiBNJww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:52:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245572AbiBNJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:49:38 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EDF1ADB0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:41:02 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220214094046epoutp01a9a9677883ff426ca6ee82de2247a8c2~Tnarp5s5A0762107621epoutp01T
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:40:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220214094046epoutp01a9a9677883ff426ca6ee82de2247a8c2~Tnarp5s5A0762107621epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644831646;
        bh=4Xbhnx9uNz2JBzthPzEn/bH0Hr1fueiRHSuJySip1XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmcgtXPM6HvMsm8KW62JOvHXi+U2HcJEdEfJdI0SZYCbf+Ou2P6SIxUUIsi19lUer
         YQGwNe8wmuOBq38OjwlLXHMgs7/gvrrU2Ohx0Nq+d91wWCl44lfi94Wi5nT73KMMk6
         FmG8kMIWF52hvuvVThuFqHNsd1r6/cZYwlm40rLc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220214094045epcas2p18e0e821c5236e8ab61f01dacd790b957~TnarKScNJ2905329053epcas2p14;
        Mon, 14 Feb 2022 09:40:45 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jxzjl6hJvz4x9QK; Mon, 14 Feb
        2022 09:40:43 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.DA.10014.8C12A026; Mon, 14 Feb 2022 18:32:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220214094041epcas2p2ec37c252dd5f9508454e9449c95e6c7a~Tnam8rKG51973219732epcas2p24;
        Mon, 14 Feb 2022 09:40:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220214094041epsmtrp130f8c9a1cd381b11e8e5d9564332e1cd~Tnam786tO2649526495epsmtrp1i;
        Mon, 14 Feb 2022 09:40:41 +0000 (GMT)
X-AuditID: b6c32a47-489ff7000000271e-76-620a21c8a84b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.B1.08738.9932A026; Mon, 14 Feb 2022 18:40:41 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220214094041epsmtip16bbeab070593c1ac6b2d8efe43af3ef0~TnamySefG0561905619epsmtip19;
        Mon, 14 Feb 2022 09:40:41 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list),
        Daehwan Jung <dh10.jung@samsung.com>, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: [PATCH v1 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Date:   Mon, 14 Feb 2022 18:37:17 +0900
Message-Id: <1644831438-125403-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644831438-125403-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7bCmue4JRa4kgw/3jSyOtT1ht7izYBqT
        RfPi9WwWl3fNYbNYtKyV2WLXv0VMFpt297FarFpwgN2Bw2PTqk42j/1z17B7TNxT59G3ZRWj
        x5b9nxk9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCdse1URsE27oqL224xNjAe5Oxi5OSQEDCR+Danm72LkYtDSGAHo0TTlV4m
        kISQwCdGiWfXpCESnxklPvYtYobpeNB2mwkisYtRYtK9t1DtPxgl+k6BzOLgYBPQkvi+kBGk
        QUQgTGLisn0sIDXMAnuBVuy7ywqSEBaIlNj7byrYVBYBVYmuS+/BGngF3CTeTFwHtU1O4ua5
        TjCbU8Bd4s7+4+wQ8UvsEp9/ZEDYLhJvn/SzQdjCEq+Ob4GqkZJ42d8GZRdL7PrUCna1hEAD
        o0TjgxNQC4wlZj1rZwQ5mllAU2L9Ln0QU0JAWeLILRaQCmYBPomOw3/ZIcK8Eh1tQhCNyhLT
        L09ghbAlJQ6+Pgc10EPi+/w/bJAgmcUocX7qZtYJjHKzEBYsYGRcxSiWWlCcm55abFRgDI+v
        5PzcTYzg1KblvoNxxtsPeocYmTgYDzFKcDArifDGneVMEuJNSaysSi3Kjy8qzUktPsRoCgy7
        icxSosn5wOSaVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qBKTB7
        r0P13a9Hn9bIzvk760j7DMai+R+n/3IOc5S7uM7xX8a9XlUF//aT1XFLvlo0nl1VeDPlVsY8
        n3MFQRtMohJ1nPlPTOnoeJ8rs7s/mVEvReFt/Yanx5+Z9jVKvRbTUI19+nTuxykv8taZprYu
        9k+v3XlopmrPlG+zPUzZKhr3nlaUnynP/NCivlnDomRrgPnDxs3HzFlfVhTM+7Sv/OHjObl3
        E5Z/N5pgHJe+9NOCY9WXdl/o8rR4raoiqGPRXe11f/vr+rm1Lic+9jdaf5qgu0nwjodcPQef
        z3W9Ep9Vh4vPPdbhlb4/T9Qk3aLttnteisWHkMgVx23czXfksM/55qE+bevl6RVvG9Q8lViK
        MxINtZiLihMBJqdt5/YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnO5MZa4kg0WvuSyOtT1ht7izYBqT
        RfPi9WwWl3fNYbNYtKyV2WLXv0VMFpt297FarFpwgN2Bw2PTqk42j/1z17B7TNxT59G3ZRWj
        x5b9nxk9Pm+SC2CL4rJJSc3JLEst0rdL4MrYdiqjYBt3xcVttxgbGA9ydjFyckgImEg8aLvN
        1MXIxSEksINRYvWyLcwQCUmJpXNvsEPYwhL3W46wQhR9Y5RYc3wrkMPBwSagJfF9ISNIjYhA
        mMS/RxdZQGqYBQ4zSrS83cUGkhAWCJc4fus7K4jNIqAq0XXpPVgDr4CbxJuJ66CWyUncPNcJ
        ZnMKuEvc2X8cbLEQUE3Pg+XMExj5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93E
        CA5DLa0djHtWfdA7xMjEwXiIUYKDWUmEN+4sZ5IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtd
        J+OFBNITS1KzU1MLUotgskwcnFINTJ5z94e6vA85Gv6s95fUysSpzee/yxvXucqnXsjn1Ob6
        Z6evoXtrxR5j1o/3bvLOOvF/8+sbOz+KH/MM6HzX09K0hvNTVfSqhrsMJoZF5kklzSv+eRq7
        zqnh87iruj7obfaGOS3L8j+0sXqHTHRtzKicvlnz+Q4T1XMv+bSLxa8yHJkfr8ZrMKv2wN0i
        AfUJ9ZMnPA7eeXTymd8W7BFcE04v/ZLs+Xg28/lFd/N8JindC6tqfsuhFad5XnlLT8pB95a5
        W+0UXjgKfm7pYT6c8+lST4Bwk7aNq/ONeVbB/Y+LS1dcDX1hGFxy5/K6pXq6HU0bjFUMnu5N
        SH0tYcHSwCInslnqdL0TE/+djg1lSizFGYmGWsxFxYkAakU/xbICAAA=
X-CMS-MailID: 20220214094041epcas2p2ec37c252dd5f9508454e9449c95e6c7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214094041epcas2p2ec37c252dd5f9508454e9449c95e6c7a
References: <1644831438-125403-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214094041epcas2p2ec37c252dd5f9508454e9449c95e6c7a@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
skipping clear stall commmand or giveback from dequeue. We fix to set it
only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
for next trb to start transfer not update transfer.

Change-Id: I2e6b58acc99f385e467e8b639a3792a5e5f4d2bb
Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/dwc3/gadget.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 183b90923f51..3ad3bc5813ca 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2044,6 +2044,12 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 				dwc3_gadget_move_cancelled_request(r,
 						DWC3_REQUEST_STATUS_DEQUEUED);
 
+			/* If ep cmd fails, then force to giveback cancelled requests here */
+			if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING)) {
+				dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+				dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+			}
+
 			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
 
 			goto out;
@@ -3645,7 +3651,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 
 	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else
+	else if (!ret)
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 }
 
-- 
2.31.1

