Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F35798F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiGSL44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbiGSL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC96542AFF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658231775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I1KTsZFixJ+o97iKP2ncjBSYXhYH2jprWjMoHsMt0Ik=;
        b=E6ozbs9vsxs1qQGOY67qGRVFB6lMmgAyjPvWX5JWV+SqWMUS2jP3snEVXPgI2woPU0mCEQ
        72dbn9vRVkd/AU6yocq+94UeKCs9sNSztc/8oTqqhmkAMdi57VZoWc/YTFJDrUVI/A3fuh
        IxHekYPoTFVFOOqTKoP2xKnGLpizVd8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-rKSO98-_OMWiURVXWyeU8g-1; Tue, 19 Jul 2022 07:56:14 -0400
X-MC-Unique: rKSO98-_OMWiURVXWyeU8g-1
Received: by mail-ed1-f70.google.com with SMTP id m10-20020a056402510a00b0043a93d807ffso9775707edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1KTsZFixJ+o97iKP2ncjBSYXhYH2jprWjMoHsMt0Ik=;
        b=bOqhzG2Y9uCFklgGdypvXzaLyiKxlgp3VxFUpkRT9CrOE/eBi4V5f3u0iS6Yk4CHRX
         TetYF302oimF25XVhT3+oB3LrcIbZg3Goykyru/8F8jmM928037T5E4UxmzU8tgn13Sh
         EpAwTBGl7RHM2Al6Y3XnnYNg3lX5mCwgm6QTApEYo+J5rGPVSOZ4BHnKwf8CG151DWsT
         JD+TrF5H/I8NWOwPJ/KDuZgIaU8xwHFfjvnJtDvmXsJeM2OzBP8LcNQ583tsECJOX5Wa
         MvtdFoOne+Fps1drXTXmiOJycB/UEYhtxfTKe73Kk+vsmIs+uHZE0hDnnkd0ExShkSb0
         0mZQ==
X-Gm-Message-State: AJIora8KuSs6gsKGvoaOKQEGVSMKu43ASw7wxBj8sKrY98M0fKR7HRHZ
        STHMKLfx/honFEZ7Kc7TOL0jzDM6r6cwN9unpWV/eL3QvAEcyiseS9E/ODMWQearvRxLvxvNd4u
        7PpvHTT+1lO2oEcXOXYKHDQbJ
X-Received: by 2002:aa7:c0c4:0:b0:43a:20cf:3c68 with SMTP id j4-20020aa7c0c4000000b0043a20cf3c68mr43811836edp.172.1658231773259;
        Tue, 19 Jul 2022 04:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIlp8Z82V49PuiO1hwXvHoZ//n+lr0dXOdhOppU3nk5LuUcwp4ZCXhdr7YYQkvNbC+bnR/zw==
X-Received: by 2002:aa7:c0c4:0:b0:43a:20cf:3c68 with SMTP id j4-20020aa7c0c4000000b0043a20cf3c68mr43811817edp.172.1658231773057;
        Tue, 19 Jul 2022 04:56:13 -0700 (PDT)
Received: from redhat.com ([2.55.46.60])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm10242169edb.55.2022.07.19.04.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:56:12 -0700 (PDT)
Date:   Tue, 19 Jul 2022 07:56:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Keir Fraser <keirf@google.com>
Cc:     Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <20220719074941-mutt-send-email-mst@kernel.org>
References: <20220719100256.419780-1-keirf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719100256.419780-1-keirf@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:02:56AM +0000, Keir Fraser wrote:
> If virtio devices are tagged for "restricted-dma-pool", then that
> pool should be used for virtio ring setup, via the DMA API.
> 
> In particular, this fixes virtio_balloon for ARM PKVM, where the usual
> workaround of setting VIRTIO_F_ACCESS_PLATFORM in the virtio device
> doesn't work because the virtio_balloon driver clears the flag. This
> seems a more robust fix than fiddling the flag again.
> 
> Signed-off-by: Keir Fraser <keirf@google.com>


So the reason balloon disables ACCESS_PLATFORM is simply
because it passes physical addresses to device and
expects device to be able to poke at them.

I worry about modifying DMA semantics yet again - it has as much of a
chance to break some legacy configs as it has to fix some.


And I don't really know much about restricted-dma-pool but
I'd like to understand why does it make sense to set it for
the balloon since it pokes at all and any system memory.


> ---
>  drivers/virtio/virtio_ring.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a5ec724c01d8..12be2607c648 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -12,6 +12,7 @@
>  #include <linux/hrtimer.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/spinlock.h>
> +#include <linux/swiotlb.h>
>  #include <xen/xen.h>
>  
>  #ifdef DEBUG
> @@ -248,6 +249,13 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	if (!virtio_has_dma_quirk(vdev))
>  		return true;
>  
> +	/* If the device is configured to use a DMA restricted pool,
> +	 * we had better use it.
> +	 */
> +	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
> +	    is_swiotlb_for_alloc(vdev->dev.parent))
> +		return true;
> +
>  	/* Otherwise, we are left to guess. */
>  	/*
>  	 * In theory, it's possible to have a buggy QEMU-supposed
> -- 
> 2.37.0.170.g444d1eabd0-goog

