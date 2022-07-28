Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2565838F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiG1GqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiG1GqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62AD04B4A6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658990760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dySmMr3XE6Y2DZ+UTqy4HFm8XEDkjL730Qh4ZxkIk0E=;
        b=arOOgevxVXwhyV1OZXtwukoJWKrbr0MOk9KyuKZXnWviZXNR6PQqHlLQ6FwzeKgqoBHbJT
        HHkUv9lTAKumcbM5tRJ7rRVo9RPnCvMb3SAIt/PLTtTgT5XCj7rGw1v3xq/KRq6aOGBrXA
        5+YLIemDFC4BGZfBRBYUhZvLKZTEC+8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-3wtUNbZ8OCS5d-uyZ0ojGQ-1; Thu, 28 Jul 2022 02:45:50 -0400
X-MC-Unique: 3wtUNbZ8OCS5d-uyZ0ojGQ-1
Received: by mail-lj1-f200.google.com with SMTP id x7-20020a05651c104700b0025e2f0ded1fso96776ljm.23
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dySmMr3XE6Y2DZ+UTqy4HFm8XEDkjL730Qh4ZxkIk0E=;
        b=5inEAFv3trvxQmCrqi64i1ybaeSBrGwaK5ZyCWwfZ8o6rLMnHkwEHbbRCj08roinXq
         LL/2fBwEMKvO2qU3xAhFSc5opHYGfr3tQAje6NBlNFZy5TX6yJT1n6tf1CRqfaBUVkCs
         UY11RKf/ZC4oBpSp3kwnz22jRs+8zjbAQHLulYnBUsitsj0lclguaU8F/0eokFnBcIi5
         3Sw1x8nv35+x6BjzMQDaM1emxLPIZVhw/MjlKB7olUjA5whvoraPmbCEq5MaGrLz9EiF
         dTjNRcvjfZ0A6D5Ia8EJ9OLKygJEGUK5urlXOEVZBEJJzJ0L6y3EtnHNAOOu8At0x/PY
         Mj6Q==
X-Gm-Message-State: AJIora+x6mFriuE1TYBN1faRTKt2PPZdxKAm9gS1FDrHSOZdILhbuoPG
        R8uXRqyCHUdwgfC5cWBlwhbp67G3CvWPlU1V+squZYEZKCsdZu8WcvRRICR1lbGkqA963Qf2eC4
        //d8MxR6Nda+ZcWGbWcFrACcxLXya5g1xOC4qau41
X-Received: by 2002:a2e:9e1a:0:b0:25d:f9db:92f7 with SMTP id e26-20020a2e9e1a000000b0025df9db92f7mr8230364ljk.243.1658990749370;
        Wed, 27 Jul 2022 23:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tH1Q7TY/ZV4QNhhL/XnK7bne/Y8apL0+dHhqk+6H2/FqgTpGY6xlOKC0cW/jXWoJCJgfKOTSmXfYi9SMA6pEs=
X-Received: by 2002:a2e:9e1a:0:b0:25d:f9db:92f7 with SMTP id
 e26-20020a2e9e1a000000b0025df9db92f7mr8230357ljk.243.1658990749155; Wed, 27
 Jul 2022 23:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com> <20220728032000.127-6-xieyongji@bytedance.com>
 <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com> <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
In-Reply-To: <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 28 Jul 2022 14:45:38 +0800
Message-ID: <CACGkMEtru8qaebnTXVu94oCV21JovkjshxYxdyzeSf=FTN0=xA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] vduse: Support querying information of IOVA regions
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 2:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Jul 28, 2022 at 1:58 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > > support querying some information of IOVA regions.
> > >
> > > Now it can be used to query whether the IOVA region
> > > supports userspace memory registration.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
> > >  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
> > >  2 files changed, 63 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index eedff0a3885a..e820c37dcba8 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >                                            umem.size);
> > >                 break;
> > >         }
> > > +       case VDUSE_IOTLB_GET_INFO: {
> > > +               struct vduse_iova_info info;
> > > +               struct vhost_iotlb_map *map;
> > > +               struct vduse_iova_domain *domain = dev->domain;
> > > +
> > > +               ret = -EFAULT;
> > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > +                       break;
> > > +
> > > +               ret = -EINVAL;
> > > +               if (info.start > info.last)
> > > +                       break;
> > > +
> > > +               if (!is_mem_zero((const char *)info.reserved,
> > > +                                sizeof(info.reserved)))
> > > +                       break;
> > > +
> > > +               spin_lock(&domain->iotlb_lock);
> > > +               map = vhost_iotlb_itree_first(domain->iotlb,
> > > +                                             info.start, info.last);
> > > +               if (map) {
> > > +                       info.start = map->start;
> > > +                       info.last = map->last;
> > > +                       info.capability = 0;
> > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > +                           map->last < domain->bounce_size)
> > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> > > +               }
> > > +               spin_unlock(&domain->iotlb_lock);
> > > +               if (!map)
> > > +                       break;
> > > +
> > > +               ret = -EFAULT;
> > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > +                       break;
> > > +
> > > +               ret = 0;
> > > +               break;
> > > +       }
> > >         default:
> > >                 ret = -ENOIOCTLCMD;
> > >                 break;
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index 9885e0571f09..11bd48c72c6c 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -233,6 +233,30 @@ struct vduse_iova_umem {
> > >  /* De-register the userspace memory. Caller should set iova and size field. */
> > >  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> > >
> > > +/**
> > > + * struct vduse_iova_info - information of one IOVA region
> > > + * @start: start of the IOVA region
> > > + * @last: last of the IOVA region
> > > + * @capability: capability of the IOVA regsion
> > > + * @reserved: for future use, needs to be initialized to zero
> > > + *
> > > + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > > + * one IOVA region.
> > > + */
> > > +struct vduse_iova_info {
> > > +       __u64 start;
> > > +       __u64 last;
> > > +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > > +       __u64 capability;
> > > +       __u64 reserved[3];
> > > +};
> > > +
> > > +/*
> > > + * Find the first IOVA region that overlaps with the range [start, last]
> >
> > So the code is actually find the IOVA region that is the super range
> > of [start, last] instead of overlap:
> >
>
> This is achieved by vhost_iotlb_itree_first(). And can't the super
> range of [start,last] be considered overlapping?

Ok, but what I want to ask is, under which condition can we hit the
following case

map->last >= domain->bounce_size ?

Thanks

>
> >
> > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > +                           map->last < domain->bounce_size)
> > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> >
> > Which part is wrong?
> >
>
> We will first call vhost_iotlb_itree_first() which will find the first
> IOVA region that overlaps with the range [start, last]. Then the flag
> will only be set if the IOVA region is within the bounce range.
>
> Thanks,
> Yongji
>

