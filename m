Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2ED587788
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiHBHIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiHBHIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B2FFD13A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659424126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lk5fZhTJlKNzqEKorGVmO33xROpi/F0xbp6DLCxyEPg=;
        b=F2swS8uX3w+nwOAvNMhp77zZgPKZOqyKl5I2KJVsKYD7Utzg/i4tmEtr2AvuhGFauX3AAc
        ug6h6dlV9t15wQ+SeNWVPflprfZ5vrajbEL/ZOSZNOWq9drvHJCotlWpof9OUpzgDZdxYZ
        yO07FjbrozJFA2Xp0Csj+eKfXGAxySE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-vF9FLO44MQmSTrt_L6I11Q-1; Tue, 02 Aug 2022 03:08:36 -0400
X-MC-Unique: vF9FLO44MQmSTrt_L6I11Q-1
Received: by mail-lj1-f200.google.com with SMTP id d4-20020a2e9284000000b0025e0f56d216so2855483ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lk5fZhTJlKNzqEKorGVmO33xROpi/F0xbp6DLCxyEPg=;
        b=erXpAQYSYpuasr6XzR36jhWVct8wz8XMgUZeL/V++lOulNUzVv/EhFHt6Lr4JrtiSE
         fMReLyX4jzzSZAsQF8HnPh43SX/HALWfn9/hyEWe9sGkHlb6SJJKUEwJigGSSAyE09pT
         BCeNmWIhE6FDObO7U1CdQ+xTbNimcetbrRsRF6OAVK+MdTfPGC8SdHiEI88BR7rzVm8Z
         K2+73+lkw1odhJ5gg8wm7BOWcMYE4YIMD+z+5Y5XSSHQqwbeKX46IvqFQROMGdj0w4p5
         8FT3vCUJSYOPUE+WKTbCYVXOXyoZBiXnTy5aUiCBkaaVJ88q9ywysE5hm/7f/AqZHDdY
         NWiA==
X-Gm-Message-State: AJIora/mNN583R+cvH9nOTedDUjAd4QKYMBNWF11zY5jhtC4PXGSv98B
        w9Pmjxw26aTLEW2aBq+ndAV6qScO4QM0znr3W7LNxnKdKH7WBA4Px6wxOHVGJx0a2xXc5xRSQ0M
        KihVYR01SyGeCzezEMJ0KV9sk1+kJzxmP1ZjQo77Z
X-Received: by 2002:a19:ac09:0:b0:48a:d1b5:1791 with SMTP id g9-20020a19ac09000000b0048ad1b51791mr7113381lfc.397.1659424114680;
        Tue, 02 Aug 2022 00:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9tTifp1Bws/2DsfyiDeWIMo2y0L+F8JtPh25awuoqWTlf2NQjl6jxIlIjDgYpJJ5HisW4TjmUWlXN3MNNdv0=
X-Received: by 2002:a19:ac09:0:b0:48a:d1b5:1791 with SMTP id
 g9-20020a19ac09000000b0048ad1b51791mr7113371lfc.397.1659424114457; Tue, 02
 Aug 2022 00:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com> <20220728032000.127-6-xieyongji@bytedance.com>
 <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
 <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
 <CACGkMEtru8qaebnTXVu94oCV21JovkjshxYxdyzeSf=FTN0=xA@mail.gmail.com>
 <CACycT3swFhETEOPNNmLbSFaYUZEJYUkPXrddQ=w0TALE=D40Lw@mail.gmail.com>
 <CACGkMEsGt4=2c20xfi-4ZYfnn9NYHQ=CQm8TrP7HSYiwwDCWag@mail.gmail.com> <CACycT3vJcJp6dr6XFg=v_EUv05SZRpCzWOEPnXfoLDedBufSnQ@mail.gmail.com>
