Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5744C6953
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiB1LFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiB1LFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:05:20 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C072E25E82
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:04:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 532E968AFE; Mon, 28 Feb 2022 12:04:38 +0100 (CET)
Date:   Mon, 28 Feb 2022 12:04:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        joro@8bytes.org, will@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove CONFIG_DMA_REMAP
Message-ID: <20220228110438.GA10232@lst.de>
References: <20220227143533.357356-1-hch@lst.de> <4802e9fd-733f-3246-92f3-05f590e05d37@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4802e9fd-733f-3246-92f3-05f590e05d37@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:32:54AM +0000, Robin Murphy wrote:
> Is it even possible to hit this case now? From a quick look, all the 
> architectures defining HIGHMEM either have an explicit dependency on MMU or 
> don't allow deselecting it anyway (plus I don't see how HIGHMEM && !MMU 
> could work in general), so I'm pretty sure this whole chunk should go away 
> now.
>
> With that (or if there *is* some subtle wacky case where PageHighmem() can 
> actually return true for !MMU, a comment to remind us in future),

No, you're right - I don't think we can support highmem on !CONFIG_MMU.
