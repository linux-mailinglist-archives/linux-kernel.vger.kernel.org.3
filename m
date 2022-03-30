Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE94EB86C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242087AbiC3Cpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiC3Cpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22716522DC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648608235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a2xX/Hy07omIgAr+hrUkEQ1I86CwFNCof15lsG56O6s=;
        b=a1vfNXEGmpsvjPKPmWrcWStQ+eWuv/cPXvHix5HvSD7aFUdiDq9hUan499/dzh3AC7w+3i
        ceiosyEKwv0qMn+IecvnYFO0fYGO6Gyz3Yy75IjyI/C34eouWeXV4IzH4J6sqQw+ga82It
        pH+J/XK3RW1if/9A9tWvCY2r4zSvquc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-HNluVhG7Mt25dw5GWBcMCg-1; Tue, 29 Mar 2022 22:43:53 -0400
X-MC-Unique: HNluVhG7Mt25dw5GWBcMCg-1
Received: by mail-lf1-f70.google.com with SMTP id w13-20020ac25d4d000000b004488cf80eb1so5956743lfd.23
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2xX/Hy07omIgAr+hrUkEQ1I86CwFNCof15lsG56O6s=;
        b=D3+/qYoQk7UnvN0VQ2BXZw9vn5Y1mQTE977usI1zRiH7Elw1i30x1oHZMj6J3plUza
         r25soqxHD7KRo4/zBKtgOxsLME/q3DEqen9s845Pix9FnKLWUydj+VhZ/N6+5X6Z96kW
         KtXNfZ1k6cmRFzhqhkjjGRPxpA0j/88OkAiPExUKGwAwmXiBDaQEjsr9NiQ1Oz2Iej/Q
         zLVogt97g3Iyi07vj2UXGSfli2ejnqmSkZHop9ENKXEaFkgZb693gSiVoJU0pApoIHSk
         kh4CVCeo9M2Us66ZfsmgrDCDl/86O6rwNwaKrmVFYN7rNhijbW3MWE3DaQMniouqAK0n
         vXXA==
X-Gm-Message-State: AOAM5335Qis7WRP1bI1V0r077215s8Sr8WjQEIzCsAHEKpAyUDgmEs6d
        5xLeyPNollHlJxVR4y566er7WumIntdS8NrDHN8bby4eA9pW8bFYkgyg22c1T/4x41wnWSZviyB
        gncmEuFUZ5m9FIvTsiKfiVNE881wmXVnbKXnxzgBB
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id e10-20020a05651c090a00b002495d82fe9cmr5111061ljq.300.1648608232020;
        Tue, 29 Mar 2022 19:43:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtjq6ZqsOr/okMJ8uC4fcXsHVSCCTYX6TFrpdrvMwrrKgYd6mwnApym+8qEZl8KaGKi0bV8pFJuBiTPe/kiDg=
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr5111051ljq.300.1648608231806; Tue, 29
 Mar 2022 19:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220323140727.3499235-1-keirf@google.com>
In-Reply-To: <20220323140727.3499235-1-keirf@google.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 30 Mar 2022 10:43:40 +0800
Message-ID: <CACGkMEuagKHAiXKNnB22wvcRL2=Qz9u9dKiaNnbMC91_=11J6w@mail.gmail.com>
Subject: Re: [PATCH v3] virtio: pci: check bar values read from virtio config space
To:     Keir Fraser <keirf@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kernel-team@android.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Mar 23, 2022 at 10:07 PM Keir Fraser <keirf@google.com> wrote:
>
> virtio pci config structures may in future have non-standard bar
> values in the bar field. We should anticipate this by skipping any
> structures containing such a reserved value.
>
> The bar value should never change: check for harmful modified values
> we re-read it from the config space in vp_modern_map_capability().
>
> Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
>
> Signed-off-by: Keir Fraser <keirf@google.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_pci_modern.c     | 12 +++++++++---
>  drivers/virtio/virtio_pci_modern_dev.c |  9 ++++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 5455bc041fb6..6adfcd0297a7 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>
>         for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
>              pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> -               u8 type, cap_len, id;
> +               u8 type, cap_len, id, res_bar;
>                 u32 tmp32;
>                 u64 res_offset, res_length;
>
> @@ -315,9 +315,14 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>                 if (id != required_id)
>                         continue;
>
> -               /* Type, and ID match, looks good */
>                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> -                                                        bar), bar);
> +                                                        bar), &res_bar);
> +               if (res_bar >= PCI_STD_NUM_BARS)
> +                       continue;
> +
> +               /* Type and ID match, and the BAR value isn't reserved.
> +                * Looks good.
> +                */
>
>                 /* Read the lower 32bit of length and offset */
>                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>                                                      length_hi), &tmp32);
>                 res_length |= ((u64)tmp32) << 32;
>
> +               *bar = res_bar;
>                 *offset = res_offset;
>                 *len = res_length;
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e8b3ff2b9fbc..591738ad3d56 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -35,6 +35,13 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
>         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
>                               &length);
>
> +       /* Check if the BAR may have changed since we requested the region. */
> +       if (bar >= PCI_STD_NUM_BARS || !(mdev->modern_bars & (1 << bar))) {
> +               dev_err(&dev->dev,
> +                       "virtio_pci: bar unexpectedly changed to %u\n", bar);
> +               return NULL;
> +       }
> +
>         if (length <= start) {
>                 dev_err(&dev->dev,
>                         "virtio_pci: bad capability len %u (>%u expected)\n",
> @@ -120,7 +127,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
>                                      &bar);
>
>                 /* Ignore structures with reserved BAR values */
> -               if (bar > 0x5)
> +               if (bar >= PCI_STD_NUM_BARS)
>                         continue;
>
>                 if (type == cfg_type) {
> --
> 2.35.1.894.gb6a874cedc-goog
>

