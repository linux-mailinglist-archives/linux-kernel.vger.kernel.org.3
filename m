Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF304E4DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbiCWH77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242377AbiCWH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E102C12ADB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648022294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAyVkbGAsQwthsHwR2YL1Xu7ffsSB44wUq5hKIC/Uq0=;
        b=JaOT7tKCSGUPgrRdtYK45PB1/05LwBboJ673NcjEAnOEhu+vY7Op+NRjp7V0TB0ICB78m5
        4I0mrGOFB/24uHyezL9KCtkr9+VdyrvBsTh+OMAR3cDE+HSD8LjaQU9ZhQyhud7E97gZ6Y
        LFmodKvKncCR8Ql63muRsAnOh4N2htU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-qFwTUAgNNUO48stjfylqwg-1; Wed, 23 Mar 2022 03:58:13 -0400
X-MC-Unique: qFwTUAgNNUO48stjfylqwg-1
Received: by mail-lj1-f197.google.com with SMTP id f12-20020a2e918c000000b002496651f1d6so294668ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAyVkbGAsQwthsHwR2YL1Xu7ffsSB44wUq5hKIC/Uq0=;
        b=TCI7ojY+yF7C30SL27gePI8NdkmB2EywDp7CbH4Zf7GeB7lb1nhvDlgn1cjnFA3OQK
         dcmjnIHEQY686dKx9mt7MLRtok3vNvsVOh69FuWQr/z9Q6mX8hSMIqhr5c+dykcAli8n
         NEKsd4DTxQqqxzHh8rrohFszilGHpzBdazUxG1UCYh0J5RjqrDE6Bv2uB7RFjae9sZTc
         6V33jj1T2gLZV9WrXE/KJY+hojoiDkyEQ7geiXZdV0zktcudD4J0HhdO9kWl8zPLVuT9
         eVD/HBpBCXtRMK9rreOBHk7roIem5r40lUUyPXB+w1J6KIGhlEROcsv8n0vmZU5doI6b
         t9Ng==
X-Gm-Message-State: AOAM530nZydoq3paQ6pHv3Vy2HpYUCHrlnRnWnCBYDFiAmpVDeJxJU12
        +7681L0LafQdAOD91zzubHxi3cTIMs0xRIO5CXoj4KWpAGb9R/NK/VYwC2SQhov8azKO12XIB3f
        M8Sn8hB6UidgnaXmiD2JD+MRydqgIZwEm0CVFMvGj
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id e10-20020a05651c090a00b002495d82fe9cmr21556666ljq.300.1648022291810;
        Wed, 23 Mar 2022 00:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzehhqEud0nAsdq/Kd29NYle9hKa9jnJAZWN6DSBqWRHij5C2bX9h3lR7Tb3iqEW8RSonlF1JIW0PRX8/99XHI=
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr21556651ljq.300.1648022291581; Wed, 23
 Mar 2022 00:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220322151952.2950143-1-keirf@google.com>
In-Reply-To: <20220322151952.2950143-1-keirf@google.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 23 Mar 2022 15:57:59 +0800
Message-ID: <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: pci: sanity check bar indexes
To:     Keir Fraser <keirf@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kernel-team@android.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:20 PM Keir Fraser <keirf@google.com> wrote:
>
> The bar index is used as an index into the device's resource list
> and should be checked as within range for a standard bar.
>
> Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
>
> Signed-off-by: Keir Fraser <keirf@google.com>
> ---
>  drivers/virtio/virtio_pci_modern.c     | 10 ++++++++--
>  drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 5455bc041fb6..84bace98dff5 100644
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
> @@ -317,7 +317,12 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>
>                 /* Type, and ID match, looks good */
>                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> -                                                        bar), bar);
> +                                                        bar), &res_bar);
> +               if (res_bar >= PCI_STD_NUM_BARS) {
> +                       dev_err(&dev->dev, "%s: shm cap with bad bar: %d\n",
> +                               __func__, res_bar);
> +                       continue;
> +               }
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
> index e8b3ff2b9fbc..a6911d1e212a 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -35,6 +35,12 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
>         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
>                               &length);
>
> +       if (bar >= PCI_STD_NUM_BARS) {
> +               dev_err(&dev->dev,
> +                       "virtio_pci: bad capability bar %u\n", bar);
> +               return NULL;
> +       }
> +
>         if (length <= start) {
>                 dev_err(&dev->dev,
>                         "virtio_pci: bad capability len %u (>%u expected)\n",
> @@ -120,7 +126,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
>                                      &bar);
>
>                 /* Ignore structures with reserved BAR values */
> -               if (bar > 0x5)
> +               if (bar >= PCI_STD_NUM_BARS)
>                         continue;

Just notice that the spec said:

"
values 0x0 to 0x5 specify a Base Address register (BAR) belonging to
the function located beginning at 10h in PCI Configuration Space and
used to map the structure into Memory or I/O Space. The BAR is
permitted to be either 32-bit or 64-bit, it can map Memory Space or
I/O Space.

Any other value is reserved for future use.
"

So we probably need to stick 0x5 instead of 0x6 (PCI_STD_NUM_BARS) for
this and other places.

Thanks

>
>                 if (type == cfg_type) {
> --
> 2.35.1.894.gb6a874cedc-goog
>

