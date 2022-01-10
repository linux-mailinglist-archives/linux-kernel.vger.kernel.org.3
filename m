Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499B3489EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiAJSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:16:33 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:58984 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiAJSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:16:33 -0500
Received: from [192.168.1.18] ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 6zDYnddNjBazo6zDYnCae6; Mon, 10 Jan 2022 19:16:31 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 10 Jan 2022 19:16:31 +0100
X-ME-IP: 90.11.185.88
Message-ID: <97ef1b73-a9a4-6018-d52c-4108ff9de7ca@wanadoo.fr>
Date:   Mon, 10 Jan 2022 19:16:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] virtio: Simplify DMA setting
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <fc97319a44d41d8b7eb127e1facdef4139ed77ac.1641625657.git.christophe.jaillet@wanadoo.fr>
 <42ba2840-bfa8-d530-4bcf-3eeee9403a31@redhat.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <42ba2840-bfa8-d530-4bcf-3eeee9403a31@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/01/2022 à 07:14, Jason Wang a écrit :
> 
> 在 2022/1/8 下午3:08, Christophe JAILLET 写道:
>> As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
>> dev->dma_mask is non-NULL.
>> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> 
> I'd expect to be more verbose here. E.g I see dma_supported() who has a 
> brunch of checks need to be called if dma_mask is non-NULL.
> 
> Thanks
> 
> 

Hi,

If Christoph Hellwig's references ([1], [2]) are not enough, here is my 
own analysis.
I put him in copy in case he has be better wording or explanation than me.



I've searched all dma_supported() function with grep
     grep -r --include=*.[ch]  \\.dma_supported * > dma_supported.txt

I've removed duplicates, then, I've audited audit all functions.
Short summary below.

Adding all this in the commit looks an overkill to me.
Maybe we can add a link to this mail if it looks good to you.

CJ



arch/arm/common/dmabounce.c:			.dma_supported =	dmabounce_dma_supported
==> Same as arm_dma_supported()

arch/arm/mm/dma-mapping.c:			.dma_supported =	arm_dma_supported
==> If a mask fails, smaller masks will fail as well.

arch/alpha/kernel/pci_iommu.c:			.dma_supported =	alpha_pci_supported
==> If a mask fails, smaller masks will fail as well.

arch/x86/kernel/amd_gart_64.c:			.dma_supported =	dma_direct_supported
==> Succeeds if >= 32 bits. If a mask fails, smaller masks will fail as 
well.

arch/powerpc/kernel/dma-iommu.c:		.dma_supported =	dma_iommu_dma_supported
==> Tricky because of dma_iommu_bypass_supported(), but if a mask fails, 
smaller masks will fail as well.

arch/powerpc/platforms/ps3/system-bus.c:	.dma_supported =	ps3_dma_supported
==> Succeeds if >= 32 bits

arch/powerpc/platforms/pseries/ibmebus.c:	.dma_supported = 
ibmebus_dma_supported
==> Succeeds if == 64 bits

arch/sparc/kernel/iommu.c:			.dma_supported =	dma_4u_supported
==> One corner case which accept only 31 bits
==> If a mask fails, smaller masks will fail as well

arch/sparc/kernel/pci_sun4v.c:			.dma_supported =	dma_4v_supported
==> Same as dma_4u_supported() above

arch/ia64/hp/common/sba_iommu.c:		.dma_supported =	sba_dma_supported
==> Succeeds if >= 32 bits

drivers/xen/swiotlb-xen.c:			.dma_supported =	xen_swiotlb_dma_supported
==> If a mask fails, smaller masks will fail as well.

drivers/parisc/ccio-dma.c:			.dma_supported =	ccio_dma_supported
==> Succeeds if >= 32 bits

drivers/parisc/sba_iommu.c:			.dma_supported =	sba_dma_supported
==> If a mask fails, smaller masks will fail as well.

kernel/dma/dummy.c:				.dma_supported =	dma_dummy_supported
==> Always fails, whatever the value of the mask


[1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/

[2]: https://lore.kernel.org/kernel-janitors/YdK4IIFvi5O5eXHC@infradead.org/
