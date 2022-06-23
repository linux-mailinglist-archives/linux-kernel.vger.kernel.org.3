Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4594455723E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiFWEp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbiFWDuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDD3C3DA6B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655956237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SS9ZQeVISzK//7xTKb4KEM9pFFxxfL9dDdxuN/WOdIc=;
        b=dWwAYe7M2e7JRizPRXfIWVuAsy073Z/JKCKJbxXePMgtYBoz0d3F9e9O/psJ1PqLORQq7h
        jEGi0+o8bvJQcyFTIcyFPgJ2cLT1HXi20hvx8a02pyTjEX4j6OkyWXDr+rfzoqQ7gzEsd3
        OGDs0T99AbDk2kNot62GxCyEYiM8/kw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-XHHtdB3KNVWG2Be1nrPO6g-1; Wed, 22 Jun 2022 23:50:35 -0400
X-MC-Unique: XHHtdB3KNVWG2Be1nrPO6g-1
Received: by mail-lf1-f72.google.com with SMTP id bi38-20020a0565120ea600b0047f640eaee0so6077872lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SS9ZQeVISzK//7xTKb4KEM9pFFxxfL9dDdxuN/WOdIc=;
        b=1ts+KhzNNg94bDMiw5ZyKhmweAtF3rc64WBAf2X98lUbPpOhTFS8t8c8MAqKVvwGdu
         QCsUbzqJ7aU7zvG1+0gPZ8nZnCKyC7FSum31layq1ywEQ2UOUVGaV0VrykEyQPmqw6WE
         kzGZWxGl3r2UHSfeNVI1OG7flagwX1Z1zSTy6cj3sZRAnMPbgrpeu0fqLJI+UROPZZTf
         Xw6cBLk1MQ3gmZ/DmGrCwQz+uSmA6DPcbk97uZjeg4+DeICUzfyguRbrYyCn+pxTRNP2
         b+Rr2hAkA+NBlGEOU8Z21gnHaXtJQ9d8L1hkPL6fbuqj/biZrmH4qpMaFk4qjDaD1cJa
         MUOg==
X-Gm-Message-State: AJIora84CJvhpG0xYM8HT+jtSUBkNKsJ7d5qbUTBjzftER/6aNf2cY91
        M4ZBOlcTEU6BWRySvp0/ulSW1b8XHpy07imqaGzPkspQqKHeHiQxjOUBu5tb8iO6wck9A2A2DEw
        p6OrhNtJyVyKkWkRvkZ7OBxKesDLJ4Nho1CfDQ2Er
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id p37-20020a05651213a500b0047dc1d9dea8mr4191412lfa.442.1655956233909;
        Wed, 22 Jun 2022 20:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJxrXj31U9449urMcIxVr7ouushJMsv4RghnzNimWrXWCJynHAMroZ8HhfAW1QET/wi7Px5SnUH4BMCrzV/Pg=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr4191404lfa.442.1655956233710; Wed, 22
 Jun 2022 20:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com> <20220621160859.196646-3-sgarzare@redhat.com>
In-Reply-To: <20220621160859.196646-3-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 23 Jun 2022 11:50:22 +0800
Message-ID: <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa_sim_blk: limit the number of request handled per batch
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:09 AM Stefano Garzarella <sgarzare@redhat.com> w=
rote:
>
> Limit the number of requests (4 per queue as for vdpa_sim_net) handled
> in a batch to prevent the worker from using the CPU for too long.
>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index a83a5c76f620..ac86478845b6 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -197,6 +197,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vd=
pasim,
>  static void vdpasim_blk_work(struct work_struct *work)
>  {
>         struct vdpasim *vdpasim =3D container_of(work, struct vdpasim, wo=
rk);
> +       bool reschedule =3D false;
>         int i;
>
>         spin_lock(&vdpasim->lock);
> @@ -206,11 +207,15 @@ static void vdpasim_blk_work(struct work_struct *wo=
rk)
>
>         for (i =3D 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>                 struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i];
> +               bool vq_work =3D true;
> +               int reqs =3D 0;
>
>                 if (!vq->ready)
>                         continue;
>
> -               while (vdpasim_blk_handle_req(vdpasim, vq)) {
> +               while (vq_work) {
> +                       vq_work =3D vdpasim_blk_handle_req(vdpasim, vq);
> +

Is it better to check and exit the loop early here?

Thanks

>                         /* Make sure used is visible before rasing the in=
terrupt. */
>                         smp_wmb();
>
> @@ -218,10 +223,18 @@ static void vdpasim_blk_work(struct work_struct *wo=
rk)
>                         if (vringh_need_notify_iotlb(&vq->vring) > 0)
>                                 vringh_notify(&vq->vring);
>                         local_bh_enable();
> +
> +                       if (++reqs > 4) {
> +                               vq_work =3D false;
> +                               reschedule =3D true;
> +                       }
>                 }
>         }
>  out:
>         spin_unlock(&vdpasim->lock);
> +
> +       if (reschedule)
> +               schedule_work(&vdpasim->work);
>  }
>
>  static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config=
)
> --
> 2.36.1
>

