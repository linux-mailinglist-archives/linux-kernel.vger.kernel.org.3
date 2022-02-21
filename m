Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484144BD7EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiBUIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:31:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiBUIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:31:13 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00610AD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:30:48 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220221083043epoutp047b45135cdf61026f7ec65901945f8ed8~Vv_hVtj8j2080720807epoutp04H
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:30:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220221083043epoutp047b45135cdf61026f7ec65901945f8ed8~Vv_hVtj8j2080720807epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645432243;
        bh=VeOvNggr2GN4Xhxn4t7sD4lcFmaTZxtJAd+bSZt2yIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MTKCTYskjqbL1YUaN5JvaJpcskrN51/VbwOhtJjhiT6g/HSGgs9fFoGcShNhqbuO5
         s6MYLIGPft55xbFw/WiphFd5NmsZhCYsIvnx3PE7B5N7+jXQglEQoDw7Kh6xQMaCC4
         6XR7KnszCVPRpHh6OQsH0T+4UyK6VYzKFtOoeVpE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220221083042epcas2p305906d0ede3d7d3a8ef524103b20dc66~Vv_gyWoyh1370513705epcas2p33;
        Mon, 21 Feb 2022 08:30:42 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K2Fqg3WnFz4x9QC; Mon, 21 Feb
        2022 08:30:39 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.28.51767.BAD43126; Mon, 21 Feb 2022 17:30:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220221083034epcas2p1c745614d557143a5cebc808bfd71f01f~Vv_ZRhKgO1960519605epcas2p16;
        Mon, 21 Feb 2022 08:30:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220221083034epsmtrp28b9ddbeffdb340a17ae717fab5716d4e~Vv_ZQONmK1620716207epsmtrp2j;
        Mon, 21 Feb 2022 08:30:34 +0000 (GMT)
X-AuditID: b6c32a45-447ff7000000ca37-43-62134dab66b4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.53.29871.AAD43126; Mon, 21 Feb 2022 17:30:34 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220221083034epsmtip156748e8f54cce02379f4629415453bdf~Vv_ZG5svj0195601956epsmtip13;
        Mon, 21 Feb 2022 08:30:34 +0000 (GMT)
Date:   Mon, 21 Feb 2022 17:28:11 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-usb@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: usb: gadget: function: add spinlock for rndis response list
Message-ID: <20220221082811.GA127516@ubuntu>
MIME-Version: 1.0
In-Reply-To: <Yg9ReVfKxHUPOTvZ@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmue5qX+EkgzNHBC3mrF/DZnGs7Qm7
        xdZviRbNi9ezWVzeNYfNYtGyVmaLrXuvslscvH+O2YHD49+JNWwejTdusHlsWtXJ5nFixm8W
        j/1z17B7PJj0htHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQXmBXrFibnF
        pXnpenmpJVaGBgZGpkCFCdkZ7d2vmAquilYs2PGKvYFxglAXIweHhICJxM2tOl2MnBxCAjsY
        JZo+1ncxcgHZnxglfky5zQLhfGOU2Nk6gw2kCqSha84zVojEXkaJjv0tUFVPGCW6v51iBqli
        EVCV+Lr0AyOIzSagJXHvxwmwuIiAsUT/2VnsIA3MAnOYJA6eXcgOkhAW8JBouHQJbAWvgI7E
        nRdrmSBsQYmTM5+wgNicApoSG6eeYge5W1RAReLVQbBbJQSmckhcWP6UDeIfF4l5y2UgLhWW
        eHV8CzuELSXx+d1eqA+KJXZ9amWC6G1glGh8AHGcBNBxs561gx3NLJApcXrbaXaImcoSR26x
        QIT5JDoO/4UK80p0tAlBdCpLTL88gRXClpQ4+PocM0SJh8T7916Q4AGG7ue3J1knMMrPQvLY
        LCTLIGwdiQW7P7HNAmpnFpCWWP6PA8LUlFi/S38BI+sqRrHUguLc9NRiowJDeFQn5+duYgSn
        Vi3XHYyT337QO8TIxMF4iFGCg1lJhPcOu3CSEG9KYmVValF+fFFpTmrxIUZTYDRNZJYSTc4H
        Jve8knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1MFS0eFlHG7h9n
        3Fhz8/x8vb7pxzb/+3yP6Ul32ud7Fnv8rOqMpPUym99ITVrt9uN6mxtXeLFcdv/u/k07Jrec
        fzNh/xw+3itKDef+Lo462O7lkCYa0tLv4r//xK+1cWLvX33+1cK61/jJ6hq1jfxlb45UnIqy
        Ln5w0tlmm7y54d2Q6VebnBc+nOdz+17pl10rf+fVLkl/wJhg12r9L2zhGo2yjCPJgSEMHQsP
        tb7w/pyot+Tf+5Utgub2fX9Ls97Ofs7/Vf25+q3w/kQWgbdmAvr3PU5FG1l9lvzExLyrfKWC
        1hJhj/gJUYdl92xbpinRaJIjnTajIu2MWN6WxNMKn/quGBlbWDn09syz6ohQYinOSDTUYi4q
        TgQAb6xpjjYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnO4qX+Ekg/n/tS3mrF/DZnGs7Qm7
        xdZviRbNi9ezWVzeNYfNYtGyVmaLrXuvslscvH+O2YHD49+JNWwejTdusHlsWtXJ5nFixm8W
        j/1z17B7PJj0htHj8ya5APYoLpuU1JzMstQifbsEroyW2XOYCyYJV7Q2PGBvYHzG38XIySEh
        YCLRNecZaxcjF4eQwG5GieebV7BDJCQlls69AWULS9xvOcIKYgsJPGKU2D5JCsRmEVCV+Lr0
        AyOIzSagJXHvxwlmEFtEwFii/+wsdpChzALzmCS+HfkP1iws4CHRcOkSG4jNK6AjcefFWiaI
        zTsYJXZ/v8MKkRCUODnzCQuIzQw09ca/l0BFHEC2tMTyfxwgYU4BTYmNU0+xg4RFBVQkXh2s
        n8AoOAtJ8ywkzbMQmhcwMq9ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiODy3NHYzb
        V33QO8TIxMF4iFGCg1lJhPcOu3CSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tS
        s1NTC1KLYLJMHJxSDUwpSrrWufmGen1hHw2eC54o/TZ9hsLEZRrmWc7vb60xYV7YzLrhXXvH
        kTiH9zXq989v+aPa0n6k7d7y55+e9V0+K227xuVlVsj/ktsBib7+H4PuVn6InrT88w6OdZ4f
        4lYaiQQ82LN596dpV5XXeiSopbc6TS/jP+Cj+oR7jsavJ/Xrk57L+j8rkHPL4OjMl1ao/KCT
        fk+qoH/7YWMVV4HUdK0zZyJvelc+4Q3OD5GRe3Zz3rKir+/qkj92vTF4oDn/ddOZA2kX900t
        6/3mq/BRMG1O+ZLay2UzAsSZj3atef2cpYeHP+O05h3OA6efNr2M9kwS2q7/Ym6JUu/+C8J1
        76WDSsWD+Cas4Qk+Vq3EUpyRaKjFXFScCAAPk52B/gIAAA==
