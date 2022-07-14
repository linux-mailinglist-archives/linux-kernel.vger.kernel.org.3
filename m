Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A825744D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiGNGGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGNGGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:06:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF2F2FFEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:06:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ez10so1480308ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K+qPh4pfyjzo3UQTrP14sCh1amn4SLpPOTTUiC7RJvM=;
        b=Xe2PnzltsKqDutrwfavyPGTMwZW0sX2s5qJIolHhzjUR3uhBSU+H4M/P03wazBGOBN
         KvrZ13FMLLvoKkZihx8D1i50T4KLTTfbcMVbAcjywlz3AB+qLS5JEsZEzEsUiCCKsJ9o
         GCnoGrk1v4Bq3+DAFY94rV9msEkEnfK6O9Dkw5LEvgDaPi41SXSPldJGNpIV6Hw8dKyY
         0/QWpf4GBiBIxyaPK1kgsgL7/HBd5UgH6rkvahEYpTUhTgPmps6nH1ID2TED587j5UKs
         IJEmw1QlJd1MzTYI7GKkKSxeuIRhgX4cg6mI5w1c3O131BjQYJQwRQa7bSXxwMZG0eAo
         Ci2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K+qPh4pfyjzo3UQTrP14sCh1amn4SLpPOTTUiC7RJvM=;
        b=JqMkt7tu76RRKks8z5FpK4g64D3ZeZl47ps3hadXX8PgbfvSnzQuQwVuroYdSoZ7Cd
         jnSMvK2fXewZjHdZ2b3ysezhNPMO0ToVuzus+G5waNSqfTWqKHQmDKuWr9aDiUjigmtl
         lthw4I4pmc6iLA2CiSEMNFyT1EJCdPElnM57fq7TfS7Czsd8Qz+0+AF3975DhsGccygy
         npM1VNymWMflk6cnTW8qtGLcflE5tLjGDJ/Q4AXDpRld7zfpWa0IbNpSYgpuSy9B/bwU
         5nkP3x+NvvW58UaFvIMYdq60Cragi2zsl0H4SmhsRLAzNfqPxNABHdkwRPKeOE7yKFo0
         VV9Q==
X-Gm-Message-State: AJIora+X4LBfgIpwWqXZzTM+kpLc3tMRe4iNziEi3PF/4QkkTk1K0XRn
        gkAL8wLW33MFywmtDewld60y4KjDtiQjxl2JQwHn
X-Google-Smtp-Source: AGRyM1uqqIx1J3a1TVOBzuCe5tUP29YfbWQmKBFSTieb0oYA4e/OIY6Nx5Rg1NjIDkDQeIdBalgCFKDCN/CVFKgHQks=
X-Received: by 2002:a17:906:8461:b0:72e:e3f5:373b with SMTP id
 hx1-20020a170906846100b0072ee3f5373bmr63658ejc.199.1657778799778; Wed, 13 Jul
 2022 23:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <20220706050503.171-2-xieyongji@bytedance.com>
 <1106133f-ebd4-f6a8-83ab-19e995bcdba6@redhat.com> <CACycT3sNt_PcPQ__KVSqV6xd=+z5+gbMqWhu6H3vcj_fTGzUsw@mail.gmail.com>
 <CACGkMEsOXyewVZ76Cc4BoZv1vhXbT1t8tm-9GqV9CJ70bF-xwg@mail.gmail.com>
In-Reply-To: <CACGkMEsOXyewVZ76Cc4BoZv1vhXbT1t8tm-9GqV9CJ70bF-xwg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 14 Jul 2022 14:06:28 +0800
Message-ID: <CACycT3tMw-Lz0ij8u8Fp0Xz2tc6q+jWp7Pk+iirmzd9wHsV3Pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:27 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Jul 13, 2022 at 7:09 PM Yongji Xie <xieyongji@bytedance.com> wrot=
e:
> >
> > On Wed, Jul 13, 2022 at 1:44 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > >
> > > =E5=9C=A8 2022/7/6 13:04, Xie Yongji =E5=86=99=E9=81=93:
> > > > Taking iotlb lock to access bounce page in page fault
> > > > handler is meaningless since vduse_domain_free_bounce_pages()
> > > > would only be called during file release.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >   drivers/vdpa/vdpa_user/iova_domain.c | 7 ++-----
> > > >   1 file changed, 2 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vd=
pa_user/iova_domain.c
> > > > index 6daa3978d290..bca1f0b8850c 100644
> > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > @@ -211,17 +211,14 @@ static struct page *
> > > >   vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u6=
4 iova)
> > > >   {
> > > >       struct vduse_bounce_map *map;
> > > > -     struct page *page =3D NULL;
> > > > +     struct page *page;
> > > >
> > > > -     spin_lock(&domain->iotlb_lock);
> > > >       map =3D &domain->bounce_maps[iova >> PAGE_SHIFT];
> > > >       if (!map->bounce_page)
> > > > -             goto out;
> > > > +             return NULL;
> > >
> > >
> > > Interesting, I wonder why we don't serialize with
> > > vduse_domain_map_bounce_page() with iotlb_lock?
> > >
> >
> > Userspace should only access the bounce page after we set up the dma
> > mapping, so we don't need serialization from the iotlb_lock in this
> > case.
>
> What about the buggy/malicious user space that tries to access those
> pages before or just in the middle of it has been mapped?
>

Yes, it might happen. But it would not have any problem. The userspace
might get a page or a SIGBUS error.

> > And vduse_domain_map_bounce_page() only sets the
> > map->bounce_page rather than clears the map->bounce_page, we would not
> > have any problem without the lock protection.
>
> Probably, I see an assignment of orig_phys after the alloc_page() but
> it seems only used in bouncing which will only be called by dma ops.
> At least we'd better have a comment to explain the synchronization
> here.
>

Yes, only map->bounce_page might be accessed concurrently in those two
places. I will add some comments in them.

Thanks,
Yongji
