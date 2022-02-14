Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D674B47DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbiBNJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:52:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245520AbiBNJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:49:14 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E664FBF7E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:40:58 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220214094042epoutp03667338893c47fbdc9ada965df3eff1c7~TnaoAuEW10387303873epoutp03W
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:40:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220214094042epoutp03667338893c47fbdc9ada965df3eff1c7~TnaoAuEW10387303873epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644831642;
        bh=20T1eoiZTVUpMZGMclxbRLvUWpU8vwOj1Kp97DmbEtk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=I4fl0CArZAdbKHXLRhXsvOl3kJZJrpEi6QvJ1WC3w4/y8mCUbsujB9iOiiV/9QiFr
         kzpSKn5F7fqSjq4aM8PLmJrk07wMh3050FblZVKBhYxW5bmi2kkVU212mpFX3rJ/hs
         tSw80xfGC9haq3b3ifVFB6qo2MGzEAz3dNG2qZrc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220214094041epcas2p28344cc7478c70fcfef35a49e1640e64b~TnanXJiTn1972019720epcas2p2O;
        Mon, 14 Feb 2022 09:40:41 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jxzjh36Syz4x9QM; Mon, 14 Feb
        2022 09:40:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.4B.35137.BF22A026; Mon, 14 Feb 2022 18:38:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220214094040epcas2p3cc844d30f54793f51f16bb2b59b432e1~TnalyEVum2774927749epcas2p3A;
        Mon, 14 Feb 2022 09:40:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220214094039epsmtrp2d78927fd8bddb3eea3abe3e1fd7ac812~TnalxGMa21924719247epsmtrp2M;
        Mon, 14 Feb 2022 09:40:39 +0000 (GMT)
X-AuditID: b6c32a46-da1ff70000018941-01-620a22fbd2b2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.8F.29871.7932A026; Mon, 14 Feb 2022 18:40:39 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220214094039epsmtip19b3ab12bf2ff5663847a88eeecd78a9c~TnaljkD4D0562805628epsmtip1G;
        Mon, 14 Feb 2022 09:40:39 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list),
        Daehwan Jung <dh10.jung@samsung.com>, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: [PATCH v1 0/2] Fix ep command fail issue in dequeue
Date:   Mon, 14 Feb 2022 18:37:16 +0900
Message-Id: <1644831438-125403-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7bCmue5vJa4kg0mzTS2OtT1ht7izYBqT
        RfPi9WwWl3fNYbNYtKyV2WLXv0VMFpt297FarFpwgN2Bw2PTqk42j/1z17B7TNxT59G3ZRWj
        x5b9nxk9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCdcXHaQdaCRywVkz7vZ2lg/M7cxcjJISFgIvGk5RSQzcUhJLCDUeLMtp1M
        IAkhgU+MEhPvZkAkvjFKrJm1Cq5j4af5LBCJvYwSayctYoPo+MEoMWNfXRcjBwebgJbE94WM
        IGERgTCJicv2gdUzg9Q37bvLCpIQFrCR+H/pAthQFgFViZYV68HivAJuEtM637FBLJOTuHmu
        E+w8CYF97BJrN66FSrhIHDm4iRHCFpZ4dXwLO4QtJfH53V6ommKJXZ9amSCaGxglGh+cgHrB
        WGLWs3ZGkEuZBTQl1u/SBzElBJQljtxiAalgFuCT6Dj8lx0izCvR0SYE0agsMf3yBFYIW1Li
        4OtzUAM9JFY9WAsNhliJs7OfM01glJ2FMH8BI+MqRrHUguLc9NRiowIjeBwl5+duYgSnMC23
        HYxT3n7QO8TIxMF4iFGCg1lJhDfuLGeSEG9KYmVValF+fFFpTmrxIUZTYHhNZJYSTc4HJtG8
        knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1Mgp9WajkEcJ1q01k/
        YU2p+7y3+1ZfCF3X1L7rwO601iS5ciO1NcoPu3/O1Si29T/wwlNuceML2Vru/zve/D/JWHRu
        AVfUwhtqgZt+Tdr7SIu/ynbDUsecf57GlVMjP0y9/tts6m8r7hr2ZSxfnR+Gr69VaepoKdzk
        rjpz+czAXSFnLp5nSE1lrYoqdV4j+m9tuNSdtg0vS3nENdznifVWbVEp/GLJEvPVM8ecOW7L
        +lrtH3N6v168wZ4d3clzbVnrsg2WphJ/HB6+1K8pfDl5TlVjPNPRghP8jV8ksiV/vpSaoXLF
        uk8vzDXc55hwV573M5OiK7mrmS4XJBVFdURyTmQXrTaxrFC8Vnui+7ASS3FGoqEWc1FxIgDq
        kjXO6gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42LZdlhJTne6MleSwYIuc4tjbU/YLe4smMZk
        0bx4PZvF5V1z2CwWLWtlttj1bxGTxabdfawWqxYcYHfg8Ni0qpPNY//cNeweE/fUefRtWcXo
        sWX/Z0aPz5vkAtiiuGxSUnMyy1KL9O0SuDIuTjvIWvCIpWLS5/0sDYzfmbsYOTkkBEwkFn6a
        z9LFyMUhJLCbUWLt4WWMEAlJiaVzb7BD2MIS91uOsEIUfWOUaJuzmamLkYODTUBL4vtCsHoR
        gTCJf48ugg1iFjjMKNHydhcbSEJYwEbi/6ULYNtYBFQlWlasZwWxeQXcJKZ1vmODWCAncfNc
        J/MERp4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCA0tLcwfj9lUf9A4xMnEw
        HmKU4GBWEuGNO8uZJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgs
        EwenVANT165imd3JAq5PZmzMcdWcMDdeynuqxt7tazhWJkr3tExJbDTjtPbL9LJrXnJp182Q
        6pUcx5e7cJ8Svpv/na/YgLlqa6n+5SRZsytZzVcPChSxzg9iFV/wQeKewcZt3g9E1yWeE3oR
        n756qpPitwt+yt21t4M2xAccuH7/ZmqvemsHk+4DC9W5DRYfWYKyfSaHSlRmCFx/tMvXNCCo
        SdT74Cn1voovnrN+fqvgYuLXzpp1Ir73+9TXBpceqTzP5VM02Rr04cgsr7/v2Fa/X2c6+dDJ
        QO9CG7YzJ2cGnr/W3dWrzz7Ba+Xag6dSHmhYpMfmPn305HP2UrNDXLI7f0VfdUu7zXm7JF+t
        0PhM1mUlluKMREMt5qLiRACeaC1LmwIAAA==
X-CMS-MailID: 20220214094040epcas2p3cc844d30f54793f51f16bb2b59b432e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214094040epcas2p3cc844d30f54793f51f16bb2b59b432e1
References: <CGME20220214094040epcas2p3cc844d30f54793f51f16bb2b59b432e1@epcas2p3.samsung.com>
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

Daehwan Jung (2):
  usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in ep cmd fails
  usb: dwc3: Prevent cleanup cancelled requests at the same time.

 drivers/usb/dwc3/gadget.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--
2.31.1