X-CMS-MailID: 20220221083034epcas2p1c745614d557143a5cebc808bfd71f01f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_11fe69_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220218053230epcas2p1c63c8b28e7448988727221e0265c64fc
References: <CGME20220218053230epcas2p1c63c8b28e7448988727221e0265c64fc@epcas2p1.samsung.com>
        <1645162195-54476-1-git-send-email-dh10.jung@samsung.com>
        <Yg9ReVfKxHUPOTvZ@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_11fe69_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Feb 18, 2022 at 08:57:45AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 18, 2022 at 02:29:55PM +0900, Daehwan Jung wrote:
> > There's no lock for rndis response list. It could cause list corruption
> > if two different list_add at the same time like below.
> > It's better to add in rndis_add_response / rndis_free_response
> > / rndis_get_next_response to prevent any race condition on response list.
> > 
> > [  361.894299] [1:   irq/191-dwc3:16979] list_add corruption.
> > next->prev should be prev (ffffff80651764d0),
> > but was ffffff883dc36f80. (next=ffffff80651764d0).
> > 
> > [  361.904380] [1:   irq/191-dwc3:16979] Call trace:
> > [  361.904391] [1:   irq/191-dwc3:16979]  __list_add_valid+0x74/0x90
> > [  361.904401] [1:   irq/191-dwc3:16979]  rndis_msg_parser+0x168/0x8c0
> > [  361.904409] [1:   irq/191-dwc3:16979]  rndis_command_complete+0x24/0x84
> > [  361.904417] [1:   irq/191-dwc3:16979]  usb_gadget_giveback_request+0x20/0xe4
> > [  361.904426] [1:   irq/191-dwc3:16979]  dwc3_gadget_giveback+0x44/0x60
> > [  361.904434] [1:   irq/191-dwc3:16979]  dwc3_ep0_complete_data+0x1e8/0x3a0
> > [  361.904442] [1:   irq/191-dwc3:16979]  dwc3_ep0_interrupt+0x29c/0x3dc
> > [  361.904450] [1:   irq/191-dwc3:16979]  dwc3_process_event_entry+0x78/0x6cc
> > [  361.904457] [1:   irq/191-dwc3:16979]  dwc3_process_event_buf+0xa0/0x1ec
> > [  361.904465] [1:   irq/191-dwc3:16979]  dwc3_thread_interrupt+0x34/0x5c
> > 
> > Fixes: f6281af9d62e ("usb: gadget: rndis: use list_for_each_entry_safe")
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/gadget/function/rndis.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
> > index b7ccf1803656..b4d58324e2d2 100644
> > --- a/drivers/usb/gadget/function/rndis.c
> > +++ b/drivers/usb/gadget/function/rndis.c
> > @@ -1011,16 +1011,21 @@ void rndis_add_hdr(struct sk_buff *skb)
> >  }
> >  EXPORT_SYMBOL_GPL(rndis_add_hdr);
> >  
> > +/* add spinlock to prevent race condition for rndis response list */
> > +static DEFINE_SPINLOCK(resp_lock);
> 
> Shouldn't this be one lock per rndis_params structure, and not a global
> one for the whole driver?
> 
I agree with your comment. I'm going to modify and push it again.
Thanks for the comment.

Best Regards,
Jung Daehwan

> thanks,
> 
> greg k-h
> 

------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_11fe69_
Content-Type: text/plain; charset="utf-8"


------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_11fe69_--
