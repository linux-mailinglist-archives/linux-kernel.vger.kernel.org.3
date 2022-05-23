Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EFE531A50
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243470AbiEWSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbiEWRu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48BC45534D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653327431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYIDCnf/Zf8QzS2kJ2TsL1URkSHu4rYCBHFAM1s78Bs=;
        b=X4g92M/O9cr8MOyAjlxlKgzzOsLO5gKyOjVE62z+FZcUBd3EzLGJGQhpGP4JqStuwz8wg3
        2FZ19yMeYhUC8HS6YTjqiIRYt2xK9Qz7JyHi+yGgi6pO0UCO1Cu/dshT2Ca9f5TSg2FPrn
        g6knrRJ4oiUokNZcqm7z0hNKi51WXRE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-R7GFGLuAPqaiapEOmtluFA-1; Mon, 23 May 2022 13:37:10 -0400
X-MC-Unique: R7GFGLuAPqaiapEOmtluFA-1
Received: by mail-qv1-f71.google.com with SMTP id ck16-20020a05621404d000b00461bcafbbe9so11444615qvb.23
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=BYIDCnf/Zf8QzS2kJ2TsL1URkSHu4rYCBHFAM1s78Bs=;
        b=pk0rpwBauIN6wC3l5uR1Tvw0HgwXOQOSfKvcBaLOfRCWNEYfgZRmCemjhMnlogSycN
         8ufDiThRsN/Vm+F3E5Wrc8tLhLDO/d1l8luiFS9FvYw5n9ePZHM2eh1hrWIcwwboqe9r
         PXzZVTbmI6+N1w2p6S+4dgsUqrCN4DUiejUIeEvPeJkh2meIGohZJmCowxtoEBCTTxn4
         KdE0QkS8uC2/t63NjW8jKMXZK0dnsOHWov8eDqtRaPsjm3rT6UsOANY0aPBUYJRD0+Ne
         Y06GKsenuPrQFGoW2WV+0LG/VBBNRH+8Hlg3qegSB1S4QjV4fyHhO4B4RDMqyG1fJU6Z
         +Hrw==
X-Gm-Message-State: AOAM5332PiPZU20/H53kt3Jid5bebHYmGnKRqzWpZKOsBnM5qS4/SA2Y
        4UUNIx4pU50zpYpSHd4TTUGkpU9j0UozQRPBFXiPQRJITUX3MSDo+KDiwQ0OVNmhh6ee6DegqDj
        bgyu9H9Gi/Tgw7o32hGvl6V69
X-Received: by 2002:ad4:5bc1:0:b0:42c:531c:ef12 with SMTP id t1-20020ad45bc1000000b0042c531cef12mr18148392qvt.15.1653327430129;
        Mon, 23 May 2022 10:37:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFSlrvT0UAwxLdqZ1fz1PXc+yVuTdzO7/sMFpZ8cj76cv99LCVVGr1j1/NEpUjri+Na5pRww==
X-Received: by 2002:ad4:5bc1:0:b0:42c:531c:ef12 with SMTP id t1-20020ad45bc1000000b0042c531cef12mr18148377qvt.15.1653327429953;
        Mon, 23 May 2022 10:37:09 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id w15-20020ac84d0f000000b002f90517bc25sm4619030qtv.41.2022.05.23.10.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:37:09 -0700 (PDT)
Message-ID: <36bd82b1a95cb4cbbecac188a4c4e27cf890cdd4.camel@redhat.com>
Subject: Re: [PATCH v3] drm/nouveau: clear output poll workers before
 nouveau_fbcon_destroy()
From:   Lyude Paul <lyude@redhat.com>
To:     Mark Menzynski <mmenzyns@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Mon, 23 May 2022 13:37:07 -0400
In-Reply-To: <20220523113541.10562-1-mmenzyns@redhat.com>
References: <20220523113541.10562-1-mmenzyns@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to the appropriate branch in a bit, thanks!

On Mon, 2022-05-23 at 13:35 +0200, Mark Menzynski wrote:
> Resources needed for output poll workers are destroyed in
> nouveau_fbcon_fini() before output poll workers are cleared in
> nouveau_display_fini(). This means there is a time between fbcon_fini()
> and display_fini(), where if output poll happens, it crashes.
> 
> This patch introduces another output poll clearing before fbcon
> resources are destroyed.
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

