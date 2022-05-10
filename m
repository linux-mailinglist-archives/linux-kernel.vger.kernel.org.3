Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3794852120E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiEJKYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiEJKYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:24:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68162AACD1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:20:22 -0700 (PDT)
Date:   Tue, 10 May 2022 12:20:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1652178020;
        bh=Nhv0FTzQESz5asnBYvRpiUwYoTOaiKJNzvOlOIwp9CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uNDX6+Ke8cHl8qxZ9lEtzivYVgiByYEc7+hF9Q5qW/pHk711/TZWdkZUm4QM6uQAq
         axQTU6ILlAYIIipm91NqGmZO2SgDVku9KUIC3Z4dM74ITktNKN5/fdStKzCF6TO4TF
         furw6zCyypPko4a5BpyWHNNZOS8znYwoZxnLdneA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Christoph Hellwig <hch@lst.de>, g@troy.t-8ch.de
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <6123b484-bf2c-49f0-a657-6085c7333b2e@t-8ch.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
 <20220428143603.GA20460@lst.de>
 <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
 <20220428150644.GA22685@lst.de>
 <676c02ef-4bbc-43f3-b3e6-27a7d353f974@t-8ch.de>
 <20220510070356.GA11660@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220510070356.GA11660@lst.de>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-10 09:03+0200, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 06:09:11PM +0200, Thomas Weißschuh wrote:
> > > > On my hardware we start with a chunk_size of 4MiB and just allocate
> > > > 8 (hmmaxd) * 4 = 32 MiB which is worse than 1 * 200MiB.
> > > 
> > > And that is because the hardware only has a limited set of descriptors.
> > 
> > Wouldn't it make more sense then to allocate as much memory as possible for
> > each descriptor that is available?
> > 
> > The comment in nvme_alloc_host_mem() tries to "start big".
> > But it actually starts with at most 4MiB.
> 
> Compared to what other operating systems offer, that is quite large.

Ok. I only looked at FreeBSD, which uses up to 5% of total memory per
device. [0]

> > And on devices that have hmminds > 4MiB the loop condition will never succeed
> > at all and HMB will not be used.
> > My fairly boring hardware already is at a hmminds of 3.3MiB.
> > 
> > > Is there any real problem you are fixing with this?  Do you actually
> > > see a performance difference on a relevant workload?
> > 
> > I don't have a concrete problem or performance issue.
> > During some debugging I stumbled in my kernel logs upon
> > "nvme nvme0: allocated 32 MiB host memory buffer"
> > and investigated why it was so low.
> 
> Until recently we could not even support these large sizes at all on
> typical x86 configs.  With my fairly recent change to allow vmap
> remapped iommu allocations on x86 we can do that now.  But if we
> unconditionally enabled it I'd be a little worried about using too
> much memory very easily.

This should still be limited to max_host_mem_size_mb which defaults to 128MiB,
or?

> We could look into removing the min with
> PAGE_SIZE * MAX_ORDER_NR_PAGES to try to do larger segments for
> "segment challenged" controllers now that it could work on a lot
> of iommu enabled setups.  But I'd rather have a very good reason for
> that.

On my current setup (WD SN770 on ThinkPad X1 Carbon Gen9) frequently the NVME
controller stops responding. Switching from no scheduler to mq-deadline reduced
this but did not eliminate it.
Since switching to HMB of 1 * 200MiB and no scheduler this did not happen anymore.
(But I'll need some more time to gain real confidence in this)

Initially I assumed that the PAGE_SIZE * MAX_ORDER_NR_PAGES was indeed
meant as a minimum for DMA allocation.
As that is not the case, removing the min() completely instead of the max() I
proposed would obviously be the correct thing to do.

[0] https://manpages.debian.org/testing/freebsd-manpages/nvme.4freebsd.en.html
