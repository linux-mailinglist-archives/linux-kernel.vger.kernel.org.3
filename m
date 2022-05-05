Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F157151C9C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385482AbiEEUBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241858AbiEEUBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:01:12 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B81B25EBC2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651780650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQdApoYa6nUTANKsVJL2yCvAWducoOnmFhGo9oVvBLo=;
        b=h5sn2L+uS+ybPxJYdEiyVldvi9Hcpp1dDaRPZ8I2qLyzhrA+KfNG21kB+RQFU3LEaSYI1r
        0DEQe19tUYeWWl95bu9pn/Q+7Yu53U9H28l8FPHJFDTHMjUKfVKabaDhUAH5LfhNFy/+Yf
        +JoqwM7JwPZ4E5yNyRbc0vzAjhyYnSY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-qgiC8VKVOPeMG6LwkFhn-g-1; Thu, 05 May 2022 15:57:29 -0400
X-MC-Unique: qgiC8VKVOPeMG6LwkFhn-g-1
Received: by mail-qv1-f69.google.com with SMTP id ke27-20020a056214301b00b0045a82079370so4024790qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 12:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=rQdApoYa6nUTANKsVJL2yCvAWducoOnmFhGo9oVvBLo=;
        b=evUMMgAzfarHVaKg8HE8A9nCMdurizlSgaQekDnDlSzslq7D1O4H3pZNquh7ARgy5N
         zH+c5aHA5e2SNUdbSWyMqegSES1A9/w2F5bqsVmg5O11xe7QDz9CNIOGda2t92hYHvT5
         wdZuPghwkA24OGevAkAltKCxxcxZBUMKtxhZD8o6VXz1HHeZ17aDkz4l3rQa3dKyw+qI
         Cxp0cRKowFvCH+gEke6mBLHaoYgHTkhvHKQ5K1kGpfhnffcC6oEpTY1GE7lPDIPfsU78
         SwizDi+r5V2WWlKeWUChTi3+3A5OcBcjSMdLccXXi8YFuGYFJw6lSeUj1r0pv5YukyOr
         KWaw==
X-Gm-Message-State: AOAM5336Rn96AL+a5s9lNXoYv4zzbLrpO00BnuSVuK9w/LYx3ILPj7oN
        CncL8m2+XS2ab2+0rivrxKmxnxPIeEPhCm/1nrIIK61cGX/j4HJkc1daKAhW1hIWOEDhtFoFw6Y
        gGPyPXZK+9JZc1Yx9Qj7eI+lr
X-Received: by 2002:a37:9381:0:b0:69f:62c6:56a7 with SMTP id v123-20020a379381000000b0069f62c656a7mr21018125qkd.643.1651780649335;
        Thu, 05 May 2022 12:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysHvCP5TnQ3sEmfDp/p5w9i9wXshs650VSW1K7lLdusgFc5hlOZKEwi/HjjBeApccdfiF3kQ==
X-Received: by 2002:a37:9381:0:b0:69f:62c6:56a7 with SMTP id v123-20020a379381000000b0069f62c656a7mr21018112qkd.643.1651780649132;
        Thu, 05 May 2022 12:57:29 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id l15-20020ac848cf000000b002f39b99f6c3sm1288303qtr.93.2022.05.05.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 12:57:28 -0700 (PDT)
Message-ID: <7574d491866ffa7c1a4607885b76140ba4206477.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: reorder nouveau_drm_device_fini
From:   Lyude Paul <lyude@redhat.com>
To:     Mark Menzynski <mmenzyns@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Date:   Thu, 05 May 2022 15:57:27 -0400
In-Reply-To: <20220504171851.17188-1-mmenzyns@redhat.com>
References: <20220504171851.17188-1-mmenzyns@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, I think we might just need to move the drm_kms_helper_poll_enable() call
to the end here instead of all of nouveau_display_init(). I realized this
because in nouveau_display_init() it seems that we actually rely on
nouveau_display_init() to setup hotplug interrupts - which we do actually need
this early on in the driver probe process.

That being said though, drm_kms_helper_poll_enable() shouldn't be required for
MST short HPD IRQs from working so moving that instead should work.

On Wed, 2022-05-04 at 19:18 +0200, Mark Menzynski wrote:
> Resources needed for output poll workers are destroyed in
> nouveau_fbcon_fini() before output poll workers are cleared in
> nouveau_display_fini(). This means there is a time between fbcon_fini
> and display_fini, where if output poll happens, it crashes.
> 
> BUG: KASAN: use-after-free in
> __drm_fb_helper_initial_config_and_unlock.cold+0x1f3/0x291
> [drm_kms_helper]
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Mark Menzynski <mmenzyns@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 561309d447e0..773efdd20d2f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -588,12 +588,6 @@ nouveau_drm_device_init(struct drm_device *dev)
>         if (ret)
>                 goto fail_dispctor;
>  
> -       if (dev->mode_config.num_crtc) {
> -               ret = nouveau_display_init(dev, false, false);
> -               if (ret)
> -                       goto fail_dispinit;
> -       }
> -
>         nouveau_debugfs_init(drm);
>         nouveau_hwmon_init(dev);
>         nouveau_svm_init(drm);
> @@ -601,6 +595,12 @@ nouveau_drm_device_init(struct drm_device *dev)
>         nouveau_fbcon_init(dev);
>         nouveau_led_init(dev);
>  
> +       if (dev->mode_config.num_crtc) {
> +               ret = nouveau_display_init(dev, false, false);
> +               if (ret)
> +                       goto fail_dispinit;
> +       }
> +
>         if (nouveau_pmops_runtime()) {
>                 pm_runtime_use_autosuspend(dev->dev);
>                 pm_runtime_set_autosuspend_delay(dev->dev, 5000);
> @@ -641,15 +641,14 @@ nouveau_drm_device_fini(struct drm_device *dev)
>                 pm_runtime_forbid(dev->dev);
>         }
>  
> +       if (dev->mode_config.num_crtc)
> +               nouveau_display_fini(dev, false, false);
>         nouveau_led_fini(dev);
>         nouveau_fbcon_fini(dev);
>         nouveau_dmem_fini(drm);
>         nouveau_svm_fini(drm);
>         nouveau_hwmon_fini(dev);
>         nouveau_debugfs_fini(drm);
> -
> -       if (dev->mode_config.num_crtc)
> -               nouveau_display_fini(dev, false, false);
>         nouveau_display_destroy(dev);
>  
>         nouveau_accel_fini(drm);

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

