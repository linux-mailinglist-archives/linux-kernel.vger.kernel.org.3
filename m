Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDFE572BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiGMD3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiGMD3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 959CF599D1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657682985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3QQVGHiCE5MKmgZTyiKOvJGL8kakTxZI99KhXYZZc+Q=;
        b=fAvczVa717ktKRGlWUTwCZqwMV60kju7uY/GSM1FFyhb0uidzFZZpR6sFKugoYLg7Tv8zh
        S/fmbpC8EXMIRh7j6MNfYzMKdeHYIh4nkB5usa4S2qa9/cit27wnuSQcWDDsFoIyTZt1pG
        ikSquC9wXEUOKl6/Bc0txX8cP1bUnvQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-tBf1hHibOdSdcAWFKm2tXA-1; Tue, 12 Jul 2022 23:29:35 -0400
X-MC-Unique: tBf1hHibOdSdcAWFKm2tXA-1
Received: by mail-lf1-f69.google.com with SMTP id d41-20020a0565123d2900b00489ed34ed26so1978850lfv.15
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QQVGHiCE5MKmgZTyiKOvJGL8kakTxZI99KhXYZZc+Q=;
        b=d2b2QtKG17JwzKYoJfEV5I801iF4o26NO3oRBd/G6H13iZGr8S2+1cYZzk9RT3rI0e
         3FKz8zx1dXnhFevWtHC+190DB4hUzjqIasb6dFYO/zL+APOb4jxeT3f//pCkELGuP1yj
         Hhr6AzeKdZ0d8c0ejRnVj1CzfJIV9THRvVELUij8bbrPukKKSWw7ggtWNDG/ytwHBv0n
         zayOv75ff0OFNLQV6g84HFGRQ4u4nVLzGxybhPV9ajpfMRhgWvD+e1D6wCeEGtUz10Es
         OAKbrcnBlx/99ADd+Itie0V9lxXLnBv675mNj3t7RMxK5MbIj1W26y+KVad1UHNoqEOc
         tP5w==
X-Gm-Message-State: AJIora+9RWRfaDWyk4hfiFj2S404VGsW6FT0FOyvWsNfgsv/EgoLiydi
        veytB3UB7dAw6HGyIPVm1fAt2FJUNSwo2/7whX0NQev21d94AvigBHVFhHUm/pGRxgMmG8fX+AW
        gPVjKVZp1VDCtierO8GqXptka+R7PzrQKLHDkDSBe
X-Received: by 2002:ac2:50d1:0:b0:489:fb36:cde1 with SMTP id h17-20020ac250d1000000b00489fb36cde1mr679916lfm.411.1657682974308;
        Tue, 12 Jul 2022 20:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vR++2/deF9gVb9a2Zd9gCVPFExHzk7dcWERBChP5SyrtGB86dwpXLnig8ahnOxWPZ3ryzHyDbEm/0qIO6boII=
X-Received: by 2002:ac2:50d1:0:b0:489:fb36:cde1 with SMTP id
 h17-20020ac250d1000000b00489fb36cde1mr679908lfm.411.1657682974086; Tue, 12
 Jul 2022 20:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
 <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
 <CACGkMEtcs9e1NJ7ArkibQSrDN7j_eyciZo=yDfbd5Jsb4gvzZA@mail.gmail.com>
 <DM8PR12MB5400FDBB177693A55074D19EAB879@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEu4iRHa_D+1jQHq65UZch-102-MhnRD22Umz94XP9+CJA@mail.gmail.com> <CAJaqyWcUUk1H2+aeoj7yAFKXSg1gdV2GzTdWUTAGi0AiW9r64w@mail.gmail.com>
