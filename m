Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47758577E42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiGRJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiGRJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BFD1BCAF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658135051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=agckOinCzDcYOPro7emOixGeA1c49jhzY5NQYNGFsdI=;
        b=M8VsNyD29wcbU28UDjq9IM88IBc7/uHYiukDkLhVjQ2HNKy74khxcictEwt7yB1nBsNtRO
        I8vW4WsuKwV12BraRvs0Ej+tgINLcV9fAh82psGiX7QODtviUh/PCir+jgcMwjauOynBFj
        UoLtZGoDS9ajOGYVVrh351XOKukKFk8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-BrjW3IWHPjaPIGqXAbcpgA-1; Mon, 18 Jul 2022 05:04:04 -0400
X-MC-Unique: BrjW3IWHPjaPIGqXAbcpgA-1
Received: by mail-lf1-f69.google.com with SMTP id g3-20020a05651222c300b00489fe30ee90so4043383lfu.20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agckOinCzDcYOPro7emOixGeA1c49jhzY5NQYNGFsdI=;
        b=OTefe5bGzBFnekscX0zzUQ2nV9Gs4xuddJ/iduIjVnNIux+csFgcQaXdDYl/LL1jzD
         YxpaNg09A44oSQ6ZA7gfV0XBL2OhYAMlG0gBDUMjAbgIf3NRRM65+9GVd00qpmcf8Q0s
         XiWXFKTC1RfHTexvUR0PCNx7JkDFFJWNddHTVp75Tycr0tomx7FNsoitMnIUqPKZQlek
         mGU+mVB6qFQ3bkfrdzvgZjWYBU/ricBIbr0OliJgcNLQ6AfvLY2Q4qA8kNXHhcPv9mNm
         7apoHen/VjFyXWLE6kv8qKo5aIAR5adbxbtj42Uwn5VAjXVVOc8kIw1WV4q9OeUNFATi
         dQAQ==
X-Gm-Message-State: AJIora/KMnaHJfsaEEoEH91vwWO+lEh+WbVTs531B9PSNQrTAeUehbLP
        r3cz5ysIaxdUGZmJaTEUB9Eh7mg/PQzR+10rW5TsilU2BQQ0q5colTtIWRCTR9bnw9oCJl6EBrZ
        tAKCBefkBSG6DfOVzc7rp0OvKPCvZ9ceGWA6kB6AD
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id p26-20020a056512313a00b00489caea7e27mr14810201lfd.397.1658135042583;
        Mon, 18 Jul 2022 02:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tmfCWJpHOeqbRDiJ1Ogzo7DdOMES+cPp4bBhODSIqr31Bc5xrX87t+oKCHjSiQh9uTzPDsaJ4W7xnIGoEb5Kg=
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id
 p26-20020a056512313a00b00489caea7e27mr14810192lfd.397.1658135042365; Mon, 18
 Jul 2022 02:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
 <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
 <CACGkMEtcs9e1NJ7ArkibQSrDN7j_eyciZo=yDfbd5Jsb4gvzZA@mail.gmail.com>
 <DM8PR12MB5400FDBB177693A55074D19EAB879@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEu4iRHa_D+1jQHq65UZch-102-MhnRD22Umz94XP9+CJA@mail.gmail.com>
 <CAJaqyWcUUk1H2+aeoj7yAFKXSg1gdV2GzTdWUTAGi0AiW9r64w@mail.gmail.com>
 <CACGkMEvGQrDdZ+g3jJF6kM=cTqi+tmxiddZYLGP6gMPKC2A68Q@mail.gmail.com> <DM8PR12MB5400DBB3EBA91C250E703E1EAB899@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400DBB3EBA91C250E703E1EAB899@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 18 Jul 2022 17:03:51 +0800
