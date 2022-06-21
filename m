Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3EF55348D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351685AbiFUOc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351344AbiFUOcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:32:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AA424087;
        Tue, 21 Jun 2022 07:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB3B8B81868;
        Tue, 21 Jun 2022 14:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7E4C3411C;
        Tue, 21 Jun 2022 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655821939;
        bh=KfjXOObhxDdwXNq2fDjD9mTcNRlE8f7SvjMFa8jQmQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1l08kl25Xg/d6lAOCFAeB5HNLZuMUQc7UjyIZ6BELhHJOTUUSptA+jxLRKWP3m9Dr
         VMqBL5SUDtfAmm15iJKspKh9Lja8RaH6sc732wLJqhbShXetT9OdHYJuteezVPehGQ
         5IixOtxjDY+D2cXl7sDbgPAQ2EcNqkqFcBJPqgtQ=
Date:   Tue, 21 Jun 2022 16:32:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     olebowle@gmx.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH V2] usb: core: Remove redundant NULL checks before kfree
Message-ID: <YrHWcBo+l4IN6WWY@kroah.com>
References: <20220613013116.900591-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613013116.900591-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 01:31:16AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Checking a pointer for NULL before calling kfree() on it is redundant,
> kfree() deals with NULL pointers just fine.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
> v1->v2:
> 	remove "quirk_list = NULL"
>  drivers/usb/core/quirks.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index f99a65a64588..9ec12c42db30 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -56,10 +56,7 @@ static int quirks_param_set(const char *value, const
> struct kernel_param *kp)
>  		if (val[i] == ',')
>  			quirk_count++;
>  
> -	if (quirk_list) {
> -		kfree(quirk_list);
> -		quirk_list = NULL;
> -	}
> +	kfree(quirk_list);
>  
>  	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
>  			     GFP_KERNEL);
> -- 
> 2.25.1
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
