Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F107F481A17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhL3HCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhL3HCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:02:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727EC061574;
        Wed, 29 Dec 2021 23:02:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09639615F1;
        Thu, 30 Dec 2021 07:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F5CC36AE7;
        Thu, 30 Dec 2021 07:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640847723;
        bh=VOYtPtyXkEZQkutvcvhc2hJhJdTQcbjO+K8vv34M0oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgO9MxhpzmXAdS/qlgoN+8MCLMpP7SDlNUYYNU27cKsROZe6CuypFa2rsiJpV8vQn
         Md5bgFUsO137kpnPNXICsmsJUjPE2uuqffMmFJv+JEbMtkXr/NuFoafWSlLPj1hQrY
         kF0h2xp2F7tYo/Wm65599CMb61IOXW1fvaeIlI48=
Date:   Thu, 30 Dec 2021 08:02:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux] usb: xhci-ring: Add return if ret is less than 0
Message-ID: <Yc1ZaOsmoZHoWyxt@kroah.com>
References: <20211230064010.586496-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230064010.586496-1-luo.penghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 06:40:10AM +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> For the robustness of the code, judgment and return should be added here

I do not understand this changelog text at all.  Please explain the
problem and why you are making this change much better.

> 
> The clang_analyzer complains as follows:
> 
> drivers/usb/host/xhci-ring.c:
> 
> Value stored to 'ret' is never read
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>  drivers/usb/host/xhci-ring.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index d0b6806..c4eefe2 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -3721,6 +3721,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
>  		ret = prepare_transfer(xhci, xhci->devs[slot_id],
>  				       ep_index, urb->stream_id,
>  				       1, urb, 1, mem_flags);
> +		if (unlikely(ret < 0))
> +			return ret;
>  		urb_priv->td[1].last_trb = ring->enqueue;
>  		urb_priv->td[1].last_trb_seg = ring->enq_seg;
>  		field = TRB_TYPE(TRB_NORMAL) | ring->cycle_state | TRB_IOC;
> -- 
> 2.15.2
> 
> 

How did you test this change?

thanks,

greg k-h
