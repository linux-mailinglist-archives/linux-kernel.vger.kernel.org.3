Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50B659BE4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiHVLOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiHVLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:14:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E232B9E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:14:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6BCEF68AA6; Mon, 22 Aug 2022 13:14:47 +0200 (CEST)
Date:   Mon, 22 Aug 2022 13:14:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <20220822111447.GA8935@lst.de>
References: <20220817060647.1032426-1-hch@lst.de> <20220817060647.1032426-4-hch@lst.de> <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz> <20220821104416.GC30530@lst.de> <YwNBHbYXpatJHD0K@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwNBHbYXpatJHD0K@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:41:01AM +0200, Michal Hocko wrote:
> ZONE_DMA existance is not runtime controlable (at least on x86).

This is more about ZONE_DMA32 that can disappear if all memory is
inside ZONE_DMA.  That is highly unusual (but still possible) with a
tiny x86-style ZONE_DMA, but can happen with a larger one other
architectures.
