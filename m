Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C781A4B63B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiBOGmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:42:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiBOGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:41:59 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66268C1172
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:41:50 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220215064147epoutp031fb19538c68513839883927a2ac4bdf0~T4nsiV2ta2458624586epoutp03L
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:41:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220215064147epoutp031fb19538c68513839883927a2ac4bdf0~T4nsiV2ta2458624586epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644907307;
        bh=uYuVoc8TLG5pnyaXF/S+/Ss83yCwqhKJwuUxsFkXcD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OZOGjYPbRrM1u60ro5V+x1GJI2VYxsqRqqk667N16j9+bLu1bLE39wuNW7kX2+4TM
         5w+46K9FrCP4IjF5dU9LubU6A6nuNASsSKEKUlkdRyejXaoFj3/c6CSSC+twaSAZQX
         w+so1Q/0jbwhUuytDQijuqPFg5SZlAi+7/FA2di4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220215064147epcas2p2ad99f62b76f65789911defc7de98304a~T4nsKogGf2025620256epcas2p2Y;
        Tue, 15 Feb 2022 06:41:47 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JyWhm1XXqz4x9Q3; Tue, 15 Feb
        2022 06:41:44 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.52.35137.16A4B026; Tue, 15 Feb 2022 15:38:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220215064139epcas2p4669383cd1a2937ce5884335856be457d~T4nlaJU6z2843428434epcas2p4N;
        Tue, 15 Feb 2022 06:41:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220215064139epsmtrp20c7fd16c90eb1427795db762e37dc096~T4nlYtDWi1742317423epsmtrp2D;
        Tue, 15 Feb 2022 06:41:39 +0000 (GMT)
X-AuditID: b6c32a46-da1ff70000018941-18-620b4a612069
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.53.08738.32B4B026; Tue, 15 Feb 2022 15:41:39 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220215064139epsmtip14d824f0e0cbc8c6cd20bd524ae674f66~T4nlPr6Di1847318473epsmtip1k;
        Tue, 15 Feb 2022 06:41:39 +0000 (GMT)
Date:   Tue, 15 Feb 2022 15:39:25 +0900
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
Message-ID: <20220215063925.GC144890@ubuntu>
MIME-Version: 1.0
In-Reply-To: <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmmW6iF3eSwcE1JhbH2p6wWzQvXs9m
        cXnXHDaLRctamS12/VvEZLFpdx+rxaoFB9gd2D02repk89g/dw27x8Q9dR5b9n9m9Pi8SS6A
        NSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
        dsadCZ+YCuZJVPTsvsDWwHhTuIuRk0NCwETi3/mnTF2MXBxCAjsYJW7f3MEI4XxilPi/4xAb
        SJWQwGdGiWsXA2A6eqZfhCraxSjxfksjK4TzhFGi4fBOsA4WAVWJN1c/MYLYbAJaEvd+nGAG
        sUUEdCQOnDgPto9ZYDmTRMf5k2AJYYFYiQvb2sCaeYGKJrVMYIawBSVOznzCAmJzCjhITOh9
        ARTn4BAVUJF4dbAeZI6EwF92iTOHDzNDnOcisffmKlYIW1ji1fEt7BC2lMTnd3vZIOxiiV2f
        WpkgmhsYJRofnIBqNpaY9awd7GpmgQyJvoZpLCDLJASUJY7cYoEI80l0HP7LDhHmlehoE4Lo
        VJaYfnkC1FpJiYOvz0FN9JD43bsIGr69TBIrrvYyT2CUn4XktVlItkHYOhILdn9imwW0gllA
        WmL5Pw4IU1Ni/S79BYysqxjFUguKc9NTi40KjOCxnZyfu4kRnEK13HYwTnn7Qe8QIxMH4yFG
        CQ5mJRHeuLOcSUK8KYmVValF+fFFpTmpxYcYTYERNZFZSjQ5H5jE80riDU0sDUzMzAzNjUwN
        zJXEeb1SNiQKCaQnlqRmp6YWpBbB9DFxcEo1MO22a/eaFWxumpoUcWmBsoP7dVNehS8L5opo
        XZh6t8fqhIl94oSbE670Ch7+tUrjB+fEsz4LXD3LOj8oLxTV5X2ttGtHaJOqgPlEnn0dL223
        8/XFb77j/jvog8rJ1abd7zco//vOv9rS/FHZ5xVPJJqXX9uzjDXhzzxlpfqoNbc2/Stwc5Ey
        W7U7YFX0FMuiqJmcX3wiAgQm9JYf/nOyI97XRXLJO5XAzbZRdhqXerwfbgmcZinKsZir5dL+
        yV1FaUq1J9tYNCX2/lKWeRFiEh3w7Y75N+dNUnvZlsZuVGu6Iq+W9uU+pwNfg/1MBvOPz1LC
        X26YkLI79O2yuSlxBR1eMXfCf8vfl5GsvqfwUImlOCPRUIu5qDgRAMUnHnMqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnK6yN3eSwZ8jGhbH2p6wWzQvXs9m
        cXnXHDaLRctamS12/VvEZLFpdx+rxaoFB9gd2D02repk89g/dw27x8Q9dR5b9n9m9Pi8SS6A
        NYrLJiU1J7MstUjfLoErY/LKS4wF90QrVvz/xNTAuEmwi5GTQ0LARKJn+kXGLkYuDiGBHYwS
        Hx+9Y4RISEosnXuDHcIWlrjfcoQVougRo8SxfavAEiwCqhJvrn4Ca2AT0JK49+MEM4gtIqAj
        ceDEeSaQBmaBlUwSU7vmsoIkhAViJS5sa2MDsXmBiia1TGCGmNrLJLH+1ERWiISgxMmZT1hA
        bGagqTf+vQSaxAFkS0ss/8cBEuYUcJCY0PuCGSQsKqAi8epg/QRGwVlImmchaZ6F0LyAkXkV
        o2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwDGhp7WDcs+qD3iFGJg7GQ4wSHMxKIrxx
        ZzmThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDKYLP9
        Oql3YtYdKdOEW73hXAfVd8lNemW5vdBnJ4PJpzdN5f29Yq0r+z8qduzk1VZgtPoUuM5Lep78
        Fkdjb9FrqtbNmxTmf91dUj7ft4iRcVYyixrr+pnPJGOlBP5+4Tqo5nXQWnST1TTXe0L/62Zf
        jNtneH3bruD1XE4/Ol6wab+sYeX1LDytbHCvW2bXujt7SqPD1wl3d6/L9DCJmPzV4uapQ9VL
        n+efWh4TPnft440dzzwZzLae1tdStd6yfc3DkxOX5S2SYrTQe8Qhyvn4XtLE49f5HBbsSLGr
        2Ko77+JRC8PfTY5rn59MzvT4KLq5KKloZUxnd+fEwv6f3h23Fj79lKHx+/x6pVyxFR+VWIoz
        Eg21mIuKEwFJTdE08AIAAA==
