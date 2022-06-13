Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D040954818E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiFMINq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240173AbiFMINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9893D1EAC9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655107979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zYvGhBu9HmB5MMoe90C77tgnPiO/jbA/i6l4B3LwqrA=;
        b=crGdGWyIlYuRUFWiyxclmdb4vK7tM3RjF8w8+dcKLVwHDlSsSnaDsoHGOqc28vW9TyqTIv
        Ai5lD5T+WfOn5GnLPirJJXsoKgUsBWKxjkWPt+sMMA4X7YMcFekXHro+CmeZsuTlhgi42v
        uW0Wj0cz8c+7CqlEtSR1xvFQuZkfilg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-yn2ZA9WPP6GBG0RCE9hGRg-1; Mon, 13 Jun 2022 04:12:58 -0400
X-MC-Unique: yn2ZA9WPP6GBG0RCE9hGRg-1
Received: by mail-lf1-f71.google.com with SMTP id c21-20020a056512105500b00479762353a4so2736331lfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYvGhBu9HmB5MMoe90C77tgnPiO/jbA/i6l4B3LwqrA=;
        b=1bdWh8OQx9QNgJmKVPlBg8lx0xlahBi3dEz0wVYGw+PvlLRYoauq4hQt1+C24CPxJw
         N45TUnLnuHU4ogEz9rX0SbmjOEMWjQPVOmkJx4ZGEI4EO4cCP+iAxmagnqOTowvakBmj
         8CtZrtNQQZurpW/duxOklwsUl1wFQ2f+vVKRxvk83B7Aad4SBT9TZpi/ifJhIN9C25sV
         1UvWiE0Pnf3Veg+tDevNXi9JFCt0dOWvO8nhnSPbmvjhaEeiCtcSPEzjeVIt1LFSDUFh
         inmPYjf8ebqW8tYyIXkiH6PvYOw0CbQQM/Cp6Qeu1oMG5RW045MTCCTwnL0W9j07U4Y4
         E2pQ==
X-Gm-Message-State: AOAM533jAA8SfcVOaAyROQW9w8zdWwDqFdEpArG9tWbdPWH1bDR4vyWY
        HdJ74s8S+6TxHOS4BpfdrYP8B3cYzCP8lgZVzPKxuqrxhtG9H7GFthP2c1sH+/QKQb0qnn2vw4g
        jc5cbwHH7Lgi0pjGlUlpXE+xHRJFbTqQjJyyVk/in
X-Received: by 2002:a05:6512:a8f:b0:479:63e5:d59f with SMTP id m15-20020a0565120a8f00b0047963e5d59fmr18242608lfu.124.1655107976647;
        Mon, 13 Jun 2022 01:12:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoz6YdTTkziAJVqYGZS4sICU2CRqhsvvMO8wJ45GEUUXf6uE6PSxjIbxuhvL9EGVlilwwa1RpUsG8dxhIgDH0=
X-Received: by 2002:a05:6512:a8f:b0:479:63e5:d59f with SMTP id
 m15-20020a0565120a8f00b0047963e5d59fmr18242601lfu.124.1655107976442; Mon, 13
 Jun 2022 01:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220613075958.511064-1-elic@nvidia.com> <20220613075958.511064-2-elic@nvidia.com>
In-Reply-To: <20220613075958.511064-2-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Jun 2022 16:12:45 +0800
Message-ID: <CACGkMEszmgnYoSi-CaMhUpZSg1c9FgzLoN9esT94A4MCgknP2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Initializde CVQ vringh only once
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst <mst@redhat.com>, eperezma <eperezma@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 4:00 PM Eli Cohen <elic@nvidia.com> wrote:
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

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 789c078ff1af..e85c1d71f4ed 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2176,7 +2176,6 @@ static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 features)
>  static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> -       struct mlx5_control_vq *cvq = &mvdev->cvq;
>         int err;
>         int i;
>
> @@ -2186,16 +2185,6 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
>                         goto err_vq;
>         }
>
> -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> -               err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
> -                                       MLX5_CVQ_MAX_ENT, false,
> -                                       (struct vring_desc *)(uintptr_t)cvq->desc_addr,
> -                                       (struct vring_avail *)(uintptr_t)cvq->driver_addr,
> -                                       (struct vring_used *)(uintptr_t)cvq->device_addr);
> -               if (err)
> -                       goto err_vq;
> -       }
> -
>         return 0;
>
>  err_vq:
> @@ -2468,6 +2457,21 @@ static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
>         ndev->mvdev.cvq.ready = false;
>  }
>
> +static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
> +{
> +       struct mlx5_control_vq *cvq = &mvdev->cvq;
> +       int err = 0;
> +
> +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> +               err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
> +                                       MLX5_CVQ_MAX_ENT, false,
> +                                       (struct vring_desc *)(uintptr_t)cvq->desc_addr,
> +                                       (struct vring_avail *)(uintptr_t)cvq->driver_addr,
> +                                       (struct vring_used *)(uintptr_t)cvq->device_addr);
> +
> +       return err;
> +}
> +
>  static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  {
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -2480,6 +2484,11 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>
>         if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
>                 if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
> +                       err = setup_cvq_vring(mvdev);
> +                       if (err) {
> +                               mlx5_vdpa_warn(mvdev, "failed to setup control VQ vring\n");
> +                               goto err_setup;
> +                       }
>                         err = setup_driver(mvdev);
>                         if (err) {
>                                 mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> --
> 2.35.1
>

