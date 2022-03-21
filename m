Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F4C4E216F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbiCUHhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiCUHhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE127E59
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647848152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jN9EzqA/aDWgWsm6Qj9+fUo2briM9lSf7r09izKJQBM=;
        b=NwMF2sidYHKgKTG0hEPEfhOPiosH4hGOnWjyMm817vjhp21N6lVJTDq6wkKTOxQ3fv56ZD
        AArjr0yAkQDIgWsi7o+3w6IXkBOAcyynrkhqKAwN578f8SDVyG51Nc+JDmSQaoLVh/8g7i
        1zgFhdmivL1S80NkBARF0Nc55yrCz2k=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-36QmAx1wN9KPkii_gwaOLg-1; Mon, 21 Mar 2022 03:35:50 -0400
X-MC-Unique: 36QmAx1wN9KPkii_gwaOLg-1
Received: by mail-lj1-f198.google.com with SMTP id 20-20020a05651c009400b002462f08f8d2so5897550ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jN9EzqA/aDWgWsm6Qj9+fUo2briM9lSf7r09izKJQBM=;
        b=7tHQoworejUKeZ7jPSp9aIiWIWnr77W3inUUMrGUU7uO6vxZenQUTvZ0WlCJquzE2Q
         LkZEz4qjnGuv5356//qrZgGIADF90llfgQCZzhdGRykJnmvb90r8QWyffJP9Kaz9mBwh
         U5xF08kKEAmfsNRgD+Y01st40sOXEatZpA82WbRu+Hm2qdMzGtxAhsjWlXAh/Euz/A1O
         wjoAHX05MhX3Ta1QmO78YY5dsZznDzJi+Wf7nBD5OLy9jbuaYS67aIsGJCtA4SQUbFYN
         G2GHSoSKRvylLmfp/rGPHxeJiOWD1dYfFDUbSaXDlVVBirCXyGTnlr4GIp2BczaP+nX2
         vY1g==
X-Gm-Message-State: AOAM531isoRU7zdEiNUFXAWx1JDxuUqtmbRWnh+V7eim9Mycda9DBs4h
        9C5QBf6Na/03RqviwWbr8QXLiNtr532GOqUQl1kZ76jVyRc2A6hTDqjwFQslp0QZZ4tB5cSfz+i
        TxVCi41aZIKtZmB2Upwp9heLp5sVujxnZ/L9Vf8Lz
X-Received: by 2002:a05:6512:ad2:b0:448:ac0a:2df8 with SMTP id n18-20020a0565120ad200b00448ac0a2df8mr13635395lfu.376.1647848149016;
        Mon, 21 Mar 2022 00:35:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDFZx9DdlliH40AAebAUR97H2Zr+7VcnEgwq/1wWtU+sQWoGuORbz6lplhmHV8rINCndgEdYrFgFzhxLqCInU=
X-Received: by 2002:a05:6512:ad2:b0:448:ac0a:2df8 with SMTP id
 n18-20020a0565120ad200b00448ac0a2df8mr13635389lfu.376.1647848148808; Mon, 21
 Mar 2022 00:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com> <20220321032019-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220321032019-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 21 Mar 2022 15:35:37 +0800
Message-ID: <CACGkMEtWqR06fAmtrT2E5BXeYxi4vaoCxMKrOSKkgrzC8kaPWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
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

On Mon, Mar 21, 2022 at 3:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Mar 21, 2022 at 02:04:28PM +0800, Jason Wang wrote:
> > A userspace triggerable infinite loop could happen in
> > mlx5_cvq_kick_handler() if userspace keeps sending a huge amount of
> > cvq requests.
> >
> > Fixing this by introducing a quota and re-queue the work if we're out
> > of the budget. While at it, using a per device workqueue to avoid on
> > demand memory allocation for cvq.
> >
> > Fixes: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index d0f91078600e..d5a6fb3f9c41 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -163,6 +163,7 @@ struct mlx5_vdpa_net {
> >       u32 cur_num_vqs;
> >       struct notifier_block nb;
> >       struct vdpa_callback config_cb;
> > +     struct mlx5_vdpa_wq_ent cvq_ent;
> >  };
> >
> >  static void free_resources(struct mlx5_vdpa_net *ndev);
> > @@ -1600,6 +1601,8 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
> >       return status;
> >  }
> >
> > +#define MLX5_CVQ_BUDGET 16
> > +
> >  static void mlx5_cvq_kick_handler(struct work_struct *work)
> >  {
> >       virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
> > @@ -1609,17 +1612,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >       struct mlx5_control_vq *cvq;
> >       struct mlx5_vdpa_net *ndev;
> >       size_t read, write;
> > -     int err;
> > +     int err, n = 0;
> >
> >       wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
> >       mvdev = wqent->mvdev;
> >       ndev = to_mlx5_vdpa_ndev(mvdev);
> >       cvq = &mvdev->cvq;
> >       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > -             goto out;
> > +             return;
> >
> >       if (!cvq->ready)
> > -             goto out;
> > +             return;
> >
> >       while (true) {
> >               err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
> > @@ -1653,9 +1656,13 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >
> >               if (vringh_need_notify_iotlb(&cvq->vring))
> >                       vringh_notify(&cvq->vring);
> > +
> > +             n++;
> > +             if (n > MLX5_CVQ_BUDGET) {
> > +                     queue_work(mvdev->wq, &wqent->work);
> > +                     break;
> > +             }
> >       }
> > -out:
> > -     kfree(wqent);
> >  }
> >
> >  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> > @@ -1663,7 +1670,6 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> >       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >       struct mlx5_vdpa_virtqueue *mvq;
> > -     struct mlx5_vdpa_wq_ent *wqent;
> >
> >       if (!is_index_valid(mvdev, idx))
> >               return;
> > @@ -1672,13 +1678,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> >               if (!mvdev->cvq.ready)
> >                       return;
> >
> > -             wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> > -             if (!wqent)
> > -                     return;
> > -
> > -             wqent->mvdev = mvdev;
> > -             INIT_WORK(&wqent->work, mlx5_cvq_kick_handler);
> > -             queue_work(mvdev->wq, &wqent->work);
> > +             queue_work(mvdev->wq, &ndev->cvq_ent.work);
> >               return;
> >       }
> >
> > @@ -2668,6 +2668,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >       if (err)
> >               goto err_mr;
> >
> > +     ndev->cvq_ent.mvdev = mvdev;
> > +     INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
> >       mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_wq");
> >       if (!mvdev->wq) {
> >               err = -ENOMEM;
>
> Shouldn't there be a flush during cleanup somewhere?

I think the destory_workqueue() in mlx5_vdpa_dev_del() will do the flush/drain.

Thanks

>
> > --
> > 2.18.1
>

