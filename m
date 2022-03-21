Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2653C4E2175
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbiCUHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbiCUHh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BB5153B68
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647848191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qe08beYUx+UYZYqGshctk6NaXdVdumZ1XV+DJA6B5a8=;
        b=LoVX1RnyVaGD+R1HfCzE+IrPtoCP5oo+XASkze5pKbotqlzkqrMrXN47NJfogha5DzByqf
        e5Kk33o8qoFa4uPJQlzYoNAgDkVx4wqrfyxH4CgYw4I17hhMD2dnx7RnfS/Mowal9rVFn4
        MSBWDZUFQHtek7ajFeG3xMKpi9dfBRw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-A5S5p0eZOFO-qvn-vIl-7g-1; Mon, 21 Mar 2022 03:36:29 -0400
X-MC-Unique: A5S5p0eZOFO-qvn-vIl-7g-1
Received: by mail-lj1-f200.google.com with SMTP id n9-20020a2e82c9000000b002435af2e8b9so5863140ljh.20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qe08beYUx+UYZYqGshctk6NaXdVdumZ1XV+DJA6B5a8=;
        b=xLR7L7TwTTxq8K52gEoI4e5fUrLrLCjhOaixRwvLBERtDffduW0Ixzn1dtdjF6FFDk
         rZoCDsspV88Hpe7t+n3J8uImdzUQK91h48qprSP59WJuMWyjaNm8aZg3J49e02Bqf93I
         Y1YkdmLiwMrfG6ycY4/L1d+x75OE1nte6iHdFcvCpcwugSO9O/Eq6NICnJMPEleZ4OER
         ++kp3NjVyo9IhiqAStO06KU9mpwpVV6krhTvDI+ER74xq71hIp9M0Z5JW+1UOuoZ9C04
         VU83xGL49wKh/Y+7E8OWQ7JX/O4XAtiG/skaHarb8WTP1UV4T8sexgNxaB0AmKAi2fq6
         Vukg==
X-Gm-Message-State: AOAM533lmS5sIvLxLlZaBJ3p12H9L+EaUYPS/R3FckBz0Z597sRXXm69
        X4hBfYg+fTBfr9Jnfkp3yYBNoVq6g54nwLQMGQjM9XNXvINdGHCUk5vKaQ4K/SMepPXCx6041eH
        F/6m/bGiBYgp8qVYOTWxqn8jAO9LIswr6rIxAochk
X-Received: by 2002:a05:6512:2203:b0:44a:12c9:8696 with SMTP id h3-20020a056512220300b0044a12c98696mr8177462lfu.98.1647848187436;
        Mon, 21 Mar 2022 00:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrJCIJF80wb6QJBxaOpt0rFvy2rgLkmZPLA1xItXiYu5J1dt0MCV1yBUyegrVf8EYAl2dqO0mzDVFLFNta2T4=
X-Received: by 2002:a05:6512:2203:b0:44a:12c9:8696 with SMTP id
 h3-20020a056512220300b0044a12c98696mr8177451lfu.98.1647848187178; Mon, 21 Mar
 2022 00:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com> <20220321060429.10457-2-jasowang@redhat.com>
 <20220321032130-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220321032130-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 21 Mar 2022 15:36:16 +0800
Message-ID: <CACGkMEvQCBTk7WVLvRAsgj1OOcE7rh5DEpN91HOdZLZyagcbuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa: mlx5: synchronize driver status with CVQ
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 3:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Mar 21, 2022 at 02:04:29PM +0800, Jason Wang wrote:
> > Currently, CVQ doesn't have any synchronization with the driver
> > status. Then CVQ emulation code run in the middle of:
> >
> > 1) device reset
> > 2) device status changed
> > 3) map updating
> >
> > The will lead several unexpected issue like trying to execute CVQ
> > command after the driver has been teared down.
> >
> > Fixing this by using reslock to synchronize CVQ emulation code with
> > the driver status changing:
> >
> > - protect the whole device reset, status changing and map updating
> >   with reslock
> > - protect the CVQ handler with the reslock and check
> >   VIRTIO_CONFIG_S_DRIVER_OK in the CVQ handler
> >
> > This will guarantee that:
> >
> > 1) CVQ handler won't work if VIRTIO_CONFIG_S_DRIVER_OK is not set
> > 2) CVQ handler will see a consistent state of the driver instead of
> >    the partial one when it is running in the middle of the
> >    teardown_driver() or setup_driver().
> >
> > Cc: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 42 +++++++++++++++++++++++--------
> >  1 file changed, 31 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index d5a6fb3f9c41..524240f55c1c 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1618,11 +1618,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >       mvdev = wqent->mvdev;
> >       ndev = to_mlx5_vdpa_ndev(mvdev);
> >       cvq = &mvdev->cvq;
> > +
> > +     mutex_lock(&ndev->reslock);
> > +
> > +     if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > +             goto done;
> > +
> >       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > -             return;
> > +             goto done;
> >
> >       if (!cvq->ready)
> > -             return;
> > +             goto done;
> >
> >       while (true) {
> >               err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
> > @@ -1663,6 +1669,9 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >                       break;
> >               }
> >       }
> > +
> > +done:
> > +     mutex_unlock(&ndev->reslock);
> >  }
> >
> >  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> > @@ -2125,6 +2134,8 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> >       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >       int err;
> >
> > +     mutex_lock(&ndev->reslock);
> > +
> >       suspend_vqs(ndev);
> >       err = save_channels_info(ndev);
> >       if (err)
> > @@ -2137,18 +2148,20 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> >               goto err_mr;
> >
> >       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > -             return 0;
> > +             goto err_mr;
> >
> >       restore_channels_info(ndev);
> >       err = setup_driver(mvdev);
> >       if (err)
> >               goto err_setup;
> >
> > +     mutex_unlock(&ndev->reslock);
> >       return 0;
> >
> >  err_setup:
> >       mlx5_vdpa_destroy_mr(mvdev);
> >  err_mr:
> > +     mutex_unlock(&ndev->reslock);
> >       return err;
> >  }
> >
> > @@ -2157,7 +2170,8 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
> >       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >       int err;
> >
> > -     mutex_lock(&ndev->reslock);
> > +     WARN_ON(!mutex_is_locked(&ndev->reslock));
> > +
> >       if (ndev->setup) {
> >               mlx5_vdpa_warn(mvdev, "setup driver called for already setup driver\n");
> >               err = 0;
>
>
> Maybe also add a comment near function header explaining this must be
> called with lock held.

Will do.

Thanks

>

