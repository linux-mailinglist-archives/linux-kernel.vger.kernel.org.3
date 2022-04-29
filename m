Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694A5140B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 04:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiD2CuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiD2CuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE73334B90
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651200414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2gx7h6NbYu8uuTSJ9N8wCp852RvTqnX9mX9jiXJyBc=;
        b=e6TN7QFmlfQ6b81tLKKQIDoYw2a/kYs6y7Cr1q96xBj4PbaXIJR2SeXKyqmBJ68u1DAnci
        xnnhyXSe2suPMk+mGPH6lZXbTGSVc51Gfab7VO6a1aohjyKsbVqfSosy4O23YgHgUKcTog
        AfPRybVfDJZuPOK4omVQ6KgMSZXR3k4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-9BEY--ZsMmyM5UC_jbMpJw-1; Thu, 28 Apr 2022 22:46:52 -0400
X-MC-Unique: 9BEY--ZsMmyM5UC_jbMpJw-1
Received: by mail-lf1-f69.google.com with SMTP id br31-20020a056512401f00b00471c57013ceso2747555lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2gx7h6NbYu8uuTSJ9N8wCp852RvTqnX9mX9jiXJyBc=;
        b=o4tje8emSKKFwYAog2RUUMXCPiTCv+i2UqKWT4lM3fLTh0gYueQIw4YErOVkxTbn7/
         IzY6aX8qIMsx0SMEggxBDs9tfM7yTdqMQZ87N0YrMWhKlt0OOHfMNbff7BgvXP6zHc45
         O3nLDVUnwaNeTCMW+m8rquodS5x/5at2B0q+YJZX3An2rEZnBTowZdaDeZRAkieV46+g
         uRePDDEhYX3Q5g1rpMeJkXyW2l+mHnvuAcfRvK7IrX7v/16kt04LtQqS0hm2hSA0NGFC
         iw3CL8bJhkajvQMFQBW9cu0yjx9O/yRt5fnz+nhxWQ7kfBLGUcLnexeKDN4SK/8/Q5rA
         +Fqw==
X-Gm-Message-State: AOAM533Z5BZsMrW6GaqOYFqlY7AeTNbrRbdZdpjFikixa+MPYfJyDO8E
        jQ9dNdVMxNFQlnNF9/J5fLpIzirTi01jIB7sFbuCbOyIX7gO+O4YC+VVnZSGfE6S+2OqSUXmQYO
        XpBhtq5tCnlHOrgqRX5d/qrkoZbwU9Qfjvi+++nar
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id h16-20020a19ca50000000b00471f556092bmr22046663lfj.587.1651200411380;
        Thu, 28 Apr 2022 19:46:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6iPLLBUifBPvjONr1Ab9ze/wQ5cB0TwkyM+p9qr7gp7ho++cFBXhVIBCz1e5TwUXO7O0QeVLJ2MLAvlTw4Ac=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr22046647lfj.587.1651200411210; Thu, 28
 Apr 2022 19:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151242.213824-1-sgarzare@redhat.com>
In-Reply-To: <20220428151242.213824-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 29 Apr 2022 10:46:40 +0800
Message-ID: <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> The simulator behaves like a ramdisk, so we don't have to do
> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
> could be useful to test driver behavior.
>
> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
> that we support the flush command.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 42d401d43911..a6dd1233797c 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -25,6 +25,7 @@
>  #define DRV_LICENSE  "GPL v2"
>
>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                 pushed += bytes;
>                 break;
>
> +       case VIRTIO_BLK_T_FLUSH:
> +               if (sector != 0) {
> +                       dev_err(&vdpasim->vdpa.dev,
> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
> +                               sector);

If this is something that could be triggered by userspace/guest, then
we should avoid this.

Thanks

> +                       status = VIRTIO_BLK_S_IOERR;
> +                       break;
> +               }
> +
> +               break;
> +
>         default:
>                 dev_warn(&vdpasim->vdpa.dev,
>                          "Unsupported request type %d\n", type);
> --
> 2.35.1
>