Message-ID: <CACGkMEvCdg8pheddm7iTAJcvPhaWHA0nagASREf8F1zcGZ6AiA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To:     Eli Cohen <elic@nvidia.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:18 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, July 13, 2022 6:29 AM
> > To: Eugenio Perez Martin <eperezma@redhat.com>
> > Cc: Eli Cohen <elic@nvidia.com>; mst <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; Si-Wei Liu <si-wei.liu@oracle.com>; Parav Pandit <parav@nvidia.com>
> > Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
> >
> > On Tue, Jul 12, 2022 at 5:16 PM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Tue, Jul 12, 2022 at 10:14 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Jul 11, 2022 at 2:14 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Tuesday, June 21, 2022 6:05 AM
> > > > > > To: Eugenio Perez Martin <eperezma@redhat.com>
> > > > > > Cc: Eli Cohen <elic@nvidia.com>; mst <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-
> > kernel
> > > > > > <linux-kernel@vger.kernel.org>; Si-Wei Liu <si-wei.liu@oracle.com>; Parav Pandit <parav@nvidia.com>
> > > > > > Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
> > > > > >
> > > > > > On Mon, Jun 20, 2022 at 5:59 PM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 20, 2022 at 10:56 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > > > > > >
> > > > > > > > > Implement the suspend callback allowing to suspend the virtqueues so
> > > > > > > > > they stop processing descriptors. This is required to allow the shadow
> > > > > > > > > virtqueue to kick in.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
> > > > > > > > >  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
> > > > > > > > >  2 files changed, 75 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > index fb0b23e71383..ea4bc8a0cd25 100644
> > > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > > > > > >         if (err)
> > > > > > > > >                 goto err_cmd;
> > > > > > > > >
> > > > > > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
> > > > > > > > >         kfree(in);
> > > > > > > > >         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> > > > > > > > >
> > > > > > > > > @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
> > > > > > > > >                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
> > > > > > > > >                 return;
> > > > > > > > >         }
> > > > > > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > > > > > > > >         umems_destroy(ndev, mvq);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
> > > > > > > > >         return err;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static bool is_valid_state_change(int oldstate, int newstate)
> > > > > > > > > +{
> > > > > > > > > +       switch (oldstate) {
> > > > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> > > > > > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> > > > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> > > > > > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> > > > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> > > > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> > > > > > > > > +       default:
> > > > > > > > > +               return false;
> > > > > > > > > +       }
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
> > > > > > > > >  {
> > > > > > > > >         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> > > > > > > > > @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > > > > > >         void *in;
> > > > > > > > >         int err;
> > > > > > > > >
> > > > > > > > > +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> > > > > > > > > +               return 0;
> > > > > > > > > +
> > > > > > > > > +       if (!is_valid_state_change(mvq->fw_state, state))
> > > > > > > > > +               return -EINVAL;
> > > > > > > > > +
> > > > > > > > >         in = kzalloc(inlen, GFP_KERNEL);
> > > > > > > > >         if (!in)
> > > > > > > > >                 return -ENOMEM;
> > > > > > > > > @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > > > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > > > >         struct mlx5_vdpa_virtqueue *mvq;
> > > > > > > > > +       int err;
> > > > > > > > >
> > > > > > > > >         if (!mvdev->actual_features)
> > > > > > > > >                 return;
> > > > > > > > > @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > >         mvq = &ndev->vqs[idx];
> > > > > > > > > -       if (!ready)
> > > > > > > > > +       if (!ready) {
> > > > > > > > >                 suspend_vq(ndev, mvq);
> > > > > > > > > +       } else {
> > > > > > > > > +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> > > > > > > > > +               if (err) {
> > > > > > > > > +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> > > > > > > > > +                       ready = false;
> > > > > > > > > +               }
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > >
> > > > > > > > >         mvq->ready = ready;
> > > > > > > > >  }
> > > > > > > > > @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> > > > > > > > >         return err;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> > > > > > > > > +{
> > > > > > > > > +       struct mlx5_control_vq *cvq;
> > > > > > > > > +
> > > > > > > > > +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > > > > > > > +               return;
> > > > > > > > > +
> > > > > > > > > +       cvq = &mvdev->cvq;
> > > > > > > > > +       cvq->ready = !suspend;
> > > > > > > > > +}
> > > > > > > >
> > > > > > > > It looks to me we need to synchronize this with reslock. And this
> > > > > > > > probably deserve a dedicated fix.
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> > > > > > > > > +{
> > > > > > > > > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > > > > > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > > > > +       struct mlx5_vdpa_virtqueue *mvq;
> > > > > > > > > +       int i;
> > > > > > > > > +
> > > > > > > > > +       if (!suspend) {
> > > > > > > > > +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> > > > > > > > > +               return -EOPNOTSUPP;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       down_write(&ndev->reslock);
> > > > > > > > > +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> > > > > > > > > +               mvq = &ndev->vqs[i];
> > > > > > > > > +               suspend_vq(ndev, mvq);
> > > > > > > > > +       }
> > > > > > > > > +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
> > > > > > > >
> > > > > > > > Do we need to synchronize with the carrier work here? Otherwise we may
> > > > > > > > get config notification after suspending.
> > > > > > > >
> > > > > > > > > +       up_write(&ndev->reslock);
> > > > > > > > > +       return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > > > > > >         .set_vq_address = mlx5_vdpa_set_vq_address,
> > > > > > > > >         .set_vq_num = mlx5_vdpa_set_vq_num,
> > > > > > > > > @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > > > > > >         .get_generation = mlx5_vdpa_get_generation,
> > > > > > > > >         .set_map = mlx5_vdpa_set_map,
> > > > > > > > >         .free = mlx5_vdpa_free,
> > > > > > > > > +       .suspend = mlx5_vdpa_suspend,
> > > > > > > >
> > > > > > > > I don't see the vDPA bus patch to enable this method. Or anything I missed here?
> > > > > > > >
> > > > > > >
> > > > > > > Should we add
> > > > > > > Based-on: <20220526124338.36247-1-eperezma@redhat.com>
> > > > > > >
> > > > > > > To this series?
> > > > > >
> > > > > > Probably, but that series seems to support resume while this series doesn't.
> > > > > >
> > > > > > Any reason for this?
> > > > >
> > > > > I think Eugenio agreed that resume is not really required since we're going stop using this
> > > > > instance and migrate. In any case, we don't support resume for the hardware object
> > > > > though it could be simulated should it be absolutely necessary.
> > > >
> > > > This is fine if everything is fine during the live migration. But when
> > > > migration fails due to some reason, management (libvirt) may choose to
> > > > restart the device in the source.
> > > >
> > > > This means we should either
> > > >
> > > > 1) support resume in the parent
> > > > 2) emulate it in the qemu (with a lot of restoring of the states)
> > > >
> > >
> > > I think it should be handled in qemu (at least the POC reset the
> > > device), but I didn't exercise a lot of the failure paths there
> > > because, well, it was a POC :).
> >
> > It looks like a must in the production environment. The failure is not
> > necessarily related to shadow virtqueue itself.
> >
>
> I don't see a specific interface to resume the device after suspend.
> Reset however could do the job and we already have it.

Yes, this is fine as long as we can emulate it via set_vq_state + reset.

Thanks

>
> > Thanks
> >
> > >
> > > > And it is not only used for live migration, it could be used for vmstop/start.
> > > >
> > >
> > > I think it would be easier if we dedicate a feature flag for resuming
> > > the device in the future. Qemu could take advantage of it at some
> > > error paths of live migration, but less than it seems because it
> > > overrides things like ring addresses. And, obviously, in the
> > > vmstop/vmstart.
> > >
> > > Actually, net devices should be ok to restore with a full reset. The
> > > problem should be filesystems etc that are not part of vdpa at the
> > > moment.
> > >
> > > Thanks!
> > >
>

