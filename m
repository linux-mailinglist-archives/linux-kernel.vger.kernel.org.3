Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC95E4BB3A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiBRH6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:58:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiBRH6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:58:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74207151D09;
        Thu, 17 Feb 2022 23:57:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F49561028;
        Fri, 18 Feb 2022 07:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0C1C340E9;
        Fri, 18 Feb 2022 07:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645171069;
        bh=1RjXsiu3Z6SS4o/E9a4X65asxgr+t4tHtpZNXouQhc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPYS2jFabTvnkMbQC77iAOAB25vBb+nAZUhtDb3CuoffF3jriH6wQss6h9EX85pQt
         AdTNny719PLHXh49AeUyXcgBkHcU3Db+BT5cZeC4PkA7qyrV/xx/LO0UpM1TWIHLNz
         CMOETdfRnGlB5XnVlHZ8HL/JTXe6Ty4CG0gIJPj8=
Date:   Fri, 18 Feb 2022 08:57:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-usb@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: usb: gadget: function: add spinlock for rndis response list
Message-ID: <Yg9ReVfKxHUPOTvZ@kroah.com>
References: <CGME20220218053230epcas2p1c63c8b28e7448988727221e0265c64fc@epcas2p1.samsung.com>
 <1645162195-54476-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645162195-54476-1-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 02:29:55PM +0900, Daehwan Jung wrote:
> There's no lock for rndis response list. It could cause list corruption
> if two different list_add at the same time like below.
> It's better to add in rndis_add_response / rndis_free_response
> / rndis_get_next_response to prevent any race condition on response list.
> 
> [  361.894299] [1:   irq/191-dwc3:16979] list_add corruption.
> next->prev should be prev (ffffff80651764d0),
> but was ffffff883dc36f80. (next=ffffff80651764d0).
> 
> [  361.904380] [1:   irq/191-dwc3:16979] Call trace:
> [  361.904391] [1:   irq/191-dwc3:16979]  __list_add_valid+0x74/0x90
> [  361.904401] [1:   irq/191-dwc3:16979]  rndis_msg_parser+0x168/0x8c0
> [  361.904409] [1:   irq/191-dwc3:16979]  rndis_command_complete+0x24/0x84
> [  361.904417] [1:   irq/191-dwc3:16979]  usb_gadget_giveback_request+0x20/0xe4
> [  361.904426] [1:   irq/191-dwc3:16979]  dwc3_gadget_giveback+0x44/0x60
> [  361.904434] [1:   irq/191-dwc3:16979]  dwc3_ep0_complete_data+0x1e8/0x3a0
> [  361.904442] [1:   irq/191-dwc3:16979]  dwc3_ep0_interrupt+0x29c/0x3dc
> [  361.904450] [1:   irq/191-dwc3:16979]  dwc3_process_event_entry+0x78/0x6cc
> [  361.904457] [1:   irq/191-dwc3:16979]  dwc3_process_event_buf+0xa0/0x1ec
> [  361.904465] [1:   irq/191-dwc3:16979]  dwc3_thread_interrupt+0x34/0x5c
> 
> Fixes: f6281af9d62e ("usb: gadget: rndis: use list_for_each_entry_safe")
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/gadget/function/rndis.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
> index b7ccf1803656..b4d58324e2d2 100644
> --- a/drivers/usb/gadget/function/rndis.c
> +++ b/drivers/usb/gadget/function/rndis.c
> @@ -1011,16 +1011,21 @@ void rndis_add_hdr(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL_GPL(rndis_add_hdr);
>  
> +/* add spinlock to prevent race condition for rndis response list */
> +static DEFINE_SPINLOCK(resp_lock);

Shouldn't this be one lock per rndis_params structure, and not a global
one for the whole driver?

thanks,

greg k-h
