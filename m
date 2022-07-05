Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AFE5661B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 05:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiGEDLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 23:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGEDLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 950F01181C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656990705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQCCvyEDOrmKMdgwu+myg3JTmuJjhTgWFLZCYX16vSI=;
        b=Z8lgFCTGFLzajSgTt/TQfylrmuhoafULTUZOnYkrhl8o7WzfxYgD7jJHCybvyi3tcpe7Mc
        nDf5HlwpSHQHme0qOCoNyP2bQbaCFxr7bBabRXPXYJLb2Q9wp5O6Ng35gCYiiMeDnmBiy7
        R4VkIvdS35sfoQj/ueHHwx2WznhjPv0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-fRMgjuqSP0aWAkm3wGMTdA-1; Mon, 04 Jul 2022 23:11:44 -0400
X-MC-Unique: fRMgjuqSP0aWAkm3wGMTdA-1
Received: by mail-lf1-f71.google.com with SMTP id bi38-20020a0565120ea600b0047f640eaee0so3472296lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 20:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qQCCvyEDOrmKMdgwu+myg3JTmuJjhTgWFLZCYX16vSI=;
        b=HA2tWezKSSSeZWezo3BMJfpdg/DlDy48z3fPl3WolCzn1u2jdEWaHkOzOTIHRcEbBE
         ZYk8ivgyYtHXpVnFo393RLGH/EPpkzxJNrBKqqEvq3O/m9svhiomY7i8HWnyp62IiI5u
         s50zk0G3WPFqsRvNAexFq28XRUjf4PcRU4YQbEsap0fEaMfECo1GuIk+VcNGbsgl2juO
         vrJfpjWC4QotYVqAwbIR77wvdd2E5oUtLecNHcNjDmN/1H/uK75GNWc/AwJbPFbdBMIK
         wq5B8G9QyocO4D+6URnzHkDbu8Bbq2qDUdNLWrryX/quHKBjLOuNzaZF6QhHdJ5RPR4H
         yjbA==
X-Gm-Message-State: AJIora+u0gCVKaFdg988olWCLVd8vhBIz+URCT1GY6367g7TmDjJY1YZ
        izg7jc7oq5bgosmQvFJMsN1AhkxHi1FZUbiNDxRADgnKAIkeHJROWIS6+EIDZWNgQp88UzZ9AFl
        N5m4je7G+edxbolZuqPoj1opW411eZN0axOKzi5Zx
X-Received: by 2002:ac2:53bb:0:b0:483:c716:c44 with SMTP id j27-20020ac253bb000000b00483c7160c44mr237741lfh.575.1656990702594;
        Mon, 04 Jul 2022 20:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLOw7+4T4lQRXfmQ6YTcpg3v6l9JZnsnJq7gm4OzuYQgoh2U+mfUUTt6rhzVXRQOXHLa+mgXAw55t/y+8cXfY=
X-Received: by 2002:ac2:53bb:0:b0:483:c716:c44 with SMTP id
 j27-20020ac253bb000000b00483c7160c44mr237731lfh.575.1656990702409; Mon, 04
 Jul 2022 20:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220630153221.83371-1-sgarzare@redhat.com> <20220630153221.83371-3-sgarzare@redhat.com>
In-Reply-To: <20220630153221.83371-3-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 5 Jul 2022 11:11:30 +0800
Message-ID: <CACGkMEtEDpX6QdBtqwx=eu-KpWEGRUZY9zuCJk1U+4Ht1TY4ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vdpa_sim_blk: limit the number of request handled
 per batch
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:32 PM Stefano Garzarella <sgarzare@redhat.com> w=
rote:
>
> Limit the number of requests (4 per queue as for vdpa_sim_net) handled
> in a batch to prevent the worker from using the CPU for too long.
>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> v2:
> - restored previous behaviour, exiting the loop immediately if the
>   request is malformed [Jason]
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index a83a5c76f620..b2d75efec63a 100644
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
> @@ -206,6 +207,7 @@ static void vdpasim_blk_work(struct work_struct *work=
)
>
>         for (i =3D 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>                 struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i];
> +               int reqs =3D 0;
>
>                 if (!vq->ready)
>                         continue;
> @@ -218,10 +220,18 @@ static void vdpasim_blk_work(struct work_struct *wo=
rk)
>                         if (vringh_need_notify_iotlb(&vq->vring) > 0)
>                                 vringh_notify(&vq->vring);
>                         local_bh_enable();
> +
> +                       if (++reqs > 4) {
> +                               reschedule =3D true;
> +                               break;
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

