Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C5F4B6699
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiBOIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:53:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiBOIxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:53:40 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CE5113D8C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:53:30 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220215085328epoutp0105612ef2aca7bc692f4412f0b44050ba~T6aqjE4CX2353023530epoutp01s
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:53:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220215085328epoutp0105612ef2aca7bc692f4412f0b44050ba~T6aqjE4CX2353023530epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644915208;
        bh=H85IgPFE9fTPPDbGFiZgFdv1FtF9Ujk3H5hnSSrYgKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NsxXsNvrivdyF8/U9AwhJNRrWCEbI/eYff9HFS9u9aCT4448VSBNJgzLC0RSX/mfd
         aiLIbOsTScK/mpBN0rWW3gA32p8s7B3DZVcpxa6CL3l76hTo+kWMcTHZIVlGuc5nVL
         YhODW+Y9YHjInPxxaosThLhwvUL9VwzBmcNnV20c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220215085327epcas2p2627901099b833affea7d4770f122c9aa~T6aqLPSRg2599025990epcas2p2r;
        Tue, 15 Feb 2022 08:53:27 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JyZch6rFMz4x9Q8; Tue, 15 Feb
        2022 08:53:24 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.6B.12141.8E96B026; Tue, 15 Feb 2022 17:52:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220215085322epcas2p2515f6d0dbfed3e9ff1e3902258533bb9~T6alon0Pt2599025990epcas2p2U;
        Tue, 15 Feb 2022 08:53:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220215085322epsmtrp1c6f83aaa873665b85afc662632571b1f~T6aln4Lag0602306023epsmtrp1l;
        Tue, 15 Feb 2022 08:53:22 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-d1-620b69e809db
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.42.08738.20A6B026; Tue, 15 Feb 2022 17:53:22 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220215085322epsmtip13f2e8dc52882f0c5a9e45edcf0f97b8e~T6alYvfcq2909929099epsmtip1b;
        Tue, 15 Feb 2022 08:53:22 +0000 (GMT)
Date:   Tue, 15 Feb 2022 17:51:08 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ugoswami@quicinc.com
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <20220215085108.GH144890@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmhe6LTO4kg6ZFghbNi9ezWVzeNYfN
        YtGyVmaL5k1TWC1ef2hisVh3Kd/i9I0bzA7sHov3vGTymHcy0GP/3DXsHhP31Hl83iQXwBqV
        bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdIOSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj
        2cl+1oLX8hWvOqewNjDul+xi5OCQEDCROLdRo4uRi0NIYAejxO8lRxkhnE+MErtnz2WBcD4z
        Snxa8Zeti5ETrOPPhqcsILaQwC5Gif/rqyDsJ4wSz48qgdgsAqoSDxq62EFsNgEtiXs/TjCD
        bBMR0JX4uEMPZCazwFNGiSkvL4LVCAt4SnTsvsQKYvMK6Eh8PXMEyhaUODnzCdguTgEniZe/
        3rKCzBEVUJF4dbAeZI6EwE92iVUPmpggbnORWPh2NtSdwhKvjm9hh7ClJF72t0HZxRK7PrUy
        QTQ3MEo0PgA5DiRhLDHrWTsjiM0skCHx4F8jEySIlCWO3GKBCPNJdBz+yw4R5pXoaBOC6FSW
        mH55AiuELSlx8PU5qIkeEs9W74UG1VkmiRdbrCcwys9C8tksJMsgbB2JBbs/sc0C2sAsIC2x
        /B8HhKkpsX6X/gJG1lWMYqkFxbnpqcVGBSbwmE7Oz93ECE6bWh47GGe//aB3iJGJg/EQowQH
        s5IIb9xZziQh3pTEyqrUovz4otKc1OJDjKbAaJrILCWanA9M3Hkl8YYmlgYmZmaG5kamBuZK
        4rxeKRsShQTSE0tSs1NTC1KLYPqYODilGphCijVcrrt5BZmlhtUXK95m35xo7r+ozyHycOv+
        t09SPsx0mPOVX8jSTMwlmDd7Re4kPa3tm0/InhCxkq4/vKPrLpe/y3rlZ0wdXsxLGsTfWL5N
        rJ23I0i6dXLc/M1p61fFl/eZ8B+2Fduxd2HN9q0zUxmE/rJNtDRZMFFmMx//m2dSYqXcumWR
        52pf99yyCdD5aM3QUcuieevesdQejqNXtrq9nCiRumxL7q372fHKf3+xxchY3TxbdOvKVs3G
        +U2HmiwOfbjDl/455tL/zmCNmYe2nNWZ4Lv8UMnrr8+1k3P2L46Ze1Jnz68VeqHCL1dLlJ70
        1vdQTJi4OP/Xp63Cm766TbJuXlNWvGlGzWUlluKMREMt5qLiRADeDyrJJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSnC5TFneSwflDKhbNi9ezWVzeNYfN
        YtGyVmaL5k1TWC1ef2hisVh3Kd/i9I0bzA7sHov3vGTymHcy0GP/3DXsHhP31Hl83iQXwBrF
        ZZOSmpNZllqkb5fAlTFr/0uWgtWyFfsWfGJpYJwh3sXIySEhYCLxZ8NTli5GLg4hgR2MEs9f
        T2KDSEhKLJ17gx3CFpa433KEFaLoEaPErbYlLCAJFgFViQcNXWBFbAJaEvd+nGDuYuTgEBHQ
        lfi4Qw+knlngKaPEg2NXwYYKC3hKdOy+xApi8wroSHw9AzP0LJNE24SZLBAJQYmTM5+A2cxA
        Q2/8e8kEMpRZQFpi+T8OkDCngJPEy19vWUHCogIqEq8O1k9gFJyFpHkWkuZZCM0LGJlXMUqm
        FhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEB7+W1g7GPas+6B1iZOJgPMQowcGsJMIbd5Yz
        SYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamiOCEs3kn
        294UvbmoVhtjk9LeV1Ds7eufYVd4/LvZOsei1xPsuf20Hp9xvzl9pfODnZdWrpyx7GPVmV8n
        Di6crxd465r13sOrZN94TuLY8C5A7vPxP8++Fs0s17/D9KtAQHzT1WOsyXfVfaMF/hgkffKI
        Nj83d8+C64caZ+f/F1nuvVDO2/GC5LX849teTynW3H9wjZW7T/Omx7ZM3af0ijRO1Zvd6Lm9
        wMq81KoiP81vac5aru7QpjuSr04+lj66MJgl+94Rew+WbAF1c0Hnhals3Ad3VUx62LnttY9o
        yV32qEUzLLbW+gRrSy2+8zZnssZR5xlrX+udfPqx95zKjfkP1iX/dXzCdUgrYc66s0osxRmJ
        hlrMRcWJALtGB/vtAgAA
