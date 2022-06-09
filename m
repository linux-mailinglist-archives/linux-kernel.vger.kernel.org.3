Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933265442E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiFIFHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbiFIFHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:07:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9062050F5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TvPXHMQO6PU//nHDA0WgcCETKSRRfJH2DEgRCxwDbVs=; b=kYmHjR7gMPF1i+IrBOvuM8YJYv
        JS56zj46eCdXv6HizKLwWK6BBJX65b+pjfOUjohLpFK2UZWT0nc39riUnjJa9KdbSNswiMY1Wf8pW
        BeK204Hw7PCKtQiDfxkbHFRDDBh4d7SeK4+7H/ecJcy6NPU9wTuqwFvK+vowvACpLgMReGOnkxRTZ
        5cCR0G2QrtAuXf7Msmn6xuLzKhR7rk7bI0LOAHyZBtYiAE/U219aV9w9pAMoHOBXScvVJzJ1ITweb
        q41BtyqfX5T02Awsmk9AVmPe1SxBXJvV+k6GtG4ovM5N310b1iJCPRLX5pcqbpP2HDax2X2Zm/YmJ
        KajG5p+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzANu-00GnN3-B4; Thu, 09 Jun 2022 05:07:06 +0000
Date:   Wed, 8 Jun 2022 22:07:06 -0700
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
Subject: Re: [PATCH RFC v1 6/7] virtio: use io_tlb_high_mem if it is active
Message-ID: <YqF/+tqMA7GtjfAY@infradead.org>
References: <20220609005553.30954-1-dongli.zhang@oracle.com>
 <20220609005553.30954-7-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609005553.30954-7-dongli.zhang@oracle.com>
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

On Wed, Jun 08, 2022 at 05:55:52PM -0700, Dongli Zhang wrote:
>  /* Unique numbering for virtio devices. */
> @@ -241,6 +243,12 @@ static int virtio_dev_probe(struct device *_d)
>  	u64 device_features;
>  	u64 driver_features;
>  	u64 driver_features_legacy;
> +	struct device *parent = dev->dev.parent;
> +	u64 dma_mask = min_not_zero(*parent->dma_mask,
> +				    parent->bus_dma_limit);
> +
> +	if (dma_mask == DMA_BIT_MASK(64))
> +		swiotlb_use_high(parent);

The driver already very clearly communicated its addressing
requirements.  The underlying swiotlb code needs to transparently
pick the right pool.

