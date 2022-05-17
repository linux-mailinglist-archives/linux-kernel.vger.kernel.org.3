Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A6652AE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiEQWds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiEQWdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B85D14738C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652826811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xsgZD2xN95jcvNsVYdiJpz1wstzqtrmwvWpl/rt8mrs=;
        b=L8fzmDd0uHM83sPFQiJ6i5qF/xxWBxqf1kRgBkoa4ILD17qJWuoxBzULtuUcf9rwocq7cm
        cB6sm7y+t3Y67yXFZfOxMlIyG+yBwZc/eH8OyKHqr8/Vze0IFhVJn1/cd37amHq8BOaYp7
        NoOCB61XYkABnpt5fDgpj+gcnZWYGFs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-PTKlFvK5M5iFlJ37ooRhyw-1; Tue, 17 May 2022 18:33:30 -0400
X-MC-Unique: PTKlFvK5M5iFlJ37ooRhyw-1
Received: by mail-qt1-f198.google.com with SMTP id h5-20020ac81385000000b002f3f91834ffso414772qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=xsgZD2xN95jcvNsVYdiJpz1wstzqtrmwvWpl/rt8mrs=;
        b=OFuuL+YhJjoz/OLO7kn15tveosKlVw1RkjBM0CeoDV1b45zAxY42ajpM1tFExIkfKz
         WLjk2fRLYeNJtIbu+HUyeHRCR4YPsHQH/b/CbkAf4Af7nT2Nt4IzpSgm4pR2wzp1cF13
         oxy8cpYMCtp+LxmrAfV6CAnL7Im7/l6SlFCI3X1rDwReg4UFoLBitukL9YAEoIB3NOe6
         MGNi0rmn2Bx1i52R/iZQXqetWEmmjAnuC+Tq5Gffgf9h9I/2wg/oq0Z3pbNfrF72bn5K
         NwsSlmqq5Ql/pytW50juEUkXiCRuTyuT3QLBYuzXG0a7Sv+84Sj+o44Dl1wCsP3mMvRT
         OJDw==
X-Gm-Message-State: AOAM533eTyI6FJa3iNAY1xo0UiLddo9MMXPKSuORonNQjoyBPyMo2a+0
        uYkwlQzxPQhwCD5iakz7qXvouSUGXfrxk08nIa/erYLKORp2ash6jO6LlnW5UBif3i8Yi+W14Qd
        0YxrYq1cRUAxJy+omoJj1sISM
X-Received: by 2002:a05:620a:4727:b0:6a0:3036:8bfe with SMTP id bs39-20020a05620a472700b006a030368bfemr18258015qkb.239.1652826809385;
        Tue, 17 May 2022 15:33:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1rJobn4JcdOWoAqeK93N2MhQ5S8q1IuwRVLFycp/5h0rBE3NqehxIR7DkNsuosW/5+564Lw==
X-Received: by 2002:a05:620a:4727:b0:6a0:3036:8bfe with SMTP id bs39-20020a05620a472700b006a030368bfemr18258006qkb.239.1652826809198;
        Tue, 17 May 2022 15:33:29 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id z197-20020a3765ce000000b0069fc13ce212sm276480qkb.67.2022.05.17.15.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 15:31:56 -0700 (PDT)
Message-ID: <aed19bec63ddcb63bf87582754c96d7fbe2c06b3.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: reorder nouveau_drm_device_fini
From:   Lyude Paul <lyude@redhat.com>
To:     Mark Menzynski <mmenzyns@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Tue, 17 May 2022 18:31:03 -0400
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

