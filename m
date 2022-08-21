Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAED459B32B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 12:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiHUKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 06:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiHUKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 06:43:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFB563DE
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 03:43:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5B49B67373; Sun, 21 Aug 2022 12:43:21 +0200 (CEST)
Date:   Sun, 21 Aug 2022 12:43:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <20220821104321.GB30530@lst.de>
References: <20220817060647.1032426-1-hch@lst.de> <20220817060647.1032426-4-hch@lst.de> <04790bd9-4f20-4d51-b988-ad4b44eeee98@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04790bd9-4f20-4d51-b988-ad4b44eeee98@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 01:50:09PM +0100, Robin Murphy wrote:
>>   +#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA32)
>
> This #ifdeffery seems horribly clunky - I think it would be much nicer to 
> mark this __maybe_unused, and preserve the has_managed_dma/IS_ENABLED logic 
> below.

>>   static int __init dma_atomic_pool_init(void)
>>   {
>> +	unsigned long nr_zone_dma_pages, nr_zone_dma32_pages;
>
> ...otherwise, I expect the buildbots will be along shortly with unused 
> variable warnings for these :)

Amazingly they haven't complained yet, even if they should.  But
simple IS_ENABLED won't work either as the ZONE_DMA / ZONE_DMA32
constants are not defined unless the corresponding config options
are set.  I'll see what I can do here using helpers.
