Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5559B32A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiHUKla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 06:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiHUKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 06:41:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556521C932
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 03:41:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77DE567373; Sun, 21 Aug 2022 12:41:21 +0200 (CEST)
Date:   Sun, 21 Aug 2022 12:41:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dma-pool: factor out a calculate_pool_size helper
Message-ID: <20220821104121.GA30530@lst.de>
References: <20220817060647.1032426-1-hch@lst.de> <20220817060647.1032426-2-hch@lst.de> <777145ed-7936-6d8a-d706-57e609f4deb6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777145ed-7936-6d8a-d706-57e609f4deb6@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 01:32:42PM +0100, Robin Murphy wrote:
> On 2022-08-17 07:06, Christoph Hellwig wrote:
>> Add a helper to calculate the pool size from dma_atomic_pool_init,
>> and fix up the last max_t to use the proper type.
>
> Hmm, both atomic_pool_size and the argument to __dma_atomic_pool_init() 
> where this gets directly passed later are size_t, not to mention that the 
> function name says we're calculating a size, so I'd say size_t *is* the 
> proper type to return here.

But the type passed to calculate_pool_size isn't about the return type,
but rather the type to use for the comparing the other two arguments.

The should generally by the largest of the involved types.  Besides
that using a size_t for a number of pages is not a correct use of
size_t, but that's a separate story.

But I'll go back to what we had originally, there's no good reason
to change it in this series.
