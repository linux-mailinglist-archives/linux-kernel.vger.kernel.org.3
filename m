Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B13562C96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiGAH2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiGAH2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:28:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19744F12;
        Fri,  1 Jul 2022 00:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAAA6B82E39;
        Fri,  1 Jul 2022 07:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDC6C3411E;
        Fri,  1 Jul 2022 07:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656660487;
        bh=6fc1GPEDsMEmIu4v1lQpzTDaplwGABQ7ko3v9tdn9Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQEytv45vG/ejfXXOvJi0DhyCGLeK7KlGKTMuD10i9SW96bgwEHgs8dWNw8G0zEeM
         DhRLgsc1QOWlSjno7fxJ6AxClqTXXiTPGpu0cHuswFQXVk39+SKS/YO3UlF7AYooa6
         7IMo1nkZPHnN6Rd8d35gsOrME7mB8WwpNQ8lewUk=
Date:   Fri, 1 Jul 2022 09:28:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: host: xhci: Fix potential memory leak in
 xhci_alloc_stream_info()
Message-ID: <Yr6iBLYjioC6AHLg@kroah.com>
References: <20220701071002.2184370-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701071002.2184370-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:10:02PM +0800, Jianglei Nie wrote:
> xhci_alloc_stream_info() allocates stream context array for stream_info
> ->stream_ctx_array with xhci_alloc_stream_ctx(). When some error occurs,
> stream_info->stream_ctx_array is not released, which will lead to a
> memory leak.
> 
> We can fix it by releasing the stream_info->stream_ctx_array with
> xhci_free_stream_ctx() on the error path to avoid the potential memory
> leak.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/usb/host/xhci-mem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 8c19e151a945..9e56aa28efcd 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -641,7 +641,7 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
>  			num_stream_ctxs, &stream_info->ctx_array_dma,
>  			mem_flags);
>  	if (!stream_info->stream_ctx_array)
> -		goto cleanup_ctx;
> +		goto cleanup_ring_array;
>  	memset(stream_info->stream_ctx_array, 0,
>  			sizeof(struct xhci_stream_ctx)*num_stream_ctxs);
>  
> @@ -702,6 +702,11 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
>  	}
>  	xhci_free_command(xhci, stream_info->free_streams_command);
>  cleanup_ctx:
> +	xhci_free_stream_ctx(xhci,
> +		stream_info->num_stream_ctxs,
> +		stream_info->stream_ctx_array,
> +		stream_info->ctx_array_dma);
> +cleanup_ring_array:
>  	kfree(stream_info->stream_rings);
>  cleanup_info:
>  	kfree(stream_info);
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
