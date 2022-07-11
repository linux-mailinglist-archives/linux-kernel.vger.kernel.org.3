Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D76557001F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiGKLVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiGKLUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 146598C142
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657536263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iMixk109WHY5PaSFzefN0ihMk3nOET5Y+l36LDytRug=;
        b=V7ewjQ44Da/hyo9+WHA1BlgoM580ItbLoiNmxumfS2Wj4dDLdatADOhIUcn9Reb00iLTM7
        dmYrslcon7xMiJLUpQ9fRzCxd7Guxl/6hiUyzMhwCcvnMkJVnrMSxANkjMU03kwwuHzUmW
        bis7GRthMaRQI0xvnjyTsWw5xEPJ1bY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-v9CjkiigO_y5UJUIeJkcow-1; Mon, 11 Jul 2022 06:44:22 -0400
X-MC-Unique: v9CjkiigO_y5UJUIeJkcow-1
Received: by mail-qt1-f200.google.com with SMTP id gd27-20020a05622a5c1b00b0031eae6afe5aso4343745qtb.23
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMixk109WHY5PaSFzefN0ihMk3nOET5Y+l36LDytRug=;
        b=kkHjxoFT52qLoNos83n2mUwKGPnNVrKOG1MDKQoFprw09qCxlOXMkqswET/m78O3NS
         kiagAAKRgdxrloQCJFBl7QycbJMLI+MIHpktykNznIHpeYiKkW+HlzY/yXt9a40DwvWD
         ohtCyMYJM6VuSppUG9bgJ9yjXRVe75NtLh4jCWIPoh5oNbNHFDfXfDOA0FxKgDaMXbUe
         BLYjRGykdIjFzVOiAc4QHIjDDg4HQqCoaBc5vJUhSjFDm3wct3RKzGCwTfT6ToMHsUfi
         vudbKmsq9Bhx8jIjiQ9wfny6iwng1tqJ5IPDBemoTC2Oo+PNihYH0KlfH89wRXuGfv0B
         HhFg==
X-Gm-Message-State: AJIora+PPNt64t2DGxEsgXdYuPS4jaAJpmpEelvXnBAvEfQWSFe6weYd
        YV5oxA4B6Z9lz0a5bDKgQtV6BapBsPtGhCz8rJ+AD235r4+5z1bAt63B1pSsT3fh1nv9nluQmR2
        vIrHMZf4HXJG4Zcn43z8EelENVDFJtV727ndb2BBW
X-Received: by 2002:ac8:5dca:0:b0:31e:85b8:8a18 with SMTP id e10-20020ac85dca000000b0031e85b88a18mr12993560qtx.370.1657536261708;
        Mon, 11 Jul 2022 03:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uCgQFp1yKQLR9KvWCW76cRgbstZ0pTSGdJPChJ+Uvk6GJLaekqM6jU8ivi0eA3/ascijrG9fzef7cRkvsdzU0=
X-Received: by 2002:ac8:5dca:0:b0:31e:85b8:8a18 with SMTP id
 e10-20020ac85dca000000b0031e85b88a18mr12993552qtx.370.1657536261489; Mon, 11
 Jul 2022 03:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
 <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
 <CACGkMEtcs9e1NJ7ArkibQSrDN7j_eyciZo=yDfbd5Jsb4gvzZA@mail.gmail.com> <DM8PR12MB5400FDBB177693A55074D19EAB879@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400FDBB177693A55074D19EAB879@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 11 Jul 2022 12:43:45 +0200
Message-ID: <CAJaqyWfWrpo1nizjSehJF5p2JRVyEGQ6d91by3q9A7QdEfS55A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>, mst <mst@redhat.com>,
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

