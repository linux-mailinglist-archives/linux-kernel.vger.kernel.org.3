Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA874F62C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiDFPQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbiDFPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D44C265EAA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649247318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kB1T+ZnqR2/L037KmDjJiiYzrhgcu2TNRn7h+cl2h1Q=;
        b=Ssdyj+AkDcJvgflY7B0DavsWApsLQgsY9oSlS8g5c5CASfUw4DEvSRGGHZ4u4R+uGMkDg5
        MOveifUhM9M2hy6qlRqjDlxDelTD6TgL7TPt4mcLwu02dGVBB5jy/tKdk/aNRpatNEURlS
        dkqQMhp51XcNb2KguyWfDyWGZjOb9Zk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-NVV-rqNPMjmD6bT48ZKlWw-1; Wed, 06 Apr 2022 07:53:40 -0400
X-MC-Unique: NVV-rqNPMjmD6bT48ZKlWw-1
Received: by mail-wm1-f71.google.com with SMTP id r64-20020a1c2b43000000b0038b59eb1940so2133827wmr.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kB1T+ZnqR2/L037KmDjJiiYzrhgcu2TNRn7h+cl2h1Q=;
        b=k5wieS+r1heDnhX0wOkiagF8ME69xD7Tgf7nxaXCnu3k2oGHqW0ylDQH4cjq8zwbtr
         uHGUnD1mjEtOsGx0RacG8MfMlPp+4MwgzG38IQcj7Uu1WXQ0HFX1iThu5IK2XGz5rNUH
         JVCYuzVWsM+uK4GLgmhUbp4cv27qZfzGobm3t3uBGxJzsAYjodA/KL7nAw502WSg8Ttv
         BOuu/KX6klfsZ4tx3ZVD+92JC+xigNhCS+HlHxtN530l1NmCjX26GcxUWgqg1P4aLGxC
         IWZSg5va3hyvr9G9+FYa40AmbhBO3dfEtsNPwEmf9+zvW3blYVwOYbM51g7BJKV2D+R0
         Fcrg==
X-Gm-Message-State: AOAM5311iHvbmXvSsOriafXuchU2W8VECi1S2UysWmeEpK9HYCXabRSD
        ejpV2yIB07FZWt/Cg0jH6Pbk8CPUzYc9ubeKYd6SAg+xUXkAiXLju52Oh46F4x17qlpwJZ9W9Pj
        p/DeCAWg39MW4HJydkhJbQnGW
X-Received: by 2002:adf:eb48:0:b0:203:f854:86cc with SMTP id u8-20020adfeb48000000b00203f85486ccmr6312035wrn.102.1649246019001;
        Wed, 06 Apr 2022 04:53:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2+5QZG87zHPtKHombCPhUvvOUvDWdcIY4nG1TjUzIlk1J6N8DJq0jnyTF+14SRheRL60Wcw==
X-Received: by 2002:adf:eb48:0:b0:203:f854:86cc with SMTP id u8-20020adfeb48000000b00203f85486ccmr6312018wrn.102.1649246018821;
        Wed, 06 Apr 2022 04:53:38 -0700 (PDT)
Received: from redhat.com ([2.55.138.162])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b0038cbd8c41e9sm4594698wmq.12.2022.04.06.04.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:53:38 -0700 (PDT)
Date:   Wed, 6 Apr 2022 07:53:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V2 2/5] virtio: use virtio_reset_device() when possible
Message-ID: <20220406074440-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406083538.16274-3-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 04:35:35PM +0800, Jason Wang wrote:
> This allows us to do common extension without duplicating codes.

codes -> code

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 75c8d560bbd3..8dde44ea044a 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -430,7 +430,7 @@ int register_virtio_device(struct virtio_device *dev)
>  
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
> -	dev->config->reset(dev);
> +	virtio_reset_device(dev);
>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> @@ -496,7 +496,7 @@ int virtio_device_restore(struct virtio_device *dev)
>  
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up. */
> -	dev->config->reset(dev);
> +	virtio_reset_device(dev);
>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> -- 
> 2.25.1

