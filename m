Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152E4F6331
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiDFP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbiDFP0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DADA35FB0D2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649247900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dicVFjsXOIL9hOndQjIV/DVmY/a3j1A4etYvxOxmSgQ=;
        b=EHZpyBiT5wD+Ld+1o8JJzRi5eNFzJEFwcxqwMRQYtaSoJzd8uASFhtL/5CM2963QGPRMZV
        yN2rIrJX6YiWZj89abcFC0feDNb9kV2Ef3oMV2Gdhy6MRlkvARZXbDTWGOxP3Qthgen7TA
        uM3ydObB8/WQNw9yeNiOoSIXaC2HQIU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-pYPjC8IkNmOoBi7ACrpfvg-1; Wed, 06 Apr 2022 07:59:38 -0400
X-MC-Unique: pYPjC8IkNmOoBi7ACrpfvg-1
Received: by mail-wm1-f69.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso608704wma.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dicVFjsXOIL9hOndQjIV/DVmY/a3j1A4etYvxOxmSgQ=;
        b=l7ylINmXNCbnPmGVSg89ENAJdz44ltwxYwobnY9NiOYTNsekgYnUlXYBsKBWBhBRzy
         TVt7lkxVRiGirBXnzKETZ2rqPax4CLhZTQQzGLi9X3+3N/J+M4piGAGhiOkzZ5TW4bhY
         4e/aIzTf4COg4G3K5zjFVSxZ7DKII2z1Twz3D8nl5WRCkMsHco1pujKyqiIsa9Ueoh9v
         /02Luspg/sSq7ftxUYE7/PjvSbipHmefvv/foFiK5UDytwfQsz2/DSk6NCcyTMk4k9NI
         caVIihWcLq1PF/sOmD02SoIY0Cx/KjApRf7tZp2s6ddMoK5uqthyfMp3GBLuQk2mJS2i
         e05w==
X-Gm-Message-State: AOAM5329s8ylw73QJna6laF39Tgtp8d+hX2OBtZqjpHJ3fJq632YFadN
        BEn8ugIJxNUxhI8yjcBd8YUMoBWN6BBXJiExEBb7a9zpwTh7OnJzxBLIl8hpuaJB3U4eSlXBcbz
        AFGhz9pOT0uIOzY85U5ChyOhb
X-Received: by 2002:adf:fc90:0:b0:206:e7b:cd63 with SMTP id g16-20020adffc90000000b002060e7bcd63mr6304657wrr.511.1649246377514;
        Wed, 06 Apr 2022 04:59:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXEb2qJOGVPTkba/SZuCnqqnQUU7IQyRanDtldo58dlWits4116YDR77kPcSHcn0/MUmK+Vg==
X-Received: by 2002:adf:fc90:0:b0:206:e7b:cd63 with SMTP id g16-20020adffc90000000b002060e7bcd63mr6304642wrr.511.1649246377324;
        Wed, 06 Apr 2022 04:59:37 -0700 (PDT)
Received: from redhat.com ([2.55.179.195])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b0038cb84f4218sm5055607wmq.27.2022.04.06.04.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:59:36 -0700 (PDT)
Date:   Wed, 6 Apr 2022 07:59:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V2 3/5] virtio: introduce config op to synchronize vring
 callbacks
Message-ID: <20220406075405-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406083538.16274-4-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 04:35:36PM +0800, Jason Wang wrote:
> This patch introduce

introduces

> a new

new

> virtio config ops to vring
> callbacks. Transport specific method is required to call
> synchornize_irq() on the IRQs. For the transport that doesn't provide
> synchronize_vqs(), use synchornize_rcu() as a fallback.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/virtio_config.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b341dd62aa4d..08b73d9bbff2 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -57,6 +57,8 @@ struct virtio_shm_region {
>   *		include a NULL entry for vqs unused by driver
>   *	Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
> + * @synchronize_vqs: synchronize with the virtqueue callbacks.
> + *	vdev: the virtio_device

I think I prefer synchronize_callbacks

>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
>   *	Returns the first 64 feature bits (all we currently need).
> @@ -89,6 +91,7 @@ struct virtio_config_ops {
>  			const char * const names[], const bool *ctx,
>  			struct irq_affinity *desc);
>  	void (*del_vqs)(struct virtio_device *);
> +	void (*synchronize_vqs)(struct virtio_device *);
>  	u64 (*get_features)(struct virtio_device *vdev);
>  	int (*finalize_features)(struct virtio_device *vdev);
>  	const char *(*bus_name)(struct virtio_device *vdev);
> @@ -217,6 +220,19 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>  				      desc);
>  }
>  
> +/**
> + * virtio_synchronize_vqs - synchronize with virtqueue callbacks
> + * @vdev: the device
> + */
> +static inline
> +void virtio_synchronize_vqs(struct virtio_device *dev)
> +{
> +	if (dev->config->synchronize_vqs)
> +		dev->config->synchronize_vqs(dev);
> +	else
> +		synchronize_rcu();

I am not sure about this fallback and the latency impact.
Maybe synchronize_rcu_expedited is better here.

> +}
> +
>  /**
>   * virtio_device_ready - enable vq use in probe function
>   * @vdev: the device
> -- 
> 2.25.1

