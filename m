Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913AB54C99E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348611AbiFONRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiFONRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:17:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35702A97D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:17:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1829A68AA6; Wed, 15 Jun 2022 15:17:01 +0200 (CEST)
Date:   Wed, 15 Jun 2022 15:17:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: helping with remapping vmem for dma
Message-ID: <20220615131700.GA18061@lst.de>
References: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28> <6e58b50c-cd05-a37b-07e1-10ee24fb972f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e58b50c-cd05-a37b-07e1-10ee24fb972f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 02:15:33PM +0100, Robin Murphy wrote:
> Put simply, if you want to call dma_map_single() on a buffer, then that 
> buffer needs to be allocated with kmalloc() (or technically alloc_pages(), 
> but then dma_map_page() would make more sense when dealing with entire 
> pages.

Yes.  It sounds like the memory here comes from the dma coherent
allocator, in which case the code need to use the address returned
by that and not create another mapping.
