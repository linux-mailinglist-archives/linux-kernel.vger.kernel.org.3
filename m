Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D21581831
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiGZRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiGZRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:12:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165E515FCC;
        Tue, 26 Jul 2022 10:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8C2CB81331;
        Tue, 26 Jul 2022 17:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C77C433C1;
        Tue, 26 Jul 2022 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658855558;
        bh=I5L3LvKv68IAD10HrqwcscAmQZ08TkvfOSypJ6/caXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDll94BYdlRdFQUmMC7z2RNeEeIT1jETdAivCSucvHHkqdcEnLXPkOifTORYfWh8v
         aWvdmM7dckf94CRWyrYjHPeOeqkDs8EcariObsx/53H8aVI/nvV5dGqS5TlIghJrDb
         z6bs1C2Z0tKSj6TXv+T32lWeB5lqLo9yK+fn3PlY=
Date:   Tue, 26 Jul 2022 19:12:35 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Andy Guo =?utf-8?B?KOmDreWNq+aWjCk=?= <guoweibin@inspur.com>
Cc:     "b-liu@ti.com" <b-liu@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix musb_gadget.c rxstate may cause
 request->buf overflow problems
Message-ID: <YuAggxK2DA72FSZh@kroah.com>
References: <59fe30106aec46ff9ec1261fbb609606@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59fe30106aec46ff9ec1261fbb609606@inspur.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 01:59:48AM +0000, Andy Guo (郭卫斌) wrote:
> when the rxstate function executes the 'goto buffer_aint_mapped' code
> branch, it will always copy the fifocnt bytes data to request->buf,
> which may cause request->buf out of bounds. for Ethernet-over-USB will
> cause skb_over_panic when a packet larger than mtu is recived.
> 
> Fix it by add the length check :
> fifocnt = min_t(unsigned, request->length - request->actual, fifocnt);
> 
> Signed-off-by: guoweibin < <mailto:guoweibin@inspur.com>
> guoweibin@inspur.com>
> ---
>  drivers/usb/musb/musb_gadget.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 51274b87f46c..4ad5a1f31d7e 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -760,6 +760,7 @@ static void rxstate(struct musb *musb, struct
> musb_request *req)
>   musb_writew(epio, MUSB_RXCSR, csr);
>  
>  buffer_aint_mapped:
> + fifo_count = min_t(unsigned, request->length - request->actual,
> fifo_count);
>   musb_read_fifo(musb_ep->hw_ep, fifo_count, (u8 *)
>   (request->buf + request->actual));
>   request->actual += fifo_count;
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

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
