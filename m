Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81155FA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiF2IYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiF2IYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:24:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10103BF83;
        Wed, 29 Jun 2022 01:24:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEF50B8219E;
        Wed, 29 Jun 2022 08:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E87C34114;
        Wed, 29 Jun 2022 08:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656491051;
        bh=oNFvciFtBXFVvkTYaTZDy44e9cB6/PJkGktJZOcWT3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wF89c+l/CdVkTKtsn81Bnd/q3QFN086ZA19R/1Hm8HuXbuJWKQ9kyB5fK1rwkqpSG
         T7APdqXPWeJJC8+gT+EpgjqGt634cFs7K9ct96yBeotcIxoASABP9z5LbzD58C7HZE
         bZ7j1C7QWyG7TRsK8DlozAhZtsU7WBsqAgGAZKYA=
Date:   Wed, 29 Jun 2022 10:24:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     SebinSebastian <mailmesebin00@gmail.com>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: gadget: dereference before null check
Message-ID: <YrwMJ+3mdFO2Lpm0@kroah.com>
References: <20220629080726.107297-1-mailmesebin00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629080726.107297-1-mailmesebin00@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 01:37:25PM +0530, SebinSebastian wrote:
> Fix coverity warning dereferencing before null check. _ep and desc is
> dereferenced on all paths until the check for null. Move the
> initializations after the check for null.
> Coverity issue: 1518209
> 
> Signed-off-by: SebinSebastian <mailmesebin00@gmail.com>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index d75a4e070bf7..96f8193fca15 100644
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
> @@ -356,6 +352,11 @@ static int ast_udc_ep_enable(struct usb_ep *_ep,
>  		return -EINVAL;
>  	}
> 
> +	u16 maxpacket = usb_endpoint_maxp(desc);
> +	struct ast_udc_ep *ep = to_ast_ep(_ep);
> +	struct ast_udc_dev *udc = ep->udc;
> +	u8 epnum = usb_endpoint_num(desc);
> +
>  	if (!udc->driver) {
>  		EP_DBG(ep, "bogus device state\n");
>  		return -ESHUTDOWN;
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
