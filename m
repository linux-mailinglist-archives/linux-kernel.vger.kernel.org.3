Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9A59B32C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiHUKoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiHUKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 06:44:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA6014099
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 03:44:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B819267373; Sun, 21 Aug 2022 12:44:16 +0200 (CEST)
Date:   Sun, 21 Aug 2022 12:44:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <20220821104416.GC30530@lst.de>
References: <20220817060647.1032426-1-hch@lst.de> <20220817060647.1032426-4-hch@lst.de> <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 02:53:47PM +0200, Michal Hocko wrote:
> Yes this is much more reasonable estimation. Especially for the DMA
> zone. I still believe some downscaling would make sense but as said
> earlier nothing to really insist on. Also you likely want to have
> pr_warn for non-poppulated DMA zone as pointed in other thread[1].

So I think the warning would be useful, but how do we detect that the
zone should exist and is empty vs the case where it doesn't even
exist based on a runtime decision?
