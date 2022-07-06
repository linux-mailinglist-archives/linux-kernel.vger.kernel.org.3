Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06DC567EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiGFGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGFGkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2476315807
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657089611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gg7lrPC8AiBLlPI2LxojejuxvQek5GgKMPUgGRCFaDA=;
        b=SZ6S32mTjvNCKr+f6aWpTvviYYsvfEpbBmt1mrDw0BCdKctNdazv1ZjAoiAmVDDVTL92lj
        b6TPBw04Lingq2Lvs1J/kjJsCUjUYxFeuWALvpBW/3wHZNPjxrfCU6NppUcfKIrg8lDG94
        ZL+ZJOuk/+M3IA4nKyOMv7ffCwFjPEo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-mURVwcJlMiWDCCwgqAluDg-1; Wed, 06 Jul 2022 02:40:04 -0400
X-MC-Unique: mURVwcJlMiWDCCwgqAluDg-1
Received: by mail-qk1-f199.google.com with SMTP id ay43-20020a05620a17ab00b006b25a9bef3dso12691840qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 23:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gg7lrPC8AiBLlPI2LxojejuxvQek5GgKMPUgGRCFaDA=;
        b=gEv5GHSK49hgJJ7fOjpl042KWP9N3TnfkjXNUgfmKfstv3pCFfC3ViLfxbDbNnRAe4
         /mZeV2Gd++HM08dZYq+g+/c3nEOjB0KiEFvdQiVc/46PrfaGpVOsINUfTyHu8DfYUC7B
         zDVnH2k/s7mKdkodVMyP/FG1Ju4BQMYHm1nRDJ0F/2JpoXVYLUy7yNJnk/lCi1lcxwjJ
         FELS0D37UGa52dppE8iMOSENn46IKltq/DWeF8XspBIOr9N623gYjn/UknIfQB+UFpy7
         nGYMGsE1P+kuosTcENufaicYHX69mMdzbNLWEiQgc5ISrjhHzMLazOdu1yQCzSpjyoVQ
         aIZg==
X-Gm-Message-State: AJIora/iIMW06jL8a/G8/w8CVXQE9z+uIKfwutXas0foBUmsZb2Yq3aJ
        lkfedFY7YEG4uJzp/J8V0OYduhsiNydCH45VrHGsbpIcehNYHbU5VLtEm1gbe9D/rHDA1G3iylM
        HB43G7E33rmHE1PaecNTmbXEN9ApwxKB8qbUX1mKL
X-Received: by 2002:ac8:5dca:0:b0:31e:85b8:8a18 with SMTP id e10-20020ac85dca000000b0031e85b88a18mr4783331qtx.370.1657089603802;
        Tue, 05 Jul 2022 23:40:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uHo8LhLcUYLcyLarGeDtkLCik+u2tlMP2iVwBjms8B6WDRFn0spIK6vbez0DXgf7cl5sfpGIArQQJVEBrpgKA=
X-Received: by 2002:ac8:5dca:0:b0:31e:85b8:8a18 with SMTP id
 e10-20020ac85dca000000b0031e85b88a18mr4783322qtx.370.1657089603604; Tue, 05
 Jul 2022 23:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220705072249.7867-1-sgarzare@redhat.com>
In-Reply-To: <20220705072249.7867-1-sgarzare@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 6 Jul 2022 08:39:27 +0200
Message-ID: <CAJaqyWfiet+NJ3bBJDeeA2dPkAq7UNoa_bniUktciHu84cvMQA@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: fix build
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>
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

On Tue, Jul 5, 2022 at 9:32 AM Stefano Garzarella <sgarzare@redhat.com> wro=
te:
>
> Fix the build caused by the following changes:
> - phys_addr_t is now defined in tools/include/linux/types.h
> - dev_warn_once() is used in drivers/virtio/virtio_ring.c
> - linux/uio.h included by vringh.h use INT_MAX defined in limits.h
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  tools/virtio/linux/kernel.h | 2 +-
>  tools/virtio/linux/vringh.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 0b493542e61a..21593bf97755 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -29,7 +29,6 @@
>  #define READ                    0
>  #define WRITE                   1
>
> -typedef unsigned long long phys_addr_t;
>  typedef unsigned long long dma_addr_t;
>  typedef size_t __kernel_size_t;
>  typedef unsigned int __wsum;
> @@ -136,6 +135,7 @@ static inline void *krealloc_array(void *p, size_t ne=
w_n, size_t new_size, gfp_t
>  #endif
>  #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS_=
_)
>  #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS=
__)
> +#define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA=
_ARGS__)
>
>  #define min(x, y) ({                           \
>         typeof(x) _min1 =3D (x);                  \
> diff --git a/tools/virtio/linux/vringh.h b/tools/virtio/linux/vringh.h
> index 9348957be56e..e11c6aece734 100644
> --- a/tools/virtio/linux/vringh.h
> +++ b/tools/virtio/linux/vringh.h
> @@ -1 +1,2 @@
> +#include <limits.h>
>  #include "../../../include/linux/vringh.h"
> --
> 2.36.1
>

