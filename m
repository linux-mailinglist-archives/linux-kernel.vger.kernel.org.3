Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0353357B39D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiGTJQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiGTJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B3962E9FD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658308551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HUKMXc9f07k4+gnbLTE/RnwIyWTnBgFirv7Xpt5z1go=;
        b=PFmxlj0BGhslptbey/qPnFQTRK9GdNRRj95QWI4iO2gpsJYXmgRSQPZF3FiE3X/OHMBpb4
        bX5DYnXEYOSzbfZNNCEaMDzmQ7tlqhPrhv850IegDfGczcBfg3NLFrw+IzY0C3/Q5AhjOV
        RepxESt8hDBdE3zjpgC720u8i3PxnHk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-wnodrgRHPQqcnTll1eiSuQ-1; Wed, 20 Jul 2022 05:15:50 -0400
X-MC-Unique: wnodrgRHPQqcnTll1eiSuQ-1
Received: by mail-lf1-f72.google.com with SMTP id h37-20020a0565123ca500b004889ff5f804so6581341lfv.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUKMXc9f07k4+gnbLTE/RnwIyWTnBgFirv7Xpt5z1go=;
        b=THiadZwlz7Ll6pA60CJ0YwUViWYjoR8JNYrACh1jJqluDuqOWMW+7v1x3crYP81jBU
         e5b6weKgm4xKI1aK+hTOApTqyqNkaqg8tpRDq7LOBHf30Z9qIFbvUtfW2feL4K7SYicu
         Za1amUOusmzT6vN/ZJaUF2YqaUR7psC8V/q1n6sir2wQ7jyOcZ9MXzrh0A2GBVccrG9k
         6AwbFe07Jebn+Ek6MBBQkNNTO/+KxsgNA1oaWG3ftoXMRZT2kszxrDtJbwR2sZ7crFMQ
         nHCt6OnXblND6qPpKEMLozJ4N8gJJjfzWUeraKIcz/WuiPZHsUrQTjMB5ebpUi0QauFZ
         JWjA==
X-Gm-Message-State: AJIora/gd3/nsxX8AeH4yUBdGn1mKbpE0md+qH6WhzU02CABlCL/g4JF
        wqj8WBV3Q0Di8gT2qGQAXMdK0AxCh1MnG4/UybVhtgIKCLrkVF5/XekqHBRMWtMb6vZbqX8fl5k
        oEtXrxts3zaDeLvf5vUQEQH6DjlbWgEGOVJ5gTbG0
X-Received: by 2002:a2e:a9a6:0:b0:25d:601a:d3d8 with SMTP id x38-20020a2ea9a6000000b0025d601ad3d8mr16223611ljq.141.1658308548672;
        Wed, 20 Jul 2022 02:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1symoo6IBmz/51GUPD/ME1iQ6e+R4xCZyOT9QTN8UBI0jSLGRhu9Br2wlQUp+NdSgKVe3ykxwoy05dNkTJEYSI=
X-Received: by 2002:a2e:a9a6:0:b0:25d:601a:d3d8 with SMTP id
 x38-20020a2ea9a6000000b0025d601ad3d8mr16223602ljq.141.1658308548487; Wed, 20
 Jul 2022 02:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044144.90-1-xieyongji@bytedance.com> <20220720044144.90-6-xieyongji@bytedance.com>
In-Reply-To: <20220720044144.90-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 20 Jul 2022 17:15:36 +0800
Message-ID: <CACGkMEti0LLi8s7V_9oCvSgj=-nNAEHLipnnwtH0_RTF75-XrQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] vduse: Support querying information of IOVA regions
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 12:42 PM Xie Yongji <xieyongji@bytedance.com> wrote:
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
>  include/uapi/linux/vduse.h         | 25 +++++++++++++++++++
>  2 files changed, 64 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index eedff0a3885a..cc4a9a700c24 100644
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

We don't check map->start and map->last in GET_FD, any reason for
those checks here?

> +                               info.capability |= VDUSE_IOVA_CAP_UMEM_SUPPORT;

Not a native speaker, but I think CAP is duplicated with SUPPORT.

Something like VDUSE_IOVA_CAP_UMEM might be better.

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
> index 9885e0571f09..720fb0b6d8ff 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -233,6 +233,31 @@ struct vduse_iova_umem {
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
> +#define VDUSE_IOVA_CAP_UMEM_SUPPORT (1 << 0)
> +       __u64 capability;
> +       __u64 reserved[3];
> +};
> +
> +/*
> + * Find the first IOVA region that overlaps with the range [start, last]
> + * and return some information on it. Caller should set start and last fields.
> + */
> +#define VDUSE_IOTLB_GET_INFO   _IOW(VDUSE_BASE, 0x1a, struct vduse_iova_info)

This should be _IOWR() ?

Thanks

> +
> +
>  /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
>
>  /**
> --
> 2.20.1
>

