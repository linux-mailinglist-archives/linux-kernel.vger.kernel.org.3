Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45376516503
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348262AbiEAPm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiEAPm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 11:42:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E213017AAE;
        Sun,  1 May 2022 08:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BA3B60ECE;
        Sun,  1 May 2022 15:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FF9C385AE;
        Sun,  1 May 2022 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651419570;
        bh=IDs94/j7EVhpVcbaLpo+hUQVhDxmlGNKvAv4h1iJscs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbKgg2fbvlieEKjX3jJO2gBr42PPDiFuq0gE20pj7G1gHuEZnWNT8B2pmO5YVNN57
         +yY96leONI0UXkoBHA6clMea+jpwstccf7EENIHx4l+5smrlb8o1Qus8aYETMCb5Rt
         xJ4UO7vF0+iaTTY3e5I2HpXb/16ZcIcTtUc1QTtg=
Date:   Sun, 1 May 2022 17:39:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kushagra Verma <kushagra765@outlook.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB / dwc3: remove a possible unnecessary 'out of
 memory' message
Message-ID: <Ym6pp/O1fpneA5ZW@kroah.com>
References: <SI2PR01MB3929F20DA02363BD6A88657DF8FE9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB3929F20DA02363BD6A88657DF8FE9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 09:01:36PM +0530, Kushagra Verma wrote:
> This patch removes a possible unnecessary out of memory message from
> core.c
> as reported by checkpatch.pl:
>    WARNING: Possible unnecessary 'out of memory' message
> 
> Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
> ---
>  drivers/usb/dwc3/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 25c686a752b0..4ee787de2956 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -844,10 +844,8 @@ static void dwc3_set_incr_burst_type(struct dwc3
> *dwc)
>  		return;
>  
>  	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
> -	if (!vals) {
> -		dev_err(dev, "Error to get memory\n");
> +	if (!vals)
>  		return;
> -	}
>  
>  	/* Get INCR burst type, and parse it */
>  	ret = device_property_read_u32_array(dev,
> -- 
> 2.32.0
> 
> 
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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
