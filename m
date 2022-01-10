Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD998488EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 03:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbiAJCoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 21:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238225AbiAJCof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 21:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641782674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SR5LJDR7Yuo7sdem+SKLe4DRKmUm4dsotpVpoRAp1vk=;
        b=iDSoL5XpOh8awH2naZ9aIQH7nBMpW5+g3bOV4fN0CbCRWTB/TcEkvaAjHM6M47mYQ2PdWY
        m5LDsqJDnXPYwpdXMhDaOjV0VPbVt4Ai/8wi2j1b2K2Ol5xLKzarJOWCaXYjkjbdBDiwGb
        rxI+qRVuclLMwJSUaJUpZAyJQ0AhSec=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-0HnZodb4OJK3d9uMtFqh4Q-1; Sun, 09 Jan 2022 21:44:33 -0500
X-MC-Unique: 0HnZodb4OJK3d9uMtFqh4Q-1
Received: by mail-lf1-f72.google.com with SMTP id s16-20020a056512215000b0042bd76cb189so1994359lfr.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 18:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SR5LJDR7Yuo7sdem+SKLe4DRKmUm4dsotpVpoRAp1vk=;
        b=D0g8jnZqo9RZm6StDbEq2Mc1Lcvd9gJGHHCh1d7SGQmJ7D/PhljxkyLWyABDzN86rr
         rx95ZV9Y5PPjIooiAX+nE4L3uo1V+HexaJfexxm/9J/2OEyrUcmnKWmiQ6767BEyJa6m
         OxOJyVloFXGRbHwlrNf4VqP00HD1iSZzifVzTQAP8pG0OQsStcZ1vHgOVhTxy2K2MeUp
         FFeoQMwYeaO2CyNBJoBOqZ+BWgvVUpXbAMktLTRRdUkD1B90YGnOSajFM3cWbOzxN/zs
         fVJ+dK64MJGzYeS5fow4/iLJ4bNngnxMhGTf6Aw04h1vfbCMFTzVzO+GMmr9twFtjaXt
         sjvA==
X-Gm-Message-State: AOAM531hv98CDpT/pLJLmD00aF6CWcfy4ZA8ZzUrzYVrLmS6BXZMF1a1
        XNIDsrt+lU0UC/gDpkpmh+bRGjnpx6a6+E7SB8PZvfea0yTp/zjyqbSAfPNbcWL4RabrHPEX5et
        QR8ysFW0YCjnjdvXSe/HOrRrc4GkU60PztEKyY9dI
X-Received: by 2002:a2e:a40c:: with SMTP id p12mr60731337ljn.369.1641782672010;
        Sun, 09 Jan 2022 18:44:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyn4yn6mbjfPrY7TWHh0U6HAgbKlHep+6bMRtnLiIJiqqtpsxe5AgSHe8T+kBeNVWG30nDbYW36WR7C6Guxyhg=
X-Received: by 2002:a2e:a40c:: with SMTP id p12mr60731331ljn.369.1641782671854;
 Sun, 09 Jan 2022 18:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20220108180041.4601-1-mst@redhat.com>
In-Reply-To: <20220108180041.4601-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 10 Jan 2022 10:44:20 +0800
Message-ID: <CACGkMEv4YY7z2eF2EHt=KvmJ+se5cAs3vRP0Wi2HdRYFhe80Hw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: fix endian-ness for max vqs
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Cohen <elic@nvidia.com>, kernel test robot <lkp@intel.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 2:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/vdpa/mlx5/net/mlx5_vnet.c:1247:23: sparse: sparse: cast to restricted __le16
> >> drivers/vdpa/mlx5/net/mlx5_vnet.c:1247:23: sparse: sparse: cast from restricted __virtio16
>
> > 1247                  num = le16_to_cpu(ndev->config.max_virtqueue_pairs);
>
> Address this using the appropriate wrapper.
>
> Fixes: 7620d51af29a ("vdpa/mlx5: Support configuring max data virtqueue")
> Cc: "Eli Cohen" <elic@nvidia.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 84b1919015ce..d1ff65065fb1 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1242,7 +1242,8 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>         if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>                 num = 1;
>         else
> -               num = le16_to_cpu(ndev->config.max_virtqueue_pairs);
> +               num = mlx5vdpa16_to_cpu(&ndev->mvdev,
> +                                       ndev->config.max_virtqueue_pairs);
>
>         max_rqt = min_t(int, roundup_pow_of_two(num),
>                         1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> --
> MST
>