In-Reply-To: <CAJaqyWcUUk1H2+aeoj7yAFKXSg1gdV2GzTdWUTAGi0AiW9r64w@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 13 Jul 2022 11:29:22 +0800
Message-ID: <CACGkMEvGQrDdZ+g3jJF6kM=cTqi+tmxiddZYLGP6gMPKC2A68Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 5:16 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Jul 12, 2022 at 10:14 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Jul 11, 2022 at 2:14 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Tuesday, June 21, 2022 6:05 AM
> > > > To: Eugenio Perez Martin <eperezma@redhat.com>
> > > > Cc: Eli Cohen <elic@nvidia.com>; mst <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-kernel
> > > > <linux-kernel@vger.kernel.org>; Si-Wei Liu <si-wei.liu@oracle.com>; Parav Pandit <parav@nvidia.com>
> > > > Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
> > > >
> > > > On Mon, Jun 20, 2022 at 5:59 PM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Mon, Jun 20, 2022 at 10:56 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > > > >
> > > > > > > Implement the suspend callback allowing to suspend the virtqueues so
> > > > > > > they stop processing descriptors. This is required to allow the shadow
> > > > > > > virtqueue to kick in.
> > > > > > >
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
> > > > > > >  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
> > > > > > >  2 files changed, 75 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index fb0b23e71383..ea4bc8a0cd25 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > > > >         if (err)
> > > > > > >                 goto err_cmd;
> > > > > > >
> > > > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
> > > > > > >         kfree(in);
> > > > > > >         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> > > > > > >
> > > > > > > @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
> > > > > > >                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
> > > > > > >                 return;
> > > > > > >         }
> > > > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > > > > > >         umems_destroy(ndev, mvq);
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
> > > > > > >         return err;
> > > > > > >  }
> > > > > > >
> > > > > > > +static bool is_valid_state_change(int oldstate, int newstate)
> > > > > > > +{
> > > > > > > +       switch (oldstate) {
> > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> > > > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> > > > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> > > > > > > +       default:
> > > > > > > +               return false;
> > > > > > > +       }
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
> > > > > > >  {
> > > > > > >         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> > > > > > > @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > > > >         void *in;
> > > > > > >         int err;
> > > > > > >
> > > > > > > +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       if (!is_valid_state_change(mvq->fw_state, state))
> > > > > > > +               return -EINVAL;
> > > > > > > +
> > > > > > >         in = kzalloc(inlen, GFP_KERNEL);
> > > > > > >         if (!in)
> > > > > > >                 return -ENOMEM;
> > > > > > > @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > >         struct mlx5_vdpa_virtqueue *mvq;
> > > > > > > +       int err;
> > > > > > >
> > > > > > >         if (!mvdev->actual_features)
> > > > > > >                 return;
> > > > > > > @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > > > >         }
> > > > > > >
> > > > > > >         mvq = &ndev->vqs[idx];
> > > > > > > -       if (!ready)
> > > > > > > +       if (!ready) {
> > > > > > >                 suspend_vq(ndev, mvq);
> > > > > > > +       } else {
> > > > > > > +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> > > > > > > +               if (err) {
> > > > > > > +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> > > > > > > +                       ready = false;
> > > > > > > +               }
> > > > > > > +       }
> > > > > > > +
> > > > > > >
> > > > > > >         mvq->ready = ready;
> > > > > > >  }
> > > > > > > @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> > > > > > >         return err;
> > > > > > >  }
> > > > > > >
> > > > > > > +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> > > > > > > +{
> > > > > > > +       struct mlx5_control_vq *cvq;
> > > > > > > +
> > > > > > > +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       cvq = &mvdev->cvq;
> > > > > > > +       cvq->ready = !suspend;
> > > > > > > +}
> > > > > >
> > > > > > It looks to me we need to synchronize this with reslock. And this
> > > > > > probably deserve a dedicated fix.
> > > > > >
> > > > > > > +
> > > > > > > +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> > > > > > > +{
> > > > > > > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > > > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > > +       struct mlx5_vdpa_virtqueue *mvq;
> > > > > > > +       int i;
> > > > > > > +
> > > > > > > +       if (!suspend) {
> > > > > > > +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> > > > > > > +               return -EOPNOTSUPP;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       down_write(&ndev->reslock);
> > > > > > > +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> > > > > > > +               mvq = &ndev->vqs[i];
> > > > > > > +               suspend_vq(ndev, mvq);
> > > > > > > +       }
> > > > > > > +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
> > > > > >
> > > > > > Do we need to synchronize with the carrier work here? Otherwise we may
> > > > > > get config notification after suspending.
> > > > > >
> > > > > > > +       up_write(&ndev->reslock);
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > > > >         .set_vq_address = mlx5_vdpa_set_vq_address,
> > > > > > >         .set_vq_num = mlx5_vdpa_set_vq_num,
> > > > > > > @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > > > >         .get_generation = mlx5_vdpa_get_generation,
> > > > > > >         .set_map = mlx5_vdpa_set_map,
> > > > > > >         .free = mlx5_vdpa_free,
> > > > > > > +       .suspend = mlx5_vdpa_suspend,
> > > > > >
> > > > > > I don't see the vDPA bus patch to enable this method. Or anything I missed here?
> > > > > >
> > > > >
> > > > > Should we add
> > > > > Based-on: <20220526124338.36247-1-eperezma@redhat.com>
> > > > >
> > > > > To this series?
> > > >
> > > > Probably, but that series seems to support resume while this series doesn't.
> > > >
> > > > Any reason for this?
> > >
> > > I think Eugenio agreed that resume is not really required since we're going stop using this
> > > instance and migrate. In any case, we don't support resume for the hardware object
> > > though it could be simulated should it be absolutely necessary.
> >
> > This is fine if everything is fine during the live migration. But when
> > migration fails due to some reason, management (libvirt) may choose to
> > restart the device in the source.
> >
> > This means we should either
> >
> > 1) support resume in the parent
> > 2) emulate it in the qemu (with a lot of restoring of the states)
> >
>
> I think it should be handled in qemu (at least the POC reset the
> device), but I didn't exercise a lot of the failure paths there
> because, well, it was a POC :).

It looks like a must in the production environment. The failure is not
necessarily related to shadow virtqueue itself.

Thanks

>
> > And it is not only used for live migration, it could be used for vmstop/start.
> >
>
> I think it would be easier if we dedicate a feature flag for resuming
> the device in the future. Qemu could take advantage of it at some
> error paths of live migration, but less than it seems because it
> overrides things like ring addresses. And, obviously, in the
> vmstop/vmstart.
>
> Actually, net devices should be ok to restore with a full reset. The
> problem should be filesystems etc that are not part of vdpa at the
> moment.
>
> Thanks!
>

