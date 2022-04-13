Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03314FEE64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiDMFCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDMFCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:02:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D77225E1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:00:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C12F68B05; Wed, 13 Apr 2022 06:59:58 +0200 (CEST)
Date:   Wed, 13 Apr 2022 06:59:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, m.szyprowski@samsung.com,
        hch@lst.de, Wang Zhaoyang1 <zhaoyang1.wang@intel.com>,
        Gao Liang <liang.gao@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Message-ID: <20220413045958.GA31209@lst.de>
References: <20220412113805.3210-1-chao.gao@intel.com> <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com> <20220413010157.GA10502@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413010157.GA10502@gao-cwp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:02:02AM +0800, Chao Gao wrote:
> dma_direct_sync_single_for_cpu() also calls arch_sync_dma_for_cpu_all()
> and arch_dma_mark_clean() in some cases. if SWIOTLB does sync internally,
> should these two functions be called by SWIOTLB?
> 
> Personally, it might be better if swiotlb can just focus on bounce buffer
> alloc/free. Adding more DMA coherence logic into swiotlb will make it
> a little complicated.
> 
> How about an open-coded version of dma_direct_sync_single_for_cpu
> in dma_direct_unmap_page with swiotlb_sync_single_for_cpu replaced by
> swiotlb_tbl_unmap_single?

I don't think the swiotlb and non-coherent case ever fully worked.
Before the merge of swiotlb into dma-direct they obviously were
mutally exclusive, and even now all the cache maintainance is done
on the physical address of the original data, not the swiotlb buffer.

If we want to fix that properly all the arch dma calls will need to
move into swiotlb, but that is a much bigger patch.

So for now I'd be happy with the one liner presented here, but
eventually the whole area could use an overhaul.