X-CMS-MailID: 20220215085322epcas2p2515f6d0dbfed3e9ff1e3902258533bb9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_ea294_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214135321epcas2p19dc7b60c27304181a8863248103e7493
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
        <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
        <d82746d2-4096-1477-42dd-fd393e0ff827@linux.intel.com>
        <CGME20220214135321epcas2p19dc7b60c27304181a8863248103e7493@epcas2p1.samsung.com>
        <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_ea294_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Feb 14, 2022 at 07:23:10PM +0530, Pavan Kondeti wrote:
> Hi Mathias,
> 
> On Mon, Feb 14, 2022 at 02:51:54PM +0200, Mathias Nyman wrote:
> > On 14.2.2022 14.20, Pavankumar Kondeti wrote:
> > > From: Daehwan Jung <dh10.jung@samsung.com>
> > > 
> > > xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
> > > controller reset and controller ready operations can be fatal to the
> > > system when controller is timed out. Reduce the timeout to 1 second
> > > and print a error message when the time out happens.
> > > 
> > > Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> > 
> > 
> > The commit 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> > intentionally increased the timeout to 10 seconds as that host might take 9
> > seconds to complete reset. This was done almost 10 years ago so I don't know
> > if it really is an issue anymore.
> > 
> > Anyways, your patch might break Renesas 72021 instead of fixing it.
> 
> Unfortunately, yes :-( . We have this reduced timeout patch in our previous
> commercialized products so thought this would be a good time to fix this
> once for all. Since this patch has been 10 years long, not sure if any other
> controllers also need 10 sec timeout. It would probably better
> 
> > 
> > I agree that busylooping up to 10 seconds with interrupts disabled doesn't make sense.
> > 
> > Lets see if there is another solution for your case.
> > 
> > - Does a "guard interval" after writing the reset help?
> >   For example Intel xHCI needs 1ms before touching xHC after writing the reset bit
> 
> I will ask this question to our hardware team. Setting that one quirk from
> DWC3 host might require other changes like this [1].
> > 
> > - Is it the CNR bit or the RESET bit that fails? could be just stuck CNR bit? 
> 
> The RESET bit never gets cleared from USBCMD register.
> 
> >  
> > - we only disable local interrupts when xhci_reset() is called from xhci_stop(),
> >   and sometimes from xhci_shutdown() and xhci_resume() if some conditions are met.
> >   Have you identified which one is the problematic case?
> 
> The crash reports I have seen are pointing to
> 
> usb_remove_hcd()->xhci_stop()->xhci_reset()
> > 
> >   I think we halt the host in the above case first, meaning there should be no
> >   xHC interrupts when xhci_reset() is called. So if we could guarantee xhci interrupt
> >   isn't handled on this cpu, maybe we could somehow enable local interrupt after 
> >   halting the host?
> > 
> >   haven't really thought this true yet, but something like this could e investigated:
> > 
> >   spin_lock_irqsave()
> >   xhci_halt()
> >   < enable interrupts, magically turn spin_lock_irqsave() to just keeping spin lock>
> >   xhci_reset()
> >   spin_unlock()
> 
> This is a very good suggestion. However, disabling preemption for 10 seconds
> is also bad even on non-RT kernels like mobiles are using. Most of the SoCs
> will have a watchdog which makes sure that all CPUs are schedulable and flag
> this condition. The most important thread in the system could have just woken
> on this CPU and it can't run until we drop the spin lock.
>  

Hi,

I also think it doesn't make sense 10 secs timeout with irqs disabled.
It could cause critical system problem as Pavan said. How about adding
new quirk for different timeout value?

Best Regards,
Jung Daehwan

> [1] https://protect2.fireeye.com/v1/url?k=31f83ce7-6e63042d-31f9b7a8-0cc47a31bee8-8c4a74e439cea40a&q=1&e=5359ff44-4a70-42b7-b593-e37b236454ca&u=https%3A%2F%2Flore.kernel.org%2Flinux-usb%2F20220209055352.GA22550%40hu-pkondeti-hyd.qualcomm.com%2F
> 
> Thanks,
> Pavan
> 


------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_ea294_
Content-Type: text/plain; charset="utf-8"


------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_ea294_--
