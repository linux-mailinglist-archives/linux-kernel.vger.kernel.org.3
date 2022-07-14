Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEFB574192
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiGNCvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNCvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011A222505
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657767105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09XFoPLUL2vtKYhbD0RdYNM/yS165RYVSGN8mkoX2x8=;
        b=EAtsqmhZJEeJUo5u74xD586QmNQPebVje7FLbDV+pj+M+h+NUaYFSiCmBdncsT9/eWq5/m
        +MMqwo42Eqi7e/8FhGPq5gahLXyXIEY6z5k6cMCDA06eLMku+HCKTwmNEVPN7w7osCGO87
        5xoLWrumCdD0nu+/Hs0mWkfpJbP796Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-nGPzoHXjP4GaltmROoW0tw-1; Wed, 13 Jul 2022 22:51:44 -0400
X-MC-Unique: nGPzoHXjP4GaltmROoW0tw-1
Received: by mail-lf1-f70.google.com with SMTP id h37-20020a0565123ca500b004889ff5f804so188417lfv.19
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09XFoPLUL2vtKYhbD0RdYNM/yS165RYVSGN8mkoX2x8=;
        b=Qjx4UOvLC4Q/XCP/PZMZzGkWyz6qNYibGejxtiS+KCA9cK0FNFlyiL66mxKxuD+a5+
         SE5k4Rv26SfvC4abqGM+Ot4zSGwIxe4C60z92+Q6H52sKI0HD0nmGKL1Gio9lTjUC073
         Fg3Fu9NEm4vXWHolezP+fzA4xVEg6pQfWZ6Wr5lU6eBeMfP9LLQmGSICmd99uJmeI0k2
         jYjJ+4DBgcTf/CF8aiojXtq4VlXrmm4o9kdLB4S3ks+cVp+SlyfvbgE2kMFyIfgAvH98
         oLhfkjnRyXXqpj7hUf3OE1iR3bLlE1ZkFVJZaYYzpnW2SWIQ6c1ot3Pi+g787l72K/+8
         Dlng==
X-Gm-Message-State: AJIora+Q9FU/qxlwyF7iH714uuQVd2G57LTmO7gLFu9t0cgoOD3LNcQg
        OYuB6ikef3lBlU110HUOwt30ESRZVU/qD/D2tCSnIhgGee73K86LWwCqhVzACRa+Wox2X2nJ8xJ
        Ji0P/4E1tgnF8SbVAvQCAsuIMy8+1yiScZAbm+UbQ
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr3748225lfa.124.1657767103010;
        Wed, 13 Jul 2022 19:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uwEhwbheOgz6wTlkIvKB70cHBlkA9GqeMpsrUC6VzNc76tluuIIaOQrAc2oNrGC/DghetpRGLu4EmRz6EZAfQ=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr3748215lfa.124.1657767102800; Wed, 13
 Jul 2022 19:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <20220706050503.171-5-xieyongji@bytedance.com>
In-Reply-To: <20220706050503.171-5-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Jul 2022 10:51:31 +0800
Message-ID: <CACGkMEv9s2WP+Ou5wk2GCBXfD+Pc8CDY2Kz41w7sO8bnkVTc7w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vduse: Support querying IOLTB information
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 1:06 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> support querying IOLTB information such as bounce
> buffer size.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
>  include/uapi/linux/vduse.h         | 17 +++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 3bc27de58f46..c47a5d9765cf 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1089,6 +1089,19 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
>                 break;
>         }
> +       case VDUSE_IOTLB_GET_INFO: {

As discussed, it's better not to expose the VDUSE internal structure
like "IOTLB" in the name.

We probably need to extend GET_FD or have a new ioctl like GET_FD_INFO.

Thanks

> +               struct vduse_iotlb_info iotlb;
> +
> +               iotlb.bounce_iova = 0;
> +               iotlb.bounce_size = dev->domain->bounce_size;
> +
> +               ret = -EFAULT;
> +               if (copy_to_user(argp, &iotlb, sizeof(iotlb)))
> +                       break;
> +
> +               ret = 0;
> +               break;
> +       }
>         default:
>                 ret = -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 7cfe1c1280c0..c201b7a77c2c 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -210,6 +210,23 @@ struct vduse_vq_eventfd {
>   */
>  #define VDUSE_VQ_INJECT_IRQ    _IOW(VDUSE_BASE, 0x17, __u32)
>
> +/**
> + * struct vduse_iotlb_info - IOTLB information
> + * @bounce_iova: start IOVA of bounce buffer
> + * @bounce_size: bounce buffer size
> + * @reserved: for future use, needs to be initialized to zero
> + *
> + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get IOTLB information.
> + */
> +struct vduse_iotlb_info {
> +       __u64 bounce_iova;
> +       __u64 bounce_size;
> +       __u64 reserved[2];
> +};
> +
> +/* Get IOTLB information, e.g. bounce buffer size */
> +#define VDUSE_IOTLB_GET_INFO    _IOR(VDUSE_BASE, 0x18, struct vduse_iotlb_info)
> +
>  /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
>
>  /**
> --
> 2.20.1
>

