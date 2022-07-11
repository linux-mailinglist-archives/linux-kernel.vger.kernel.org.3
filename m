Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1C570002
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiGKLRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiGKLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:16:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF567C85
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:39:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B6E468AA6; Mon, 11 Jul 2022 12:39:21 +0200 (CEST)
Date:   Mon, 11 Jul 2022 12:39:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Message-ID: <20220711103921.GA6542@lst.de>
References: <20220708170811.270589-1-ben.dooks@sifive.com> <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com> <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com> <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de> <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:24:51AM +0100, Ben Dooks wrote:
> On 11/07/2022 11:21, Christoph Hellwig wrote:
>> On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
>>> If none of your peripherals should need SWIOTLB, then the fact that
>>> you're ending up in swiotlb_map() at all is a clear sign that
>>> something's wrong. Most likely someone's forgotten to set their DMA
>>> masks correctly.
>>
>> Yes.
>
> Possibly, we had at least one driver which attempted to set a 32 bit
> DMA mask which had to be removed as the DMA layer accepts this but
> since there is no DMA32 memory the allocator then just fails.
>
> I expect the above may need to be a separate discussion(s) of how to
> default the DMA mask and how to stop the implicit acceptance of setting
> a 32-bit DMA mask.

No.  Linux simply assumes you can do 32-bit DMA and this won't
change.  So we'll need to fix your platform to support swiotlb
eventually.
