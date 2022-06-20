Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F120E55154F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiFTKHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbiFTKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8265D644C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655719626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8+oyhT+8f+yjPHoPC8FgRV/Li3g70WqJrxyO3naqDE=;
        b=EAmZH1+m3thmANW/n2fx8fBSupJd4IqbP0wSkINtUuQ7srhdASm4rAu5WtDoRBEPXO2QXr
        DbHtEK2BA9A72uTez9CZ8qmjAJXa5Ysa+yNOFsDSACNNWi8IZoFLZTAcNU8uWa+RbahsJC
        J1sxfUDRe2d6ETWtYDKPN2l7UrRuvFA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-VDstPHVpPGqsT4dxuuzduA-1; Mon, 20 Jun 2022 06:07:05 -0400
X-MC-Unique: VDstPHVpPGqsT4dxuuzduA-1
Received: by mail-ed1-f70.google.com with SMTP id b14-20020a056402278e00b004359006fd49so85656ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8+oyhT+8f+yjPHoPC8FgRV/Li3g70WqJrxyO3naqDE=;
        b=T7M5tZ3t/NdDn/BiMkmrzV+eqmQ+Z4/o/lfiJUdHE9UwLCObp9a/Hmy2sKRXUB0puw
         zcubVj+H+2eVFSDWQAqzRVUDlKsmet3fV1AklB9Ie4+2v4+ap4if2KhAmvYgp9gWKFew
         5t6T/tE/BMZGJ80tGMe9bGux25tPvkabRd5GPxi02+e5yG37zBTlEmsCRcJeYm8/Vo/d
         BP+AckgmKSBqvfGP3e6+FR0iGne5504w+Y8yPvf6bSOEEVG1kGSLJDcHTcJkiQrU3+wm
         0dlvrB0AGPCL/O/Bn3dSEyIl/rFssWdaiFrQMSQs0f8KvZa83DeCoX/W0ktealBlyWV7
         RZYQ==
X-Gm-Message-State: AJIora/3SW2qkglY/W68oQJ23YucVEZJEKgK2mnUfbv+/OsFbmQj6wDn
        acRcNSeh76GzUeZQjfLwqUV1/Hqvd/QD5L1mBA+mqMElonKaWVbcvVlNbhg04DD7wl33SFoPQJd
        OpZVD/NRuOfYHqd3rVmWaXDLq
X-Received: by 2002:a17:906:6947:b0:711:a86b:6780 with SMTP id c7-20020a170906694700b00711a86b6780mr20685665ejs.686.1655719624524;
        Mon, 20 Jun 2022 03:07:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u/bE5PbUXYWNZC5VVu4LfaqOg1wJkcAHhTMKdsDxWystOWTHiclgbd+3CabgeQZjeuhlnZxg==
X-Received: by 2002:a17:906:6947:b0:711:a86b:6780 with SMTP id c7-20020a170906694700b00711a86b6780mr20685640ejs.686.1655719624264;
        Mon, 20 Jun 2022 03:07:04 -0700 (PDT)
Received: from redhat.com ([2.52.146.221])
        by smtp.gmail.com with ESMTPSA id m13-20020a056402510d00b0042ddd08d5f8sm10152736edd.2.2022.06.20.03.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 03:07:03 -0700 (PDT)
Date:   Mon, 20 Jun 2022 06:06:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
Message-ID: <20220620060312-mutt-send-email-mst@kernel.org>
References: <20220616132725.50599-1-elic@nvidia.com>
 <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
 <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:58:33AM +0200, Eugenio Perez Martin wrote:
