Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B1959EE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiHWWAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiHWWAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:00:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EC05A829;
        Tue, 23 Aug 2022 15:00:22 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so1358953oth.10;
        Tue, 23 Aug 2022 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KxUnJO5kb4knBfdxm8mXJ+AuQhFumfmLRhT6rxam+RI=;
        b=PFBIoO3Tr9ZKI+LdxB+z2ngMlEd+2QVBA7kjAAQNZ4xICRXJ5GXCXb/C/6r1NxZ0Eb
         bQHeIGudoW7wbPVN61R4Q38wQtV0UGUEVnrOI0q8fth7fsYeNTP3hue2NFRqJn91IHhv
         tMT9xlcs1OElw6MzIXX5BgfRZ6GSBfPeNtPX5ertXIkgSIKwPj/TVWKU03esLsQKBooE
         Pi+zS2rqOIVwX6NQyolqsmbeuDiBL0pg++13uNXmJO9NwmOKdFHjL6BoFsO2wGGm0OKP
         HGlw6XE30IachmI0niAHMhpCysaMlkHbL/+69guE2wZiqcs+GGm/Midk9Fr1BBF6zJl0
         zZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KxUnJO5kb4knBfdxm8mXJ+AuQhFumfmLRhT6rxam+RI=;
        b=dlh1R8xBZP+YRrGcujJvld3pILXct3eaiq1EblfsABRC+9v3wFYDT7sbTbGR1fqiEZ
         dhx+lJjrV6raiF72kVdsyKe2H4tEFXTxk6X6KhRiLsrt3vpk/ANn6Hc3xGG43Cl7FUu6
         30+EK3JI5hKe+vfNerDTyKKVUVr/h18XX5+PIzcsZUoZIICrEkZhqkFC8IRN34guXkZ9
         /LcxjtS3U7hYIEUcNB6BLUf769Fz0DJutSNInrG3l4SrXh3VtKAxmr/wf6nRNL8QGPv+
         0JQnKXAE+d932LbSNu3PE1TE4CuvrUs9zOhz3ah79HiBmRKLNJkhRHa/vJunEPzNsuu1
         owIA==
X-Gm-Message-State: ACgBeo2Q1/fOXmyXENAwa5WeCNlWe+z5wI33G6yq65ISQnZhT23XdKrD
        dH93A7HAY05MOfFRVJ9wKGr0l1Bu8mFwo2jvO88=
X-Google-Smtp-Source: AA6agR6yvxeRJ1r5dz8UoW2dhWNf4E3ZO3dZi4TMMLWAKElVhVFa/163CDI9rblTbYjseBsGZzfezNSR0ORlRhDrH40=
X-Received: by 2002:a9d:61d2:0:b0:639:31ca:87fe with SMTP id
 h18-20020a9d61d2000000b0063931ca87femr3407223otk.22.1661292021482; Tue, 23
 Aug 2022 15:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220823163719.90399-1-robdclark@gmail.com> <8d3c8ae2-f342-b38c-e0d2-9abd357703f5@quicinc.com>
In-Reply-To: <8d3c8ae2-f342-b38c-e0d2-9abd357703f5@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 23 Aug 2022 15:00:55 -0700
Message-ID: <CAF6AEGtC5g17buULLxag5Ev4=To2QENSBwqOVbmxdopWtpt8cw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v2] drm/msm/iommu: optimize map/unmap
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 2:37 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 8/23/2022 10:07 PM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Using map_pages/unmap_pages cuts down on the # of pgtable walks needed
> > in the process of finding where to insert/remove an entry.  The end
> > result is ~5-10x faster than mapping a single page at a time.
> >
> > v2: Rename iommu_pgsize(), drop obsolete comments, fix error handling
> >      in msm_iommu_pagetable_map()
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/msm_iommu.c | 101 +++++++++++++++++++++++++++-----
> >   1 file changed, 86 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> > index a54ed354578b..5577cea7c009 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -21,6 +21,7 @@ struct msm_iommu_pagetable {
> >       struct msm_mmu base;
> >       struct msm_mmu *parent;
> >       struct io_pgtable_ops *pgtbl_ops;
> > +     unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
> >       phys_addr_t ttbr;
> >       u32 asid;
> >   };
> > @@ -29,23 +30,84 @@ static struct msm_iommu_pagetable *to_pagetable(struct msm_mmu *mmu)
> >       return container_of(mmu, struct msm_iommu_pagetable, base);
> >   }
> >
> > +/* based on iommu_pgsize() in iommu.c: */
> > +static size_t calc_pgsize(struct msm_iommu_pagetable *pagetable,
> > +                        unsigned long iova, phys_addr_t paddr,
> > +                        size_t size, size_t *count)
> > +{
> > +     unsigned int pgsize_idx, pgsize_idx_next;
> > +     unsigned long pgsizes;
> > +     size_t offset, pgsize, pgsize_next;
> > +     unsigned long addr_merge = paddr | iova;
> > +
> > +     /* Page sizes supported by the hardware and small enough for @size */
> > +     pgsizes = pagetable->pgsize_bitmap & GENMASK(__fls(size), 0);
> > +
> > +     /* Constrain the page sizes further based on the maximum alignment */
> > +     if (likely(addr_merge))
> > +             pgsizes &= GENMASK(__ffs(addr_merge), 0);
> > +
> > +     /* Make sure we have at least one suitable page size */
> > +     BUG_ON(!pgsizes);
> > +
> > +     /* Pick the biggest page size remaining */
> > +     pgsize_idx = __fls(pgsizes);
> > +     pgsize = BIT(pgsize_idx);
> > +     if (!count)
> > +             return pgsize;
> > +
> > +     /* Find the next biggest support page size, if it exists */
> > +     pgsizes = pagetable->pgsize_bitmap & ~GENMASK(pgsize_idx, 0);
> > +     if (!pgsizes)
> > +             goto out_set_count;
> > +
> > +     pgsize_idx_next = __ffs(pgsizes);
> > +     pgsize_next = BIT(pgsize_idx_next);
> > +
> > +     /*
> > +      * There's no point trying a bigger page size unless the virtual
> > +      * and physical addresses are similarly offset within the larger page.
> > +      */
> > +     if ((iova ^ paddr) & (pgsize_next - 1))
> > +             goto out_set_count;
> > +
> > +     /* Calculate the offset to the next page size alignment boundary */
> > +     offset = pgsize_next - (addr_merge & (pgsize_next - 1));
> > +
> > +     /*
> > +      * If size is big enough to accommodate the larger page, reduce
> > +      * the number of smaller pages.
> > +      */
> > +     if (offset + pgsize_next <= size)
> > +             size = offset;
> > +
> > +out_set_count:
> > +     *count = size >> pgsize_idx;
> > +     return pgsize;
> > +}
> > +
> Can we keep this in iommu driver? Seems useful to other drivers too.

