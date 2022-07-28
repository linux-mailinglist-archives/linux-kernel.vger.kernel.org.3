Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F42255838D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiG1GgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiG1GgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:36:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5004A53D06
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:36:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c131so1785471ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUUY1/m9+7HRXnB9jDKYnmw1m+gsNorqO+vRcx+LMJY=;
        b=nvfafRvrKAraORSdu+1C6Xh5aHA1yz1+2dU+Rya+Xu5DX52aP91mdTywZybyHdOz+r
         UUX1b5sm4H3TBmOwW3/T1LRr8DuvKZVn6oSFAPx3OSbwkfeZhNDSsp7X54L68axMM8mG
         auNXdHwUhKO2pZ/l+8gwrOkL2jqGy7LCZvcDKoeqJi2TlX4PQfc5JRSV6pTcoXXL8AUy
         omhOsJWk9ayB5O6pj555W92PovgNhHnb0j0hvEH+HDLSUf6dIEvsWcNLLPs31PS3NCFX
         X2iNUKdJHTN//Uswws22x1NJ2Atpxv+5oBXWp4RLekbJOUfQZoIJq3uehe0GWsZ1+i+g
         Qesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUUY1/m9+7HRXnB9jDKYnmw1m+gsNorqO+vRcx+LMJY=;
        b=R4woz5OI0LKy/CiWQ0knV+8iekbU+gfCvv5LHig6vaxQFnQOhnsYKCWSX8a5SqxYTe
         Ei6DpyRFN5YWeJu12EnkyTw9LUShAdwsp0GWPLvTk9LeHB0TOMJFPIcrB5f9RzqisVOP
         kQlJA35k5cDaVzRJkNIwDo5bw+gbb/iJtFXAfIVRk7TuUwrP7/vfNXxa3Y1bWUlei9CA
         NZNeeLzYcGeXNh86TH/VAVEw3Q0eGPjg48A9XaQRRbRDoLYCWvn1+guksUAv8hD/Od9q
         FPbXZuaI+J9GhL63FnqJlHyYX6zZKcRh4IZ5szwsPMge56n7Xlnpm5L7ojh4UgAakXEa
         ee5Q==
X-Gm-Message-State: AJIora/MNJ7Z9kyuOdDG/bAOhu1S62M0f4gKuujvcB88ZS4d3Qk21Ry3
        3di3ti1G8qNRHhuZkB+luQ+rRj+1VxCLVQ32o82O
X-Google-Smtp-Source: AGRyM1uFHWzndaowSIphhB+gGC2rtHX8jCfsRWDss3omccRLbvby7X2uvNMtXxfhASuJ/UU42RQSY4+UfGO+VjJ5DSg=
X-Received: by 2002:a25:5f51:0:b0:676:3753:ea26 with SMTP id
 h17-20020a255f51000000b006763753ea26mr347281ybm.649.1658990173390; Wed, 27
 Jul 2022 23:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com> <20220728032000.127-6-xieyongji@bytedance.com>
 <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
In-Reply-To: <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 28 Jul 2022 14:36:02 +0800
Message-ID: <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
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

On Thu, Jul 28, 2022 at 1:58 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > support querying some information of IOVA regions.
> >
> > Now it can be used to query whether the IOVA region
> > supports userspace memory registration.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
> >  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
> >  2 files changed, 63 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index eedff0a3885a..e820c37dcba8 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >                                            umem.size);
> >                 break;
> >         }
> > +       case VDUSE_IOTLB_GET_INFO: {
> > +               struct vduse_iova_info info;
> > +               struct vhost_iotlb_map *map;
> > +               struct vduse_iova_domain *domain = dev->domain;
> > +
> > +               ret = -EFAULT;
> > +               if (copy_from_user(&info, argp, sizeof(info)))
> > +                       break;
> > +
> > +               ret = -EINVAL;
> > +               if (info.start > info.last)
> > +                       break;
> > +
> > +               if (!is_mem_zero((const char *)info.reserved,
> > +                                sizeof(info.reserved)))
> > +                       break;
> > +
> > +               spin_lock(&domain->iotlb_lock);
> > +               map = vhost_iotlb_itree_first(domain->iotlb,
> > +                                             info.start, info.last);
> > +               if (map) {
> > +                       info.start = map->start;
> > +                       info.last = map->last;
> > +                       info.capability = 0;
> > +                       if (domain->bounce_map && map->start >= 0 &&
> > +                           map->last < domain->bounce_size)
> > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> > +               }
> > +               spin_unlock(&domain->iotlb_lock);
> > +               if (!map)
> > +                       break;
> > +
> > +               ret = -EFAULT;
> > +               if (copy_to_user(argp, &info, sizeof(info)))
> > +                       break;
> > +
> > +               ret = 0;
> > +               break;
> > +       }
> >         default:
> >                 ret = -ENOIOCTLCMD;
> >                 break;
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index 9885e0571f09..11bd48c72c6c 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -233,6 +233,30 @@ struct vduse_iova_umem {
> >  /* De-register the userspace memory. Caller should set iova and size field. */
> >  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> >
> > +/**
> > + * struct vduse_iova_info - information of one IOVA region
> > + * @start: start of the IOVA region
> > + * @last: last of the IOVA region
> > + * @capability: capability of the IOVA regsion
> > + * @reserved: for future use, needs to be initialized to zero
> > + *
> > + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > + * one IOVA region.
> > + */
> > +struct vduse_iova_info {
> > +       __u64 start;
> > +       __u64 last;
> > +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > +       __u64 capability;
> > +       __u64 reserved[3];
> > +};
> > +
> > +/*
> > + * Find the first IOVA region that overlaps with the range [start, last]
>
> So the code is actually find the IOVA region that is the super range
> of [start, last] instead of overlap:
>

This is achieved by vhost_iotlb_itree_first(). And can't the super
range of [start,last] be considered overlapping?

>
> > +                       if (domain->bounce_map && map->start >= 0 &&
> > +                           map->last < domain->bounce_size)
> > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
>
> Which part is wrong?
>

We will first call vhost_iotlb_itree_first() which will find the first
IOVA region that overlaps with the range [start, last]. Then the flag
will only be set if the IOVA region is within the bounce range.

Thanks,
Yongji
