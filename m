Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD74A61FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiBARKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:10:50 -0500
Received: from foss.arm.com ([217.140.110.172]:52690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240258AbiBARKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:10:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10EE36D;
        Tue,  1 Feb 2022 09:10:45 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A203D3F40C;
        Tue,  1 Feb 2022 09:10:42 -0800 (PST)
Message-ID: <90333cef-9ad1-bbf5-5c46-86083c1f5b24@arm.com>
Date:   Tue, 1 Feb 2022 17:10:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC] ARM: sa1100/assabet: move dmabounce hack to ohci driver
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220201150339.1028032-1-arnd@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220201150339.1028032-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-01 15:02, Arnd Bergmann wrote:
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
>   - dmabounce is only initialized on assabet and pfs168, but not on
>     any other sa1100 or pxa platform using sa1111.

Hmm, my reading of it was different. AFAICS it should affect all 
platforms with CONFIG_ARCH_SA1100 + CONFIG_SA1111 - the bus notifier 
from sa1111_init() will initialise dmabounce for everything where 
sa1111_configure_smc() has punched a hole in the DMA mask to handle the 
addressing erratum. sa1111_needs_bounce() looks to be a further 
consideration for platforms where DMA *additionally* cannot target an 
entire bank of memory at all.

>   - pfs168 is not supported in mainline Linux.
> 
>   - only the OHCI and audio devices on sa1111 support DMA
> 
>   - There is no audio driver for this hardware
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
>   - rather than using a dynamically sized pool, this buffer needs
>     to be allocated at probe time using a fixed size. Without
>     having any idea of what it should be, I picked a size of
>     64KB, which is between what the other two OHCI front-ends use
>     in their SRAM. If anyone has a better idea what that size
>     is reasonable, this can be trivially changed.
> 
>   - Previously, only USB transfers to the second memory bank
>     on Assabet needed to go through the bounce buffer, now all
>     of them do, which may impact runtime performance, depending
>     on what type of device is attached.

As above, bouncing should also happen for every other 1/8/16/32MB 
(depending on configuration) of memory, see the "Figure out if we need 
to bounce from the DMA mask" case in needs_bounce().

