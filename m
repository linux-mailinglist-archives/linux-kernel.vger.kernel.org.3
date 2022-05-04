Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6B751AC64
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376858AbiEDSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376537AbiEDSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F06F47DA91
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651685364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DtzKR9aJWXKQXaXTDvVkj3EbrIwKfckZvxRRNgRE8g=;
        b=EsumouLKgXhzZP4UqAAlXpSodnldS9NrV2a6Pf12GTJhSN+XOfAZzABYQ5Y6fgnlPA/bom
        iZQqLOAaR5mtqXEjiCBBRNt9d8LViCXQq3prVn6F81W3fy+nliTV/IDXjKl+JU0dW1vtON
        e8kmYFvdHWloW1wHVS9x2gJ3pPJ1Vf8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-QJhoN6n9Pf-445zSO_qaAQ-1; Wed, 04 May 2022 13:29:21 -0400
X-MC-Unique: QJhoN6n9Pf-445zSO_qaAQ-1
Received: by mail-qv1-f72.google.com with SMTP id bu6-20020ad455e6000000b004563a74e3f9so1368373qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6DtzKR9aJWXKQXaXTDvVkj3EbrIwKfckZvxRRNgRE8g=;
        b=NYtYJLZwRHvI5OlxWjl7MLvlGAgLY/99o5NJ79X/1hbBI/1JprTk9yS8aXsSVQvMDl
         oPe0eqfLIF4xo3wUksVmDW2jAdyLTHto+Gw4P94NmMb1t8lGFXZ0hSMjgNqw1kVI1kUl
         6GdrkbH7hU5SonSkXHkL65oa35sZ1azFj/Y2SixNInaCxoJfjDp0Nktxs76oiQcu3pA5
         wCvtnkWG9M4tFFsTtJFQp2IyqgF8PrBeK0lq2vYJB8tU5yYzzR78K/619PLe8DIiX14K
         QKQwB1khHzd+sdegRPXpDr7FFcdRk5CN4ldBnCRS4Kgtcy7H0j9AJhPOATfszMDeVkcJ
         ZoMg==
X-Gm-Message-State: AOAM533lRyQq20oeDjZjWBMJcdngGSZnFOxadmSUeGxRRT9gxNFi4r0n
        GLrMTMOAFLjSAovhD3AqOp/R7gsaAVpEp3oLxlWuA0e0b8O7UqclP2XIVYVZuTel29Gnc12AQo8
        OblpWlIQ+x4FPmBniYiNPYbvG
X-Received: by 2002:ac8:5e0c:0:b0:2f3:adfd:bd30 with SMTP id h12-20020ac85e0c000000b002f3adfdbd30mr8408569qtx.277.1651685360396;
        Wed, 04 May 2022 10:29:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjrX58n0IOhBj6Fr3PV/2lw6DGC036Yba/rU/r+Mamk+IeEqM5857Vdlz0oR2XeiB+lpTMJA==
X-Received: by 2002:ac8:5e0c:0:b0:2f3:adfd:bd30 with SMTP id h12-20020ac85e0c000000b002f3adfdbd30mr8408554qtx.277.1651685360137;
        Wed, 04 May 2022 10:29:20 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id h23-20020ac85497000000b002f39b99f6b9sm7762181qtq.83.2022.05.04.10.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:29:19 -0700 (PDT)
Message-ID: <0ca5c54fab5dd7dd5988ae48af779570076800a6.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/devinit: fix returnvar.cocci warnings
From:   Lyude Paul <lyude@redhat.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     zhengkui_guo@outlook.com
Date:   Wed, 04 May 2022 13:29:18 -0400
In-Reply-To: <20220504161003.9245-1-guozhengkui@vivo.com>
References: <20220504161003.9245-1-guozhengkui@vivo.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to the appropriate branch in a little bit

On Thu, 2022-05-05 at 00:09 +0800, Guo Zhengkui wrote:
> Fix the following coccicheck warnings:
> 
> drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c:71:5-12:
> Unneeded variable: "disable". Return "0ULL" on line 90.
> drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c:35:5-12:
> Unneeded variable: "disable". Return "0ULL" on line 44.
> drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c:35:5-12:
> Unneeded variable: "disable". Return "0ULL" on line 50.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c   | 3 +--
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c | 3 +--
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c
> index 05729ca19e9a..8977483a9f42 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c
> @@ -32,7 +32,6 @@ g98_devinit_disable(struct nvkm_devinit *init)
>         struct nvkm_device *device = init->subdev.device;
>         u32 r001540 = nvkm_rd32(device, 0x001540);
>         u32 r00154c = nvkm_rd32(device, 0x00154c);
> -       u64 disable = 0ULL;
>  
>         if (!(r001540 & 0x40000000)) {
>                 nvkm_subdev_disable(device, NVKM_ENGINE_MSPDEC, 0);
> @@ -47,7 +46,7 @@ g98_devinit_disable(struct nvkm_devinit *init)
>         if (!(r00154c & 0x00000040))
>                 nvkm_subdev_disable(device, NVKM_ENGINE_SEC, 0);
>  
> -       return disable;
> +       return 0ULL;
>  }
>  
>  static const struct nvkm_devinit_func
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> index 051cfd6a5caf..5b7cb1fe7897 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> @@ -68,7 +68,6 @@ gf100_devinit_disable(struct nvkm_devinit *init)
>  {
>         struct nvkm_device *device = init->subdev.device;
>         u32 r022500 = nvkm_rd32(device, 0x022500);
> -       u64 disable = 0ULL;
>  
>         if (r022500 & 0x00000001)
>                 nvkm_subdev_disable(device, NVKM_ENGINE_DISP, 0);
> @@ -87,7 +86,7 @@ gf100_devinit_disable(struct nvkm_devinit *init)
>         if (r022500 & 0x00000200)
>                 nvkm_subdev_disable(device, NVKM_ENGINE_CE, 1);
>  
> -       return disable;
> +       return 0ULL;
>  }
>  
>  void
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c
> index 4323732a3cb2..8955af2704c7 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c
> @@ -32,7 +32,6 @@ gm107_devinit_disable(struct nvkm_devinit *init)
>         struct nvkm_device *device = init->subdev.device;
>         u32 r021c00 = nvkm_rd32(device, 0x021c00);
>         u32 r021c04 = nvkm_rd32(device, 0x021c04);
> -       u64 disable = 0ULL;
>  
>         if (r021c00 & 0x00000001)
>                 nvkm_subdev_disable(device, NVKM_ENGINE_CE, 0);
> @@ -41,7 +40,7 @@ gm107_devinit_disable(struct nvkm_devinit *init)
>         if (r021c04 & 0x00000001)
>                 nvkm_subdev_disable(device, NVKM_ENGINE_DISP, 0);
>  
> -       return disable;
> +       return 0ULL;
>  }
>  
>  static const struct nvkm_devinit_func

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

