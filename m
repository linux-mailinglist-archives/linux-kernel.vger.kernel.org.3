Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84F3552C63
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiFUHwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347000AbiFUHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 554D0248EA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655797954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbfQbA+lbrllekKppJrLO+lLoZayibVp217TUJUktlg=;
        b=ZMQfUvrS+DAGN0QJ6bNsZutYVblJFnj3hxlFJqF6TPLSRO0svcU+vY9WhH78PAKE2AxqVo
        bnn9jpoYO1milqidE6NEsNKsNRwqZNUSf13qnCxCSolrbv+3RKH9ooEqKdJS5Y44Xmg8U7
        Y4kBFf8qjn42UuuOzrI1QYYXByEfSe4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-Ix3ae77RMzKT-p5oGyLj9A-1; Tue, 21 Jun 2022 03:52:32 -0400
X-MC-Unique: Ix3ae77RMzKT-p5oGyLj9A-1
Received: by mail-lf1-f70.google.com with SMTP id q22-20020a0565123a9600b0047f6b8e1babso2628470lfu.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbfQbA+lbrllekKppJrLO+lLoZayibVp217TUJUktlg=;
        b=OIOMl6vGvuU3yAcVSQ6uFT7WPtKaQIRmlDB7Z6+jrpQb/GzyXD1b9+lGgcG6+S4UBj
         /3QQ81SlcdW7k450TunMRTaY9xOzEBkJKKKx8iobXUJ0uP2OxKhems1Mmu1oZ5bDQWWf
         tE2wvPXGyR1oY11kAd23Qsfki6Gq8etJjwnyPhR2epnufxVw1+8CJe5jFo+nTuGwwwFK
         OUd2mUD/nodkEZAvB6dDZQI9p6/0I007AQeL9JmdThA4OTqhosDR7PVl5pD7tiAbztbX
         EGJ4XdhhtYTKvpEWf8Dy/6b3FI/UnDHpz86bFoYec0i7pKMwUtI5ixH69yCZsE2h24hM
         P09g==
X-Gm-Message-State: AJIora9tfKLmjXbkKXE9cxu4nWndRgg0BZR5pGvaZU40hj1EsfXkmIzY
        CPp6LTJbZjo4Sa0+NWJJzxVd7FMaKlU6+EcvGFGkHHOiO962LWIueRsfmNGZVBOFAnjCuduHg7o
        7za6PUXecNIMDk4lYRLwb578zz/AhedGZqitDM1Vn
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id h22-20020a2e3a16000000b0025578112827mr13558538lja.130.1655797951370;
        Tue, 21 Jun 2022 00:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t1yCRG/NZhfDCal8QlfALVTw5lISDlDaowzC78DMuSasoHtyf137yR5R3VQeSLsvv/tUzY8AFJPBu5BC8H4es=
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id
 h22-20020a2e3a16000000b0025578112827mr13558532lja.130.1655797951127; Tue, 21
 Jun 2022 00:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
 <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
 <CACGkMEtcs9e1NJ7ArkibQSrDN7j_eyciZo=yDfbd5Jsb4gvzZA@mail.gmail.com> <CAJaqyWfDQ5RhHPuW2DnJ3o72+e5LMzZ9vjp6rD4kYh9G7KgCvw@mail.gmail.com>
In-Reply-To: <CAJaqyWfDQ5RhHPuW2DnJ3o72+e5LMzZ9vjp6rD4kYh9G7KgCvw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 21 Jun 2022 15:52:19 +0800
Message-ID: <CACGkMEt2mxQVvJ06q9fjRb+Jh9Ac4xyuSx4w0ovcRZRSD8HE=A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To:     Eugenio Perez Martin <eperezma@redhat.com>
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

On Tue, Jun 21, 2022 at 3:49 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Jun 21, 2022 at 5:05 AM Jason Wang <jasowang@redhat.com> wrote:
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
> >
> > (I don't see any blocker for this especially considering parents can
> > choose to do reset + set_vring_state etc.)
> >
>
> I suggest starting simple and modify the vdpa_sim series so it only
> provides suspend() operation, with no parameters. We can always add
> the resume() later if needed at all.

This complicates the feature a little bit.

>
> To provide the reset + set_vring_state etc seems simpler if done from userland.

One issue for the current API is that it only works for networking
devices since we don't have a way to set device state.

By having stop/resume, we know the device state is kept.

Thanks

>
> Thanks!
>
> > Thanks
> >
> > >
> > > > Thanks
> > > >
> > > > >  };
> > > > >
> > > > >  static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
> > > > > @@ -2827,6 +2892,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> > > > >                 mvq->index = i;
> > > > >                 mvq->ndev = ndev;
> > > > >                 mvq->fwqp.fw = true;
> > > > > +               mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > > > >         }
> > > > >         for (; i < ndev->mvdev.max_vqs; i++) {
> > > > >                 mvq = &ndev->vqs[i];
> > > > > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > index 4414ed5b6ed2..423562f39d3c 100644
> > > > > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > @@ -150,6 +150,14 @@ enum {
> > > > >         MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
> > > > >  };
> > > > >
> > > > > +/* This indicates that the object was not created or has alreadyi
> > > > > + * been desroyed. It is very safe to assume that this object will never
> > > > > + * have so many states
> > > > > + */
> > > > > +enum {
> > > > > +       MLX5_VIRTIO_NET_Q_OBJECT_NONE = 0xffffffff
> > > > > +};
> > > > > +
> > > > >  enum {
> > > > >         MLX5_RQTC_LIST_Q_TYPE_RQ            = 0x0,
> > > > >         MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q  = 0x1,
> > > > > --
> > > > > 2.35.1
> > > > >
> > > >
> > >
> >
>

