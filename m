Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15034CECF9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 19:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiCFSBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 13:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiCFSBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 13:01:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126763EF37;
        Sun,  6 Mar 2022 10:00:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2AA9B80EBE;
        Sun,  6 Mar 2022 18:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6463AC340EC;
        Sun,  6 Mar 2022 18:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646589605;
        bh=HZP74ZA4RW2ibfRByAf5KWvT/L7pk7G/fjmfHeBhJD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPFmLs3H6+2+NS3g3jxd6sVwEX3G8BorFRhHe5/+q54jru0FUXLK9xUYb+4B6eB+2
         iWPwoBI4Fh3j6h9WJQNO+ojbIM2SoUsM+v6y0hEQHFyVVio3gKIDsqnVFbJfoaWaXQ
         4hD4RDZMKn7uDHG3kb9yPMFQGisOh3cdrINAtU7w=
Date:   Sun, 6 Mar 2022 19:00:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH 25/26] usb: gadget: dummy_hcd: replace usage of rc to
 check if a list element was found
Message-ID: <YiT2odfvXhp4nsK4@kroah.com>
References: <20220306175034.3084609-1-jakobkoschel@gmail.com>
 <20220306175034.3084609-26-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306175034.3084609-26-jakobkoschel@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 06:50:33PM +0100, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable [1].
> 
> This removes the need to check the rc value to determine if the
> break/goto was hit and can be made more obvious
> by checking if the variable was set within the list traversal loop.
> 
> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/usb/gadget/udc/dummy_hcd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index a2d956af42a2..f21944707707 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -751,7 +751,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  	struct dummy		*dum;
>  	int			retval = -EINVAL;
>  	unsigned long		flags;
> -	struct dummy_request	*req = NULL;
> +	struct dummy_request	*req = NULL, *tmp;
>  
>  	if (!_ep || !_req)
>  		return retval;
> @@ -763,17 +763,18 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  
>  	local_irq_save(flags);
>  	spin_lock(&dum->lock);
> -	list_for_each_entry(req, &ep->queue, queue) {
> -		if (&req->req == _req) {
> -			list_del_init(&req->queue);
> +	list_for_each_entry(tmp, &ep->queue, queue) {
> +		if (&tmp->req == _req) {
> +			list_del_init(&tmp->queue);
>  			_req->status = -ECONNRESET;
> +			req = tmp;
>  			retval = 0;
>  			break;
>  		}
>  	}
>  	spin_unlock(&dum->lock);
>  
> -	if (retval == 0) {
> +	if (req) {

There's no need for this change as we are testing retval, not req here,
unlike the other udc drivers.

So this one I think is correct as-is, or am I mistaken somehow?

thanks,

greg k-h
