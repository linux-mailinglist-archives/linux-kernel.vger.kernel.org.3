Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97D957C3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiGUFiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGUFiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:38:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36BC30F67
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:38:04 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id l11so1019910ybu.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEbY+UdcRJSElq0P7L4/KDdxeRCwEYJgFfHXwQLLZHc=;
        b=cqxfxuP/yHlleNMSpmYXC7PWUYCrEL6GniuxeEutJEBNmUQFY/Y8BNMMJnaxOxlSC/
         GOBK/mA0E5y4TARAIx0U8ls3D/a+vg/ePfuSawrj/h0XaO1NgLkNrqWD8WOCrm25dFMH
         /lcew+foloMZQafT2P3xKiwUDnRrzF99mnddkvuSgYTm80lxw5JISX/XMAnWxadST75A
         rj+bGx8rn91AOzOdJ5Z0+muULMvTu9eEWHCPY9zqiRk/AMsnhZfleR2D5pxAAtzuQsw1
         mwqq3BolLbJikUDbaL0C/Zd54OPjnmyiyYmkaZvz6aPBTa6fJY7vnGUOojBU8UqcfLTr
         9LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEbY+UdcRJSElq0P7L4/KDdxeRCwEYJgFfHXwQLLZHc=;
        b=XKbgc7UjQ6Va2Xn6Ou5WXKGq0avy1Cbz1Z0qpTcWCnwjpk+RbgmVjt5fpUILL283L9
         WsCwoNotDaYg0A6+yLF3o1kNH/4pDzyhYskBDbCKKBoihkY6vomXOS7qvnGWH8GU5rF8
         BMF4S1uGOEoGCCXP89rbmKq86qw0t9sBD/ldSac+R5TnP2SIaiqSy1wXcF0+q4xV93FD
         PdEU2njWTMaxn5xaY+Ax9AWuOVeSLNjK32Q2HrtZxGnm9zezmyJWy5ITIcMaQxjbRlc+
         fygn7VaaxUINMzfNLdaNzDsFRsUCGrtrn6CApnW5ufG7O83+D9ua9EGMM9uvIdqJNnam
         HZ2w==
X-Gm-Message-State: AJIora/BvDukmDaeka68nWqYIAxc2NosA1LHwARGAnqX8nveoUdLEO+9
        zWTrhu5IMX8tV3BRJa5RblwN5s4eXBG7aGO1hf+5
X-Google-Smtp-Source: AGRyM1vyEl1OsxehVnO27Noj73kHPePI8DRK22VT54fEdRlVhvZiYc2fETtzZKbk635WCQhFzBLHr0AoiwBm/NCqSDU=
X-Received: by 2002:a25:6a43:0:b0:66f:d259:7918 with SMTP id
 f64-20020a256a43000000b0066fd2597918mr33079789ybc.486.1658381884132; Wed, 20
 Jul 2022 22:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044144.90-1-xieyongji@bytedance.com> <20220720044144.90-6-xieyongji@bytedance.com>
 <CACGkMEti0LLi8s7V_9oCvSgj=-nNAEHLipnnwtH0_RTF75-XrQ@mail.gmail.com>
In-Reply-To: <CACGkMEti0LLi8s7V_9oCvSgj=-nNAEHLipnnwtH0_RTF75-XrQ@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 21 Jul 2022 13:37:53 +0800
Message-ID: <CACycT3vKFUdOSF7n79Cxt3pg0hF3uxdMjiN+=mNLwUJeVHtdxw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] vduse: Support querying information of IOVA regions
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

On Wed, Jul 20, 2022 at 5:15 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Jul 20, 2022 at 12:42 PM Xie Yongji <xieyongji@bytedance.com> wrote:
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
> >  include/uapi/linux/vduse.h         | 25 +++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index eedff0a3885a..cc4a9a700c24 100644
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
>
> We don't check map->start and map->last in GET_FD, any reason for
> those checks here?
>

Since we only support userspace memory registration for the bounce
buffer region. We don't need to set VDUSE_IOVA_CAP_UMEM_SUPPORT for
any other region.

> > +                               info.capability |= VDUSE_IOVA_CAP_UMEM_SUPPORT;
>
> Not a native speaker, but I think CAP is duplicated with SUPPORT.
>
> Something like VDUSE_IOVA_CAP_UMEM might be better.
>

OK.

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
> > index 9885e0571f09..720fb0b6d8ff 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -233,6 +233,31 @@ struct vduse_iova_umem {
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
> > +#define VDUSE_IOVA_CAP_UMEM_SUPPORT (1 << 0)
> > +       __u64 capability;
> > +       __u64 reserved[3];
> > +};
> > +
> > +/*
> > + * Find the first IOVA region that overlaps with the range [start, last]
> > + * and return some information on it. Caller should set start and last fields.
> > + */
> > +#define VDUSE_IOTLB_GET_INFO   _IOW(VDUSE_BASE, 0x1a, struct vduse_iova_info)
>
> This should be _IOWR() ?
>

Will fix it.

Thanks,
Yongji
