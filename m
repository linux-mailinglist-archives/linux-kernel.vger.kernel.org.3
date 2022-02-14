Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE36C4B4E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiBNLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:32:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351711AbiBNLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:30:13 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DDB40A01
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:11:53 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220214111151epoutp04f2337dcb6b52306508a8d1cfffe1c393~ToqNPoHYu1097310973epoutp04T
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:11:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220214111151epoutp04f2337dcb6b52306508a8d1cfffe1c393~ToqNPoHYu1097310973epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644837111;
        bh=vo5dCj6f0lE9XyHVfR1Uk+w8viUP5iroIa6Ar1pwTks=;
        h=From:To:Cc:Subject:Date:References:From;
        b=RBah/8tj4X4iaXWvaypPOgA2Na7+74kWd6EsiYMQTR8YTeGWTPxsyax4f4khCbtQN
         EHUhijVzg1kAH3WQcJjVSnAN6hUogWZ3OItqEg6+/KR9wtnaDK7JnFyGZsQpNYS/Aw
         C6I155ZT4h8qbpTe81YjDeL8yecUUOGOj3gOmzzk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220214111150epcas2p435d7e3c9bfb219d59ee36c1ae023f1f6~ToqML7M1F2326823268epcas2p4j;
        Mon, 14 Feb 2022 11:11:50 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jy1kr5nLrz4x9QG; Mon, 14 Feb
        2022 11:11:48 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.3F.35137.5583A026; Mon, 14 Feb 2022 20:09:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220214111148epcas2p3fac143c7870c53ecadfb6b093fcf626b~ToqKfaxnx0748407484epcas2p3c;
        Mon, 14 Feb 2022 11:11:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220214111148epsmtrp15721726d40d4abf09784118321c4bd7d~ToqKeuNEw1541015410epsmtrp1M;
        Mon, 14 Feb 2022 11:11:48 +0000 (GMT)
X-AuditID: b6c32a46-d8bff70000018941-f4-620a38552c01
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.78.08738.4F83A026; Mon, 14 Feb 2022 20:11:48 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220214111148epsmtip12a5e91e2420e4853ed0a3abb5f486336~ToqKQO9nN2598625986epsmtip1d;
        Mon, 14 Feb 2022 11:11:48 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list),
        Daehwan Jung <dh10.jung@samsung.com>, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: [PATCH v2 0/2] Fix ep command fail issue in dequeue
Date:   Mon, 14 Feb 2022 20:08:51 +0900
Message-Id: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7bCmmW6oBVeSQecWJYtjbU/YLe4smMZk
        0bx4PZvF5V1z2CwWLWtlttj1bxGTxabdfawWqxYcYHfg8Ni0qpPNY//cNeweE/fUefRtWcXo
        sWX/Z0aPz5vkAtiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
        fAJ03TJzgO5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+Wl
        llgZGhgYmQIVJmRnvJl7nbGgnbWi/9Mk1gbGCSxdjBwcEgImEuueancxcnEICexglNj4/zUT
        hPOJUaLr+1MWCOczo8TTlm+MXYycYB1rZ+6ASuxilFjU9ZEVwvnBKLHm7EV2kLlsAloS3xeC
        NYgIhElMXLYPrIFZYC+jRNO+u6wgCWEBG4mey2eZQGwWAVWJxY9egtm8Am4Sez9PZIXYJidx
        81wnM0izhMAudonDxw4zQSRcJPasPssMYQtLvDq+hR3ClpJ42d8GZRdL7PrUygTR3MAo0fjg
        BFSDscSsZ+2MIJcyC2hKrN+lDwkMZYkjt1hAKpgF+CQ6Dv9lhwjzSnS0CUE0KktMvzwB6jRJ
        iYOvz0EN9JBYu3M72L9CArES/VMuMk5glJ2FMH8BI+MqRrHUguLc9NRiowIjeCQl5+duYgQn
        MS23HYxT3n7QO8TIxMF4iFGCg1lJhDfuLGeSEG9KYmVValF+fFFpTmrxIUZTYHhNZJYSTc4H
        ptG8knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1MXCqSAdMXFKz7
        1rj04vW76492/uyZaTSjYnHZw/u7I/o7fk16vNtVrbGYoV8jv5f1UXteOH/f+7UVDo3m95bF
        Tiv9/CWie8Xq4p1MkoeUjP5ZXlxzKUac4YTn0pNh/2+d/TT/McdXHx2VhYau030qpsgGT17G
        UXSLR2XKvhX3ShgOzaiwXL5A1/terduio33rNkZdv9mrVFSe9VZd3aFAgvP2+R2/mlyuyVT8
        X3Wn4Anf96Nx0571cfqKSjIqdWzfspPpzdmgdws7K6v/LVzQPqvuMXf8sRv7Z6fuCr8X1/jC
        9YzjtPfbVovFHPNZkXY7jXv334fd37tP+zqrc3/kYbb5+kDz6Pd2Ne/pzzewzFJiKc5INNRi
        LipOBAAihIVG6wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42LZdlhJTveLBVeSwY5jHBbH2p6wW9xZMI3J
        onnxejaLy7vmsFksWtbKbLHr3yImi027+1gtVi04wO7A4bFpVSebx/65a9g9Ju6p8+jbsorR
        Y8v+z4wenzfJBbBFcdmkpOZklqUW6dslcGW8mXudsaCdtaL/0yTWBsYJLF2MnBwSAiYSa2fu
        ALK5OIQEdjBKtO2cyAaRkJRYOvcGO4QtLHG/5QgrRNE3Rom1d/YzdjFycLAJaEl8X8gIUiMi
        ECbx79FFsEHMAocZJVre7gIbJCxgI9Fz+SwTiM0ioCqx+NFLMJtXwE1i7+eJrBAL5CRunutk
        nsDIs4CRYRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnBgaWntYNyz6oPeIUYmDsZD
        jBIczEoivHFnOZOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi
        4JRqYNK5HFHKt1uh0K3fLbsz955++Bbv8raMtE+OzCd51L67v1At2JgUfLt/2ettS9L879oL
        tK6N3/9TMemL44Qjzp2Cglv9fc4EZR/1UbYzvP01P1R9j867XRI3ueWY4qKiH5jcz1DtKmpd
        mDTpdJzYl+nO/boeyrma+5RznigY3Rc3ZtV13B6S927Vq4PLvglqK3UHlkgf+CX4mGlj1M0C
        C74Twe/mu/hWrL9eMe+4SM73mOfWKT45RuWdNp92zLmi465+prXWzuK2dnlcrMiVDTnL/CbW
        B/c7/1cI5OIKrBNuaZ4hk2r4uPzKapvdnWkVl7XvC3Hs/FGh1H7ryrJ+jsPlMRt9dzpUlewT
        9VJiKc5INNRiLipOBAA19PfEmwIAAA==
X-CMS-MailID: 20220214111148epcas2p3fac143c7870c53ecadfb6b093fcf626b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214111148epcas2p3fac143c7870c53ecadfb6b093fcf626b
References: <CGME20220214111148epcas2p3fac143c7870c53ecadfb6b093fcf626b@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
skipping clear stall commmand or giveback from dequeue. It could cause
hung task if ENDTRANSFER command should not be completed. It seems
like HW(Controller) issue but SW can prevent it.

Changes in v2:
- fix coding rule

Daehwan Jung (2):
  usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in ep cmd fails
  usb: dwc3: Prevent cleanup cancelled requests at the same time.

 drivers/usb/dwc3/gadget.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.31.1

