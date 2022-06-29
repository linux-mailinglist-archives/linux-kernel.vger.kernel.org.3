Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5455F608
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiF2GHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiF2GGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:06:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361F42983D;
        Tue, 28 Jun 2022 23:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8A2F2CE243D;
        Wed, 29 Jun 2022 06:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B903C34114;
        Wed, 29 Jun 2022 06:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656482795;
        bh=v+QrMFau7PMS8LMjF6or9QJ2YF6CwZpdYo1DW6OX/PM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wkuD9Lm/QUKbnK0gSvj9vKBqQtHURYHwsAti95fWhu9rdQna5+oi9b1X8O+lY3V3I
         rs1HyZWJOM71izFEI+7o9bSAHajpOaXqs3ZhMv9lBliLdckglEubgOvHNs7eeRiLni
         DmKzoq0+zvXc4f1rwgFC5rIrQboiMKnhqdkMgLN0=
Date:   Wed, 29 Jun 2022 08:06:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     SebinSebastian <mailmesebin00@gmail.com>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next] usb: gadget: dereference before null check
Message-ID: <Yrvr6A8YgyZuWQUz@kroah.com>
References: <20220629055605.102425-1-mailmesebin00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629055605.102425-1-mailmesebin00@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 11:26:05AM +0530, SebinSebastian wrote:
> From: Sebin Sebastian <mailmesebin00@gmail.com>
> 
> Fix coverity warning dereferencing before null check. _ep and desc is
> deferenced on all paths until the check for null. Move the
> initilizations after the check for null.
> Coverity issue: 1518209
> 
> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index d75a4e070bf7..4f158030e2cc 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -341,10 +341,6 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
>  static int ast_udc_ep_enable(struct usb_ep *_ep,
>  			     const struct usb_endpoint_descriptor *desc)
>  {
> -	u16 maxpacket = usb_endpoint_maxp(desc);
> -	struct ast_udc_ep *ep = to_ast_ep(_ep);
> -	struct ast_udc_dev *udc = ep->udc;
> -	u8 epnum = usb_endpoint_num(desc);
>  	unsigned long flags;
>  	u32 ep_conf = 0;
>  	u8 dir_in;
> @@ -355,6 +351,12 @@ static int ast_udc_ep_enable(struct usb_ep *_ep,
>  		EP_DBG(ep, "Failed, invalid EP enable param\n");
>  		return -EINVAL;
>  	}
> +
> +	u16 maxpacket = usb_endpoint_maxp(desc);
> +	struct ast_udc_ep *ep = to_ast_ep(_ep);
> +	struct ast_udc_dev *udc = ep->udc;
> +	u8 epnum = usb_endpoint_num(desc);
> +
>  
>  	if (!udc->driver) {
>  		EP_DBG(ep, "bogus device state\n");
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch breaks the build.

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
