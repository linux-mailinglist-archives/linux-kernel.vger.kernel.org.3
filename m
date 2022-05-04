Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0151A250
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351428AbiEDOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351400AbiEDOi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:38:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E0C3B;
        Wed,  4 May 2022 07:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08FA6B825A5;
        Wed,  4 May 2022 14:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743CFC385A5;
        Wed,  4 May 2022 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651674916;
        bh=FpqXWG4km/rO5KQV/khRTb/6jDcIdGQHP3TKMQAPa9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZCJuy2GW/102BzQOqCgO3IixzxWNvXpJJGLfg9nFyS2sNSsZmVQfe7d45j/GAPEi
         aW4cZ5ZHVBvej2D5MKS6V1voGaM+qmzi7Kn44FMWS2BXjkGayVfYXu+/LlNKvf9n7h
         Yp/wmzw4l/GvpGH0n3J6HxB10RzYq8X+MZiMmnpA=
Date:   Wed, 4 May 2022 16:35:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     balbi@kernel.org, quic_jackp@quicinc.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: Fix null pointer dereference
Message-ID: <YnKPI4O7JloBqi0F@kroah.com>
References: <20220504072802.83487-1-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504072802.83487-1-albertccwang@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 03:28:02PM +0800, Albert Wang wrote:
> There are still race conditions to hit the null pointer deference
> with my previous commit. So I re-write the code to dereference the
> pointer right after checking it is not null.

What race conditions?

And just moving it is not going to solve a race condition, you need a
lock.

> 
> Fixes: 26288448120b ("usb: dwc3: gadget: Fix null pointer exception")
> 
> Signed-off-by: Albert Wang <albertccwang@google.com>
> ---
>  drivers/usb/dwc3/gadget.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 19477f4bbf54..f2792968afd9 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3366,15 +3366,14 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
>  	struct dwc3		*dwc = dep->dwc;
>  	bool			no_started_trb = true;
>  
> -	if (!dep->endpoint.desc)
> -		return no_started_trb;
> -
>  	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
>  
>  	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>  		goto out;
>  
> -	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
> +	if (!dep->endpoint.desc)
> +		return no_started_trb;
> +	else if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&

There is no locking here, so why would this change do anything but
reduce the window?

thanks,

greg k-h
