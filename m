Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABC3482EE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiACHyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiACHyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:54:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B12C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 23:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s6pxSP+ajg4hdJ8d9+GMrlSCSiEOlsN0aP8e9JW0qCo=; b=uwCl5XU5JVUEfQ5LILKGctTPdV
        W4RvxzbFzkCYUQTJJoMl95IYrXXq8egkDmG8VnN9qzDoRSF3iPjX2K2zD2BJUfTyWZPez2W8QypCS
        gGCYTCbUAXJpJjRCO4elEs/2p0PdcAelqWqxQ5e2N0468VevRiAEAFV/9f+L4f368gWnUBhVRsLrM
        4V9Qr6jWY5HUFk4pko1sxKX62jJ72ZPI8rlv/Kc31o52X9NRMoxgJIzwbcguYpHsXN8OYBoyTTFak
        Y4K+tnefWkBNxwIBxpOfFtse4bOvsvogp1hPaIu49dPj+o1KpPyp6rQNe70AL3e92RtD3JY4MHIF0
        GeHFtCGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4IB4-008XyT-FD; Mon, 03 Jan 2022 07:54:46 +0000
Date:   Sun, 2 Jan 2022 23:54:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in
 the swiotlb_mem_remap()
Message-ID: <YdKrxgnpT0Dc0t2T@infradead.org>
References: <20211231165640.1245751-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231165640.1245751-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 11:56:40AM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> HAS_IOMEM option may not be selected on some platforms(e.g, s390) and this
> will cause compile error due to miss memremap() implementation. Fix it via
> adding HAS_IOMEM check around memremap() in the swiotlb.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  kernel/dma/swiotlb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b36c1cdd0c4f..3de651ba38cc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -167,6 +167,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
>  {
>  	void *vaddr = NULL;
>  
> +#ifdef CONFIG_HAS_IOMEM

Please stub out all of swiotlb_mem_remap instead of the ifdef inside the
function.
