Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE750D72D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbiDYCxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240544AbiDYCwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80CDB6E4CE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650854980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCDyepNLXIMjCmD0I9QrPPQw55hA5ANlxUCyUt8honk=;
        b=Stcu18lcAZIvic+2IW01pKjrU6M1mu30qNO5Xt5RH49IFNX3tsSp8kgxryKAmHS+sgQUlt
        VsauHQtzP1s/6mJ2B0UtkIuTxsUpHoE68U/i6ZEr04ThNPm0EvDvpEtIqs5CGT+A/a5I6+
        CyAY+WABAkMDBwk+KtCUa2ItEncd2t0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-KGGdpmXROGuukpFTnRAzjg-1; Sun, 24 Apr 2022 22:49:39 -0400
X-MC-Unique: KGGdpmXROGuukpFTnRAzjg-1
Received: by mail-lj1-f197.google.com with SMTP id o17-20020a2e0c51000000b0024b484876a8so3224697ljd.21
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCDyepNLXIMjCmD0I9QrPPQw55hA5ANlxUCyUt8honk=;
        b=zB1vTIGNIFKzKH3AVo+FBYybhSppS8yZ3oVU7/zZnlR/wugf3RTYRMxCdEAUBqHt5P
         HqvyWAaZMD4ZpoEjXLX5tgOiNRFIDW/4MbOnttf7LuG8gFQ6qrSIHh678AEx2VAI8Vjn
         mP4IxgnTB9dVPJloLpSI8lw1bOUgjVc/6tdXoyyEXhn0qVZtKDMaDIrHA6oPoKgLcuNp
         i6UNe95iWgo945ZwxMrQKvmHSAKY1vMfS9DZTfBELTW8g/kBSj4CUs94NeSX5YHSHt/H
         hcMXReP83xPfeoeFJblbphdwPhGXvMuLq5FFWcAAh0Uct6gqDhbn2DtJcAYPuKZ9t/b1
         UZuA==
X-Gm-Message-State: AOAM533aiWnFNF++hWdu7xYZajRDduBMERsMYlj2o5mmVl5/GocXj+OT
        jNzD+0IEg4I/of7Pu2QsoiF0h3xxonOp+6629CZuI2gXXmcaurFxtWu0NQRHAd/ztINy3lUYsj+
        aqyZDrvp7OaW6PgxLcF2iDT41wlJ6T6EqjLhL15PN
X-Received: by 2002:a05:6512:33d0:b0:471:a625:fdc0 with SMTP id d16-20020a05651233d000b00471a625fdc0mr11800997lfg.98.1650854977602;
        Sun, 24 Apr 2022 19:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1Bvc17jPROA+PgD8i2WHUkLeo7es3ShJCEW8hl7n+TZizuTW12IXBKEaR8K1XNZsBoQg+8eF/ps6c9TnSDWs=
X-Received: by 2002:a05:6512:33d0:b0:471:a625:fdc0 with SMTP id
 d16-20020a05651233d000b00471a625fdc0mr11800984lfg.98.1650854977394; Sun, 24
 Apr 2022 19:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220425024418.8415-1-jasowang@redhat.com>
In-Reply-To: <20220425024418.8415-1-jasowang@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 25 Apr 2022 10:49:26 +0800
Message-ID: <CACGkMEu0qSb2o0HM6R2HE2g_fTbEBwPfXk7pO-QYepe3Unk5aw@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] rework on the IRQ hardening of virtio
To:     jasowang <jasowang@redhat.com>, mst <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:44 AM Jason Wang <jasowang@redhat.com> wrote:
>
> Hi All:
>

Forgot to add Xuan to the series.

Thanks

> This is a rework on the IRQ hardening for virtio which is done
> previously by the following commits are reverted:
>
> 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
>
> The reason is that it depends on the IRQF_NO_AUTOEN which may conflict
> with the assumption of the affinity managed IRQ that is used by some
> virtio drivers. And what's more, it is only done for virtio-pci but
> not other transports.
>
> In this rework, I try to implement a general virtio solution which
> borrows the idea of the INTX hardening by re-using per virtqueue
> boolean vq->broken and toggle it in virtio_device_ready() and
> virtio_reset_device(). Then we can simply reuse the existing checks in
> the vring_interrupt() and return early if the driver is not ready.
>
> Note that, I only did compile test on ccw and MMIO transport.
>
> Please review.
>
> Changes since v1:
>
> - Use transport specific irq synchronization method when possible
> - Drop the module parameter and enable the hardening unconditonally
> - Tweak the barrier/ordering facilities used in the code
> - Reanme irq_soft_enabled to driver_ready
> - Avoid unnecssary IRQ synchornization (e.g during boot)
>
> Changes since V2:
>
> - add ccw and MMIO support
> - rename synchronize_vqs() to synchronize_cbs()
> - switch to re-use vq->broken instead of introducing new device
>   attributes for the future virtqueue reset support
> - remove unnecssary READ_ONCE()/WRITE_ONCE()
> - a new patch to remove device triggerable BUG_ON()
> - more tweaks on the comments
>
> Jason Wang (8):
>   virtio: use virtio_reset_device() when possible
>   virtio: introduce config op to synchronize vring callbacks
>   virtio-pci: implement synchronize_cbs()
>   virtio-mmio: implement synchronize_cbs()
>   virtio-ccw: implement synchronize_cbs()
>   virtio: allow to unbreak virtqueue
>   virtio: harden vring IRQ
>   virtio: use WARN_ON() to warning illegal status value
>
> Stefano Garzarella (1):
>   virtio: use virtio_device_ready() in virtio_device_restore()
>
>  drivers/char/virtio_console.c              |  2 +-
>  drivers/crypto/virtio/virtio_crypto_core.c |  2 +-
>  drivers/s390/virtio/virtio_ccw.c           | 31 ++++++++++++++++--
>  drivers/virtio/virtio.c                    | 24 ++++++++++----
>  drivers/virtio/virtio_mmio.c               |  9 +++++
>  drivers/virtio/virtio_pci_common.c         |  2 +-
>  drivers/virtio/virtio_pci_common.h         |  2 ++
>  drivers/virtio/virtio_pci_legacy.c         |  1 +
>  drivers/virtio/virtio_pci_modern.c         |  2 ++
>  drivers/virtio/virtio_ring.c               | 15 +++++----
>  include/linux/virtio.h                     |  2 +-
>  include/linux/virtio_config.h              | 38 +++++++++++++++++++++-
>  12 files changed, 110 insertions(+), 20 deletions(-)
>
> --
> 2.25.1
>
>

