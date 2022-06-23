Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425F0557206
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiFWEpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiFWDk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C756E35271
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655955657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiF/hZE79qFgnRr7vycw43sCH5KeoUxCMY9Y1NxAp7k=;
        b=dF39sKOeqr3FLztr5hsDm4DXfCHsPtbBJdHtCwPrxFWPqRXFAF+RfgaFJ0vB3wKaNDgkKT
        93sAlqVQZD+JmbLzH1rjMJ1DrY8nnQPXy94vObxI6iu+cs/Yv5kfexMYMqAD/V9kJsAVYP
        OFBQlHJkPCnJwc9HcYaB5hgFY181vnU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-QSN4NSW3MoOT0DgqjlDMqA-1; Wed, 22 Jun 2022 23:40:56 -0400
X-MC-Unique: QSN4NSW3MoOT0DgqjlDMqA-1
Received: by mail-lf1-f69.google.com with SMTP id d42-20020a0565123d2a00b0047f83b85c2dso3196437lfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiF/hZE79qFgnRr7vycw43sCH5KeoUxCMY9Y1NxAp7k=;
        b=ZtVA7QKqpud70UxshCfl/Evk53+EK5YmWjX29Yn3e3A/e05p2FBVMjbWuMuLLXer+E
         mgCrtzbQWurK+OTg3bnqOVkt3lHdKGNLmWrRzSMYbVcugBAUYv6t9MvsNXnPxtoReqRb
         a0KEg5COCXWj5C4BMhlmIXsHkK6FUuQRhWUuRusVH2But545HQPoNHzrSmNBtUND0ihM
         M2N+J0muq1Kp6IM505Y+PJWccndYOJmW/yWtcanQRtD7CFRG4+EowNAJiodT2e0cUKNU
         keLGyhvS8Tfv5wc2dN9hhLbzoopWXk94hzl6Ah03xR25nkvI9KKMKf3HG3pFkZNY+7Un
         aamA==
X-Gm-Message-State: AJIora+KswrkLs9s1GCbEHSk9nuKgh/ZS0G7vGC8AqBE8Iex6ql1TM0h
        Dyf5/qI/QEp3tbyH3dOcQFde7q4VVU6plTTuoEEpgXubcEc3CFy1ViP1Ym8M6IPCDAkpFzx074o
        ycC/BjPLkzOC3JLOF+PIZTIqKGuBC9nIKfmyTw0tO
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id j3-20020a2eb703000000b0025a93d08a57mr497870ljo.487.1655955654797;
        Wed, 22 Jun 2022 20:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0vnxyVZ3lSg79H5V5lG6eHxw0VCJyRXUocHKOF/cwDjvQDRinefk8NlQ3aWmf8BWIcnr0CohuTQZgm8bFcGs=
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr497860ljo.487.1655955654604; Wed, 22 Jun
 2022 20:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com> <20220621160859.196646-2-sgarzare@redhat.com>
In-Reply-To: <20220621160859.196646-2-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 23 Jun 2022 11:40:43 +0800
Message-ID: <CACGkMEsdx24TMSw_HgDemNKLAQJfym_fkn-th1HEX8q8ESRoag@mail.gmail.com>
Subject: Re: [PATCH 1/3] vdpa_sim_blk: use dev_dbg() to print errors
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Jun 22, 2022 at 12:09 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Use dev_dbg() instead of dev_err()/dev_warn() to avoid flooding the
> host with prints, when the guest driver is misbehaving.
> In this way, prints can be dynamically enabled when the vDPA block
> simulator is used to validate a driver.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 42d401d43911..a83a5c76f620 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -76,13 +76,13 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                 return false;
>
>         if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
> -               dev_err(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
> +               dev_dbg(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
>                         vq->out_iov.used, vq->in_iov.used);
>                 return false;
>         }
>
>         if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
> -               dev_err(&vdpasim->vdpa.dev, "request in header too short\n");
> +               dev_dbg(&vdpasim->vdpa.dev, "request in header too short\n");
>                 return false;
>         }
>
> @@ -96,7 +96,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>         bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &hdr,
>                                       sizeof(hdr));
>         if (bytes != sizeof(hdr)) {
> -               dev_err(&vdpasim->vdpa.dev, "request out header too short\n");
> +               dev_dbg(&vdpasim->vdpa.dev, "request out header too short\n");
>                 return false;
>         }
>
> @@ -110,7 +110,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>         switch (type) {
>         case VIRTIO_BLK_T_IN:
>                 if (!vdpasim_blk_check_range(sector, to_push)) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "reading over the capacity - offset: 0x%llx len: 0x%zx\n",
>                                 offset, to_push);
>                         status = VIRTIO_BLK_S_IOERR;
> @@ -121,7 +121,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                                               vdpasim->buffer + offset,
>                                               to_push);
>                 if (bytes < 0) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
>                                 bytes, offset, to_push);
>                         status = VIRTIO_BLK_S_IOERR;
> @@ -133,7 +133,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>
>         case VIRTIO_BLK_T_OUT:
>                 if (!vdpasim_blk_check_range(sector, to_pull)) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "writing over the capacity - offset: 0x%llx len: 0x%zx\n",
>                                 offset, to_pull);
>                         status = VIRTIO_BLK_S_IOERR;
> @@ -144,7 +144,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                                               vdpasim->buffer + offset,
>                                               to_pull);
>                 if (bytes < 0) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
>                                 bytes, offset, to_pull);
>                         status = VIRTIO_BLK_S_IOERR;
> @@ -157,7 +157,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                                               vdpasim_blk_id,
>                                               VIRTIO_BLK_ID_BYTES);
>                 if (bytes < 0) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "vringh_iov_push_iotlb() error: %zd\n", bytes);
>                         status = VIRTIO_BLK_S_IOERR;
>                         break;
> @@ -167,8 +167,8 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                 break;
>
>         default:
> -               dev_warn(&vdpasim->vdpa.dev,
> -                        "Unsupported request type %d\n", type);
> +               dev_dbg(&vdpasim->vdpa.dev,
> +                       "Unsupported request type %d\n", type);
>                 status = VIRTIO_BLK_S_IOERR;
>                 break;
>         }
> --
> 2.36.1
>

