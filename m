Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266B34BB0D5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiBRErf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:47:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiBREra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:47:30 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647E32A267
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:47:12 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220218044710epoutp02115f0fcde95e6efd424c5646c1754c69~Ux-eeGzfp1911019110epoutp02l
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:47:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220218044710epoutp02115f0fcde95e6efd424c5646c1754c69~Ux-eeGzfp1911019110epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645159630;
        bh=ogoRrv1kJL1px7WeKpen146whT9nRAjbnabgdCKG4cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E/ThpjguyP/N0bmCXNIJKyxAmMXxvJk1ODOv57nfwRXpekcvBDXSLp+RYnc9o5UgX
         FM6elEljJ2GpkRCwmzrwQaZegVp+Z8ROYHqI4/EkOuraUCdhAzBiPJYBJ80EbdvyfL
         gdYkcWGxlMrhEQunKiSikrGRizvF3YU3zfWKVxu8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220218044709epcas2p2e63ea3ff21709629144fab0f6f3fdbfd~Ux-eDoWse2277922779epcas2p2x;
        Fri, 18 Feb 2022 04:47:09 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K0K1718Plz4x9Qc; Fri, 18 Feb
        2022 04:47:07 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.F9.12141.3342F026; Fri, 18 Feb 2022 13:44:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220218044705epcas2p263822f08c9e2d0ef246f720daba8d3bc~Ux-Zoq_jT2187621876epcas2p2I;
        Fri, 18 Feb 2022 04:47:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220218044705epsmtrp1495ed8400b1a2fe9943fc1d8b18a1fce~Ux-Zn9nUV1618816188epsmtrp1J;
        Fri, 18 Feb 2022 04:47:05 +0000 (GMT)
X-AuditID: b6c32a48-5886ca8000002f6d-93-620f24334804
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.B2.08738.8C42F026; Fri, 18 Feb 2022 13:47:04 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220218044704epsmtip2a2a26935d0efd81eaee20715df16a3a1~Ux-ZdTV5q2386723867epsmtip2o;
        Fri, 18 Feb 2022 04:47:04 +0000 (GMT)
