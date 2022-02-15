Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4554B63DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiBOHBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:01:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiBOHBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:01:01 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444743EAAE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:00:50 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220215070048epoutp0144fd164efbe97553800c3cc0a0d34f0b~T44TT50aN0973809738epoutp01U
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:00:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220215070048epoutp0144fd164efbe97553800c3cc0a0d34f0b~T44TT50aN0973809738epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644908448;
        bh=SRsg8T/OPnQjmJqo/heZLDC52o8CsKO+t4bo75zyF8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gM/4USTgPJRS1gPeNrCloswHupOnAk+sqBfSGXGKxgHatDPZ1qvivq+HKnrCdCm7l
         KcXq9ZVectcYc5RgG+ay7+XVJsluwAtcrKEJIr6NXu8QlJKpa0007uquGwIAv0nCaW
         30xww0qxOV8S6lYMoGVWpew2QmyHPyK6eG417jkE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220215070047epcas2p4d07eca8aeb686d84644d297c0655cc4e~T44Sb0XDl2412424124epcas2p4X;
        Tue, 15 Feb 2022 07:00:47 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JyX6g5Tcbz4x9Pp; Tue, 15 Feb
        2022 07:00:43 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.49.12141.18F4B026; Tue, 15 Feb 2022 16:00:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220215070040epcas2p1fcd565aafa659ef677b45d414fe65792~T44MP0Ncm3059430594epcas2p1S;
        Tue, 15 Feb 2022 07:00:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220215070040epsmtrp1021b9f20207f005f621f131c4808002a~T44MPElEK0510805108epsmtrp1T;
        Tue, 15 Feb 2022 07:00:40 +0000 (GMT)
X-AuditID: b6c32a48-d5dff70000002f6d-50-620b4f81f95b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.85.08738.89F4B026; Tue, 15 Feb 2022 16:00:40 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220215070040epsmtip12d42ee1053040720cc37ab306ebd86e6~T44MC656X2677026770epsmtip1j;
        Tue, 15 Feb 2022 07:00:40 +0000 (GMT)
Date:   Tue, 15 Feb 2022 15:58:26 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Message-ID: <20220215065826.GD144890@ubuntu>
MIME-Version: 1.0
In-Reply-To: <Ygo9LZg8lxitTE8J@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmuW6jP3eSwcprlhbH2p6wWzQvXs9m
        cXnXHDaLRctamS12/VvEZLFpdx+rxaoFB9gd2D02repk89g/dw27x8Q9dR5b9n9m9Pi8SS6A
        NSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
        dkb/hMssBf8EKz7uncLSwNjM38XIySEhYCJxeetbpi5GLg4hgR2MEuduvWCBcD4xSqz5+IQR
        wvnMKDFp03M2mJYrU16wQiR2MUocmfuRGcJ5wijxc/MFFpAqFgFViV9TOxhBbDYBLYl7P04w
        g9giAsYS/WdnsYM0MIMsvLH9G1hCWCBW4sK2NrAVvAI6Emc+HYCyBSVOznwCNpRTQFPi3sm1
        QM0cHKICKhKvDtZDXPSTXaL5jS+E7SJxb892JghbWOLV8S3sELaUxMv+Nii7WGLXp1awpyUE
        GhglGh9AHCcBdNysZ+1gRzMLZEi0bf8PtktCQFniyC0WiDCfRMfhv1BhXomONiGITmWJ6Zcn
        sELYkhIHX5+Dmugh8bt3ETR8vzFKTDl5nG0Co/wsJJ/NQrINwtaRWLD7E9ssoBXMAtISy/9x
        QJiaEut36S9gZF3FKJZaUJybnlpsVGACj+3k/NxNjOAUquWxg3H22w96hxiZOBgPMUpwMCuJ
        8Mad5UwS4k1JrKxKLcqPLyrNSS0+xGgKjKeJzFKiyfnAJJ5XEm9oYmlgYmZmaG5kamCuJM7r
        lbIhUUggPbEkNTs1tSC1CKaPiYNTqoHp9LTieVHKtfPDuSTcOlZt1OcN/PdW9Urfk0WmT8UL
        Uy5fvXMufEf0jZvZ904b7E/4ud6irWZH5T6R5q1852JOmETbCk69PTFG58gj1+3tJnV8wg+M
        1nRycKef3Dn39PJpR6TLTc/XzHa5bsfZXh6S+lHF9KUXd923w7v39d8Uj8/7tPeSF1P2UtPt
        mmIWXWHLClIaPDSrv+54Ja39+YCnzx9hY4/dR6Y+PT4n7rDYJb3M25tPCCw08jqY0aR9RUJT
        S3EGW3C7eIaF1mrv7eKqx2evinf8n6dwV4optGf/zZvZXXqReprT3jUaRc+dyDWd7YhVaV/m
        YgPNtJLN++/bHTB8YD6l2bDIwN1IcpsSS3FGoqEWc1FxIgCBb+DaKgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnO4Mf+4kg5bL2hbH2p6wWzQvXs9m
        cXnXHDaLRctamS12/VvEZLFpdx+rxaoFB9gd2D02repk89g/dw27x8Q9dR5b9n9m9Pi8SS6A
        NYrLJiU1J7MstUjfLoEro3nnSqaCffwVc/v/sjcw3uHpYuTkkBAwkbgy5QVrFyMXh5DADkaJ
        3mv9zBAJSYmlc2+wQ9jCEvdbjkAVPWKU6HvQxgSSYBFQlfg1tYMRxGYT0JK49+MEWLOIgLFE
        /9lZ7CANzCBT1y77ClYkLBArcWFbGxuIzSugI3Hm0wE2iKnfGCW2Pr3PCpEQlDg58wkLiM0M
        NPXGv5dA2ziAbGmJ5f84QMKcApoS906uZQcJiwqoSLw6WD+BUXAWkuZZSJpnITQvYGRexSiZ
        WlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHANaWjsY96z6oHeIkYmD8RCjBAezkghv3FnO
        JCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY9j3atrNR
        VPLuxNSo8zllfnuO+O5e5yEl95xvzWX7N03z2Ta6uN3M/PGZRexao//Bd86ykuqtWuEBD7g1
        Cg6H8E9X8F92sUlKw7RdRH3R++bijLUzeLYr8kb/ODHngvnn1a+uuV0T+3dw6Z9vcfLK+w74
        8p68wv8gKF2tWvuyVpXA0v6fZV67IwM4U2v2Kn+Nmyh/65JYUGmfKMfMs+kv3136uOfas2n/
        vuuFvFTLdwgTXKLTODGG//OxCde/pmQrs3R6rTrAdqhrwfOd09/qS3zgKZH8qjkjj/XvhqCt
        ZnXBXFfb9//vd/g+1bx9q8HDEJPjf2bs7mANttR51Tnpe3bVnVWhZ4rbFhivkj/irsRSnJFo
        qMVcVJwIACjI+qvwAgAA
