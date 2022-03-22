Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C34E379A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiCVDiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiCVDiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28555BD7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647920198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iMzx+aioEJysUsrwA03nQ3DLxiWp0PNXhW4lisYP70U=;
        b=ija/uiPG7vViYO1JI+76TgZGvUhEoHTwz2vk3WcRXw531UfQ++nsGBJDrHiNOqMVqzYqPV
        M971K3lr+t/91cw3WK2+TTfO68BVJvd3CPmCTtCHwkMxWpfaahYiDK8iGQsR1rhMT4PSLz
        1gD8nzeAQGWNVSzcXpwHkxYeuC0z0AY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-SZUVseLTN8SoyZqXjFU05A-1; Mon, 21 Mar 2022 23:36:37 -0400
X-MC-Unique: SZUVseLTN8SoyZqXjFU05A-1
Received: by mail-lf1-f69.google.com with SMTP id z39-20020a0565120c2700b0044a219505a4so1254299lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMzx+aioEJysUsrwA03nQ3DLxiWp0PNXhW4lisYP70U=;
        b=q4pnBH9vpa9NV4Rl5BWqbKZrHG7N/eFgzaIbjed/aTAmtkrTBnAGMyhuA5AmyV6KFf
         OwGbIqTwyZ0gnuWgx2QVLZAb/oBuwGH7/jyI4RPaBw5hbzD1UvkQ6bmCWLDtBOrj0QPl
         Nod1nPIH/BETIlf+SQV74JLOeOlZwXCd5xIlK6XYdHUx40I+mQJuhrPj1ov/NNEUXulz
         1u9zETKWUx8Hckdh4gf39Qth5reRauP53kngW5BwwG16SedfXpdWPal8IPbCmJiAIZ0k
         i1Di/TwaSt8L/pe7zOaerd0nCXukOx9ZbJRru0JC3hnVLD6xH03b3wYFt4JgA/TfxASB
         j+Kg==
X-Gm-Message-State: AOAM532dxmdraLYYnWPAhTS/VGAgTpkag7RWfLDbWWqkCTGLZNTW7CUX
        MmWGVIqoOE68n2mL/6RhuKAZaEGn3e7l+Md9XWN66UWOpNJL8LQpEEeknkwI+Pl8sSNGUhlHUhT
        cAYmmucYjEQhm/GOj0QJb4LjINZXrSAuMVE6j9V2Z
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id b1-20020a0565120b8100b00448b342513cmr16747263lfv.257.1647920195435;
        Mon, 21 Mar 2022 20:36:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj1G/AYOP3skVnNg/P+5mXQxxZT3muCA9UKvGxFZZI4XYPIarVqtXRw6VTfqLiA2IK6CTrcVHAKh6xTpSY7rc=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr16747254lfv.257.1647920195269; Mon, 21
 Mar 2022 20:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220321154931.859511-1-keirf@google.com>
In-Reply-To: <20220321154931.859511-1-keirf@google.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 22 Mar 2022 11:36:23 +0800
Message-ID: <CACGkMEuEh+vsDok6hrp96kgGHkxbmzskFMJOouR3mo3d3VjwdQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: pci: Sanity check the bar index in find_shm_cap
To:     Keir Fraser <keirf@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:49 PM Keir Fraser <keirf@google.com> wrote:
>
> The bar index is used as an index into the device's resource list
> and should be checked as within range for a standard bar.
>
> Signed-off-by: Keir Fraser <keirf@google.com>

Patch looks good, do we need a similar check in vp_modern_map_capability()?

Thanks

> ---
>  drivers/virtio/virtio_pci_modern.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
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
> --
> 2.35.1.894.gb6a874cedc-goog
>

