Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04355C5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbiF0MIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbiF0MHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:07:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A0CE18;
        Mon, 27 Jun 2022 05:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F27E961553;
        Mon, 27 Jun 2022 12:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074BFC3411D;
        Mon, 27 Jun 2022 12:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656331559;
        bh=jWx+ZB/3GO7W16Tms7wsdO71Vn4Hhk3NED6hLwj/3Vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTWHbxqbon+yqo7Ep8WyNw8mz35CvkkYAkzcH9ea4zDjnA9Alxwjz80BIpHvFK2+v
         Ywmkj5Zev1zNgqpkzu4iQQ+Jas5o0wktpqfIZvliDgdxwNlhXJmgZ2lAyEzFJ6i4sV
         kS9Jfw4+ZF7UgzZ/VpcNipeXVvqY8GtxcQlMf/bQ=
Date:   Mon, 27 Jun 2022 13:45:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhoun <zhounan@nfschina.com>
Cc:     balbi@kernel.org, jakobkoschel@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        lutovinova@ispras.ru
Subject: Re: [PATCH v2] usb: remove unnecessary mv_u3d* conversion
Message-ID: <YrmYRElMVwVz5tAr@kroah.com>
References: <YrV2aQc8lB6wDEbE@kroah.com>
 <20220627031108.12246-1-zhounan@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627031108.12246-1-zhounan@nfschina.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 11:11:08PM -0400, zhoun wrote:
> From: Zhou nan <zhounan@nfschina.com>
> 
> remove unnecessary mv_u3d* type casting.
> After analysis, the two u3d objects have the same type.
> 
> Signed-off-by: Zhou nan <zhounan@nfschina.com>
> ---
>  drivers/usb/gadget/udc/mv_u3d_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
> index 598654a3cb41..102278a71307 100644
> --- a/drivers/usb/gadget/udc/mv_u3d_core.c
> +++ b/drivers/usb/gadget/udc/mv_u3d_core.c
> @@ -175,7 +175,7 @@ void mv_u3d_done(struct mv_u3d_ep *ep, struct mv_u3d_req *req, int status)
>  	__releases(&ep->udc->lock)
>  	__acquires(&ep->udc->lock)
>  {
> -	struct mv_u3d *u3d = (struct mv_u3d *)ep->u3d;
> +	struct mv_u3d *u3d = ep->u3d;
>  
>  	dev_dbg(u3d->dev, "mv_u3d_done: remove req->queue\n");
>  	/* Removed the req from ep queue */
> -- 
> 2.27.0
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
