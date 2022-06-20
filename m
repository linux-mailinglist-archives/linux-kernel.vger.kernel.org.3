Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E343551509
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbiFTJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbiFTJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF6F111810
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655719152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDTyypq3LThkWqob8SwhB0JTWFswSlmPNv7btpDZXns=;
        b=JEHhLeCiFKqmsnBB5gd5TsHbUGvvlp0Sdyn+o0oKUEufsAQADElTGi+x70MDioOTrCmg06
        moH/yG3g5U5ZxfAnJbVAdq/UGsQV8Nm/V5ABxkyCtvYhuRVOkkZifckngr5WpTAgnX/5Sd
        OnFEs+fCLQkSyjYafy/LoFtiaTG8LSk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-94xPtH2KO4i9tEB4fAFKzg-1; Mon, 20 Jun 2022 05:59:10 -0400
X-MC-Unique: 94xPtH2KO4i9tEB4fAFKzg-1
Received: by mail-qk1-f197.google.com with SMTP id w22-20020a05620a445600b006a6c18678f2so12565026qkp.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDTyypq3LThkWqob8SwhB0JTWFswSlmPNv7btpDZXns=;
        b=J7EBF54nr7dFuUMmYJ33UVdzoHX7ai8BwlWa+3qm9whg82p+U3b+ZWFzAOwHsJK1ob
         D/G4dpnCGkThJ7P6h/jPx0lnZfGOWl81AE9x19ENIK/JK5dxi/Lj032EJdmd2z1gC4DH
         x9yspkC11MF+KFbTKysr9k8UVuhBYizmIfi58G9wY5Zj4A72EdLfSd/nOpmB6R7SOHYR
         dfkuzLEfMcBkbdAWaXriflGY4/rJRO2vISSRZLPEZQ4D1RVMD1K86l7Vqrb3BnCV8tjr
         CGvbaJBhsaXBcA1NLOZJDuYNCXPmFXB2OAO667Sgu/HX16v9Bluw8XcKIQAznT7euYjm
         T5KQ==
X-Gm-Message-State: AJIora9PpWvqDUu+Hb+8Q+MWu7sMBliNEx02Krao5AP3gz6UBM+aVM1A
        nwiUZOR8Vad4CyPhxQAHcoHDxCMamVPyglnz4q/yEyKMBBB9daHWL91ilpqTpbsTaDoYsC4wigi
        JrX1FvKhWq2GF6UIndEY9J2OzK7xUuJMl6aYhP9aY
X-Received: by 2002:a05:6214:cc4:b0:470:2c94:4fdf with SMTP id 4-20020a0562140cc400b004702c944fdfmr10635920qvx.2.1655719149696;
        Mon, 20 Jun 2022 02:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLRl5GGnQ86FE2wMDI6MdJQIns77whX20LlOUv4x4iLleBfURppxgETkDrS2eqZEAaJC+AI7nc+WPdQ+y5UX8=
X-Received: by 2002:a05:6214:cc4:b0:470:2c94:4fdf with SMTP id
 4-20020a0562140cc400b004702c944fdfmr10635910qvx.2.1655719149490; Mon, 20 Jun
 2022 02:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
In-Reply-To: <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 20 Jun 2022 11:58:33 +0200
Message-ID: <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, mst <mst@redhat.com>,
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

On Mon, Jun 20, 2022 at 10:56 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > Implement the suspend callback allowing to suspend the virtqueues so
> > they stop processing descriptors. This is required to allow the shadow
> > virtqueue to kick in.
> >
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
> >  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
> >  2 files changed, 75 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index fb0b23e71383..ea4bc8a0cd25 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> >         if (err)
> >                 goto err_cmd;
> >
> > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
> >         kfree(in);
> >         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> >
> > @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
> >                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
> >                 return;
> >         }
> > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> >         umems_destroy(ndev, mvq);
> >  }
> >
> > @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
> >         return err;
> >  }
> >
> > +static bool is_valid_state_change(int oldstate, int newstate)
> > +{
> > +       switch (oldstate) {
> > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> >  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
> >  {
> >         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> > @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> >         void *in;
> >         int err;
> >
> > +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> > +               return 0;
> > +
> > +       if (!is_valid_state_change(mvq->fw_state, state))
> > +               return -EINVAL;
> > +
> >         in = kzalloc(inlen, GFP_KERNEL);
> >         if (!in)
> >                 return -ENOMEM;
> > @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> >         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >         struct mlx5_vdpa_virtqueue *mvq;
> > +       int err;
> >
> >         if (!mvdev->actual_features)
> >                 return;
> > @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> >         }
> >
> >         mvq = &ndev->vqs[idx];
> > -       if (!ready)
> > +       if (!ready) {
> >                 suspend_vq(ndev, mvq);
> > +       } else {
> > +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> > +               if (err) {
> > +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> > +                       ready = false;
> > +               }
> > +       }
> > +
> >
> >         mvq->ready = ready;
> >  }
> > @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> >         return err;
> >  }
> >
> > +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> > +{
> > +       struct mlx5_control_vq *cvq;
> > +
> > +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > +               return;
> > +
> > +       cvq = &mvdev->cvq;
> > +       cvq->ready = !suspend;
> > +}
>
> It looks to me we need to synchronize this with reslock. And this
> probably deserve a dedicated fix.
>
> > +
> > +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> > +{
> > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +       struct mlx5_vdpa_virtqueue *mvq;
> > +       int i;
> > +
> > +       if (!suspend) {
> > +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       down_write(&ndev->reslock);
> > +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> > +               mvq = &ndev->vqs[i];
> > +               suspend_vq(ndev, mvq);
> > +       }
> > +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
>
> Do we need to synchronize with the carrier work here? Otherwise we may
> get config notification after suspending.
>
> > +       up_write(&ndev->reslock);
> > +       return 0;
> > +}
> > +
> >  static const struct vdpa_config_ops mlx5_vdpa_ops = {
> >         .set_vq_address = mlx5_vdpa_set_vq_address,
> >         .set_vq_num = mlx5_vdpa_set_vq_num,
> > @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> >         .get_generation = mlx5_vdpa_get_generation,
> >         .set_map = mlx5_vdpa_set_map,
> >         .free = mlx5_vdpa_free,
> > +       .suspend = mlx5_vdpa_suspend,
>
> I don't see the vDPA bus patch to enable this method. Or anything I missed here?
>

Should we add
Based-on: <20220526124338.36247-1-eperezma@redhat.com>

To this series?

> Thanks
>
> >  };
> >
> >  static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
> > @@ -2827,6 +2892,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> >                 mvq->index = i;
> >                 mvq->ndev = ndev;
> >                 mvq->fwqp.fw = true;
> > +               mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> >         }
> >         for (; i < ndev->mvdev.max_vqs; i++) {
> >                 mvq = &ndev->vqs[i];
> > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > index 4414ed5b6ed2..423562f39d3c 100644
> > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > @@ -150,6 +150,14 @@ enum {
> >         MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
> >  };
> >
> > +/* This indicates that the object was not created or has alreadyi
> > + * been desroyed. It is very safe to assume that this object will never
> > + * have so many states
> > + */
> > +enum {
> > +       MLX5_VIRTIO_NET_Q_OBJECT_NONE = 0xffffffff
> > +};
> > +
> >  enum {
> >         MLX5_RQTC_LIST_Q_TYPE_RQ            = 0x0,
> >         MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q  = 0x1,
> > --
> > 2.35.1
> >
>