Date:   Fri, 18 Feb 2022 13:44:44 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Message-ID: <20220218044444.GA48532@ubuntu>
MIME-Version: 1.0
In-Reply-To: <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmha6xCn+SwZJZNhbH2p6wWzQvXs9m
        cXnXHDaLRctamS12/VvEZLFpdx+rxaoFB9gd2D02repk89g/dw27x8Q9dR5b9n9m9Pi8SS6A
        NSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
        dsbU83EF050qGjruMTYwrjXrYuTkkBAwkXi++iZ7FyMXh5DADkaJl3dXMUM4nxglns28BJX5
        zChx/WsPC0zL8pV7GCESuxgl9m6ZzgrhPGGUWN/bxgpSxSKgKnFx+2lmEJtNQEvi3o8TYLaI
        gI7EgRPnmUAamAWWM0l0nD8JlhAWiJW4sK2NDcTmFdCWWLihlwXCFpQ4OfMJkM3BwSngINHV
        mQRiigqoSLw6WA9x0E92iU+d+hC2i8TR3fvYIGxhiVfHt7BD2FISL/vboOxiiV2fWsFOkBBo
        YJRofABxm4SAscSsZ+2MIDazQKbEo83TmEB2SQgoSxy5xQIR5pPoOPyXHSLMK9HRJgTRqSwx
        /fIEVghbUuLg63NQEz0kfvcuYoIEzzMmif4fF5kmMMrPQvLYLCTbIGwdiQW7P7HNAlrBLCAt
        sfwfB4SpKbF+l/4CRtZVjGKpBcW56anFRgUm8LhOzs/dxAhOn1oeOxhnv/2gd4iRiYPxEKME
        B7OSCO+Hg7xJQrwpiZVVqUX58UWlOanFhxhNgdE0kVlKNDkfmMDzSuINTSwNTMzMDM2NTA3M
        lcR5vVI2JAoJpCeWpGanphakFsH0MXFwSjUwGVu98XFkTtpR+evhVcsvDz4VechfKX/mHRpe
        pNjWfGGmqG7G6vsR3mdN5UNFQ+QT3GdbLVkou5v3I8dulkcFcTVPn2wUUWjvkHx2843XBZuj
        bmEVx4W261t9vK6Za/Ty9/kb3fEJuf55dxqsjBX//3jfHvMzyzGheEu3oNMelaRKi2yG2h38
        xdPbT5o8u1F+10goMNxReIv7ws9udw53NT5kuqnUPFFzzZzjpult06bLLfFdU/2n0eGT5MuP
        HP9ueh498ab21kLm4qnqV19tjYgUSL43/+amdeUv/q7bsjS0LGSzdqWdVoPPK3vduVGbIl93
        /Qro+qsgy7NNJ8RvgfxT/8w/n1Y56VopdPYosRRnJBpqMRcVJwIARapysygEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvO4JFf4kg5v3LS2OtT1ht2hevJ7N
        4vKuOWwWi5a1Mlvs+reIyWLT7j5Wi1ULDrA7sHtsWtXJ5rF/7hp2j4l76jy27P/M6PF5k1wA
        axSXTUpqTmZZapG+XQJXxoefC5kKrthXPNlyjLGBsdmki5GTQ0LARGL5yj2MXYxcHEICOxgl
        Gpb1s0IkJCWWzr3BDmELS9xvOcIKUfSIUeL+5iXMIAkWAVWJi9tPg9lsAloS936cALNFBHQk
        Dpw4zwTSwCywkkliatdcsKnCArESF7a1sYHYvALaEgs39LJATH3GJPHwwyuohKDEyZlPWEBs
        ZqCpN/69BJrEAWRLSyz/xwFicgo4SHR1JoGYogIqEq8O1k9gFJyFpHcWkt5ZCL0LGJlXMUqm
        FhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER4CW1g7GPas+6B1iZOJgPMQowcGsJML74SBv
        khBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MvEJhn5eZ
        ubcszvoaYme8QnpxEkNTxMyoq//8N4ov4fC1vHKtfZuf3po7kRJ6PV7Jn6pMThx58oFrncmp
        RSFF+RtEsyKuKWw+/ER+rb5cwXytuuCwzQ9Ocvfr1641Narc/W9n56QfPzI2Wy1f+8nqwMeK
        xfbiobJXvf54/I5RKV9v/kqxyuVgd2Bo6LrHPza2LzmTvjaxTnftznNXLObtLHPvyM0tKbf6
        8WTPY/8o8y1BWYrPuTkqJxZ4lIn2nZ536rb18yBXDYttNTOOzd22ZMbn/nOWPHzSQh6O69j3
        +hYysTnv5j3MZHXp55PEwhWaenunG/z3Dr0ySzK/9uglCSOLA0ek3l54qLZ04u5UJZbijERD
        Leai4kQA7aHztO8CAAA=
X-CMS-MailID: 20220218044705epcas2p263822f08c9e2d0ef246f720daba8d3bc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_1086b7_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
        <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
        <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
        <20220215063925.GC144890@ubuntu>
        <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_1086b7_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Feb 15, 2022 at 05:14:50PM +0000, Thinh Nguyen wrote:
> Jung Daehwan wrote:
> > Hi Thinh,
> > 
> > On Mon, Feb 14, 2022 at 06:44:33PM +0000, Thinh Nguyen wrote:
> >> Hi,
> >>
> >> Daehwan Jung wrote:
> >>> It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
> >>> even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
> >>
> >> How does it fail? Timed out?
> > 
> > Yes, timed out.
> >>
> >>> skipping clear stall commmand or giveback from dequeue. We fix to set it
> >>> only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
> >>> for next trb to start transfer not update transfer.
> >>
> >> We shouldn't do this. Things will be out of sync. It may work for 1
> >> scenario, but it won't work for others.
> >>
> >> Please help me understand a few things:
> >>
> >> 1) What is the scenario that triggers this? Is it random?
> >>
> > ep cmd timeout occurs on dequeue request from user side. End Transfer command
> > would be sent in dwc3_stop_active transfer.
> 
> At the high level, what's triggering the request dequeue? Is it from a
> disconnect, change of interface, or simply function driver protocol that
> changes it.
> 
> What application was used to trigger this?
> 
Removing function driver requests dequeue.
> > 
> >> 2) Are there other traffics pending while issuing the End Transfer
> >> command? If so, what transfer type(s)?
> >>
> > I haven't checked it yet. 
> 
> Can you check?
> 
It seems there's no pending traffic.
> > 
> >> 3) Have you tried increasing the timeout?
> >>
> > No, I haven't.
> 
> Can you try up to 10 seconds (just for experiment)
> 
Yes, it's reproduced on 10 secs.
> >> BR,
> >> Thinh
> >>
> > 
> > This issue occurs very rarely on customer. I only have restricted
> > information. That's why I've been trying to reproduce it.
> 
> How did you test your fix if you can't reproduce it?
> 

