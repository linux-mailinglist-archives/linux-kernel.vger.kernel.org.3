Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB622584A25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiG2DRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiG2DRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:17:45 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F57A51C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:17:43 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 123so6231186ybv.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvtHQoV3o8Kw99ckk4tHGijVcTk5oIgJe4e2tLoWlZw=;
        b=D+zZKxZmfL3MitPoh6PDqhuLHIkE23fFZBbIftQDrWvzZ8F7Yg+IFE6B/Z4YP+lhVx
         gSYSiCxlOFfccBGG3zljtf5DdlnAkIsvI893HRFut7SRil78G5ZvF871e60L213m5oU5
         gK8ptX1lRYyNOHk2Y66jwJnjUmi8M1cErcLFxFBOcj5ScznBnJoxVYUH0LXsdahuRbgK
         JXt9b58EZ7dknEWfJw+jqEs59LvQcxusUf7V9FxNUaro6VrnlY9l1ojbUGVhw+2DHGhe
         ZLl4jhYheRG1FhXj+XtDlQWNXAE1SuV0M5nSm7BAh7P5RLfg7kVM/2oHoX309p3vs4c7
         2Ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvtHQoV3o8Kw99ckk4tHGijVcTk5oIgJe4e2tLoWlZw=;
        b=mm7+E+R3rhBTdueurFh3U5u1Y1u/gbRF4A8QYsdmeRNBK0x5xkuQFmJpsJ+SyIJcIr
         SiPAoiC1emrCe+yZQt79W7/8j2Oosaua2+eUtI3/SKiL3F+ohSAovwyNkWMBzwoc3iYu
         K9vChlsDW11spuaQ0YnUuwqd75tWUvmogK7L9CE3GYsN+J5crg4lrmg/ahLUF7mQJRF9
         Hadsyl2YceCb9sCKcxvXGrERYLEmNNDHOuJXGxREi/niRkcexjElaxPqSAsmp8Igg7Qv
         vf1oRA3Umt3TVNxPHN7pTGlN2wxOBleXzj1Yd0qDB2X1ygks09DN/CoXrgLULX9QfCvn
         Kgrw==
X-Gm-Message-State: ACgBeo1yNOs9t98YFyu8C2n4Li1jlGbPgG7GXx5T0G8JOG+OS1ddfTpf
        trORfITpJj9cuNIukBT7CrxnjcqN7ceVvpFbxQ6JoJESbQ==
X-Google-Smtp-Source: AA6agR6ThtpVBg6Qpw/8IaSLk7kSVvXMyFqqkweougqEV90S2VMNePIWhG/oPtyRZ8uTQtcOmgCougz49G3EUlNHKN8=
X-Received: by 2002:a5b:cc6:0:b0:66e:45c6:2a25 with SMTP id
 e6-20020a5b0cc6000000b0066e45c62a25mr1236780ybr.304.1659064662559; Thu, 28
 Jul 2022 20:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com> <20220728032000.127-6-xieyongji@bytedance.com>
 <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
 <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
 <CACGkMEtru8qaebnTXVu94oCV21JovkjshxYxdyzeSf=FTN0=xA@mail.gmail.com>
 <CACycT3swFhETEOPNNmLbSFaYUZEJYUkPXrddQ=w0TALE=D40Lw@mail.gmail.com> <CACGkMEsGt4=2c20xfi-4ZYfnn9NYHQ=CQm8TrP7HSYiwwDCWag@mail.gmail.com>
In-Reply-To: <CACGkMEsGt4=2c20xfi-4ZYfnn9NYHQ=CQm8TrP7HSYiwwDCWag@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 29 Jul 2022 11:17:31 +0800
Message-ID: <CACycT3vJcJp6dr6XFg=v_EUv05SZRpCzWOEPnXfoLDedBufSnQ@mail.gmail.com>
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

