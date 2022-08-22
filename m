Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579AC59BF7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiHVM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiHVM2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:28:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD932A96
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:28:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DDAB568C7B; Mon, 22 Aug 2022 14:27:59 +0200 (CEST)
Date:   Mon, 22 Aug 2022 14:27:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <20220822122759.GA14932@lst.de>
References: <20220817060647.1032426-1-hch@lst.de> <20220817060647.1032426-4-hch@lst.de> <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz> <20220821104416.GC30530@lst.de> <YwNBHbYXpatJHD0K@dhcp22.suse.cz> <20220822111447.GA8935@lst.de> <YwNx6Q+FSwpKUOQ2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwNx6Q+FSwpKUOQ2@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 02:09:13PM +0200, Michal Hocko wrote:
> OK, so you are worried about configurations that lack ZONE_DMA32 because
> that memory range is covered by ZONE_DMA? I thought though simply do not
> have CONFIG_ZONE_DMA32. Or am I wrong here?

Zones can disappear when they are empty.  Normally that affects
ZONE_NORMAL and ZONE_HIGHMEM, but it can also happen to ZONE_DMA32
when there is not enough memory.
