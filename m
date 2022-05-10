Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E73520E71
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiEJHfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiEJHH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:07:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951211D8135
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:04:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B31E468AFE; Tue, 10 May 2022 09:03:56 +0200 (CEST)
Date:   Tue, 10 May 2022 09:03:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <20220510070356.GA11660@lst.de>
References: <20220428101922.14216-1-linux@weissschuh.net> <20220428143603.GA20460@lst.de> <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de> <20220428150644.GA22685@lst.de> <676c02ef-4bbc-43f3-b3e6-27a7d353f974@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <676c02ef-4bbc-43f3-b3e6-27a7d353f974@t-8ch.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 06:09:11PM +0200, Thomas Weißschuh wrote:
> > > On my hardware we start with a chunk_size of 4MiB and just allocate
> > > 8 (hmmaxd) * 4 = 32 MiB which is worse than 1 * 200MiB.
> > 
> > And that is because the hardware only has a limited set of descriptors.
> 
> Wouldn't it make more sense then to allocate as much memory as possible for
> each descriptor that is available?
> 
> The comment in nvme_alloc_host_mem() tries to "start big".
> But it actually starts with at most 4MiB.

Compared to what other operating systems offer, that is quite large.

> And on devices that have hmminds > 4MiB the loop condition will never succeed
> at all and HMB will not be used.
> My fairly boring hardware already is at a hmminds of 3.3MiB.
> 
> > Is there any real problem you are fixing with this?  Do you actually
> > see a performance difference on a relevant workload?
> 
> I don't have a concrete problem or performance issue.
> During some debugging I stumbled in my kernel logs upon
> "nvme nvme0: allocated 32 MiB host memory buffer"
> and investigated why it was so low.

Until recently we could not even support these large sizes at all on
typical x86 configs.  With my fairly recent change to allow vmap
remapped iommu allocations on x86 we can do that now.  But if we
unconditionally enabled it I'd be a little worried about using too
much memory very easily.

We could look into removing the min with
PAGE_SIZE * MAX_ORDER_NR_PAGES to try to do larger segments for
"segment challenged" controllers now that it could work on a lot
of iommu enabled setups.  But I'd rather have a very good reason for
that.
