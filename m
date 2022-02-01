Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0913F4A6029
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiBAPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:31:04 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40309 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S240354AbiBAPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:31:01 -0500
Received: (qmail 308126 invoked by uid 1000); 1 Feb 2022 10:31:01 -0500
Date:   Tue, 1 Feb 2022 10:31:01 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] ARM: sa1100/assabet: move dmabounce hack to ohci driver
Message-ID: <YflSNQQvignxL4PA@rowland.harvard.edu>
References: <20220201150339.1028032-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201150339.1028032-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 04:02:48PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sa1111 platform is one of the two remaining users of the old Arm
> specific "dmabounce" code, which is an earlier implementation of the
> generic swiotlb.
> 
> Linus Walleij submitted a patch that removes dmabounce support from
> the ixp4xx, and I had a look at the other user, which is the sa1111
> companion chip.
> 
> Looking at how dmabounce is used, I could narrow it down to one driver
> one one machine:
> 
>  - dmabounce is only initialized on assabet and pfs168, but not on
>    any other sa1100 or pxa platform using sa1111.
> 
>  - pfs168 is not supported in mainline Linux.
> 
>  - only the OHCI and audio devices on sa1111 support DMA
> 
>  - There is no audio driver for this hardware
> 
> In the OHCI code, I noticed that two other platforms already have
> a local bounce buffer support in the form of the "local_mem"
> allocator. Specifically, TMIO and SM501 use this on a few other ARM
> boards with 16KB or 128KB of local SRAM that can be accessed from the
> OHCI and from the CPU.
> 
> While this is not the same problem as on sa1111, I could not find a
> reason why we can't re-use the existing implementation but replace the
> physical SRAM address mapping with a locally allocated DMA buffer.
> 
> There are two main downsides:
> 
>  - rather than using a dynamically sized pool, this buffer needs
>    to be allocated at probe time using a fixed size. Without
>    having any idea of what it should be, I picked a size of
>    64KB, which is between what the other two OHCI front-ends use
>    in their SRAM. If anyone has a better idea what that size
>    is reasonable, this can be trivially changed.
> 
>  - Previously, only USB transfers to the second memory bank
>    on Assabet needed to go through the bounce buffer, now all
>    of them do, which may impact runtime performance, depending
>    on what type of device is attached.
> 
> On the upside, the local_mem support uses write-combining
> buffers, which should be a bit faster for transfers to the device
> compared to normal uncached coherent memory as used in dmabounce.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I don't have this hardware, so the patch is not tested at all.


> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 3c7c64ff3c0a..5f2fa46c7958 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1260,7 +1260,8 @@ void usb_hcd_unlink_urb_from_ep(struct usb_hcd *hcd, struct urb *urb)
>  EXPORT_SYMBOL_GPL(usb_hcd_unlink_urb_from_ep);
>  
>  /*
> - * Some usb host controllers can only perform dma using a small SRAM area.
> + * Some usb host controllers can only perform dma using a small SRAM area,
> + * or that have restrictions in addressable DRAM.

s/that //
s/in/on/

Otherwise the USB parts of this look okay to me.  I don't have suitable 
hardware to test either.  (I wonder if anyone is still using this 
platform...)

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