In-Reply-To: <CACycT3vJcJp6dr6XFg=v_EUv05SZRpCzWOEPnXfoLDedBufSnQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 2 Aug 2022 15:08:22 +0800
Message-ID: <CACGkMEtTnwG2y4RT6E7tzkWh0rm2xJJEgV8cvjWkqt3th-4DUA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] vduse: Support querying information of IOVA regions
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 11:17 AM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Jul 28, 2022 at 5:02 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 4:27 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 2:45 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jul 28, 2022 at 2:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > On Thu, Jul 28, 2022 at 1:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > > >
> > > > > > > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > > > > > > support querying some information of IOVA regions.
> > > > > > >
> > > > > > > Now it can be used to query whether the IOVA region
> > > > > > > supports userspace memory registration.
> > > > > > >
> > > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
> > > > > > >  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
> > > > > > >  2 files changed, 63 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > index eedff0a3885a..e820c37dcba8 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > > > > >                                            umem.size);
> > > > > > >                 break;
> > > > > > >         }
> > > > > > > +       case VDUSE_IOTLB_GET_INFO: {
> > > > > > > +               struct vduse_iova_info info;
> > > > > > > +               struct vhost_iotlb_map *map;
> > > > > > > +               struct vduse_iova_domain *domain = dev->domain;
> > > > > > > +
> > > > > > > +               ret = -EFAULT;
> > > > > > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               ret = -EINVAL;
> > > > > > > +               if (info.start > info.last)
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               if (!is_mem_zero((const char *)info.reserved,
> > > > > > > +                                sizeof(info.reserved)))
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               spin_lock(&domain->iotlb_lock);
> > > > > > > +               map = vhost_iotlb_itree_first(domain->iotlb,
> > > > > > > +                                             info.start, info.last);
> > > > > > > +               if (map) {
> > > > > > > +                       info.start = map->start;
> > > > > > > +                       info.last = map->last;
> > > > > > > +                       info.capability = 0;
> > > > > > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > > > > > +                           map->last < domain->bounce_size)
> > > > > > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> > > > > > > +               }
> > > > > > > +               spin_unlock(&domain->iotlb_lock);
> > > > > > > +               if (!map)
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               ret = -EFAULT;
> > > > > > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               ret = 0;
> > > > > > > +               break;
> > > > > > > +       }
> > > > > > >         default:
> > > > > > >                 ret = -ENOIOCTLCMD;
> > > > > > >                 break;
> > > > > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > > > > > index 9885e0571f09..11bd48c72c6c 100644
> > > > > > > --- a/include/uapi/linux/vduse.h
> > > > > > > +++ b/include/uapi/linux/vduse.h
> > > > > > > @@ -233,6 +233,30 @@ struct vduse_iova_umem {
> > > > > > >  /* De-register the userspace memory. Caller should set iova and size field. */
> > > > > > >  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> > > > > > >
> > > > > > > +/**
> > > > > > > + * struct vduse_iova_info - information of one IOVA region
> > > > > > > + * @start: start of the IOVA region
> > > > > > > + * @last: last of the IOVA region
> > > > > > > + * @capability: capability of the IOVA regsion
> > > > > > > + * @reserved: for future use, needs to be initialized to zero
> > > > > > > + *
> > > > > > > + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > > > > > > + * one IOVA region.
> > > > > > > + */
> > > > > > > +struct vduse_iova_info {
> > > > > > > +       __u64 start;
> > > > > > > +       __u64 last;
> > > > > > > +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > > > > > > +       __u64 capability;
> > > > > > > +       __u64 reserved[3];
> > > > > > > +};
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Find the first IOVA region that overlaps with the range [start, last]
> > > > > >
> > > > > > So the code is actually find the IOVA region that is the super range
> > > > > > of [start, last] instead of overlap:
> > > > > >
> > > > >
> > > > > This is achieved by vhost_iotlb_itree_first(). And can't the super
> > > > > range of [start,last] be considered overlapping?
> > > >
> > > > Ok, but what I want to ask is, under which condition can we hit the
> > > > following case
> > > >
> > > > map->last >= domain->bounce_size ?
> > > >
> > >
> > > I think we would not hit this case currently.
> >
> > I wonder if it's worthwhile to have a WARN or just remove this check.
> >
>
> I think we can't remove the check since not only the bounce region
> will match the condition: map->start >= 0.
>
> Or changing to map->start == 0 && map->last == domain->bounce_size - 1 ?

This looks like an assumption that there should be only one single map
for bound buffer.

It should be fine.

Thanks

>
> Thanks,
> Yongji
>

