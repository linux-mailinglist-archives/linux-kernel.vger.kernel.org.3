Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054F054A948
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348015AbiFNGPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiFNGPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16E01377D8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655187344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RNf8eVNqMA/iaHm020il2tl80mkHlq4NtWAnfHwj7Mc=;
        b=fRm4CRzGteF5oZi06qpHPp0dtFG6pDl5usvbtNEXG2xlvOfWwqxIbmbL3b0zzdL6Cx9efX
        bj/vx/oKj/cWSp3KtPysELNLhpp7KKqHfLcSM7rCaAhwLrwK1EBYMrA2ER25wo+nqUcN95
        PZXCNUvO2haAmnK/+Dp0M5b159S2zUU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-G5XKJegCPdu6oUdopJx9IA-1; Tue, 14 Jun 2022 02:15:41 -0400
X-MC-Unique: G5XKJegCPdu6oUdopJx9IA-1
Received: by mail-qv1-f71.google.com with SMTP id x18-20020a0ce0d2000000b0046458e0e18bso5345106qvk.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RNf8eVNqMA/iaHm020il2tl80mkHlq4NtWAnfHwj7Mc=;
        b=P023ddc2PyluWcsh3X5ft339tvUFSYEceVSgYaPinKxfnkItxqWMd+mlpAQE79aUOR
         fZX8EHB9qdDjeZFpLM3wYozQuCNYRySgCNjtAxMO7QFQ8o0YA5f12Zep0gKXRiJSaTTB
         Q04wQi7IzOphBllIUfSAmyX9PFWrxQuGIvaTVpwGjZLPktcQS7/xBhbFe5JoYBSnemaT
         6qGZqYyXN9i1S0wdThIQYK2hDhGYrsN4R+uoAWz4jb3sMys+rckUB2deOl7X4U7xNGuL
         MVniLhuN4V+icWQ9h+ygQ1qhYuD1ZLfI0ja36hW3t7yl86iUL/sLFSAxB+1V36C1EHxX
         crNw==
X-Gm-Message-State: AOAM531xTGqPpG3sNySSzwqgATgjSZusXYF6z0sLEZt2uNWAEav2ApXT
        LQ5azu2FFiLo6PbUhAD31yDubMKc373ZcRjWZcq4iLqoyfa+TPPTu8U+1trg8RA9+l6elJ3n15I
        79S15vxcsuZonBmWuP+AXGxCVC+1kNcWjEUYnvFzJ
X-Received: by 2002:a05:620a:2847:b0:67d:2bad:422f with SMTP id h7-20020a05620a284700b0067d2bad422fmr2781236qkp.559.1655187341276;
        Mon, 13 Jun 2022 23:15:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZp7RVPEx9AFt3JJRU85a1dtxGaczb5T+5jVZTzfgszQQ/9iPXxHu92MgrAqVyNR56G9BLpR2PyHlpZNwNYOc=
X-Received: by 2002:a05:620a:2847:b0:67d:2bad:422f with SMTP id
 h7-20020a05620a284700b0067d2bad422fmr2781226qkp.559.1655187341061; Mon, 13
 Jun 2022 23:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220613075958.511064-1-elic@nvidia.com> <20220613075958.511064-2-elic@nvidia.com>
In-Reply-To: <20220613075958.511064-2-elic@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 14 Jun 2022 08:15:05 +0200
Message-ID: <CAJaqyWc=6k0ywNPvLODcuMAzvyMwKaCHL-E5FhMTpwL=soN50A@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Initializde CVQ vringh only once
To:     Eli Cohen <elic@nvidia.com>
Cc:     Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:00 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Currently, CVQ vringh is initialized inside setup_virtqueues() which is
> called every time a memory update is done. This is undesirable since it
> resets all the context of the vring, including the available and used
> indices.
>
> Move the initialization to mlx5_vdpa_set_status() when
> VIRTIO_CONFIG_S_DRIVER_OK is set.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 789c078ff1af..e85c1d71f4ed 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2176,7 +2176,6 @@ static int verify_driver_features(struct mlx5_vdpa_=
dev *mvdev, u64 features)
>  static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> -       struct mlx5_control_vq *cvq =3D &mvdev->cvq;
>         int err;
>         int i;
>
> @@ -2186,16 +2185,6 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *=
mvdev)
>                         goto err_vq;
>         }
>
> -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> -               err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_feat=
ures,
> -                                       MLX5_CVQ_MAX_ENT, false,
> -                                       (struct vring_desc *)(uintptr_t)c=
vq->desc_addr,
> -                                       (struct vring_avail *)(uintptr_t)=
cvq->driver_addr,
> -                                       (struct vring_used *)(uintptr_t)c=
vq->device_addr);
> -               if (err)
> -                       goto err_vq;
> -       }
> -
>         return 0;
>
>  err_vq:
> @@ -2468,6 +2457,21 @@ static void clear_vqs_ready(struct mlx5_vdpa_net *=
ndev)
>         ndev->mvdev.cvq.ready =3D false;
>  }
>
> +static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
> +{
> +       struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> +       int err =3D 0;
> +
> +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> +               err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_feat=
ures,
> +                                       MLX5_CVQ_MAX_ENT, false,
> +                                       (struct vring_desc *)(uintptr_t)c=
vq->desc_addr,
> +                                       (struct vring_avail *)(uintptr_t)=
cvq->driver_addr,
> +                                       (struct vring_used *)(uintptr_t)c=
vq->device_addr);
> +
> +       return err;
> +}
> +
>  static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> @@ -2480,6 +2484,11 @@ static void mlx5_vdpa_set_status(struct vdpa_devic=
e *vdev, u8 status)
>
>         if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
>                 if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
> +                       err =3D setup_cvq_vring(mvdev);
> +                       if (err) {
> +                               mlx5_vdpa_warn(mvdev, "failed to setup co=
ntrol VQ vring\n");
> +                               goto err_setup;
> +                       }
>                         err =3D setup_driver(mvdev);
>                         if (err) {
>                                 mlx5_vdpa_warn(mvdev, "failed to setup dr=
iver\n");
> --
> 2.35.1
>

