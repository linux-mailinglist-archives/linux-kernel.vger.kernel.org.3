Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155714F6267
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiDFPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiDFPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8928131FFD3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649244972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsS3+hPNYqFkkpCy/2zflCp4q5xBw1zafG1zPBrhqj4=;
        b=dY057qsRLqer5mQvBgQZozyVYQuI3qRPWlGE/wyy+AIAV6S6lgDGiF41OQApewJnjpe6Sh
        Hh31ni/5QVgDtFL34URUSHlXlxRO/tCkQwGWUFRqiuH9mQhBCyAdsuD+BeyTtV+P5E71EO
        MGYIinvm4vxh2NzArW2PJwQbsNqgGjM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-wWUmEuUWPyifirl7JRkRHA-1; Wed, 06 Apr 2022 07:36:11 -0400
X-MC-Unique: wWUmEuUWPyifirl7JRkRHA-1
Received: by mail-ed1-f71.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so1075524edw.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QsS3+hPNYqFkkpCy/2zflCp4q5xBw1zafG1zPBrhqj4=;
        b=xkwH73DT5CubzXNEEbm8FphHixSt/ItNJPP0U46XVVHUrr9ryOor8wDzVbHTM45Q45
         Oba3YoFqKEPyUWkFE3DMzrAc8XhJZmlrPmrAfxsy5sk7/++S7Thv4ST6jVz4VvE6lHUb
         eu8O1DU/hs+f/6xKy9v6TvpMg2q8Glz66Q6Rc6bHF1E3y2sx5CYr3gJbmfs6Z9913O4n
         0/gyKiOJYDtaGTGXd0k0FGi95pUHD5kx7TX1VijFrAtWKp4idhkFJIwFRekqb9599fhK
         wShOURoulZ6OKH7WLXu3R4UsE2QAOxo86U5Y/0MQldWfiMr+i2Y7ZUFVD8BvP6pYejy5
         ivYA==
X-Gm-Message-State: AOAM533dO2r/wKCMFFUjp7vaGI98UP0csF+HnyW/sexWg+6m2ZKvnOoO
        bpcSFS0XynEvGm69gPRgsUknSIyYwO4eWkZHNC/W04DL2pR9n9wfex32fmrc2GLD/morRGMuzSK
        uQZrNw9c837FZNhyVbrfCMbAx
X-Received: by 2002:a17:907:6d92:b0:6e5:d50e:9170 with SMTP id sb18-20020a1709076d9200b006e5d50e9170mr7892339ejc.506.1649244970496;
        Wed, 06 Apr 2022 04:36:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypxpXVVLOxhtpSoSl0a6R8c9Uqer3rPVAkc8Pe1+YYicYMzoEDo4eBchIbF2poX4V8YaDCTw==
X-Received: by 2002:a17:907:6d92:b0:6e5:d50e:9170 with SMTP id sb18-20020a1709076d9200b006e5d50e9170mr7892318ejc.506.1649244970217;
        Wed, 06 Apr 2022 04:36:10 -0700 (PDT)
Received: from redhat.com ([2.53.144.12])
        by smtp.gmail.com with ESMTPSA id m20-20020a170906235400b006e718d8b849sm4612248eja.45.2022.04.06.04.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:36:09 -0700 (PDT)
Date:   Wed, 6 Apr 2022 07:36:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com
Subject: Re: [PATCH V2 0/5] rework on the IRQ hardening of virtio
Message-ID: <20220406073500-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406083538.16274-1-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 04:35:33PM +0800, Jason Wang wrote:
> Hi All:
> 
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
> borrows the idea of the INTX hardening by introducing a boolean for
> virtqueue callback enabling and toggle it in virtio_device_ready()
> and virtio_reset_device(). Then vring_interrupt() can simply check and
> return early if the driver is not ready.


All of a sudden all patches are having a wrong mime type.

It is application/octet-stream; should be text/plain

Pls fix and repost, thanks!

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
> Jason Wang (4):
>   virtio: use virtio_reset_device() when possible
>   virtio: introduce config op to synchronize vring callbacks
>   virtio-pci: implement synchronize_vqs()
>   virtio: harden vring IRQ
> 
> Stefano Garzarella (1):
>   virtio: use virtio_device_ready() in virtio_device_restore()
> 
>  drivers/virtio/virtio.c            | 20 ++++++++++++++++----
>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>  drivers/virtio/virtio_pci_common.h |  2 ++
>  drivers/virtio/virtio_pci_legacy.c |  1 +
>  drivers/virtio/virtio_pci_modern.c |  2 ++
>  drivers/virtio/virtio_ring.c       |  9 ++++++++-
>  include/linux/virtio.h             |  2 ++
>  include/linux/virtio_config.h      | 24 ++++++++++++++++++++++++
>  8 files changed, 69 insertions(+), 5 deletions(-)
> 
> -- 
> 2.25.1

