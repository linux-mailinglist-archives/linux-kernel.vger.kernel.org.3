Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BEE5442ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiFIFJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbiFIFJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:09:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBDD186DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1370MvjFrg636nlGFXu8CpOfBg8+mRgqzhQ7YScZLE8=; b=z4YKvf9NkWQn8P4v8bwSUJFMzO
        wFYfxYFg0PkZgnD659U4rh7iitXqzKlNSVwWTA1C2nrNn5h07lgmlJhc0ReHis19xaonefaZB6sxZ
        +V+P9DVDmD/46UTQmN/JjdZTZZAQC5fMv8RMAMMUgf2fXLubCn2cMrYDqfdfylD9qDdZdNi8P/Svh
        J+9KZ2qoXLt20f3lL7nsIP15svEtGRlcPZ9rH5GjuL/37Zo1WS6wUeHHKMNr3CNoOja+2Q00FXJVs
        gHmBMVQKXvRtoRkoEQ8E3W/0xik7QAo//cz+ATtxhmw/3yPF5rc4z1d9FC8BroUGeyAeuXFwnjhyj
        BRV2y6Ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzAPe-00Gnin-I4; Thu, 09 Jun 2022 05:08:54 +0000
Date:   Wed, 8 Jun 2022 22:08:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        m.szyprowski@samsung.com, jgross@suse.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        sstabellini@kernel.org, mpe@ellerman.id.au, konrad.wilk@oracle.com,
        mst@redhat.com, jasowang@redhat.com, joe.jin@oracle.com
Subject: Re: [PATCH RFC v1 3/7] swiotlb-xen: support highmem for xen specific
 code
Message-ID: <YqGAZoG6/pVX9NqN@infradead.org>
References: <20220609005553.30954-1-dongli.zhang@oracle.com>
 <20220609005553.30954-4-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609005553.30954-4-dongli.zhang@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:55:49PM -0700, Dongli Zhang wrote:
> @@ -109,19 +110,25 @@ int xen_swiotlb_fixup(void *buf, unsigned long nslabs, bool high)
>  	int rc;
>  	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
>  	unsigned int i, dma_bits = order + PAGE_SHIFT;
> +	unsigned int max_dma_bits = MAX_DMA32_BITS;
>  	dma_addr_t dma_handle;
>  	phys_addr_t p = virt_to_phys(buf);
>  
>  	BUILD_BUG_ON(IO_TLB_SEGSIZE & (IO_TLB_SEGSIZE - 1));
>  	BUG_ON(nslabs % IO_TLB_SEGSIZE);
>  
> +	if (high) {
> +		dma_bits = MAX_DMA64_BITS;
> +		max_dma_bits = MAX_DMA64_BITS;
> +	}
> +

I think you really want to pass the addressing bits or mask to the
remap callback and not do magic with a 'high' flag here.
