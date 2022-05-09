Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF651FB3F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiEIL15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiEIL1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:27:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AE41E1232
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AAC85CE16A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBDFC385AB;
        Mon,  9 May 2022 11:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652095430;
        bh=4sMRxwWbMwSBqrLDZsezgT/k8hJeSkoZibqUfXtt7qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pF/NmeE6XgjgIua1ubBXkK4j0d5lGb1CXdf5x9jMUYp76LS7FWCGLud15PwRFcmVV
         c/FMBXdOgrFmC1EUU7/18Ug+Y3ZjXsceTJRvzxGvJJbV3E8uPUAG1qLXise2RkewWh
         pS1hw0mXCN1brGxMu8/ByNRC8jxuaA32bj2lV97o=
Date:   Mon, 9 May 2022 13:23:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: add missing iounmap() in dio_init()
Message-ID: <Ynj5wy5vkFaICkdi@kroah.com>
References: <20220509111840.764375-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509111840.764375-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 07:18:40PM +0800, Yang Yingliang wrote:
> Add iounmap() in error path of kzalloc().
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/dio/dio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
> index 005a82f671c3..0e5a5662d5a4 100644
> --- a/drivers/dio/dio.c
> +++ b/drivers/dio/dio.c
> @@ -216,8 +216,11 @@ static int __init dio_init(void)
>  
>  		/* Found a board, allocate it an entry in the list */
>  		dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
> -		if (!dev)
> +		if (!dev) {
> +			if (scode >= DIOII_SCBASE)
> +				iounmap(va);
>  			return -ENOMEM;
> +		}
>  
>  		dev->bus = &dio_bus;
>  		dev->dev.parent = &dio_bus.dev;
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
