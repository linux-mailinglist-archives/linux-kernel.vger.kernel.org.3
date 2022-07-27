Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF1582120
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiG0HdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiG0HdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41E213F24;
        Wed, 27 Jul 2022 00:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6712E615E0;
        Wed, 27 Jul 2022 07:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B2C433D6;
        Wed, 27 Jul 2022 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658907189;
        bh=98UvVK1hQ5nxz3e59OpZYvviPSmMObiqhZm0riCYgm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umd2TjCpVeA8NoflpwamOYbEhjZGSoco4pRNEr6mO9vwE5ItP7vFXKZAyULUS9z7g
         9/+7TS6hvNXI0Vw7fDLfoanAsabQJYly5dt9byn1Cw+bLsagH0C5jeVZBq14t/a+hA
         1DmO0NklCZRy08FHbyk7Teby2+LVOLJsF9xbyykg=
Date:   Wed, 27 Jul 2022 09:33:06 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Andy Guo =?utf-8?B?KOmDreWNq+aWjCk=?= <guoweibin@inspur.com>
Cc:     "b-liu@ti.com" <b-liu@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix musb_gadget.c rxstate may cause
 request->buf overflow problems
Message-ID: <YuDqMpDBb27FbG3B@kroah.com>
References: <7acfffb210974cff959d056ef88221de@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7acfffb210974cff959d056ef88221de@inspur.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 07:21:39AM +0000, Andy Guo (郭卫斌) wrote:
> when the rxstate function executes the 'goto buffer_aint_mapped' code
> branch, it will always copy the fifocnt bytes data to request->buf,
> which may cause request->buf out of bounds. for Ethernet-over-USB will
> cause skb_over_panic when a packet larger than mtu is recived.
> 
> Fix it by add the length check :
> fifocnt = min_t(unsigned, request->length - request->actual, fifocnt);
> 
> Signed-off-by: guoweibin <guoweibin@inspur.com>
> ---
>  drivers/usb/musb/musb_gadget.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 51274b87f46c..4ad5a1f31d7e 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -760,6 +760,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
>  			musb_writew(epio, MUSB_RXCSR, csr);
>  
>  buffer_aint_mapped:
> +			fifo_count = min_t(unsigned, request->length - request->actual, fifo_count);
>  			musb_read_fifo(musb_ep->hw_ep, fifo_count, (u8 *)
>  					(request->buf + request->actual));
>  			request->actual += fifo_count;
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

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