> On Mon, Jun 20, 2022 at 10:56 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Implement the suspend callback allowing to suspend the virtqueues so
> > > they stop processing descriptors. This is required to allow the shadow
> > > virtqueue to kick in.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
> > >  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
> > >  2 files changed, 75 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index fb0b23e71383..ea4bc8a0cd25 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > >         if (err)
> > >                 goto err_cmd;
> > >
> > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
> > >         kfree(in);
> > >         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> > >
> > > @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
> > >                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
> > >                 return;
> > >         }
> > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > >         umems_destroy(ndev, mvq);
> > >  }
> > >
> > > @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
> > >         return err;
> > >  }
> > >
> > > +static bool is_valid_state_change(int oldstate, int newstate)
> > > +{
> > > +       switch (oldstate) {
> > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> > > +       default:
> > > +               return false;
> > > +       }
> > > +}
> > > +
> > >  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
> > >  {
> > >         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> > > @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > >         void *in;
> > >         int err;
> > >
> > > +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> > > +               return 0;
> > > +
> > > +       if (!is_valid_state_change(mvq->fw_state, state))
> > > +               return -EINVAL;
> > > +
> > >         in = kzalloc(inlen, GFP_KERNEL);
> > >         if (!in)
> > >                 return -ENOMEM;
> > > @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > >         struct mlx5_vdpa_virtqueue *mvq;
> > > +       int err;
> > >
> > >         if (!mvdev->actual_features)
> > >                 return;
> > > @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > >         }
> > >
> > >         mvq = &ndev->vqs[idx];
> > > -       if (!ready)
> > > +       if (!ready) {
> > >                 suspend_vq(ndev, mvq);
> > > +       } else {
> > > +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> > > +               if (err) {
> > > +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> > > +                       ready = false;
> > > +               }
> > > +       }
> > > +
> > >
> > >         mvq->ready = ready;
> > >  }
> > > @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> > >         return err;
> > >  }
> > >
> > > +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> > > +{
> > > +       struct mlx5_control_vq *cvq;
> > > +
> > > +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > +               return;
> > > +
> > > +       cvq = &mvdev->cvq;
> > > +       cvq->ready = !suspend;
> > > +}
> >
> > It looks to me we need to synchronize this with reslock. And this
> > probably deserve a dedicated fix.
> >
> > > +
> > > +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> > > +{
> > > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > +       struct mlx5_vdpa_virtqueue *mvq;
> > > +       int i;
> > > +
> > > +       if (!suspend) {
> > > +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> > > +               return -EOPNOTSUPP;
> > > +       }
> > > +
> > > +       down_write(&ndev->reslock);
> > > +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> > > +               mvq = &ndev->vqs[i];
> > > +               suspend_vq(ndev, mvq);
> > > +       }
> > > +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
> >
> > Do we need to synchronize with the carrier work here? Otherwise we may
> > get config notification after suspending.
> >
> > > +       up_write(&ndev->reslock);
> > > +       return 0;
> > > +}
> > > +
> > >  static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > >         .set_vq_address = mlx5_vdpa_set_vq_address,
> > >         .set_vq_num = mlx5_vdpa_set_vq_num,
> > > @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > >         .get_generation = mlx5_vdpa_get_generation,
> > >         .set_map = mlx5_vdpa_set_map,
> > >         .free = mlx5_vdpa_free,
> > > +       .suspend = mlx5_vdpa_suspend,
> >
> > I don't see the vDPA bus patch to enable this method. Or anything I missed here?
> >
> 
> Should we add
> Based-on: <20220526124338.36247-1-eperezma@redhat.com>
> 
> To this series?

If it's based on your patch then mentioning this in the log and
including the S.O.B. is customary. what would this tag add?
was there relevant discussion?


> > Thanks
> >
> > >  };
> > >
> > >  static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
> > > @@ -2827,6 +2892,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> > >                 mvq->index = i;
> > >                 mvq->ndev = ndev;
> > >                 mvq->fwqp.fw = true;
> > > +               mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > >         }
> > >         for (; i < ndev->mvdev.max_vqs; i++) {
> > >                 mvq = &ndev->vqs[i];
> > > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > index 4414ed5b6ed2..423562f39d3c 100644
> > > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > @@ -150,6 +150,14 @@ enum {
> > >         MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
> > >  };
> > >
> > > +/* This indicates that the object was not created or has alreadyi
> > > + * been desroyed. It is very safe to assume that this object will never
> > > + * have so many states
> > > + */
> > > +enum {
> > > +       MLX5_VIRTIO_NET_Q_OBJECT_NONE = 0xffffffff
> > > +};
> > > +
> > >  enum {
> > >         MLX5_RQTC_LIST_Q_TYPE_RQ            = 0x0,
> > >         MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q  = 0x1,
> > > --
> > > 2.35.1
> > >
> >