On Mon, Jul 11, 2022 at 8:14 AM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, June 21, 2022 6:05 AM
> > To: Eugenio Perez Martin <eperezma@redhat.com>
> > Cc: Eli Cohen <elic@nvidia.com>; mst <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; Si-Wei Liu <si-wei.liu@oracle.com>; Parav Pandit <parav@nvidia.com>
> > Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
> >
> > On Mon, Jun 20, 2022 at 5:59 PM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Mon, Jun 20, 2022 at 10:56 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > Implement the suspend callback allowing to suspend the virtqueues so
> > > > > they stop processing descriptors. This is required to allow the shadow
> > > > > virtqueue to kick in.
> > > > >
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
> > > > >  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
> > > > >  2 files changed, 75 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index fb0b23e71383..ea4bc8a0cd25 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > >         if (err)
> > > > >                 goto err_cmd;
> > > > >
> > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
> > > > >         kfree(in);
> > > > >         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> > > > >
> > > > > @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
> > > > >                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
> > > > >                 return;
> > > > >         }
> > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > > > >         umems_destroy(ndev, mvq);
> > > > >  }
> > > > >
> > > > > @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > +static bool is_valid_state_change(int oldstate, int newstate)
> > > > > +{
> > > > > +       switch (oldstate) {
> > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> > > > > +       default:
> > > > > +               return false;
> > > > > +       }
> > > > > +}
> > > > > +
> > > > >  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
> > > > >  {
> > > > >         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> > > > > @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > >         void *in;
> > > > >         int err;
> > > > >
> > > > > +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> > > > > +               return 0;
> > > > > +
> > > > > +       if (!is_valid_state_change(mvq->fw_state, state))
> > > > > +               return -EINVAL;
> > > > > +
> > > > >         in = kzalloc(inlen, GFP_KERNEL);
> > > > >         if (!in)
> > > > >                 return -ENOMEM;
> > > > > @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > >         struct mlx5_vdpa_virtqueue *mvq;
> > > > > +       int err;
> > > > >
> > > > >         if (!mvdev->actual_features)
> > > > >                 return;
> > > > > @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > >         }
> > > > >
> > > > >         mvq = &ndev->vqs[idx];
> > > > > -       if (!ready)
> > > > > +       if (!ready) {
> > > > >                 suspend_vq(ndev, mvq);
> > > > > +       } else {
> > > > > +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> > > > > +               if (err) {
> > > > > +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> > > > > +                       ready = false;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > >
> > > > >         mvq->ready = ready;
> > > > >  }
> > > > > @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> > > > > +{
> > > > > +       struct mlx5_control_vq *cvq;
> > > > > +
> > > > > +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > > > +               return;
> > > > > +
> > > > > +       cvq = &mvdev->cvq;
> > > > > +       cvq->ready = !suspend;
> > > > > +}
> > > >
> > > > It looks to me we need to synchronize this with reslock. And this
> > > > probably deserve a dedicated fix.
> > > >
> > > > > +
> > > > > +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> > > > > +{
> > > > > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > +       struct mlx5_vdpa_virtqueue *mvq;
> > > > > +       int i;
> > > > > +
> > > > > +       if (!suspend) {
> > > > > +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> > > > > +               return -EOPNOTSUPP;
> > > > > +       }
> > > > > +
> > > > > +       down_write(&ndev->reslock);
> > > > > +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> > > > > +               mvq = &ndev->vqs[i];
> > > > > +               suspend_vq(ndev, mvq);
> > > > > +       }
> > > > > +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
> > > >
> > > > Do we need to synchronize with the carrier work here? Otherwise we may
> > > > get config notification after suspending.
> > > >
> > > > > +       up_write(&ndev->reslock);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > >         .set_vq_address = mlx5_vdpa_set_vq_address,
> > > > >         .set_vq_num = mlx5_vdpa_set_vq_num,
> > > > > @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > >         .get_generation = mlx5_vdpa_get_generation,
> > > > >         .set_map = mlx5_vdpa_set_map,
> > > > >         .free = mlx5_vdpa_free,
> > > > > +       .suspend = mlx5_vdpa_suspend,
> > > >
> > > > I don't see the vDPA bus patch to enable this method. Or anything I missed here?
> > > >
> > >
> > > Should we add
> > > Based-on: <20220526124338.36247-1-eperezma@redhat.com>
> > >
> > > To this series?
> >
> > Probably, but that series seems to support resume while this series doesn't.
> >
> > Any reason for this?
>
> I think Eugenio agreed that resume is not really required since we're going stop using this
> instance and migrate. In any case, we don't support resume for the hardware object
> though it could be simulated should it be absolutely necessary.
>

That's right, to resume the device it's not mandatory to achieve Live
Migration use case and we can always add another backend feature bit
to support the resume of a device from my point of view.

Thanks!

