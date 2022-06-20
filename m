Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD79551386
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiFTI6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbiFTI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D97C4B6A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibeQfE5HebkZIVtIk5k0V7n2maOuGYJ6xdtJii5O3LY=;
        b=H1xLieou+c63eH4hkU3rupIWZO6S6P0eew0qL34aM6a7DxTibjmGnpU7YxBehrouUDZWIt
        fYA8NOENtgWg0+g90ivRx7uyohaazyNgAjDzAkz0at9VrB25bmQPtZCpHJgkB9isAf5/Tk
        VVEWa01QD24oF/G0Qu4+tnd6/sNysqM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-5QE9yC-jMd2sessiZD6uJg-1; Mon, 20 Jun 2022 04:58:04 -0400
X-MC-Unique: 5QE9yC-jMd2sessiZD6uJg-1
Received: by mail-qk1-f199.google.com with SMTP id de4-20020a05620a370400b006a9711bd9f8so12402789qkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibeQfE5HebkZIVtIk5k0V7n2maOuGYJ6xdtJii5O3LY=;
        b=sinJWcB5xxbcr5TQpiM7Z4e/SgcQmD+m/w/TuU3fZNKIWQpO/sLJvSRFvcapbnAoTb
         TzRvY32mh+Wbf81LrKA0v1vT+g+qqIYEVODRgogJTrWrzAT4+2c/J7f4rTNXHLehnmhW
         13SSWsMnR/5T8Ps7SZ8aKf2HhHKpRT39ZdhQlwIFm+6DpWzL0NdjHG+wj+Euoh896nzG
         hNXWcoWj0A6UCUfaKGeHgho358IzBQe7+80k6GyjkcKPa8Xw56YeKGOYWzMvc0NEAwvH
         M5C1+luK/Uom9oR1nn/jIUhCB1tPdndWVmuWjMrcXJtHmXsmnAtQEkTCB2nLNNkSqug9
         23WA==
X-Gm-Message-State: AJIora9uIJQptxDYVy5VHmfEFLc5Z8cJlGIuXmT98ppW4nkuOVhig9iw
        MGNKqLScu5NHgl9DSrf3Uep3BX3/RY5R8C1Tvo60Dq+/kR3KYDUsf2VShvT8Tef0BlPl3o+Oxgc
        4oPf4MApHaKjw7bD0ZGyy1RgbtEzRyIy/EQvdQfK6
X-Received: by 2002:a05:620a:4256:b0:6ab:54c4:cf9 with SMTP id w22-20020a05620a425600b006ab54c40cf9mr13702791qko.234.1655715483621;
        Mon, 20 Jun 2022 01:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vaAHN88kfBUTgvgqg2FZR8XFVDT5k+f/5vgGTsG1REjY478/Fprs2PG48aiLfSsxmmg4DxhopEXmwUO7QSvxc=
X-Received: by 2002:a05:620a:4256:b0:6ab:54c4:cf9 with SMTP id
 w22-20020a05620a425600b006ab54c40cf9mr13702785qko.234.1655715483351; Mon, 20
 Jun 2022 01:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-3-elic@nvidia.com>
