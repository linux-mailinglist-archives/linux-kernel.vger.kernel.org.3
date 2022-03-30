Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3964EBB40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243415AbiC3G6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243442AbiC3G6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12C96DE09E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648623419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qKUvRRDyEZQxeQ5LJrbQhUwwlKMs3DpMfIG+d7qfFw=;
        b=hHW+lR4MOKM8e7km1YJaYHGLLKlIlYmeKXLehZ0iv+yG4cimBkju/nqJh9K7C4WeobsIaq
        hWxoshpVVln5mwfuUCCGCz6l8H9P8E/U/Il6CsbtJIsdJwtVpBlSGpSU8qnOd89UkgFF84
        NwypGBtoPSA85ydxab+xb9nS0C+gc9w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-0UYwZeqoNZii3F5hTGlTLg-1; Wed, 30 Mar 2022 02:56:57 -0400
X-MC-Unique: 0UYwZeqoNZii3F5hTGlTLg-1
Received: by mail-lj1-f200.google.com with SMTP id 67-20020a2e0946000000b002493a3be913so8284340ljj.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qKUvRRDyEZQxeQ5LJrbQhUwwlKMs3DpMfIG+d7qfFw=;
        b=5c2B+Byp0nEgEf0FsPbGEFp0bDaWhtuuooAYJzM7Z8eMPlZUHtB/QuHmHux1eGfabd
         fvd9qrqHFBi2lApX3gV+vBtf3hFoBc1zumubnQ+k/TjgTthB9mPo15nsQI8Y8LpIqzCi
         kzLkbtt6uLsNvK6S3mRxP1ul5juYj/ieTPqiIztO9TvpafL90A4UyEcIwnMWsvgjclrh
         u8CYBbMJ/Y6LMWdrgbG6PpPlcucrZ8KwZmA8Jmbm4LEtsGC8E0fONG9vYjxjOSv12LBE
         6SnI1IB/lCOcCPODl/9NkEPG3NG0aD98aAE5HgUHVNwfkvVkZSMkF8p7H26iVN3q+q7t
         7LRA==
X-Gm-Message-State: AOAM531aJcHehdVp/vwRGU+Esy+c2Z1wYEzkaEJ/VVZUiq7PyTLLJkui
        +2lvi4dTACegE3YF2iauL9mogto+dmLMZPlK0CcdeQWRUMAmCF3vrx0fdiK3VRPbu9RAqzHvX71
        9pa39h+5vFjkv8eGroEgb0TJLiCg/k8wZ3JTwcfI1
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id b1-20020a0565120b8100b00448b342513cmr5793365lfv.257.1648623416068;
        Tue, 29 Mar 2022 23:56:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvR34KN4X2wt0BQXe0xslAEoh0cLasw/9DhLwWUYs42y4tkSy7O7S9Lma3mNvczzLnVOeM3VUuQRhtiXkaBC0=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr5793351lfv.257.1648623415897; Tue, 29
 Mar 2022 23:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220330062315.125924-1-mst@redhat.com>
In-Reply-To: <20220330062315.125924-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 30 Mar 2022 14:56:44 +0800
Message-ID: <CACGkMEth00XnrHmurhNHJ=sAs-BWdaRQ1fE638OTM9Fsq0WPzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "virtio: use virtio_device_ready() in virtio_device_restore()"
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 2:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This reverts commit 8d65bc9a5be3f23c5e2ab36b6b8ef40095165b18.
>
> We reverted the problematic changes, no more need for work
> arounds on restore.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 75c8d560bbd3..22f15f444f75 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -526,9 +526,8 @@ int virtio_device_restore(struct virtio_device *dev)
>                         goto err;
>         }
>
> -       /* If restore didn't do it, mark device DRIVER_OK ourselves. */
> -       if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> -               virtio_device_ready(dev);
> +       /* Finally, tell the device we're all set */
> +       virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>
>         virtio_config_enable(dev);
>
> --
> MST
>

