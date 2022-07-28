Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D686583A57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiG1I1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG1I1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:27:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40C4E61C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:27:15 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i62so370749yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuOwg8zLZYTNGp3dnBE/duFf3jptoCHmwZgBs/JWqoM=;
        b=xzzKH7sPcQmkwiVdKloGauRpi7blCjAQCrDKrQeTUx6AIgCVlOJdE1tfKV3OgeeetB
         3mbYapqzRhUe6nAZt/YPteZ4qVYbv3uJ+bYn/NpTa5VxxnxIsPQRFBaMWvPjZI/3ljeR
         sNK/xeV3AykoDIT3fjdWS4aw3rXihp8s+P+ptoMpX0C3Ox7tttbQEgm01eTkjwlImdar
         dNBdNe5wTcQVPXTBQgToL5PIgNkx0IIUMMW7n1Wb2NSanE/ynAKQj/mnXKaFqlb3frQK
         M9e+V1X8rIEZEj/Cv7EfRB+fwzFP1bdKpzE4gTDonF2WPCGGsuR9l9XKG6KYc7SzQ8LI
         UQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuOwg8zLZYTNGp3dnBE/duFf3jptoCHmwZgBs/JWqoM=;
        b=2NcPfaapIMYqpyq6Y3O5TuZWDCv5VuBJ3dPnrSq2yP57GaNBqEScaeK6hDGh/ilYik
         w/ZB/k32aQOS6PHpRtyLdJ4piUhA5yht2rkz0xVW9Y75YkhG9zLGPdBL49nisEUsV7uc
         RyXp4Pcbw88rAv/7xSODlnnyT9HfaAH18FvjQUbb1mvCFIKYiBvfItVR9tDifj2pP0md
         gfYSOHMWrFykyvAeXonF7+R+qQM6/Sxq7eZ1ebRi1b8fTYY4tSzFZce3sdqL07AVXH8M
         61T0AVmQ0IsltVs2a5vNTKUAjOMY8Dbp1I9AF5nARyCgbGkPxmDO346nCK/HB7hE9CMc
         dMfQ==
X-Gm-Message-State: AJIora9sUGKSVz5KQRFG8NsyEskm21tGJKQUTICaXfoL34WcelOJ63gf
        7VSwkel9ksB/sZ4dwVuskhZgaeSz8LqOEjA8zKUoW/tKEg==
X-Google-Smtp-Source: AGRyM1sAHvU7GqvfvAsRUKf5bk0NJRLPcZj8A+NCDwrJZ9G5gB688U1aoOSGAj4+vfJQQNS9bmYBSTnMzyY0j2jSh5k=
X-Received: by 2002:a5b:cc6:0:b0:66e:45c6:2a25 with SMTP id
 e6-20020a5b0cc6000000b0066e45c62a25mr20619329ybr.304.1658996834580; Thu, 28
 Jul 2022 01:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com> <20220728032000.127-6-xieyongji@bytedance.com>
 <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
 <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com> <CACGkMEtru8qaebnTXVu94oCV21JovkjshxYxdyzeSf=FTN0=xA@mail.gmail.com>
In-Reply-To: <CACGkMEtru8qaebnTXVu94oCV21JovkjshxYxdyzeSf=FTN0=xA@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 28 Jul 2022 16:27:03 +0800
Message-ID: <CACycT3swFhETEOPNNmLbSFaYUZEJYUkPXrddQ=w0TALE=D40Lw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] vduse: Support querying information of IOVA regions
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 2:45 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jul 28, 2022 at 2:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 1:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > >
> > > > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > > > support querying some information of IOVA regions.
> > > >
> > > > Now it can be used to query whether the IOVA region
> > > > supports userspace memory registration.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
> > > >  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
> > > >  2 files changed, 63 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > index eedff0a3885a..e820c37dcba8 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > >                                            umem.size);
> > > >                 break;
> > > >         }
> > > > +       case VDUSE_IOTLB_GET_INFO: {
> > > > +               struct vduse_iova_info info;
> > > > +               struct vhost_iotlb_map *map;
> > > > +               struct vduse_iova_domain *domain = dev->domain;
> > > > +
> > > > +               ret = -EFAULT;
> > > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > > +                       break;
> > > > +
> > > > +               ret = -EINVAL;
> > > > +               if (info.start > info.last)
> > > > +                       break;
> > > > +
> > > > +               if (!is_mem_zero((const char *)info.reserved,
> > > > +                                sizeof(info.reserved)))
> > > > +                       break;
> > > > +
> > > > +               spin_lock(&domain->iotlb_lock);
> > > > +               map = vhost_iotlb_itree_first(domain->iotlb,
> > > > +                                             info.start, info.last);
> > > > +               if (map) {
> > > > +                       info.start = map->start;
> > > > +                       info.last = map->last;
> > > > +                       info.capability = 0;
> > > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > > +                           map->last < domain->bounce_size)
> > > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> > > > +               }
> > > > +               spin_unlock(&domain->iotlb_lock);
> > > > +               if (!map)
> > > > +                       break;
> > > > +
> > > > +               ret = -EFAULT;
> > > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > > +                       break;
> > > > +
> > > > +               ret = 0;
> > > > +               break;
> > > > +       }
> > > >         default:
> > > >                 ret = -ENOIOCTLCMD;
> > > >                 break;
> > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > > index 9885e0571f09..11bd48c72c6c 100644
> > > > --- a/include/uapi/linux/vduse.h
> > > > +++ b/include/uapi/linux/vduse.h
> > > > @@ -233,6 +233,30 @@ struct vduse_iova_umem {
> > > >  /* De-register the userspace memory. Caller should set iova and size field. */
> > > >  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> > > >
> > > > +/**
> > > > + * struct vduse_iova_info - information of one IOVA region
> > > > + * @start: start of the IOVA region
> > > > + * @last: last of the IOVA region
> > > > + * @capability: capability of the IOVA regsion
> > > > + * @reserved: for future use, needs to be initialized to zero
> > > > + *
> > > > + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > > > + * one IOVA region.
> > > > + */
> > > > +struct vduse_iova_info {
> > > > +       __u64 start;
> > > > +       __u64 last;
> > > > +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > > > +       __u64 capability;
> > > > +       __u64 reserved[3];
> > > > +};
> > > > +
> > > > +/*
> > > > + * Find the first IOVA region that overlaps with the range [start, last]
> > >
> > > So the code is actually find the IOVA region that is the super range
> > > of [start, last] instead of overlap:
> > >
> >
> > This is achieved by vhost_iotlb_itree_first(). And can't the super
> > range of [start,last] be considered overlapping?
>
> Ok, but what I want to ask is, under which condition can we hit the
> following case
>
> map->last >= domain->bounce_size ?
>

I think we would not hit this case currently.

Thanks,
Yongji
