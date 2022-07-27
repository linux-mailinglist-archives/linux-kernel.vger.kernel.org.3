Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE6558230B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiG0JZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiG0JZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCF75F93;
        Wed, 27 Jul 2022 02:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D7B461793;
        Wed, 27 Jul 2022 09:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A8AC433D7;
        Wed, 27 Jul 2022 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658913943;
        bh=7plC1FNzgarZx4ZMqwPL4bhSO98RGTgZpyEfnpz5Q1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmkfXNhRKNzesoJN+XiQKkHlxf4fmPVTapaLIkbnxxvm1KWK/h59bOK86XRLApzCc
         b58k+4Vrhx8tB5EE/HEK54x52YVbNlj9NgKDKXs9uUvW0O/CMOc4nq+SLwPZ2IgCis
         Q5aXCAIjMpOlU9YlFjyHS5mJjJfDz2NLPTax2SSQ=
Date:   Wed, 27 Jul 2022 11:25:40 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Andy Guo =?utf-8?B?KOmDreWNq+aWjCk=?= <guoweibin@inspur.com>
Cc:     "b-liu@ti.com" <b-liu@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: musb: Fix musb_gadget.c rxstate may cause
 request->buf overflow problems
Message-ID: <YuEElC563HN5ldMu@kroah.com>
References: <200f38d3e3eb44ec8ec8f8e9f210f131@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200f38d3e3eb44ec8ec8f8e9f210f131@inspur.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 08:43:34AM +0000, Andy Guo (郭卫斌) wrote:
> From: guoweibin <guoweibin@inspur.com>

Your From: in your email has your real name, why not use that instead of
just putting your email alias here?

> 
> when the rxstate function executes the 'goto buffer_aint_mapped' code
> branch, it will always copy the fifocnt bytes data to request->buf,
> which may cause request->buf out of bounds. for Ethernet-over-USB will
> cause skb_over_panic when a packet larger than mtu is recived.

How can we get a bigger packet than mtu?

> 
> Fix it by add the length check :
> fifocnt = min_t(unsigned, request->length - request->actual, fifocnt);
> 
> Signed-off-by: guoweibin <guoweibin@inspur.com>

Same here.

> ---
>  v2:
> -fix format error
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

Why the case to "unsigned"?

And if we get a too big packet, shouldn't we drop it?

And what does this have to do with a usb-ethernet device, this is in the
generic musb code, not an ethernet driver.

thanks,

greg k-h
