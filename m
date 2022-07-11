Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECDB56FFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiGKLMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGKLMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:12:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C232DAB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:21:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 220B568AA6; Mon, 11 Jul 2022 12:21:35 +0200 (CEST)
Date:   Mon, 11 Jul 2022 12:21:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ben Dooks <ben.dooks@sifive.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Message-ID: <20220711102134.GB4639@lst.de>
References: <20220708170811.270589-1-ben.dooks@sifive.com> <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com> <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com> <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
> If none of your peripherals should need SWIOTLB, then the fact that
> you're ending up in swiotlb_map() at all is a clear sign that
> something's wrong. Most likely someone's forgotten to set their DMA
> masks correctly.

Yes.

>
> However, by inspection it seems we do have a bug here as well, for which
> the correct fix should be as below. The fireworks you're *supposed* to
> get in that situation are considerably louder and more obvious than a
> DEBUG_SPINLOCK complaint ;)

This looks sensible, I'll pick it up.
