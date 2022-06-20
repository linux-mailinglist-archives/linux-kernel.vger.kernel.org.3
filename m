Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC7551381
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiFTI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbiFTI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9241AE7B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xrcQNn+Ra/Wmk9UclwpSlnyoXDjxFRvBSfAIpCmWbBM=;
        b=Y6nouvtcP0p1VKlrmTzcM2KjrvjXh3b06bw5AYBi37UPDonVRrxQ2NuFY2+HNq3qxFhs+y
        WQEdHl4j6r9Du8WSZhG6wnYpPdw7IE0cu3dQRKKLs3sDU3c1coYpt4FudE9jiWoPYT2/8L
        cokOo7gHtro+HwNIt5/Cn3xdkcNssws=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55--ygmmNmXNtKB8U38H1iYlg-1; Mon, 20 Jun 2022 04:56:25 -0400
X-MC-Unique: -ygmmNmXNtKB8U38H1iYlg-1
Received: by mail-lf1-f71.google.com with SMTP id l12-20020a056512110c00b0047961681d22so5203043lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrcQNn+Ra/Wmk9UclwpSlnyoXDjxFRvBSfAIpCmWbBM=;
        b=HmTLKHvGrTcF6FkcQ3ox/PZfv1xYqjcerfu73/C6y1dKL2dGrrq0Qk3lLJW51s16v4
         D1dlQGvCuPx0FWAknbV3Sowq7F1v1RQBSXdAhzt9r7d+9T3Sy1eBcpw/sJPK/xTj1gZv
         dqCHKHzQjFRxoyQDYxCAzvAYT1q/Z/mKyEHHiu0f/GKgM7p4EvIA4YEusBGJlfDFYgtJ
         DXjtr0kSCHbXUXK0cVGHTejOo1HL0JAYfVzdOMF+74le0NXZ7Lh8wIaEKV3ft2ye5PU8
         j7nGpOQ9x2taU/ST+sNdGTT6XTTcAPYPFkAWD+pAarrk6bX/rlyiqWDi0OkZkIXmfUuJ
         vddg==
X-Gm-Message-State: AJIora/zY9/YfNqEAeBm9YAsF6slDtnrNN7tazDwNOu3JR+yFvfbAcCh
        YeCmSfuvcrunsVZAUy2nlAGsyUxCPxeS/V+k56NtDxVlH0cL5ARQSaplg7F7Y0B1/01zQaw6jNY
        fr1f1umsVkE86LzCjHHfSWjXwplCEwbxwtWX/jhor
X-Received: by 2002:a2e:3c11:0:b0:25a:7397:94ea with SMTP id j17-20020a2e3c11000000b0025a739794eamr317514lja.323.1655715383661;
        Mon, 20 Jun 2022 01:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tpjJXgF3f2rNJJAuO7/ogDPQq7NS3aWvyPEEYwA0wIcZC8D9ot1Ib/elCPZiMD9rO8Q7lLni5edQHYV0gYp1s=
X-Received: by 2002:a2e:3c11:0:b0:25a:7397:94ea with SMTP id
 j17-20020a2e3c11000000b0025a739794eamr317504lja.323.1655715383436; Mon, 20
 Jun 2022 01:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-2-elic@nvidia.com>
In-Reply-To: <20220616132725.50599-2-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 20 Jun 2022 16:56:12 +0800
Message-ID: <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
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

On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Implement the suspend callback allowing to suspend the virtqueues so
> they stop processing descriptors. This is required to allow the shadow
> virtqueue to kick in.
>
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

It looks to me we need to synchronize this with reslock. And this
probably deserve a dedicated fix.

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

Do we need to synchronize with the carrier work here? Otherwise we may
get config notification after suspending.

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

I don't see the vDPA bus patch to enable this method. Or anything I missed here?

Thanks

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

