Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48B8589732
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiHDExb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiHDEx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 144325F9B9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659588805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OLmka0NC3UlfBuYckPNASUIU1cERM9leULZwcp5E6j4=;
        b=Ka08RA122PHXGQkfLfjiGk7FJK+r0Nmc+cX40mvz11B36cB4VZlQHaAfvCZIomsPtENxCK
        jGCrAF3QxuxHlV/wVmv2n0Rxc4ghcu4COAru1ArEVn97DDPBWNINexvn9jwiR3arjgPzag
        LUs3oGPAbup9q1S+HNysv/ZQZ7mqp1E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-EpHnSM9dO8KOPYsQSwKELw-1; Thu, 04 Aug 2022 00:53:24 -0400
X-MC-Unique: EpHnSM9dO8KOPYsQSwKELw-1
Received: by mail-lf1-f70.google.com with SMTP id m5-20020ac24245000000b0048a7c6bf079so5620700lfl.15
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 21:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLmka0NC3UlfBuYckPNASUIU1cERM9leULZwcp5E6j4=;
        b=fk4A7juF8GrYF6TvtR8EKKkLR4ziKJQahiRm4xX51ekDcgyQ0vP1NtXklsnvbzcOPR
         /sBYXccEQFMbMATLhkSndsW0UnEzcladgJfrtqCWjAohIdPvCIIzt0AtHq6LDdJa5wE0
         f4gQfaHF4IBZ7mDm31SW52NU7JQnoROk/Lycb/ZMj95uKUvM8Sz3aGhrnTmarNxuDGXG
         IoTEfSN74SrBU2SI4aSGZIjyCD3dVExPNEfPtcDyr+Nufk+9Xt92MVZobTI6YJztDBxh
         D/csam7huwFuMxryTArXOJVOwJHXJMD6LWgWiSBPHiJiLdeQuXVm2ePX4AwsklcAF5q9
         PoOA==
X-Gm-Message-State: ACgBeo0CVpOmvw+BlJVRI0LJE18VgvDkTpNbdQxz/AQlVcEeFU8Sepdn
        70jPtPZv1Mg0/QhG3XDGLnQbgIk693lasT38FaTCE2u4I7LcQedFK3Kp6ia9NcWUpJ5Ba5vmLOm
        MiuEdGrMvZx4YTQ1QerI9vFGTqwK7nApVz+qEzaBo
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id y14-20020a0565123f0e00b0048a5edd99b2mr82485lfa.124.1659588800238;
        Wed, 03 Aug 2022 21:53:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4E+uvfcwgkuiwuzZB+8RJjAjNJM0hEmaUlpNaRuyeUjSSQarpOIMjsof16sQtNs6Wj+6Y44uUEG5p2j1j0Q+g=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr82481lfa.124.1659588800034; Wed, 03 Aug
 2022 21:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220803045523.23851-1-xieyongji@bytedance.com> <20220803045523.23851-6-xieyongji@bytedance.com>
In-Reply-To: <20220803045523.23851-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 4 Aug 2022 12:53:09 +0800
Message-ID: <CACGkMEs4LxYh1K3O=ycu-r+AJjSmvrJpHZbw+i+SDM-w-pbm+A@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] vduse: Support querying information of IOVA regions
To:     Xie Yongji <xieyongji@bytedance.com>
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

On Wed, Aug 3, 2022 at 12:56 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> support querying some information of IOVA regions.
>
> Now it can be used to query whether the IOVA region
> supports userspace memory registration.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index eedff0a3885a..41c0b29739f1 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                                            umem.size);
>                 break;
>         }
> +       case VDUSE_IOTLB_GET_INFO: {
> +               struct vduse_iova_info info;
> +               struct vhost_iotlb_map *map;
> +               struct vduse_iova_domain *domain = dev->domain;
> +
> +               ret = -EFAULT;
> +               if (copy_from_user(&info, argp, sizeof(info)))
> +                       break;
> +
> +               ret = -EINVAL;
> +               if (info.start > info.last)
> +                       break;
> +
> +               if (!is_mem_zero((const char *)info.reserved,
> +                                sizeof(info.reserved)))
> +                       break;
> +
> +               spin_lock(&domain->iotlb_lock);
> +               map = vhost_iotlb_itree_first(domain->iotlb,
> +                                             info.start, info.last);
> +               if (map) {
> +                       info.start = map->start;
> +                       info.last = map->last;
> +                       info.capability = 0;
> +                       if (domain->bounce_map && map->start == 0 &&
> +                           map->last == domain->bounce_size - 1)
> +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> +               }
> +               spin_unlock(&domain->iotlb_lock);
> +               if (!map)
> +                       break;
> +
> +               ret = -EFAULT;
> +               if (copy_to_user(argp, &info, sizeof(info)))
> +                       break;
> +
> +               ret = 0;
> +               break;
> +       }
>         default:
>                 ret = -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 9885e0571f09..11bd48c72c6c 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -233,6 +233,30 @@ struct vduse_iova_umem {
>  /* De-register the userspace memory. Caller should set iova and size field. */
>  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
>
> +/**
> + * struct vduse_iova_info - information of one IOVA region
> + * @start: start of the IOVA region
> + * @last: last of the IOVA region
> + * @capability: capability of the IOVA regsion
> + * @reserved: for future use, needs to be initialized to zero
> + *
> + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> + * one IOVA region.
> + */
> +struct vduse_iova_info {
> +       __u64 start;
> +       __u64 last;
> +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> +       __u64 capability;
> +       __u64 reserved[3];
> +};
> +
> +/*
> + * Find the first IOVA region that overlaps with the range [start, last]
> + * and return some information on it. Caller should set start and last fields.
> + */
> +#define VDUSE_IOTLB_GET_INFO   _IOWR(VDUSE_BASE, 0x1a, struct vduse_iova_info)
> +
>  /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
>
>  /**
> --
> 2.20.1
>

