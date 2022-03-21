Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30454E22C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiCUJAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiCUJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDFC75BD13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647853160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TACjk6R4PSYbfRZ6CJuCtZCZ4dHNbrWklt+lsL+W/vQ=;
        b=PxOFo+0nmtETNQ5V/4vGTKVlZHKsbydfMsGF7D96AkFHatkNyZvrWZmmN3+dc2LSOp9Dp7
        JuwPIkVriOEwxlxn2alQoiiDbn0uIDEri/G1itISd14/k9PXs11S43ucoek4rqihykbMAH
        xS4TQ3EEmJ8RregR4icQDUYPz4p/5B0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-KcwD9npAP7-EN8QJRktuRw-1; Mon, 21 Mar 2022 04:59:19 -0400
X-MC-Unique: KcwD9npAP7-EN8QJRktuRw-1
Received: by mail-lf1-f72.google.com with SMTP id q19-20020ac24a73000000b0044a100bb508so1276152lfp.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TACjk6R4PSYbfRZ6CJuCtZCZ4dHNbrWklt+lsL+W/vQ=;
        b=ctM+1Wbs03z5lIQe+X4/DTy+wmM4O3OU7O5MZ7Shg9P6eSwd74wZQeR9c9uoQ6dlwe
         3FStzOLoh7NmTEm+J3/kgWkVXqGUuA+ghRhh1XvfLRiiS+wKIY6yxc4M7m9lAzfS6y3t
         xlJxOkBsCec70CJTtTrM5oo0ici+TinN+UqkOB4lkvHHYsu6i8dhmkzB1E0mJ1PbRnCq
         wtVnqJXlpE6w9vhQ4yxsKgaAJ1bMk4Btw6rBq8H9toPaAe9AYWSWTdcpnUzxeKkbOoKm
         xZNYI78Hiuje3bN5vV/BDzw8OJJLoyIS0dJ4uJHeOUTbFOPnISEHHilZywHlt3wcbg5k
         iX0g==
X-Gm-Message-State: AOAM531rDmE6lBOxc9xSKlYw5jz7Ik6vu3XNIu/qQaPb1P02gecqbzIt
        fv+XljYSvD13lLkrAO3yvMR9B4+0NYZr9Mb6C+eUysDP66UHFZCw848VTqetJavszIwpu0r3DvQ
        oWtrRH14sOhYncBwzWiNulBht/IQcHjBMTChXw5UH
X-Received: by 2002:a05:651c:1543:b0:249:218f:2228 with SMTP id y3-20020a05651c154300b00249218f2228mr14691138ljp.492.1647853157646;
        Mon, 21 Mar 2022 01:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwspRa/3XED/kMS/oaqPukHOIHrr/aJEo+WZJYEMmSggzLodu+d9PjVSsSV3ywTkJ6I5lvN0albgWIWncZqhMk=
X-Received: by 2002:a05:651c:1543:b0:249:218f:2228 with SMTP id
 y3-20020a05651c154300b00249218f2228mr14691129ljp.492.1647853157450; Mon, 21
 Mar 2022 01:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com> <20220321085317.3148-1-hdanton@sina.com>
In-Reply-To: <20220321085317.3148-1-hdanton@sina.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 21 Mar 2022 16:59:06 +0800
Message-ID: <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To:     Hillf Danton <hdanton@sina.com>
Cc:     mst <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 4:53 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 21 Mar 2022 14:04:28 +0800 Jason Wang wrote:
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
>
> This is not needed as given a single thread workqueue, a cond_resched()
> can do the job in the worker context instead of requeue of work.
>
> Hillf

I'm not sure I get this, but there's a loop in the work fn:

while(true) {
}

Where there could be no chance for the cond_resched() to run?

Thanks

>
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
> > --
> > 2.18.1
>

