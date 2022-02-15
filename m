Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0F24B6347
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiBOGLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:11:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiBOGLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:11:10 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC9F1186
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:11:00 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220215061058epoutp025b92000ba35cb7f48e773f97bdce6503~T4MyrN8qU0321003210epoutp02n
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:10:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220215061058epoutp025b92000ba35cb7f48e773f97bdce6503~T4MyrN8qU0321003210epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644905458;
        bh=NTyW/hdAfUjA6iQMQHXUxa9Lo11qEZpBXPgW2wxx4zo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S0oXg1psdYQJVDtuoW5IOb8iV/I4lw6z7OSi3rNCJxlPw6MXEOOVAWlWZ6VEMjtDR
         K+ageFud1Ksd/yoExy/XdlLghmUssY121btywEAZDsjGdOXbEbSxCrcpD9BhV70D+1
         OkU0uw3pW7vqI+NxME5rDzYTfDotCPvwqKkR5amk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220215061057epcas2p49de0f293f9b4ced03147eed7451c7f53~T4MxmFDgv2792727927epcas2p4C;
        Tue, 15 Feb 2022 06:10:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JyW1B54d6z4x9Q5; Tue, 15 Feb
        2022 06:10:54 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.18.12141.5D34B026; Tue, 15 Feb 2022 15:10:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220215061050epcas2p476733a589249d4d82b5a4add161edb22~T4MrPgJEQ2792727927epcas2p4v;
        Tue, 15 Feb 2022 06:10:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220215061050epsmtrp25b9dd3ebef9b6c2bc9d257b827a3ea1a~T4MrOZH_L3155431554epsmtrp2I;
        Tue, 15 Feb 2022 06:10:50 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-c8-620b43d5da11
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.9D.29871.AE34B026; Tue, 15 Feb 2022 15:10:50 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220215061050epsmtip2038bb7739a11dd2af44b0215e47c01d5~T4MrE1duP0764107641epsmtip2c;
        Tue, 15 Feb 2022 06:10:50 +0000 (GMT)
Date:   Tue, 15 Feb 2022 15:08:36 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH v1 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Message-ID: <20220215060836.GB144890@ubuntu>
MIME-Version: 1.0
In-Reply-To: <e4b18b77-ab33-bd70-c239-b009210c3864@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmue5VZ+4kg3kdPBbH2p6wWzQvXs9m
        cXnXHDaLRctamS12/VvEZLFpdx+rxaoFB9gd2D02repk89g/dw27x8Q9dR5b9n9m9Pi8SS6A
        NSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
        dsbBK/IF1yUqTj/ew9rAOEeki5GTQ0LAROLqqq9sXYxcHEICOxgljuyZygySEBL4xCix84kl
        ROIbo8SOc59ZYDoWdv6E6tgL1DFnJROE84RR4trpi2wgVSwCqhK/bh9iB7HZBLQk7v04ATZW
        BMi+M+c+I0gDs8AlRondT24CORwcwgKxEj1LpEBqeAV0JHrf72OFsAUlTs58AraZU8BeYktj
        B1i5qICKxKuD9SBjJAR+skt8WbOCHSQuIeAisf5RHsShwhKvjm9hh7ClJD6/28sGYRdL7PrU
        ygTR28Ao0fgA4jYJAWOJWc/aGUFsZoEMiQ9r5jBCzFSWOHKLBSLMJ9Fx+C/UKl6JjjYhiE5l
        iemXJ7BC2JISB1+fg5roIfF9/h9oWPUwSaw48YVxAqP8LCSfzUKyDcLWkViw+xPbLKAVzALS
        Esv/cUCYmhLrd+kvYGRdxSiWWlCcm55abFRgAo/q5PzcTYzg5KnlsYNx9tsPeocYmTgYDzFK
        cDArifDGneVMEuJNSaysSi3Kjy8qzUktPsRoCoymicxSosn5wPSdVxJvaGJpYGJmZmhuZGpg
        riTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qBSe7XNl7lZWtPcoqv2SZ3Vf3/11kHi4/03Pue
        /+n3q2U7rIX4e1YqXtJaxHe6R471tXUW6/aV0YdW7b9VemH/90m6WaJyZ+t+beec0Bjzz2OF
        92mliccWn7nx7b9Cyc6gZtXQVxOi+9/WlIpcyGU4x/4ldMXsg8o5lmHLt5dklIZPeHDU4wmL
        ts/fuaevhSmE7bern/KZqaA94b6bvGBzicraq6bB7Zc1d3VKvFgYdiDW9cI0kZmvrpi1NkmJ
        rfpj+YzjY8D+pfkHlwoIMCxO53B4u+WpnkDc5E8v0j/LXT/6InJB9O5ysflCH3nTyk81N3t2
        687pjQ9ZW79cuKLI/TdD7h/fkJ5nEzbu0XD1PKrEUpyRaKjFXFScCABzS3vGJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvO4rZ+4kg8nv5CyOtT1ht2hevJ7N
        4vKuOWwWi5a1Mlvs+reIyWLT7j5Wi1ULDrA7sHtsWtXJ5rF/7hp2j4l76jy27P/M6PF5k1wA
        axSXTUpqTmZZapG+XQJXRsv0NraC6WIVHTOXMjYwfhXsYuTkkBAwkVjY+ZOti5GLQ0hgN6PE
        8f0nWCESkhJL595gh7CFJe63HGGFKHrEKNE64Q4bSIJFQFXi1+1DYEVsAloS936cYAaxRYDs
        O3PuM4I0MAtcYpTYfmcKSxcjB4ewQKxEzxIpkBpeAR2J3vf7oIb2MElsWtHADpEQlDg58wkL
        iM0MNOjGv5dMIL3MAtISy/9xgIQ5BewltjR2MIKERQVUJF4drJ/AKDgLSfMsJM2zEJoXMDKv
        YpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgAtzR2M21d90DvEyMTBeIhRgoNZSYQ3
        7ixnkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MLFzT
        pF31PhfPDMlKDJ782fK0hFNW4d48/oDqG301LnfWnXd9YK40a4GYXlPFd5+dC91eVLcEX7nr
        ukjViHHuGT7Onqnfmxj62NKrbCp4xEterJTfsezq/cTEtFU/I82u2z6YdKIuab6zUgbHsna5
        rBnX2M4rRkypO3d16Qn3lpNSsQ/O1nuHtTKt8+f/U7ch90Gdg6ntt61a7w8trjA8+M9F0XVX
        XEn/gq0JU8r4vBsfqNb0quzgMCqUiw7kLTVNbgv95rDpjX7C7RfyZyMvpm3QuK3UYNrlKihg
        3TCp6Wr27d1dB+OlF3t1iuWu2XaD3SXnocbTStXeXcsS83uCzvLqNFQp+SqedDOcqMRSnJFo
        qMVcVJwIANZ0uh/vAgAA
