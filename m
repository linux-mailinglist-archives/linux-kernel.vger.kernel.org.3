Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE1B5968AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiHQFgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbiHQFgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:36:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C3D65560
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:36:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8176D68AA6; Wed, 17 Aug 2022 07:36:28 +0200 (CEST)
Date:   Wed, 17 Aug 2022 07:36:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liu Song <liusong@linux.alibaba.com>,
        akpm@linux-foundation.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2] mm/dmapool.c: avoid duplicate memset within
 dma_pool_alloc
Message-ID: <20220817053628.GA28747@lst.de>
References: <1658125690-76930-1-git-send-email-liusong@linux.alibaba.com> <CGME20220816123958eucas1p1b03a5efa1f5804245a5c1a9b27529015@eucas1p1.samsung.com> <1dbe63ff-5575-745b-653a-a992ae53e1aa@samsung.com> <413d8666-7a82-efd7-6716-13658016ca10@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413d8666-7a82-efd7-6716-13658016ca10@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> A helper function "use_dev_coherent_memory" is introduced here to
>>> determine whether the memory is allocated by "dma_alloc_from_dev_coherent".
>>>
>>> And use "get_dma_ops" to determine whether the memory is allocated by
>>> "dma_direct_alloc".

WTF?  get_dma_ops is privat to the DMA API layer, and dmapool has no
business even using that.  Even independent of this particular case,
consumers of an API never have any business looking at the implementation
of the API, that is the whole point of the abstraction.

> It's not even that, the change here is just obviously broken, since it ends 
> up entirely ignoring want_init_on_alloc() for devices using dma-direct. 
> Sure, the memory backing a dma_page is zeroed *once* by its initial 
> dma-coherent allocation, but who says we're not not reallocating pool 
> entries from an existing dma_page?

And yes, in addition to that it also is completely broken.
