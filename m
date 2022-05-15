Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13752765E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 10:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiEOIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 04:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiEOIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 04:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6A22BCA
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 01:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DF7860CBA
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93649C385B8;
        Sun, 15 May 2022 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652602063;
        bh=Q64AhienHy94BCU9s84kotZtczJvQigVt038jtD6lkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHxXy23jc7ju5x23LjW5wlynfkwletItR1IuLY9fefCX6Ko3XSH34iEJvlGS2bPr5
         f9jXVByL91gGvJuoPCsgmMFINV6eAs/D54kCLSsrL5mdIh4kKRTnbhnIdb4Qq/2ZBe
         ooSYZMBqWQgFVdq2W7WnYDZDKVVGTLwe2Z7OkB4U=
Date:   Sun, 15 May 2022 10:07:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH 1/3] char: lp: ensure that index has not exceeded LP_NO
Message-ID: <YoC0yg5FWDxJocV5@kroah.com>
References: <20220515075455.306082-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515075455.306082-1-sshedi@vmware.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 01:24:53PM +0530, Shreenidhi Shedi wrote:
> After finishing the loop, index value can be equal to LP_NO and lp_table
> array is of size LP_NO, so this can end up in accessing an out of bound
> address in lp_register function.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  drivers/char/lp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index bd95aba1f..e61060f3c 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -971,7 +971,7 @@ static void lp_attach(struct parport *port)
>  			if (port_num[i] == -1)
>  				break;
>  
> -		if (!lp_register(i, port))
> +		if (i < LP_NO && !lp_register(i, port))
>  			lp_count++;
>  		break;
>  
> -- 
> 2.36.1
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