X-CMS-MailID: 20220215064139epcas2p4669383cd1a2937ce5884335856be457d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_e8880_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
        <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
        <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
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

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_e8880_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Thinh,

On Mon, Feb 14, 2022 at 06:44:33PM +0000, Thinh Nguyen wrote:
> Hi,
> 
> Daehwan Jung wrote:
> > It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
> > even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
> 
> How does it fail? Timed out?

Yes, timed out.
> 
> > skipping clear stall commmand or giveback from dequeue. We fix to set it
> > only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
> > for next trb to start transfer not update transfer.
> 
> We shouldn't do this. Things will be out of sync. It may work for 1
> scenario, but it won't work for others.
> 
> Please help me understand a few things:
> 
> 1) What is the scenario that triggers this? Is it random?
> 
ep cmd timeout occurs on dequeue request from user side. End Transfer command
would be sent in dwc3_stop_active transfer.

> 2) Are there other traffics pending while issuing the End Transfer
> command? If so, what transfer type(s)?
> 
I haven't checked it yet. 

> 3) Have you tried increasing the timeout?
> 
No, I haven't.
> BR,
> Thinh
> 

This issue occurs very rarely on customer. I only have restricted
information. That's why I've been trying to reproduce it.

Wesley may have run into same issue and you can see this issue in detail.
https://protect2.fireeye.com/v1/url?k=9d423b69-fc3fd32e-9d43b026-74fe485fff30-77a099b52659410d&q=1&e=20b4d9f5-2599-4f57-8b6a-7c4ec167d228&u=https%3A%2F%2Flore.kernel.org%2Flinux-usb%2F20220203080017.27339-1-quic_wcheng%40quicinc.com%2F

Best Regards,
Jung Daehwan
> 
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/dwc3/gadget.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 183b90923f51..3ad3bc5813ca 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2044,6 +2044,12 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
> >  				dwc3_gadget_move_cancelled_request(r,
> >  						DWC3_REQUEST_STATUS_DEQUEUED);
> >  
> > +			/* If ep cmd fails, then force to giveback cancelled requests here */
> > +			if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING)) {
> > +				dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
> > +				dwc3_gadget_ep_cleanup_cancelled_requests(dep);
> > +			}
> > +
> >  			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
> >  
> >  			goto out;
> > @@ -3645,7 +3651,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
> >  
> >  	if (!interrupt)
> >  		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
> > -	else
> > +	else if (!ret)
> >  		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
> >  }
> >  
> 

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_e8880_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_e8880_--