This might end up being only temporary.. Robin had the idea of adding
a private way to create "dummy" iommu_domain's which we could use
instead of the pgtbl ops directly.  On one hand, it would simplify
this quite a bit.  On the other hand it would force powering up (at
least the SMMU) for unmaps/maps, and make it harder to do things like
this:

  https://patchwork.freedesktop.org/patch/498660/?series=107536&rev=1

> Perhaps implement an sg friendly version of iopgtble ops, like
> unmap_sg() maybe!

Probably not a good idea to push more into the iopgtbl
implementations.. __iommu_map_sg() does have a bit of cleverness, but
that shouldn't really be required if we get our sg from
drm_prime_pages_to_sg() since sg_alloc_append_table_from_pages()
already performs a similar merging

BR,
-R

>
> -Akhil.
> >   static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
> >               size_t size)
> >   {
> >       struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
> >       struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
> > -     size_t unmapped = 0;
> >
> > -     /* Unmap the block one page at a time */
> >       while (size) {
> > -             unmapped += ops->unmap(ops, iova, 4096, NULL);
> > -             iova += 4096;
> > -             size -= 4096;
> > +             size_t unmapped, pgsize, count;
> > +
> > +             pgsize = calc_pgsize(pagetable, iova, iova, size, &count);
> > +
> > +             unmapped = ops->unmap_pages(ops, iova, pgsize, count, NULL);
> > +             if (!unmapped)
> > +                     break;
> > +
> > +             iova += unmapped;
> > +             size -= unmapped;
> >       }
> >
> >       iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
> >
> > -     return (unmapped == size) ? 0 : -EINVAL;
> > +     return (size == 0) ? 0 : -EINVAL;
> >   }
> >
> >   static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
> > @@ -54,7 +116,6 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
> >       struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
> >       struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
> >       struct scatterlist *sg;
> > -     size_t mapped = 0;
> >       u64 addr = iova;
> >       unsigned int i;
> >
> > @@ -62,17 +123,26 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
> >               size_t size = sg->length;
> >               phys_addr_t phys = sg_phys(sg);
> >
> > -             /* Map the block one page at a time */
> >               while (size) {
> > -                     if (ops->map(ops, addr, phys, 4096, prot, GFP_KERNEL)) {
> > -                             msm_iommu_pagetable_unmap(mmu, iova, mapped);
> > +                     size_t pgsize, count, mapped = 0;
> > +                     int ret;
> > +
> > +                     pgsize = calc_pgsize(pagetable, addr, phys, size, &count);
> > +
> > +                     ret = ops->map_pages(ops, addr, phys, pgsize, count,
> > +                                          prot, GFP_KERNEL, &mapped);
> > +
> > +                     /* map_pages could fail after mapping some of the pages,
> > +                      * so update the counters before error handling.
> > +                      */
> > +                     phys += mapped;
> > +                     addr += mapped;
> > +                     size -= mapped;
> > +
> > +                     if (ret) {
> > +                             msm_iommu_pagetable_unmap(mmu, iova, addr - iova);
> >                               return -EINVAL;
> >                       }
> > -
> > -                     phys += 4096;
> > -                     addr += 4096;
> > -                     size -= 4096;
> > -                     mapped += 4096;
> >               }
> >       }
> >
> > @@ -207,6 +277,7 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
> >
> >       /* Needed later for TLB flush */
> >       pagetable->parent = parent;
> > +     pagetable->pgsize_bitmap = ttbr0_cfg.pgsize_bitmap;
> >       pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
> >
> >       /*
>
