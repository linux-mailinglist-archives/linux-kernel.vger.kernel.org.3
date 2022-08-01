Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433AE587006
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiHASB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiHASBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:01:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3F9237ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:01:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4406D68AFE; Mon,  1 Aug 2022 20:01:47 +0200 (CEST)
Date:   Mon, 1 Aug 2022 20:01:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     yf.wang@mediatek.com, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, wsd_upstream@mediatek.com,
        Libo Kang <Libo.Kang@mediatek.com>,
        Ning Li <Ning.Li@mediatek.com>, Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH] dma-debug: Remove warning in dma_debug_entry
Message-ID: <20220801180146.GB17256@lst.de>
References: <20220730085657.31977-1-yf.wang@mediatek.com> <19a0a508-fb39-8b06-ce0f-ce26767ef57f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a0a508-fb39-8b06-ce0f-ce26767ef57f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 01:07:10PM +0100, Robin Murphy wrote:
> Furthermore, even for the valid dma-buf import case I'm not convinced that 
> the SKIP_CPU_SYNC check can be dropped either. If one device can import a 
> buffer while another device is already accessing it, there are definitely 
> combinations of parameters which could lead to potential data loss (e.g. a 
> non-coherent DMA_TO_DEVICE mapping during a non-coherent DMA_FROM_DEVICE 
> access, a or non-coherent DMA_FROM_DEVICE mapping during a coherent 
> DMA_TO_DEVICE access).

Yes.  While there is a rare case where double mapping actually works
(exactly the same region, no access to the data between the invidual
mapping and unmapping calls), there is absolutely no good reason to
support it.  The additional cache maintainance operations will still
take some overhead that can be skipped, and it makes the rules very
confusing.  It is much better to fix the upper layers to use
the SKIP_CPU_SYNC flag in case of multiple mappings, which also
clearly documents what is being done there.
