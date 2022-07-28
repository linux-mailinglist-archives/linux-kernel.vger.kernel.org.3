Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F0B583AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiG1JCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiG1JCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C91F65662
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658998963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzC7zxZBrSOXts7QAnv7lFC1B1g3+eSUwjPBNTC8QDM=;
        b=a67Axq3Kr6lEcnzrG6pxSaSjP3ALohR4Bv74O2XBzKIpACC5QXH0wIMH7UxP9eFsR4pNhA
        bIbZsF62mgdcZLb+xnuWyYc0VTkwzi1U/2na2yyI4IluptSlm3vkopW2nKdDwRB/yY0BFy
        2R0SgIeeBBA6kPYANilfym2LrcBDWz8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-dgqGbPA_P3GQYpRina5G1A-1; Thu, 28 Jul 2022 05:02:42 -0400
X-MC-Unique: dgqGbPA_P3GQYpRina5G1A-1
Received: by mail-ej1-f69.google.com with SMTP id hq20-20020a1709073f1400b0072b9824f0a2so434272ejc.23
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzC7zxZBrSOXts7QAnv7lFC1B1g3+eSUwjPBNTC8QDM=;
        b=U3DVzDvJOHcy70vKVkeqqk8L438SbULUADcE1fdqkLzoh2451GG1MAlQVrReEBaJhc
         VsE2WSAdHVhtOyhuTrbv09pkOR0uMpqeJWbYLyKioUWMMtmGAzPHLDvX2Je1EcPFOdsy
         UqRTB6Z1B1b7yIP1aZR9PDJUTKXpit0S8+omArRsviD8qXPl4mB8daiI2YL2pomGv+Sa
         Rp99st4yDwb9UzpnXinbWFPuCpX/iQPXmFs1eoJvHl+PHPQ7hKwB+aSuODvXJCvBSp4w
         AtQDp94KyAWuV8Re47n36B3qOJTDTMr+09UnVo99HzJD9RbwFSp2PA3WCX8e85J16Qy1
         FjKQ==
X-Gm-Message-State: AJIora+xLdEVIzNH4X1+Ylk40pwplT6OhUo6gBuuRxTqYBDtPCWDCW8D
        cYb3yvAfPHdKL0z3a5acdY+cZWq8f7t0pAnUSRsNTEQaNzU5Sjsd3uH77onVZsh2PEhpsMnnksp
        xLebH6aA/b/cusjshw9++qZg/T1jaJPsLGToEzydp
X-Received: by 2002:a17:907:2cf6:b0:72b:9d9b:2404 with SMTP id hz22-20020a1709072cf600b0072b9d9b2404mr20022938ejc.171.1658998959967;
        Thu, 28 Jul 2022 02:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tQIqsVpahFrnYCYZvp58S9uAUE4QDiEw5xrWFlR9EOhNei8yHZPwCsR7qCe+NUhl7lSU3iC4+jdb5+ANa8Z3E=
X-Received: by 2002:a17:907:2cf6:b0:72b:9d9b:2404 with SMTP id
 hz22-20020a1709072cf600b0072b9d9b2404mr20022919ejc.171.1658998959626; Thu, 28
 Jul 2022 02:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com> <20220728032000.127-6-xieyongji@bytedance.com>
 <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
 <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
 <CACGkMEtru8qaebnTXVu94oCV21JovkjshxYxdyzeSf=FTN0=xA@mail.gmail.com> <CACycT3swFhETEOPNNmLbSFaYUZEJYUkPXrddQ=w0TALE=D40Lw@mail.gmail.com>
In-Reply-To: <CACycT3swFhETEOPNNmLbSFaYUZEJYUkPXrddQ=w0TALE=D40Lw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 28 Jul 2022 17:02:28 +0800
Message-ID: <CACGkMEsGt4=2c20xfi-4ZYfnn9NYHQ=CQm8TrP7HSYiwwDCWag@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] vduse: Support querying information of IOVA regions
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 4:27 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Jul 28, 2022 at 2:45 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 2:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 1:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > > > > support querying some information of IOVA regions.
> > > > >
> > > > > Now it can be used to query whether the IOVA region
> > > > > supports userspace memory registration.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
> > > > >  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
> > > > >  2 files changed, 63 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > index eedff0a3885a..e820c37dcba8 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > > >                                            umem.size);
> > > > >                 break;
> > > > >         }
> > > > > +       case VDUSE_IOTLB_GET_INFO: {
> > > > > +               struct vduse_iova_info info;
> > > > > +               struct vhost_iotlb_map *map;
> > > > > +               struct vduse_iova_domain *domain = dev->domain;
> > > > > +
> > > > > +               ret = -EFAULT;
> > > > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > > > +                       break;
> > > > > +
> > > > > +               ret = -EINVAL;
> > > > > +               if (info.start > info.last)
> > > > > +                       break;
> > > > > +
> > > > > +               if (!is_mem_zero((const char *)info.reserved,
> > > > > +                                sizeof(info.reserved)))
> > > > > +                       break;
> > > > > +
> > > > > +               spin_lock(&domain->iotlb_lock);
> > > > > +               map = vhost_iotlb_itree_first(domain->iotlb,
> > > > > +                                             info.start, info.last);
> > > > > +               if (map) {
> > > > > +                       info.start = map->start;
> > > > > +                       info.last = map->last;
> > > > > +                       info.capability = 0;
> > > > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > > > +                           map->last < domain->bounce_size)
> > > > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> > > > > +               }
> > > > > +               spin_unlock(&domain->iotlb_lock);
> > > > > +               if (!map)
> > > > > +                       break;
> > > > > +
> > > > > +               ret = -EFAULT;
> > > > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > > > +                       break;
> > > > > +
> > > > > +               ret = 0;
> > > > > +               break;
> > > > > +       }
> > > > >         default:
> > > > >                 ret = -ENOIOCTLCMD;
> > > > >                 break;
> > > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > > > index 9885e0571f09..11bd48c72c6c 100644
> > > > > --- a/include/uapi/linux/vduse.h
> > > > > +++ b/include/uapi/linux/vduse.h
> > > > > @@ -233,6 +233,30 @@ struct vduse_iova_umem {
> > > > >  /* De-register the userspace memory. Caller should set iova and size field. */
> > > > >  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> > > > >
> > > > > +/**
> > > > > + * struct vduse_iova_info - information of one IOVA region
> > > > > + * @start: start of the IOVA region
> > > > > + * @last: last of the IOVA region
> > > > > + * @capability: capability of the IOVA regsion
> > > > > + * @reserved: for future use, needs to be initialized to zero
> > > > > + *
> > > > > + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > > > > + * one IOVA region.
> > > > > + */
> > > > > +struct vduse_iova_info {
> > > > > +       __u64 start;
> > > > > +       __u64 last;
> > > > > +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > > > > +       __u64 capability;
> > > > > +       __u64 reserved[3];
> > > > > +};
> > > > > +
> > > > > +/*
> > > > > + * Find the first IOVA region that overlaps with the range [start, last]
> > > >
> > > > So the code is actually find the IOVA region that is the super range
> > > > of [start, last] instead of overlap:
> > > >
> > >
> > > This is achieved by vhost_iotlb_itree_first(). And can't the super
> > > range of [start,last] be considered overlapping?
> >
> > Ok, but what I want to ask is, under which condition can we hit the
> > following case
> >
> > map->last >= domain->bounce_size ?
> >
>
> I think we would not hit this case currently.

I wonder if it's worthwhile to have a WARN or just remove this check.

Thanks

>
> Thanks,
> Yongji
>

