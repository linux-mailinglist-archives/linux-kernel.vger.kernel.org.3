Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FC9583853
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiG1F6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiG1F6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 418995A2EC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658987885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VTL7R2ln0lyo49p8Nu+NwDtwT2nCSo+7KDiGxqDzOU=;
        b=QEKw9Ot27WcGuE+gVKSPVRD7WQ4jwj2ZIa5s4b0DB6yjgJ7qpCXxzIcV5g12tcJteaEY1y
        qDNDd7t7w3BaRo0Ys9wlIrRpLQ20raCV7aiCuxenlAJ32lNSvQpAI0ST+9q97OQoBrJqCr
        QdDJP8oyFh+nKKQZalJG6bLBiaKAzVs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-9JI5uku9POOwPO_27lkFyg-1; Thu, 28 Jul 2022 01:58:01 -0400
X-MC-Unique: 9JI5uku9POOwPO_27lkFyg-1
Received: by mail-lf1-f72.google.com with SMTP id k30-20020a0565123d9e00b0048a716121bcso335893lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VTL7R2ln0lyo49p8Nu+NwDtwT2nCSo+7KDiGxqDzOU=;
        b=Ybf3yQ+QKLPt1ZrofwlQUzKa946CoqIV+ShQkEaW+f/YsRvi6DW5hFAyq/mR7AQa4N
         4Ub0ELpwAW1jkueLnhf2xkqapY2wTErshfFTK8MAe7zf0iwDlRA6y8k9xV4nK/fHtOOw
         3si9Ctf4pQYkHXXE/5pazCAo2bwLUz3Vg2kg9ov7Zkae3OuORRqP9Uzp23hFOCi4c0jS
         IWIVTvvc3Iy+DsInPrr6kzMqhNgJy7Mo+t6D8F28CRtToWiYZIt+ZPb+31SJA8vi42QS
         FmUqyChEJ7f/R3l9BO6QRLiPXRegiiFcK/5JYpwQzV2HO7ok7uG/HGAber07+gCPt29m
         iVMg==
X-Gm-Message-State: AJIora+IZwOBFCmkjuP20G6B7tBlSTLoMT3UKLNqjohqTZ0OQ0lTKiqF
        5/rq9zJbFmQMzqW92hxheeLhFFSWNp4iotY0rY7vPLo9mxz9GZXjGj1+/U3I3laDRjCDXAiIDL9
        fU1a/MHQ5FWos+VCL3tcbrp7a/XgDA/kLOebDEvP2
X-Received: by 2002:a19:9145:0:b0:48a:7ee4:5eac with SMTP id y5-20020a199145000000b0048a7ee45eacmr9242772lfj.641.1658987879888;
        Wed, 27 Jul 2022 22:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syhth8cn2l/zatLNxI80Gp6fqmQbo5DpZln8RVAxOxO6ONGRzdSAPie4hIXA0VboNjtxI4vm/4CuyRBeSsTDQ=
X-Received: by 2002:a19:9145:0:b0:48a:7ee4:5eac with SMTP id
 y5-20020a199145000000b0048a7ee45eacmr9242761lfj.641.1658987879410; Wed, 27
 Jul 2022 22:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com> <20220728032000.127-6-xieyongji@bytedance.com>
In-Reply-To: <20220728032000.127-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 28 Jul 2022 13:57:48 +0800
Message-ID: <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] vduse: Support querying information of IOVA regions
To:     Xie Yongji <xieyongji@bytedance.com>
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

On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> support querying some information of IOVA regions.
>
> Now it can be used to query whether the IOVA region
> supports userspace memory registration.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index eedff0a3885a..e820c37dcba8 100644
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
> +                       if (domain->bounce_map && map->start >= 0 &&
> +                           map->last < domain->bounce_size)
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

So the code is actually find the IOVA region that is the super range
of [start, last] instead of overlap:


> +                       if (domain->bounce_map && map->start >= 0 &&
> +                           map->last < domain->bounce_size)
> +                               info.capability |= VDUSE_IOVA_CAP_UMEM;

Which part is wrong?

Thanks

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

