Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1152AE39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiEQWdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiEQWdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80BA94738C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652826821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xsgZD2xN95jcvNsVYdiJpz1wstzqtrmwvWpl/rt8mrs=;
        b=Js7VkRPvMV+8h8BvFZkIWA8fL+QpIRmFtzMGbFF2kJ9C10qfnE7qupz7k40TC2opmf826f
        xVXlD3XofEG0mXu1Iy77i37jAqYHAgk8kkl9DFv/l2trd1QhzPd7iGTMYw5FMW7flp2Mzw
        SJ2SpCbt/jwvmqsrT8hHqZ1Mbw/7m6E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-UG_BkEwtN_CBvzl7Opai3Q-1; Tue, 17 May 2022 18:33:40 -0400
X-MC-Unique: UG_BkEwtN_CBvzl7Opai3Q-1
Received: by mail-qv1-f69.google.com with SMTP id kd30-20020a056214401e00b0045a96ed0d4aso215718qvb.17
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=xsgZD2xN95jcvNsVYdiJpz1wstzqtrmwvWpl/rt8mrs=;
        b=C5SRU+ifDWayoXOIdfpQ6wr1GiHXuE3WMkUue/TMEFxxh2Z8lSFf9Sf5lb8wvtHwYA
         5no4TUZuOuSuh1tYtg1rFlJcwWckOJ+orS3vZFaOerGKv6M51AnkqHWO5hKnq/4hsmJB
         erEH7tZ6U+twYVJMx1pG8uqjhQQ2J4MytJUSzJRsnn7AyTQHKAu2xpk7+D+nkg+LEnBC
         1jUR0MblElpB31map1ClVKYh/5GAtrS5amSdIXLBm4ak5o6RR7+EmrOvWwmjN8jbNSE0
         AWesu3QrpeHcprG0eu4orK29Z8jlR07uzUi5t/8CGNt1O1H8aL8+vXpQxMuFdvdqsnIp
         6+Og==
X-Gm-Message-State: AOAM533yg0G253GAcANj8/IkiZ/DwBHtzdMF9g5XJdO74hn5G1MENfEd
        UyEhkCxXgx0q0uNdZREdOcwgFCCGJUnMEnUQ9BfnHn0z5GxP1A7HLr6dGoegx8Ss+sD2rfdvLLn
        Ed4/CMsNwZo6ks0R7tV0e6eOF
X-Received: by 2002:a05:622a:4d4:b0:2f3:c529:5f89 with SMTP id q20-20020a05622a04d400b002f3c5295f89mr22472718qtx.158.1652826820079;
        Tue, 17 May 2022 15:33:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNH3lIfhXQ3QcRjAYZSIHBy4cUOe+o8UjX9lacQqYYbq3FNnSKIvDUgOrGldFFWLAX52lxvw==
X-Received: by 2002:a05:622a:4d4:b0:2f3:c529:5f89 with SMTP id q20-20020a05622a04d400b002f3c5295f89mr22472711qtx.158.1652826819889;
        Tue, 17 May 2022 15:33:39 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id g12-20020ac8070c000000b002f39b99f69csm114858qth.54.2022.05.17.15.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 15:33:39 -0700 (PDT)
Message-ID: <4382925e2e4174598214f3a9f74b373a5fca40fd.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: reorder nouveau_drm_device_fini
From:   Lyude Paul <lyude@redhat.com>
To:     Mark Menzynski <mmenzyns@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Tue, 17 May 2022 18:33:38 -0400
In-Reply-To: <20220516133103.324365-1-mmenzyns@redhat.com>
References: <20220516133103.324365-1-mmenzyns@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I think you forgot to update the subject of the patch. If you can send a
respin of this patch with a corrected patch title, then you can consider this:

Reviewed-by: Lyude Paul <lyude@redhat.com>

I'll push once you get the respin out

On Mon, 2022-05-16 at 15:31 +0200, Mark Menzynski wrote:
> Resources needed for output poll workers are destroyed in
> nouveau_fbcon_fini() before output poll workers are cleared in
> nouveau_display_fini(). This means there is a time between fbcon_fini()
> and display_fini(), where if output poll happens, it crashes.
> 
> This makes output poll workers cleared right before fbcon resources are
> destroyed.
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
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Mark Menzynski <mmenzyns@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_fbcon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> index 4f9b3aa5deda..5226323e55d3 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> @@ -39,6 +39,7 @@
>  
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_probe_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_atomic.h>
> @@ -605,6 +606,7 @@ nouveau_fbcon_fini(struct drm_device *dev)
>         if (!drm->fbcon)
>                 return;
>  
> +       drm_kms_helper_poll_fini(dev);
>         nouveau_fbcon_accel_fini(dev);
>         nouveau_fbcon_destroy(dev, drm->fbcon);
>         kfree(drm->fbcon);

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

