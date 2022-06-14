Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1A54B575
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356593AbiFNQH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356436AbiFNQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:07:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C531355
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:07:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F4C3B818E9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0695C3411C;
        Tue, 14 Jun 2022 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655222869;
        bh=CvK4H2JhfLSeydKjsOxaZRUzbWFeeDXWVJ8g0pCp1mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jsO0T9u9fPzltYlTEu0r7c7N3/VPq4dG88/SmhunFsor3fP0hOrv6mfOnKJoOwta6
         xW5SADrFFOEdfuY5HbNmvC2CQypvWz6RI6IdBS8N0acreRzDj94/Y2Wk0mxECtE+nN
         nUvXS/WO/Pfx0wNuXd3+3e0zNBuNx5e+M7qsOEPg=
Date:   Tue, 14 Jun 2022 18:07:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhi Song <zhi.song@bytedance.com>
Cc:     vilhelm.gray@gmail.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isa: put_device after failing to device_register
Message-ID: <YqiyUjCahmYG7bIa@kroah.com>
References: <20220614160126.1739982-1-zhi.song@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614160126.1739982-1-zhi.song@bytedance.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:01:26AM +0800, Zhi Song wrote:
> device_register() is used to register a device with the system.
> We need to call put_device() to give up the reference initialized
> in device_register() when it returns an error and this will clean
> up correctly.
> 
> Signed-off-by: Zhi Song <zhi.song@bytedance.com>
> ---
>  drivers/base/isa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/isa.c b/drivers/base/isa.c
> index 55e3ee2da98f..cf88f3d77b7d 100644
> --- a/drivers/base/isa.c
> +++ b/drivers/base/isa.c
> @@ -173,8 +173,10 @@ static int __init isa_bus_init(void)
>  	error = bus_register(&isa_bus_type);
>  	if (!error) {
>  		error = device_register(&isa_bus);
> -		if (error)
> +		if (error) {
> +			put_device(&isa_bus);
>  			bus_unregister(&isa_bus_type);
> +		}
>  	}
>  	return error;
>  }
> -- 
> 2.30.2
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