I sent patches to my client and he said this issue would not occur after
applying them. In fact, They are not totally equal with those we are
discussing. I've refactor-ed and pushed them here.

> > 
> > Wesley may have run into same issue and you can see this issue in detail.
> > https://protect2.fireeye.com/v1/url?k=39bd3e50-66260725-39bcb51f-0cc47a31ce4e-bf000d5a697ead66&q=1&e=b04500ad-43d0-4ee7-b5f0-a7283d8fc0da&u=https%3A%2F%2Furldefense.com%2Fv3%2F__https%3A%2F%2Fprotect2.fireeye.com%2Fv1%2Furl%3Fk%3D9d423b69-fc3fd32e-9d43b026-74fe485fff30-77a099b52659410d%26q%3D1%26e%3D20b4d9f5-2599-4f57-8b6a-7c4ec167d228%26u%3Dhttps%2A3A%2A2F%2A2Flore.kernel.org%2A2Flinux-usb%2A2F20220203080017.27339-1-quic_wcheng%2A40quicinc.com%2A2F__%3BJSUlJSUlJQ%21%21A4F2R9G_pg%21JWPzNLoO3BFX_IZCVzmHPtxq6frr_VFbSNNaxSQylunt1Y4EauTOefth2LCIcVEuTx8E%24 
> > 
> 
> I can take a look, but please provide the tracepoints of the failure if
> you can reproduce it.
> 

Thanks to client's help, I could reproduce it in my envrionment.

1. Trace

MtpServer-2484    [003] d..2   114.376829: dwc3_ep_queue: ep1out: req 0000000055561867 length 0/512 zsI ==> -115
MtpServer-2484    [003] d..2   114.376838: dwc3_prepare_trb: ep1out: trb 0000000074078a95 (E23:D22) buf 0000000954845600 size 512 ctrl 0000001d (HlCS:sc:normal)
MtpServer-2484    [003] d..2   114.376844: dwc3_prepare_trb: ep1out: trb 0000000095f503e7 (E24:D22) buf 00000000e1303000 size 512 ctrl 00000819 (HlcS:sC:normal)
MtpServer-2484    [003] d..2   114.376867: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
ksoftirqd/2-23      [002] d.s2   190.428752: dwc3_ep_dequeue: ep2out: req 00000000732c0f69 length 0/16384 zsI ==> -115
ksoftirqd/2-23      [002] dns3   190.447625: dwc3_gadget_ep_cmd: ep2out: cmd 'End Transfer' [40d08] params 00000000 00000000 00000000 --> status: Timed Out
ksoftirqd/2-23      [002] dns2   190.450596: dwc3_ep_dequeue: ep2out: req 00000000be3434d4 length 0/16384 zsI ==> -115
ksoftirqd/2-23      [002] dns2   190.450618: dwc3_ep_dequeue: ep2out: req 0000000033655f2e length 0/16384 zsI ==> -115
ksoftirqd/2-23      [002] dns2   190.450625: dwc3_ep_dequeue: ep2out: req 00000000dc0ff635 length 0/16384 zsI ==> -115
ksoftirqd/2-23      [002] dns2   190.450633: dwc3_ep_dequeue: ep2out: req 0000000023ffb8e8 length 0/16384 zsI ==> -115
ksoftirqd/2-23      [002] dns2   190.450641: dwc3_ep_dequeue: ep2out: req 000000005fab61aa length 0/16384 zsI ==> -115
ksoftirqd/2-23      [002] dns2   190.450648: dwc3_ep_dequeue: ep2out: req 000000001f618cd8 length 0/16384 zsI ==> -115
ksoftirqd/2-23      [002] dns2   190.450654: dwc3_ep_dequeue: ep2out: req 00000000da0ea1b1 length 0/16384 zsI ==> -115
##### CPU 6 buffer started ####
HwBinder:636_1-658     [006] d..1   190.735324: dwc3_gadget_ep_disable: ep0out: mps 512/512 streams 0 burst 1 ring 0/0 flags e:swbp:>
HwBinder:636_1-658     [006] d..1   190.735327: dwc3_gadget_ep_disable: ep0in: mps 512/512 streams 0 burst 1 ring 0/0 flags e:swbp:<
HwBinder:636_1-658     [003] dn.1   214.206652: dwc3_gadget_ep_disable: ep0out: mps 512/512 streams 0 burst 1 ring 0/0 flags e:swbp:>
HwBinder:636_1-658     [003] dn.1   214.206677: dwc3_gadget_ep_disable: ep0in: mps 512/512 streams 0 burst 1 ring 0/0 flags e:swbp:<

