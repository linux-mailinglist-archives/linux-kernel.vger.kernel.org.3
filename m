Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8A55DDC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiF1EB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbiF1EBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 468EA2A94E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 21:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656388879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdLK+h8IXLKnhKITMkQq24+hZBcrSjQqvNBN3RS5ans=;
        b=DbNENmaznjRSkl9sLe/e0JQ0PqgBKde3KKklmQ73LF7zCIxZV1/IwldVMQCUFLUIXXb82i
        0MMWxVy2ZAQDR9h7PlfYWe+ACcwaGli2bGhaIFI9yIMea+QNBm0cvbEF35FYJExwDi1ULA
        gJk/emCzYU76RXPx7LdHPixTl4uR8Ms=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-5WRftexlODqmpygWuYpNhg-1; Tue, 28 Jun 2022 00:01:15 -0400
X-MC-Unique: 5WRftexlODqmpygWuYpNhg-1
Received: by mail-lf1-f70.google.com with SMTP id y8-20020ac24208000000b0047f9fc8f632so5645712lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 21:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rdLK+h8IXLKnhKITMkQq24+hZBcrSjQqvNBN3RS5ans=;
        b=BA3LZlE+4pfyBXwSbNMRpxlKvysMxm0xivEf1rCl1T6fkAihagsiVeWsmqUI9QOWfy
         lsX2ZOwALBdoJwvdjcjRERdWL7xNhJ0BYNwx4ecIi3Y4Mskw2Hja+PKlsils9daZHwCG
         DAzGEjEFnVFFS5YMLQ4CO0xZU0rOcG7xr0qJFEUWMj+3la4ntg9gTOUahwYwmJO0uYvw
         E62NFQ5fTJUdrxYhovpuSpZ0RuYlaiVtRZLDKmzO8WzYPmJdAhTt/VQLPVxAh+bpExzt
         HyvDpmOq40i7+xHYUeOLx0bUDGUlO79CXELgBBk5wVXyTqUn6VstsqkatKRdh36zKC2w
         o8Bg==
X-Gm-Message-State: AJIora9HOVOlhy/4KOy/3IJlWUMToi/00IHxlk5r5ExQSb897NBuvpt1
        oUQWWj9ulZqqdqtCaLSJC7mXys0jhBCPxBbwVKz8WAtDZMjPZj2KAPgf56sgQtnEFKWoDY+liRx
        eH7x0QoGfsbbfx4quN/UgtGu2gArIssS24ZpWYlLy
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr10025574lfa.124.1656388873979;
        Mon, 27 Jun 2022 21:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uEdcPj8h62S0wPUyO4y7EMiYdlRlcfqE+a+UWDr4hc96LAvzQ7xs0iHnAaZMvpywR5M5d6TAH2PYCfZdpL6qs=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr10025565lfa.124.1656388873794; Mon, 27
 Jun 2022 21:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com> <20220621160859.196646-3-sgarzare@redhat.com>
 <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com> <20220623085830.voi6gixpikz64nm2@sgarzare-redhat>
In-Reply-To: <20220623085830.voi6gixpikz64nm2@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 28 Jun 2022 12:01:02 +0800
Message-ID: <CACGkMEvH-LFW3dvcaKNSmKyFG_SeBbTrPKtJOCwJHKMdtormJw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa_sim_blk: limit the number of request handled per batch
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 4:58 PM Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
>
> On Thu, Jun 23, 2022 at 11:50:22AM +0800, Jason Wang wrote:
> >On Wed, Jun 22, 2022 at 12:09 AM Stefano Garzarella <sgarzare@redhat.com=
> wrote:
> >>
> >> Limit the number of requests (4 per queue as for vdpa_sim_net) handled
> >> in a batch to prevent the worker from using the CPU for too long.
> >>
> >> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> ---
> >>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 15 ++++++++++++++-
> >>  1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_=
sim/vdpa_sim_blk.c
> >> index a83a5c76f620..ac86478845b6 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> @@ -197,6 +197,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim =
*vdpasim,
> >>  static void vdpasim_blk_work(struct work_struct *work)
> >>  {
> >>         struct vdpasim *vdpasim =3D container_of(work, struct vdpasim,=
 work);
> >> +       bool reschedule =3D false;
> >>         int i;
> >>
> >>         spin_lock(&vdpasim->lock);
> >> @@ -206,11 +207,15 @@ static void vdpasim_blk_work(struct work_struct =
*work)
> >>
> >>         for (i =3D 0; i < VDPASIM_BLK_VQ_NUM; i++) {
> >>                 struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i];
> >> +               bool vq_work =3D true;
> >> +               int reqs =3D 0;
> >>
> >>                 if (!vq->ready)
> >>                         continue;
> >>
> >> -               while (vdpasim_blk_handle_req(vdpasim, vq)) {
> >> +               while (vq_work) {
> >> +                       vq_work =3D vdpasim_blk_handle_req(vdpasim, vq=
);
> >> +
> >
> >Is it better to check and exit the loop early here?
>
> Maybe, but I'm not sure.
>
> In vdpa_sim_net we call vringh_complete_iotlb() and send notification
> also in the error path,

Looks not?

                read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov, &=
ctrl,
                                             sizeof(ctrl));
                if (read !=3D sizeof(ctrl))
                        break;

We break the loop.

Thanks

> so I thought was better to send notification
> also when vdpasim_blk_handle_req() return false, since we will update
> the used.idx.
>
> However, I don't think it's a common path, so if you think it's better
> to exit the loop early, I can do it.
>
> Thanks,
> Stefano
>

