Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FCB4B4EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345759AbiBNLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:32:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351317AbiBNLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:30:13 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859841311
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:11:54 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220214111152epoutp027c042f241b30db6bf36307fd02eb3ade~ToqOKhID52530025300epoutp02d
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:11:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220214111152epoutp027c042f241b30db6bf36307fd02eb3ade~ToqOKhID52530025300epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644837112;
        bh=14Me7vBAMhBKZ9NdNtxty8qye+T9cXqjuVsFOurxFrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQEO/Gp8g3/bHvzxBJ6256Js102TytdMHHaKyCF1c8FXlTYezaZoVJ2KBKYprudyf
         CA1lf5YlanIm5Di9PdG5lDlAzA5iYrMTZ4IjGtDZYxREXy54WJtzP/T3ciTiBZa963
         oY3molFFEuiUNbriQ2v7CCCexwheSaftxAlfRKpE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220214111151epcas2p25ebfa707162dc228e7abdbff6a596582~ToqNkrAc80249502495epcas2p2l;
        Mon, 14 Feb 2022 11:11:51 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jy1ks6SN6z4x9Px; Mon, 14 Feb
        2022 11:11:49 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.3F.35137.6583A026; Mon, 14 Feb 2022 20:09:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5~ToqLfFI331425414254epcas2p1Y;
        Mon, 14 Feb 2022 11:11:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220214111149epsmtrp2be83b3b6ba35f490fccafb4ff3695997~ToqLeYaqf0758607586epsmtrp2U;
        Mon, 14 Feb 2022 11:11:49 +0000 (GMT)
X-AuditID: b6c32a46-da1ff70000018941-f5-620a385652ce
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.A6.29871.5F83A026; Mon, 14 Feb 2022 20:11:49 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220214111149epsmtip1d1ec519cd8f46524a04ce85c38ff0762~ToqLU_wcj2931329313epsmtip1a;
        Mon, 14 Feb 2022 11:11:49 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list),
        Daehwan Jung <dh10.jung@samsung.com>, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Date:   Mon, 14 Feb 2022 20:08:52 +0900
Message-Id: <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmhW6YBVeSwa+zYhbH2p6wW9xZMI3J
        onnxejaLy7vmsFksWtbKbLHr3yImi027+1gtVi04wO7A4bFpVSebx/65a9g9Ju6p8+jbsorR
        Y8v+z4wenzfJBbBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
        +AToumXmAN2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tL
        LbEyNDAwMgUqTMjOWHdmBWtBA3fF8RuPGBsY+zi7GDk5JARMJC7s/cvaxcjFISSwg1Fi2skj
        7BDOJ0aJGceesUA43xgl7vU9Y4RpaZr1ihkisZdRYvn0tYwQzg9GicsP9gMN4+BgE9CS+L4Q
        rEFEIExi4rJ9YJOYQRqa9t1lBUkIC0RKfOz7xgZiswioSjycdgDM5hVwkzi0YgITxDY5iZvn
        OplBbE4Bd4muO+vAlkkIXGOXeHW3hRWiyEXizPrlUOcJS7w6voUdwpaS+PxuLxuEXSyx61Mr
        E0RzA6NE44MTzBAJY4lZz9oZQa5mFtCUWL9LH8SUEFCWOHKLBaSCWYBPouPwX3aIMK9ER5sQ
        RKOyxPTLE6AukJQ4+Poc1EAPid+9i8DOFxKYxShx7Uj6BEa5WQjzFzAyrmIUSy0ozk1PLTYq
        MILHWHJ+7iZGcHrTctvBOOXtB71DjEwcjIcYJTiYlUR4485yJgnxpiRWVqUW5ccXleakFh9i
        NAWG3URmKdHkfGCCzSuJNzSxNDAxMzM0NzI1MFcS5/VK2ZAoJJCeWJKanZpakFoE08fEwSnV
        wKQnvy32cva0M2d0j1lMUlLkZV24fI/S9bjLCl5iuw+1VRco9u37Hvt72QsTLe0kpsDgXz/n
        dV0u9L/awvTl0pSNtdsv3onV39Lqq+S1rtP6lkNrh3ld2OMlXbce997J6Si9fHSaT91JkW9+
        h/XnrTQvPyK2X6HJXyf52NvZUfwuZSklpnnbC66k6zJLfy698avO42XRx17hzws0Vp6W/trk
        +2Tt30PsQaf2rLvSb9R8O7z21ZNlX3zeTX1bLf/ihnrplnkMbj2T2Pz++L5cFhdZ3hgbec7f
        y0rkp9jiSwqibGWeIWrW/GtKZ6gFp+6+nvE389XB6qYnEWHspey7Q+I0v/Pf/ihzLETm1jF1
        YSWW4oxEQy3mouJEAFG0rP34AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSnO5XC64kgzvXBCyOtT1ht7izYBqT
        RfPi9WwWl3fNYbNYtKyV2WLXv0VMFpt297FarFpwgN2Bw2PTqk42j/1z17B7TNxT59G3ZRWj
        x5b9nxk9Pm+SC2CL4rJJSc3JLEst0rdL4MpYd2YFa0EDd8XxG48YGxj7OLsYOTkkBEwkmma9
        Yu5i5OIQEtjNKHH/w3Y2iISkxNK5N9ghbGGJ+y1HWCGKvjFKXH81CaiIg4NNQEvi+0JGkBoR
        gTCJf48usoDUMAscZpRoebsLbJCwQLjEzikHwAaxCKhKPJx2ACzOK+AmcWjFBCaIBXISN891
        MoPYnALuEl131oENFQKqebP3NvsERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNz
        NzGCA1FLcwfj9lUf9A4xMnEwHmKU4GBWEuGNO8uZJMSbklhZlVqUH19UmpNafIhRmoNFSZz3
        QtfJeCGB9MSS1OzU1ILUIpgsEwenVANTf3RX8CrRC+nTJz0uipsg+E3EQnFB7E8F1qbyVbpn
        hcpi/1vPkq6Ma18bxvlCo8g2YdLazaEWZ09YmXJc2R0h8ZFhusXCmWm3prHvvbquhWvVoowm
        oTelP88uPvxkk+Nek57PBuYyj+KMK0TW1Ew59Gub1eodz9I5n3iavLkhzrVtjbKizO7Ij2v7
        Fr91tbg83UHNWn3u6ZrX6Qdyp6ziudS5PlnoutLu7/OTSxdc+7l2mXb/5sw9r+UidH/X8Nxg
        3RDGePy/2gK9S28FGyS3ztikvGfRTrFIz61/DnGUc2u/WXfI933kzrrn3yX+MZ6IWr6qWFit
        qmPdmgkl1qu9AplnCzXEcXA9m3L6W8mNaiWW4oxEQy3mouJEABuIuRuzAgAA
X-CMS-MailID: 20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