X-CMS-MailID: 20220215070040epcas2p1fcd565aafa659ef677b45d414fe65792
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Jd1PkHJvbSWK3nTfpzLY69px07-gfkp_xqPU6voikj1qGUH4=_e8e52_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
        <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
        <Ygo9LZg8lxitTE8J@kroah.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------Jd1PkHJvbSWK3nTfpzLY69px07-gfkp_xqPU6voikj1qGUH4=_e8e52_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Feb 14, 2022 at 12:29:49PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 14, 2022 at 08:08:52PM +0900, Daehwan Jung wrote:
> > It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
> > even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
> > skipping clear stall commmand or giveback from dequeue. We fix to set it
> > only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
> > for next trb to start transfer not update transfer.
> 
> So is this two different changes?
> 
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> 
> What commit id does this fix?
> 
> thanks,
> 
> greg k-h
> 

Hi greg,

Below is commit id to fix.

commit c58d8bfc77a2c7f6ff6339b58c9fca7ae6f57e70
Author: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date:   Wed Dec 18 18:14:44 2019 -0800

    usb: dwc3: gadget: Check END_TRANSFER completion

    While the END_TRANSFER command is sent but not completed, any request
    dequeue during this time will cause the driver to issue the END_TRANSFER
    command. The driver needs to submit the command only once to stop the
    controller from processing further. The controller may take more time to
    process the same command multiple times unnecessarily. Let's add a flag
    DWC3_EP_END_TRANSFER_PENDING to check for this condition.

    Fixes: 3aec99154db3 ("usb: dwc3: gadget: remove DWC3_EP_END_TRANSFER_PENDING")
    Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
    Signed-off-by: Felipe Balbi <balbi@kernel.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Wesley may have run into same issue and I think it's better for us to discuss.

https://protect2.fireeye.com/v1/url?k=9d423b69-fc3fd32e-9d43b026-74fe485fff30-77a099b52659410d&q=1&e=20b4d9f5-2599-4f57-8b6a-7c4ec167d228&u=https%3A%2F%2Flore.kernel.org%2Flinux-usb%2F20220203080017.27339-1-quic_wcheng%40quicinc.com%2F

Best Regards,
Jung Daehwan

------Jd1PkHJvbSWK3nTfpzLY69px07-gfkp_xqPU6voikj1qGUH4=_e8e52_
Content-Type: text/plain; charset="utf-8"


------Jd1PkHJvbSWK3nTfpzLY69px07-gfkp_xqPU6voikj1qGUH4=_e8e52_--