Thanks,
Robin.

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
> ---
>   arch/arm/common/Kconfig        |  1 -
>   arch/arm/common/sa1111.c       | 64 ----------------------------------
>   drivers/usb/core/hcd.c         | 17 +++++++--
>   drivers/usb/host/ohci-sa1111.c | 16 +++++++++
>   4 files changed, 30 insertions(+), 68 deletions(-)
> 
> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index c8e198631d41..286ea014c015 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   config SA1111
>   	bool
> -	select DMABOUNCE if !ARCH_PXA
>   
>   config DMABOUNCE
>   	bool
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index 7df003b149c6..a00915883f78 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -1391,70 +1391,9 @@ void sa1111_driver_unregister(struct sa1111_driver *driver)
>   }
>   EXPORT_SYMBOL(sa1111_driver_unregister);
>   
> -#ifdef CONFIG_DMABOUNCE
> -/*
> - * According to the "Intel StrongARM SA-1111 Microprocessor Companion
> - * Chip Specification Update" (June 2000), erratum #7, there is a
> - * significant bug in the SA1111 SDRAM shared memory controller.  If
> - * an access to a region of memory above 1MB relative to the bank base,
> - * it is important that address bit 10 _NOT_ be asserted. Depending
> - * on the configuration of the RAM, bit 10 may correspond to one
> - * of several different (processor-relative) address bits.
> - *
> - * This routine only identifies whether or not a given DMA address
> - * is susceptible to the bug.
> - *
> - * This should only get called for sa1111_device types due to the
> - * way we configure our device dma_masks.
> - */
> -static int sa1111_needs_bounce(struct device *dev, dma_addr_t addr, size_t size)
> -{
> -	/*
> -	 * Section 4.6 of the "Intel StrongARM SA-1111 Development Module
> -	 * User's Guide" mentions that jumpers R51 and R52 control the
> -	 * target of SA-1111 DMA (either SDRAM bank 0 on Assabet, or
> -	 * SDRAM bank 1 on Neponset). The default configuration selects
> -	 * Assabet, so any address in bank 1 is necessarily invalid.
> -	 */
> -	return (machine_is_assabet() || machine_is_pfs168()) &&
> -		(addr >= 0xc8000000 || (addr + size) >= 0xc8000000);
> -}
> -
> -static int sa1111_notifier_call(struct notifier_block *n, unsigned long action,
> -	void *data)
> -{
> -	struct sa1111_dev *dev = to_sa1111_device(data);
> -
> -	switch (action) {
> -	case BUS_NOTIFY_ADD_DEVICE:
> -		if (dev->dev.dma_mask && dev->dma_mask < 0xffffffffUL) {
> -			int ret = dmabounce_register_dev(&dev->dev, 1024, 4096,
> -					sa1111_needs_bounce);
> -			if (ret)
> -				dev_err(&dev->dev, "failed to register with dmabounce: %d\n", ret);
> -		}
> -		break;
> -
> -	case BUS_NOTIFY_DEL_DEVICE:
> -		if (dev->dev.dma_mask && dev->dma_mask < 0xffffffffUL)
> -			dmabounce_unregister_dev(&dev->dev);
> -		break;
> -	}
> -	return NOTIFY_OK;
> -}
> -
> -static struct notifier_block sa1111_bus_notifier = {
> -	.notifier_call = sa1111_notifier_call,
> -};
> -#endif
> -
>   static int __init sa1111_init(void)
>   {
>   	int ret = bus_register(&sa1111_bus_type);
> -#ifdef CONFIG_DMABOUNCE
> -	if (ret == 0)
> -		bus_register_notifier(&sa1111_bus_type, &sa1111_bus_notifier);
> -#endif
>   	if (ret == 0)
>   		platform_driver_register(&sa1111_device_driver);
>   	return ret;
> @@ -1463,9 +1402,6 @@ static int __init sa1111_init(void)
>   static void __exit sa1111_exit(void)
>   {
>   	platform_driver_unregister(&sa1111_device_driver);
> -#ifdef CONFIG_DMABOUNCE
> -	bus_unregister_notifier(&sa1111_bus_type, &sa1111_bus_notifier);
> -#endif
>   	bus_unregister(&sa1111_bus_type);
>   }
>   
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 3c7c64ff3c0a..5f2fa46c7958 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1260,7 +1260,8 @@ void usb_hcd_unlink_urb_from_ep(struct usb_hcd *hcd, struct urb *urb)
>   EXPORT_SYMBOL_GPL(usb_hcd_unlink_urb_from_ep);
>   
>   /*
> - * Some usb host controllers can only perform dma using a small SRAM area.
> + * Some usb host controllers can only perform dma using a small SRAM area,
> + * or that have restrictions in addressable DRAM.
>    * The usb core itself is however optimized for host controllers that can dma
>    * using regular system memory - like pci devices doing bus mastering.
>    *
> @@ -3095,8 +3096,18 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
>   	if (IS_ERR(hcd->localmem_pool))
>   		return PTR_ERR(hcd->localmem_pool);
>   
> -	local_mem = devm_memremap(hcd->self.sysdev, phys_addr,
> -				  size, MEMREMAP_WC);
> +	/*
> +	 * if a physical SRAM address was passed, map it, otherwise
> +	 * allocate system memory as a buffer.
> +	 */
> +	if (phys_addr)
> +		local_mem = devm_memremap(hcd->self.sysdev, phys_addr,
> +					  size, MEMREMAP_WC);
> +	else
> +		local_mem = dmam_alloc_attrs(hcd->self.sysdev, size, &dma,
> +					     GFP_KERNEL,
> +					     DMA_ATTR_WRITE_COMBINE);
> +
>   	if (IS_ERR(local_mem))
>   		return PTR_ERR(local_mem);
>   
> diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
> index 137f66f6977f..488033f2e144 100644
> --- a/drivers/usb/host/ohci-sa1111.c
> +++ b/drivers/usb/host/ohci-sa1111.c
> @@ -206,6 +206,22 @@ static int ohci_hcd_sa1111_probe(struct sa1111_dev *dev)
>   		goto err1;
>   	}
>   
> +	/*
> +	 * Section 4.6 of the "Intel StrongARM SA-1111 Development Module
> +	 * User's Guide" mentions that jumpers R51 and R52 control the
> +	 * target of SA-1111 DMA (either SDRAM bank 0 on Assabet, or
> +	 * SDRAM bank 1 on Neponset). The default configuration selects
> +	 * Assabet, so any address in bank 1 is necessarily invalid.
> +	 *
> +	 * As a workaround, use a bounce buffer in addressable memory
> +	 * as local_mem.
> +	 */
> +	if (machine_is_assabet()) {
> +		ret = usb_hcd_setup_local_mem(hcd, 0, 0, SZ_64K);
> +		if (ret)
> +			goto out_err1;
> +	}
> +
>   	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
>   		dev_dbg(&dev->dev, "request_mem_region failed\n");
>   		ret = -EBUSY;