On Thu, Jul 28, 2022 at 5:02 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jul 28, 2022 at 4:27 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 2:45 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 2:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > >
> > > > On Thu, Jul 28, 2022 at 1:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > >
> > > > > > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > > > > > support querying some information of IOVA regions.
> > > > > >
> > > > > > Now it can be used to query whether the IOVA region
> > > > > > supports userspace memory registration.
> > > > > >
> > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
> > > > > >  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
> > > > > >  2 files changed, 63 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > index eedff0a3885a..e820c37dcba8 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > > > >                                            umem.size);
> > > > > >                 break;
> > > > > >         }
> > > > > > +       case VDUSE_IOTLB_GET_INFO: {
> > > > > > +               struct vduse_iova_info info;
> > > > > > +               struct vhost_iotlb_map *map;
> > > > > > +               struct vduse_iova_domain *domain = dev->domain;
> > > > > > +
> > > > > > +               ret = -EFAULT;
> > > > > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > > > > +                       break;
> > > > > > +
> > > > > > +               ret = -EINVAL;
> > > > > > +               if (info.start > info.last)
> > > > > > +                       break;
> > > > > > +
> > > > > > +               if (!is_mem_zero((const char *)info.reserved,
> > > > > > +                                sizeof(info.reserved)))
> > > > > > +                       break;
> > > > > > +
> > > > > > +               spin_lock(&domain->iotlb_lock);
> > > > > > +               map = vhost_iotlb_itree_first(domain->iotlb,
> > > > > > +                                             info.start, info.last);
> > > > > > +               if (map) {
> > > > > > +                       info.start = map->start;
> > > > > > +                       info.last = map->last;
> > > > > > +                       info.capability = 0;
> > > > > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > > > > +                           map->last < domain->bounce_size)
> > > > > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> > > > > > +               }
> > > > > > +               spin_unlock(&domain->iotlb_lock);
> > > > > > +               if (!map)
> > > > > > +                       break;
> > > > > > +
> > > > > > +               ret = -EFAULT;
> > > > > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > > > > +                       break;
> > > > > > +
> > > > > > +               ret = 0;
> > > > > > +               break;
> > > > > > +       }
> > > > > >         default:
> > > > > >                 ret = -ENOIOCTLCMD;
> > > > > >                 break;
> > > > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > > > > index 9885e0571f09..11bd48c72c6c 100644
> > > > > > --- a/include/uapi/linux/vduse.h
> > > > > > +++ b/include/uapi/linux/vduse.h
> > > > > > @@ -233,6 +233,30 @@ struct vduse_iova_umem {
> > > > > >  /* De-register the userspace memory. Caller should set iova and size field. */
> > > > > >  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> > > > > >
> > > > > > +/**
> > > > > > + * struct vduse_iova_info - information of one IOVA region
> > > > > > + * @start: start of the IOVA region
> > > > > > + * @last: last of the IOVA region
> > > > > > + * @capability: capability of the IOVA regsion
> > > > > > + * @reserved: for future use, needs to be initialized to zero
> > > > > > + *
> > > > > > + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > > > > > + * one IOVA region.
> > > > > > + */
> > > > > > +struct vduse_iova_info {
> > > > > > +       __u64 start;
> > > > > > +       __u64 last;
> > > > > > +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > > > > > +       __u64 capability;
> > > > > > +       __u64 reserved[3];
> > > > > > +};
> > > > > > +
> > > > > > +/*
> > > > > > + * Find the first IOVA region that overlaps with the range [start, last]
> > > > >
> > > > > So the code is actually find the IOVA region that is the super range
> > > > > of [start, last] instead of overlap:
> > > > >
> > > >
> > > > This is achieved by vhost_iotlb_itree_first(). And can't the super
> > > > range of [start,last] be considered overlapping?
> > >
> > > Ok, but what I want to ask is, under which condition can we hit the
> > > following case
> > >
> > > map->last >= domain->bounce_size ?
> > >
> >
> > I think we would not hit this case currently.
>
> I wonder if it's worthwhile to have a WARN or just remove this check.
>

I think we can't remove the check since not only the bounce region
will match the condition: map->start >= 0.

Or changing to map->start == 0 && map->last == domain->bounce_size - 1 ?

Thanks,
Yongji
