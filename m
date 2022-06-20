Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FC55132D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbiFTIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbiFTIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B86763F3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655714882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dTV1FjdagOn2blPRO899RL2TzF/ALoz6Mi1x3g7dZ+g=;
        b=WtGrjThaLnNXRcz+IZb7Z1OcdaTF/3tiw9K4fQkCG3KMMVH9lN1hOlfld9A5rmAgYwPlRC
        3Hf8lS/bUn4P6GzIb8sDrK8ngRnIHAMCNmY55qQFZfP3P57HIf1MtoFa9jdmRChXtnj7HV
        5EwthMSzS9gm+G++9Wfj8vHHTp+Ve40=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-fe3kCKKSPJmlwx263gKFSQ-1; Mon, 20 Jun 2022 04:48:00 -0400
X-MC-Unique: fe3kCKKSPJmlwx263gKFSQ-1
Received: by mail-lf1-f72.google.com with SMTP id u5-20020a056512128500b00479784f526cso5186311lfs.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTV1FjdagOn2blPRO899RL2TzF/ALoz6Mi1x3g7dZ+g=;
        b=xFav/XfV3Wn9HZ+EP290aVFAUa4LGPUbt6m6eJsd2MC07eh7tmGy3qgmq3Df0GV4xq
         TfeUBBaytm+4ZT0OvW9g/JGfihx18o6vrDmJjZQYXfCWGDs0O34FJhk4T8/rFyVD0b/j
         8RIcLdVOmgunXNXv3ZjhoSGgd2oCnNHpclPnrozDKz3/eCjfDNqoqhcSinc6m6lqQv4c
         2lNOwjvILMbi/x+4WUuX5XfpaONejmO4FkDVBAZArgp9jTU83Vz7xJoE1oUoTEmqGHDo
         +dResJ1Lm5ti3MpyiMtoDTP7YbYiBRgObSewrxlgLlT92hIihYuVmSVq7zwh6O1wIbC5
         8ClA==
X-Gm-Message-State: AJIora9teYo+fZoSK3CuAvutSrJz0ZxsDi0gwIlu2sNmjkv9eTsGvSoG
        nmbytKKRFOSm28ArL53uHvqeAyIEW/MDNQ3hD6+XfHNo7pDf+j3oOx+HglIrSpXJUbcmjkPJOM8
        WFO6tY4fWKlkoPw8IkKfSyMc34rT5Ox0r6wSjzPS9
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id p16-20020a2e9ad0000000b0025a715626bbmr1150477ljj.141.1655714879454;
        Mon, 20 Jun 2022 01:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/LDcG35w7DbXZQTaNe4ORqCwTHWzas403SEZk1fkPHDUk1WsNFgdf4HVm1WbWhZ7zTeeuxuJ6DXuvyewdpwQ=
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id
 p16-20020a2e9ad0000000b0025a715626bbmr1150470ljj.141.1655714879288; Mon, 20
 Jun 2022 01:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-4-elic@nvidia.com>
In-Reply-To: <20220616132725.50599-4-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 20 Jun 2022 16:47:48 +0800
Message-ID: <CACGkMEsc+MCsRq6aA1vLXE3OJ0buX-0g73qaz72Px-ismfMKLA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] vdpa/mlx5: Disable VLAN support to support live migration
To:     Eli Cohen <elic@nvidia.com>
Cc:     eperezma <eperezma@redhat.com>, mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 9:28 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Current qemu code does not support live migration for devices supporting
> VLAN. Disable it.

This looks like a bug that we need to fix in Qemu.

Thanks

>
> Note: this patch is provided just to enable testing with current qemu.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 34bd81cb697c..1568cfdf07e6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2172,7 +2172,6 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
>         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MQ);
>         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
>         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
> -       mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
>
>         return mlx_vdpa_features;
>  }
> --
> 2.35.1
>

