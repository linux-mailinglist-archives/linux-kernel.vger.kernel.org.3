Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61E7484E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiAEGgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:36:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54224 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231960AbiAEGgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:36:00 -0500
X-UUID: 74e77be901fe420393d4d2238783a093-20220105
X-UUID: 74e77be901fe420393d4d2238783a093-20220105
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <guangming.cao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 295248893; Wed, 05 Jan 2022 14:35:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 5 Jan 2022 14:35:54 +0800
Received: from mszswglt01.gcn.mediatek.inc (10.16.20.20) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 5 Jan 2022 14:35:53 +0800
From:   <guangming.cao@mediatek.com>
To:     <christian.koenig@amd.com>
CC:     <Brian.Starkey@arm.com>, <benjamin.gaignard@linaro.org>,
        <bo.song@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <guangming.cao@mediatek.com>, <jianjiao.zeng@mediatek.com>,
        <john.stultz@linaro.org>, <labbott@redhat.com>,
        <libo.kang@mediatek.com>, <linaro-mm-sig@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <lmark@codeaurora.org>,
        <matthias.bgg@gmail.com>, <mingyuan.ma@mediatek.com>,
        <sumit.semwal@linaro.org>, <wsd_upstream@mediatek.com>,
        <yf.wang@mediatek.com>
Subject: Re: [PATCH v2] dma-buf: dma-heap: Add a size check for allocation
Date:   Wed, 5 Jan 2022 14:36:43 +0800
Message-ID: <20220105063643.119874-1-guangming.cao@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c05749d0-4c24-8763-a459-27257b2524ed@amd.com>
References: <c05749d0-4c24-8763-a459-27257b2524ed@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangming.Cao <guangming.cao@mediatek.com>

On Tue, 2022-01-04 at 08:47 +0100, Christian K鰊ig wrote:
> Am 03.01.22 um 19:57 schrieb John Stultz:
> > On Mon, Dec 27, 2021 at 1:52 AM <guangming.cao@mediatek.com> wrote:
> > > From: Guangming <Guangming.Cao@mediatek.com>
> > > 
> > 
> > Thanks for submitting this!
> > 
> > > Add a size check for allcation since the allocation size is
> > 
> > nit: "allocation" above.
> > 
> > > always less than the total DRAM size.
> > 
> > In general, it might be good to add more context to the commit
> > message
> > to better answer *why* this change is needed rather than what the
> > change is doing.  ie: What negative thing happens without this
> > change?
> > And so how does this change avoid or improve things?
> 
> Completely agree, just one little addition: Could you also add this
> why 
> as comment to the code?
> 
> When we stumble over this five years from now it is absolutely not 
> obvious why we do this.
> 
> Thanks,
> Christian.
> 
Thanks for your reply!
I will update the related reason in the patch later.

The reason for adding this check is that we met a case that the user
sent an invalid size(It seems it's a negative value, MSB is 0xff, it's
larger than DRAM size after convert it to size_t) to dma-heap to alloc
memory, and this allocation was running on a process(such as "gralloc"
on Android device) can't be killed by OOM flow, and we also couldn't
find the related dmabuf in "dma_buf_debug_show" because the related
dmabuf was not exported yet since the allocation is still on going.

Since this invalid argument case can be prevented at dma-heap side, so,
I added this size check, and moreover, to let debug it easily, I also
added logs when size is bigger than a threshold we set in mtk system
heap.
If you think that print logs in dma-heap framework is better, I will
update it in next version.

If you have better solution(such as dump the size under allocating
in "dma_buf_debug_show", which maybe need add global variable to record
it), please kindly let me know.
Thanks :)
Guangming

> > 
> > 
> > > Signed-off-by: Guangming <Guangming.Cao@mediatek.com>
> > > Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
> > > ---
> > > v2: 1. update size limitation as total_dram page size.
> > >      2. update commit message
> > > ---
> > >   drivers/dma-buf/dma-heap.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-
> > > heap.c
> > > index 56bf5ad01ad5..e39d2be98d69 100644
> > > --- a/drivers/dma-buf/dma-heap.c
> > > +++ b/drivers/dma-buf/dma-heap.c
> > > @@ -55,6 +55,8 @@ static int dma_heap_buffer_alloc(struct
> > > dma_heap *heap, size_t len,
> > >          struct dma_buf *dmabuf;
> > >          int fd;
> > > 
> > > +       if (len / PAGE_SIZE > totalram_pages())
> > > +               return -EINVAL;
> > 
> > This seems sane. I know ION used to have some 1/2 of memory cap to
> > avoid unnecessary memory pressure on crazy allocations.
> > 
> > Could you send again with an improved commit message?
> > 
> > thanks
> > -john
> 
> 
