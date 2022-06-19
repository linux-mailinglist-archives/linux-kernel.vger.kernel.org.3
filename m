Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F706550C15
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiFSQeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFSQeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C7CAB491
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655656453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEwP5F/yZNS5SDjHR1K72rrfM43XmiN8C3zogcgKGeI=;
        b=QsJsx6bi31NVtZ37sBt5EGJax6BRLEPtFiWfpB84tBBFUhfl8M5OOAPSsv+pqrVZdw2TyQ
        1iYXzwnt9Te7cCraJ2la/FAJH0iCdB4qOPaRzfc6T/L4EhD5GlnFNBPKMqbdDesoaytp7z
        gDGxo/o77B4zAd4OGvaKJldRMuOYN7A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-XarOpjspPWW0ZglYqlO5vA-1; Sun, 19 Jun 2022 12:34:08 -0400
X-MC-Unique: XarOpjspPWW0ZglYqlO5vA-1
Received: by mail-qv1-f72.google.com with SMTP id b18-20020a0ccd12000000b004703d1b04e8so2541844qvm.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEwP5F/yZNS5SDjHR1K72rrfM43XmiN8C3zogcgKGeI=;
        b=QSDRausEwCUyZgJtxrL0I/cw7ImlmSQ9559vcVS1BvxM9mmX6OOYzcXQ+RyIFJm8k0
         JtuQeOLf/t7C1ftoA8mrIN69ZFhUFVNmAe/9Nvxbltiopg078A/QHjHU5LpN8XhmzEnG
         q0XcfVOmCUu9ja3qFPCre22Tcu1zLuUnJEUWJHehkIbj8LXVtFd8sYga9nvP00/kG0jK
         SRlP/A7q2QzLYHmAk3U/HQHkAMdR00qcloOtmD40UBN0fSuc14pXohd28OdBZpHIvIgv
         0L1eG032GwnTWIM/6H0tSZ1pOcCiaJqwiNRKZ/CR7EdbWqWD42aALlQJFbOae0vk/SQu
         mhYw==
X-Gm-Message-State: AJIora/g6g6Nar1sDE0kOJ+4mSeV8LoyRJqZP/MBBtxptQfYarrEJiAJ
        lrfrA8xWsuGoewX2fdxBCk7bZlaRhzN3ZQGNLIw3cZxgOIJbjWPA3MefC4zxZ6fAYXO4IFWWVk5
        6FLpz15b/YqGz69bysoB1gn912wnMNalAbi4HchPl
X-Received: by 2002:a05:6214:19ec:b0:464:6aaa:8e98 with SMTP id q12-20020a05621419ec00b004646aaa8e98mr15939590qvc.45.1655656448241;
        Sun, 19 Jun 2022 09:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u6V8FMVvqVd7z3tP25z2jyKBYSAMEBUv+zDsaekGEN1rkmAwLWNFIjj1sFUtvL1NXkAVxVTHX2Zf18W1SzvBU=
X-Received: by 2002:a05:6214:19ec:b0:464:6aaa:8e98 with SMTP id
 q12-20020a05621419ec00b004646aaa8e98mr15939580qvc.45.1655656447982; Sun, 19
 Jun 2022 09:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-2-elic@nvidia.com>
In-Reply-To: <20220616132725.50599-2-elic@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Sun, 19 Jun 2022 18:33:31 +0200
Message-ID: <CAJaqyWehxTW_ie=3rPygSGc9JvZuMMj6FGfXaQkYCGYvMf-hag@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>,
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

On Thu, Jun 16, 2022 at 3:27 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Implement the suspend callback allowing to suspend the virtqueues so
> they stop processing descriptors. This is required to allow the shadow
> virtqueue to kick in.
>

Maybe a more general description is "To get a meaningful virtqueue
state in live migration, trusting the device will not modify it from
the moment it is suspended"?

> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
>  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
>  2 files changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index fb0b23e71383..ea4bc8a0cd25 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>         if (err)
>                 goto err_cmd;
>
> +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
>         kfree(in);
>         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
>
> @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
>                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
>                 return;
>         }
> +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
>         umems_destroy(ndev, mvq);
>  }
>
> @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
>         return err;
>  }
>
> +static bool is_valid_state_change(int oldstate, int newstate)
> +{
> +       switch (oldstate) {
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> +       default:
> +               return false;
> +       }
> +}
> +
>  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
>  {
>         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>         void *in;
>         int err;
>
> +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> +               return 0;
> +
> +       if (!is_valid_state_change(mvq->fw_state, state))
> +               return -EINVAL;
> +
>         in = kzalloc(inlen, GFP_KERNEL);
>         if (!in)
>                 return -ENOMEM;
> @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>         struct mlx5_vdpa_virtqueue *mvq;
> +       int err;
>
>         if (!mvdev->actual_features)
>                 return;
> @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
>         }
>
>         mvq = &ndev->vqs[idx];
> -       if (!ready)
> +       if (!ready) {
>                 suspend_vq(ndev, mvq);
> +       } else {
> +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> +               if (err) {
> +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> +                       ready = false;
> +               }
> +       }
> +
>
>         mvq->ready = ready;
>  }
> @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
>         return err;
>  }
>
> +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> +{
> +       struct mlx5_control_vq *cvq;
> +
> +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +               return;
> +
> +       cvq = &mvdev->cvq;
> +       cvq->ready = !suspend;
> +}
> +
> +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_virtqueue *mvq;
> +       int i;
> +
> +       if (!suspend) {
> +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> +               return -EOPNOTSUPP;
> +       }
> +
> +       down_write(&ndev->reslock);
> +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> +               mvq = &ndev->vqs[i];
> +               suspend_vq(ndev, mvq);
> +       }
> +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
> +       up_write(&ndev->reslock);
> +       return 0;
> +}
> +
>  static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .set_vq_address = mlx5_vdpa_set_vq_address,
>         .set_vq_num = mlx5_vdpa_set_vq_num,
> @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .get_generation = mlx5_vdpa_get_generation,
>         .set_map = mlx5_vdpa_set_map,
>         .free = mlx5_vdpa_free,
> +       .suspend = mlx5_vdpa_suspend,
>  };
>
>  static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
> @@ -2827,6 +2892,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>                 mvq->index = i;
>                 mvq->ndev = ndev;
>                 mvq->fwqp.fw = true;
> +               mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
>         }
>         for (; i < ndev->mvdev.max_vqs; i++) {
>                 mvq = &ndev->vqs[i];
> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> index 4414ed5b6ed2..423562f39d3c 100644
> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> @@ -150,6 +150,14 @@ enum {
>         MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
>  };
>
> +/* This indicates that the object was not created or has alreadyi
> + * been desroyed. It is very safe to assume that this object will never

Small typos: "already been destroyed".

> + * have so many states
> + */
> +enum {
> +       MLX5_VIRTIO_NET_Q_OBJECT_NONE = 0xffffffff
> +};
> +
>  enum {
>         MLX5_RQTC_LIST_Q_TYPE_RQ            = 0x0,
>         MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q  = 0x1,
> --
> 2.35.1
>

