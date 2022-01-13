Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8258948D613
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiAMKux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiAMKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:50:50 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F4C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:50:50 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m3so4002018lfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NYdzsGyEzIJrHP8JYJwpG+jE5+s3oneWhUEBd32KPfc=;
        b=DhhsZ4FcY1ymdPypyg+ee+pcqdiHSzGlYLuwyZma/jDW9t3eFFml3cIDRE+Xfvh99+
         +4oBLTJzqus8vayylwYSGzQKdoQjicyTib8TNKHtenL7vge/5KER7iSIJlAE22OHhGJe
         x26kaaSxBgB6/8hltdzilL4tnDFYGvTapV+X0GXSpKGaE1H9QCc424YeLyw+l6/UYVla
         wQtNgHr259qGkouEiYzjKPAtE/9phQmnDoID2v36ht4co+cvmhsonWjWDetrDg23Ae8Y
         oYC9lNdWL0QXBuHtQ0w3FPum0JejOV6lgCawUm6ESNZY8+czHxksEfkBGAloMBHoU6PX
         K0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NYdzsGyEzIJrHP8JYJwpG+jE5+s3oneWhUEBd32KPfc=;
        b=kgeIrrTqEUeSUk0o78c69OdKk+rTr8X5qqBCVC6UDa+TOn5UkUEg6piNO0LKjIDDdM
         JmPl02uCSkOkaPMbgQS02i61Y18a2go8xQHk7wA3JDNfpUsZreQgXpLQLwK8xBHA0pDI
         Uw3KnCLZBr3TPA7rv5xALJEBlW7NBMfVBWwMWm1/jLpo85RA7u4V5HUfpIMeHg3Jh0gA
         3sSSoCCUhovuwDg9sslCRIIv3w5hnouixpL2Vv2Kh0uc4Z+M68Nb0efkIaNCcCGnEHG0
         +jZM3eKsMpeTLwe27p1QPfZ/AZG+9WeIrReWWJkER33RbK7UDQyGUsEnHlbpu103VNqc
         Gl7A==
X-Gm-Message-State: AOAM533okh9hQpEq0TRsZZmPVuMt88o2i0kYfRfSQ2DTIqMhrsWOuNx1
        oLVjqsvvzSdGEEzrlXVCuSMe6DFnaHHbWGiul/sKcQ==
X-Google-Smtp-Source: ABdhPJyhIUaFCImjQEUT36hwyszgx3JmEnCBpsaSjbzQZGA3S2YuSL/rPG5RGeiNf1e3gQIc9S9mjOGoHwjjuLtLZ6g=
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr2544065ljk.122.1642071048268;
 Thu, 13 Jan 2022 02:50:48 -0800 (PST)
MIME-Version: 1.0
References: <c05749d0-4c24-8763-a459-27257b2524ed@amd.com> <20220105063643.119874-1-guangming.cao@mediatek.com>
In-Reply-To: <20220105063643.119874-1-guangming.cao@mediatek.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 13 Jan 2022 16:20:36 +0530
Message-ID: <CAO_48GF=ttKqSOm9GRoA3Mq+-RQOtRjWp449XPcz-wH=kjaTjw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: dma-heap: Add a size check for allocation
To:     guangming.cao@mediatek.com
Cc:     christian.koenig@amd.com, brian.starkey@arm.com,
        benjamin.gaignard@linaro.org, bo.song@mediatek.com,
        dri-devel@lists.freedesktop.org, jianjiao.zeng@mediatek.com,
        john.stultz@linaro.org, labbott@redhat.com, libo.kang@mediatek.com,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        lmark@codeaurora.org, matthias.bgg@gmail.com,
        mingyuan.ma@mediatek.com, wsd_upstream@mediatek.com,
        yf.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guangming,

On Wed, 5 Jan 2022 at 12:05, <guangming.cao@mediatek.com> wrote:
>
> From: Guangming.Cao <guangming.cao@mediatek.com>
>
> On Tue, 2022-01-04 at 08:47 +0100, Christian K=E9=B0=8Aig wrote:
> > Am 03.01.22 um 19:57 schrieb John Stultz:
> > > On Mon, Dec 27, 2021 at 1:52 AM <guangming.cao@mediatek.com> wrote:
> > > > From: Guangming <Guangming.Cao@mediatek.com>
> > > >
> > >
> > > Thanks for submitting this!
> > >
> > > > Add a size check for allcation since the allocation size is
> > >
> > > nit: "allocation" above.
> > >
> > > > always less than the total DRAM size.
> > >
> > > In general, it might be good to add more context to the commit
> > > message
> > > to better answer *why* this change is needed rather than what the
> > > change is doing.  ie: What negative thing happens without this
> > > change?
> > > And so how does this change avoid or improve things?
> >
> > Completely agree, just one little addition: Could you also add this
> > why
> > as comment to the code?
> >
> > When we stumble over this five years from now it is absolutely not
> > obvious why we do this.
> >
> > Thanks,
> > Christian.
> >
> Thanks for your reply!
> I will update the related reason in the patch later.
>
> The reason for adding this check is that we met a case that the user
> sent an invalid size(It seems it's a negative value, MSB is 0xff, it's
> larger than DRAM size after convert it to size_t) to dma-heap to alloc
> memory, and this allocation was running on a process(such as "gralloc"
> on Android device) can't be killed by OOM flow, and we also couldn't
> find the related dmabuf in "dma_buf_debug_show" because the related
> dmabuf was not exported yet since the allocation is still on going.
>
> Since this invalid argument case can be prevented at dma-heap side, so,
> I added this size check, and moreover, to let debug it easily, I also
> added logs when size is bigger than a threshold we set in mtk system
> heap.
> If you think that print logs in dma-heap framework is better, I will
> update it in next version.
>
> If you have better solution(such as dump the size under allocating
> in "dma_buf_debug_show", which maybe need add global variable to record
> it), please kindly let me know.

Thank you for the patch!

I think just adding the reasoning above as the commit message and a
comment in the code should be enough for now; the debug parts may be
easy to add in case someone runs into issues.

> Thanks :)
> Guangming

Best,
Sumit.

>
> > >
> > >
> > > > Signed-off-by: Guangming <Guangming.Cao@mediatek.com>
> > > > Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
> > > > ---
> > > > v2: 1. update size limitation as total_dram page size.
> > > >      2. update commit message
> > > > ---
> > > >   drivers/dma-buf/dma-heap.c | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-
> > > > heap.c
> > > > index 56bf5ad01ad5..e39d2be98d69 100644
> > > > --- a/drivers/dma-buf/dma-heap.c
> > > > +++ b/drivers/dma-buf/dma-heap.c
> > > > @@ -55,6 +55,8 @@ static int dma_heap_buffer_alloc(struct
> > > > dma_heap *heap, size_t len,
> > > >          struct dma_buf *dmabuf;
> > > >          int fd;
> > > >
> > > > +       if (len / PAGE_SIZE > totalram_pages())
> > > > +               return -EINVAL;
> > >
> > > This seems sane. I know ION used to have some 1/2 of memory cap to
> > > avoid unnecessary memory pressure on crazy allocations.
> > >
> > > Could you send again with an improved commit message?
> > >
> > > thanks
> > > -john
> >
> >



--
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - LCG, Vertical Technologies
Linaro.org =E2=94=82 Open source software for ARM SoCs