In-Reply-To: <20220616132725.50599-3-elic@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 20 Jun 2022 10:57:27 +0200
Message-ID: <CAJaqyWdFyT+QGce998vsTQNiGAF1LZqOXNZH1RS660tb6pvtgA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] vdpa/mlx5: Support different address spaces for
 control and data
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
> Partition virtqueues to two different address spaces: oce for control
> virtqueue which is implemented in software, and one for data virtqueus.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  11 ++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 101 +++++++++++++++++++++++++----
>  2 files changed, 101 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index 44104093163b..6af9fdbb86b7 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -70,6 +70,16 @@ struct mlx5_vdpa_wq_ent {
>         struct mlx5_vdpa_dev *mvdev;
>  };
>
> +enum {
> +       MLX5_VDPA_DATAVQ_GROUP,
> +       MLX5_VDPA_CVQ_GROUP,
> +       MLX5_VDPA_NUMVQ_GROUPS
> +};
> +
> +enum {
> +       MLX5_VDPA_NUM_AS = MLX5_VDPA_NUMVQ_GROUPS
> +};
> +
>  struct mlx5_vdpa_dev {
>         struct vdpa_device vdev;
>         struct mlx5_core_dev *mdev;
> @@ -85,6 +95,7 @@ struct mlx5_vdpa_dev {
>         struct mlx5_vdpa_mr mr;
>         struct mlx5_control_vq cvq;
>         struct workqueue_struct *wq;
> +       unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
>  };
>
>  int mlx5_vdpa_alloc_pd(struct mlx5_vdpa_dev *dev, u32 *pdn, u16 uid);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ea4bc8a0cd25..34bd81cb697c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2125,9 +2125,14 @@ static u32 mlx5_vdpa_get_vq_align(struct vdpa_device *vdev)
>         return PAGE_SIZE;
>  }
>
> -static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> +static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdev, u16 idx)
>  {
> -       return 0;
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +
> +       if (is_ctrl_vq_idx(mvdev, idx))
> +               return MLX5_VDPA_CVQ_GROUP;
> +
> +       return MLX5_VDPA_DATAVQ_GROUP;
>  }
>
>  enum { MLX5_VIRTIO_NET_F_GUEST_CSUM = 1 << 9,
> @@ -2541,6 +2546,15 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>         up_write(&ndev->reslock);
>  }
>
> +static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
> +{
> +       int i;
> +
> +       /* default mapping all groups are mapped to asid 0 */
> +       for (i = 0; i < MLX5_VDPA_NUMVQ_GROUPS; i++)
> +               mvdev->group2asid[i] = 0;
> +}
> +
>  static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -2559,7 +2573,9 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>         ndev->mvdev.cvq.completed_desc = 0;
>         memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>         ndev->mvdev.actual_features = 0;
> +       init_group_to_asid_map(mvdev);
>         ++mvdev->generation;
> +
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>                 if (mlx5_vdpa_create_mr(mvdev, NULL))
>                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
> @@ -2597,26 +2613,76 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
>         return mvdev->generation;
>  }
>
> -static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
> -                            struct vhost_iotlb *iotlb)
> +static u32 get_group(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
> +{
> +       u32 group;
> +
> +       for (group = 0; group < MLX5_VDPA_NUMVQ_GROUPS; group++) {
> +               if (mvdev->group2asid[group] == asid)
> +                       return group;
> +       }
> +       return -EINVAL;
> +}
> +
> +static int set_map_control(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> +{
> +       u64 start = 0ULL, last = 0ULL - 1;
> +       struct vhost_iotlb_map *map;
> +       int err = 0;
> +
> +       spin_lock(&mvdev->cvq.iommu_lock);
> +       vhost_iotlb_reset(mvdev->cvq.iotlb);
> +
> +       for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
> +            map = vhost_iotlb_itree_next(map, start, last)) {
> +               err = vhost_iotlb_add_range(mvdev->cvq.iotlb, map->start,
> +                                           map->last, map->addr, map->perm);
> +               if (err)
> +                       goto out;
> +       }
> +
> +out:
> +       spin_unlock(&mvdev->cvq.iommu_lock);
> +       return err;
> +}
> +
> +static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
>  {
> -       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> -       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>         bool change_map;
>         int err;
>
> -       down_write(&ndev->reslock);
> -
>         err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
>         if (err) {
>                 mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
> -               goto err;
> +               return err;
>         }
>
>         if (change_map)
>                 err = mlx5_vdpa_change_map(mvdev, iotlb);
>
> -err:
> +       return err;
> +}
> +
> +static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
> +                            struct vhost_iotlb *iotlb)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +       u32 group;
> +       int err;
> +
> +       down_write(&ndev->reslock);
> +       group = get_group(mvdev, asid);
> +       switch (group) {
> +       case MLX5_VDPA_DATAVQ_GROUP:
> +               err = set_map_data(mvdev, iotlb);
> +               break;
> +       case MLX5_VDPA_CVQ_GROUP:
> +               err = set_map_control(mvdev, iotlb);
> +               break;
> +       default:
> +               err = -EINVAL;
> +       }

This shouldn't be a switch, but to check the asid assigned to the
different vqs individually.

In the current qemu version with no ASID support, all vq groups (data
and cvq) are assigned to asid 0 at the device reset. In this case,
emulated cvq also needs to receive the mappings, because guest's CVQ
commands will go from the guest's ASID directly.

Thanks!

>         up_write(&ndev->reslock);
>         return err;
>  }
> @@ -2796,6 +2862,18 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
>         return 0;
>  }
>
> +static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
> +                              unsigned int asid)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +
> +       if (group >= MLX5_VDPA_NUMVQ_GROUPS)
> +               return -EINVAL;
> +
> +       mvdev->group2asid[group] = asid;
> +       return 0;
> +}
> +
>  static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .set_vq_address = mlx5_vdpa_set_vq_address,
>         .set_vq_num = mlx5_vdpa_set_vq_num,
> @@ -2825,6 +2903,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .set_config = mlx5_vdpa_set_config,
>         .get_generation = mlx5_vdpa_get_generation,
>         .set_map = mlx5_vdpa_set_map,
> +       .set_group_asid = mlx5_set_group_asid,
>         .free = mlx5_vdpa_free,
>         .suspend = mlx5_vdpa_suspend,
>  };
> @@ -3047,7 +3126,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>         }
>
>         ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
> -                                1, 1, name, false);
> +                                MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
>         if (IS_ERR(ndev))
>                 return PTR_ERR(ndev);
>
> --
> 2.35.1
>