2. Kernel log

[  190.447711]I[2:    ksoftirqd/2:   23] ------------[ cut here ]------------
[  190.447777]I[2:    ksoftirqd/2:   23] WARNING: CPU: 2 PID: 23 at drivers/usb/dwc3/gadget.c:3632 dwc3_gadget_ep_dequeue+0x228/0x234
[  190.449587]I[2:    ksoftirqd/2:   23] pc : dwc3_gadget_ep_dequeue+0x228/0x234
[  190.449610]I[2:    ksoftirqd/2:   23] lr : dwc3_gadget_ep_dequeue+0x124/0x234
[  190.449629]I[2:    ksoftirqd/2:   23] sp : ffffffc01294bad0
[  190.449647]I[2:    ksoftirqd/2:   23] x29: ffffffc01294baf0 x28: 0000000000000000 
[  190.449679]I[2:    ksoftirqd/2:   23] x27: ffffffc0121e4000 x26: ffffff88208c9dc0 
[  190.449711]I[2:    ksoftirqd/2:   23] x25: ffffff893dd5c570 x24: ffffff893dd22080 
[  190.449742]I[2:    ksoftirqd/2:   23] x23: ffffff88a4f8a168 x22: ffffff88a4f8a100 
[  190.449773]I[2:    ksoftirqd/2:   23] x21: ffffff893dd5c500 x20: 0000000000000080 
[  190.449803]I[2:    ksoftirqd/2:   23] x19: ffffff893dd22238 x18: ffffffc01291d068 
[  190.449834]I[2:    ksoftirqd/2:   23] x17: 0000000000004000 x16: ffffff88bb0cc000 
[  190.449864]I[2:    ksoftirqd/2:   23] x15: 0000000000000200 x14: ffffff88208d4d00 
[  190.449895]I[2:    ksoftirqd/2:   23] x13: ffffff88208d4d00 x12: 00000000000001b5 
[  190.449926]I[2:    ksoftirqd/2:   23] x11: ffffff88208c9dc0 x10: 0000000100000103 
[  190.449958]I[2:    ksoftirqd/2:   23] x9 : ffffff88208c9dc0 x8 : 0000000000000008 
[  190.449989]I[2:    ksoftirqd/2:   23] x7 : fefefefefefefefe x6 : 0000000000008080 
[  190.450020]I[2:    ksoftirqd/2:   23] x5 : 0000000000000000 x4 : 0000000000000103 
[  190.450050]I[2:    ksoftirqd/2:   23] x3 : 0000000000000080 x2 : ffffff88208ac900 
[  190.450081]I[2:    ksoftirqd/2:   23] x1 : ffffff88208ac900 x0 : 00000000ffffff92 
[  190.450120]I[2:    ksoftirqd/2:   23] Call trace:
[  190.450153]I[2:    ksoftirqd/2:   23]  dwc3_gadget_ep_dequeue+0x228/0x234
[  190.450187]I[2:    ksoftirqd/2:   23]  usb_ep_dequeue+0x4c/0xa0
[  190.450219]I[2:    ksoftirqd/2:   23]  ffs_aio_cancel+0x4c/0x84
[  190.450247]I[2:    ksoftirqd/2:   23]  free_ioctx_users+0x80/0x110
[  190.450281]I[2:    ksoftirqd/2:   23]  percpu_ref_put_many+0xf0/0x164
[  190.450310]I[2:    ksoftirqd/2:   23]  percpu_ref_switch_to_atomic_rcu+0x13c/0x1dc
[  190.450339]I[2:    ksoftirqd/2:   23]  rcu_do_batch+0x208/0x5b4
[  190.450360]I[2:    ksoftirqd/2:   23]  rcu_core+0x22c/0x43c
[  190.450384]I[2:    ksoftirqd/2:   23]  rcu_core_si+0x14/0x24
[  190.450409]I[2:    ksoftirqd/2:   23]  efi_header_end+0x134/0x350
[  190.450437]I[2:    ksoftirqd/2:   23]  run_ksoftirqd+0x34/0x74

The point is there would be some requests pending without giveback-ed.
They're from removing function driver(ffs_aio_cancel). It could cause
the function driver would wait for dequeue requests completed.

Best Regards,
Jung Daehwan

> Thanks,
> Thinh

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_1086b7_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_1086b7_--