X-CMS-MailID: 20220215061050epcas2p476733a589249d4d82b5a4add161edb22
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_e8433_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214094041epcas2p2ec37c252dd5f9508454e9449c95e6c7a
References: <1644831438-125403-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220214094041epcas2p2ec37c252dd5f9508454e9449c95e6c7a@epcas2p2.samsung.com>
        <1644831438-125403-2-git-send-email-dh10.jung@samsung.com>
        <e4b18b77-ab33-bd70-c239-b009210c3864@quicinc.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_e8433_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Feb 14, 2022 at 10:53:14AM -0800, Wesley Cheng wrote:
> Hi Daehwan,
> 
> On 2/14/2022 1:37 AM, Daehwan Jung wrote:
> > It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
> > even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
> > skipping clear stall commmand or giveback from dequeue. We fix to set it
> > only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
> > for next trb to start transfer not update transfer.
> > 
> > Change-Id: I2e6b58acc99f385e467e8b639a3792a5e5f4d2bb
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
> What I realized when looking at the endxfer command fail due to TIMEOUT,
> was that it would lead to subsequent controller halt failures as well
> (during pullup disable case).  It might not be safe to forcefully unmap
> the request buffers if the controller may still be "working" on it.
>
Hi Wesley,

I agree with your opinion that the controller may still be "working" on
it.

> I found some interesting quirks with regards to endxfer timeouts as
> well, which I'm trying to get some more feedback on [1].  What is the
> end issue being seen that requires this change? (we may have run into
> the same issue as well.
> 
> [1] -
> https://protect2.fireeye.com/v1/url?k=9d423b69-fc3fd32e-9d43b026-74fe485fff30-77a099b52659410d&q=1&e=20b4d9f5-2599-4f57-8b6a-7c4ec167d228&u=https%3A%2F%2Flore.kernel.org%2Flinux-usb%2F20220203080017.27339-1-quic_wcheng%40quicinc.com%2F

I had adb hung issue if ep cmd timeout occurs. I also think we may have
run into the same issue. I'm going to see your patches.
Thanks for your comment.

Best Regards,
Jung Daehwan

> 
> Thanks
> Wesley Cheng
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

------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_e8433_
Content-Type: text/plain; charset="utf-8"


------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_e8433_--
