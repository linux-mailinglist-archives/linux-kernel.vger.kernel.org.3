Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27CA51068B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353683AbiDZSTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353670AbiDZSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97EA231377
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650996944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eKECW1gDIo2Gn5I+8eJ141sOgh784fCDwHXtewOPik=;
        b=WnYJPFovWzmX5IT3WNoM03+055IDD65N38FxObcXVB/PV+eGcGosnA4+rYqH3ikVrChp2I
        oNfG8Gc4KRtl9S3Tw0HboO9Rs8G1PiGRbUkHyilES0kz+ucCh2NRcf/PBmD9X47fXKvVCY
        4GqZ+ejRzDiUy2Bn5X9yJY5i7AcksBM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-Qn9jT4RmN9aKjMuKdivEmw-1; Tue, 26 Apr 2022 14:15:43 -0400
X-MC-Unique: Qn9jT4RmN9aKjMuKdivEmw-1
Received: by mail-qv1-f70.google.com with SMTP id u19-20020ad449b3000000b004523cc11b95so10253115qvx.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=5eKECW1gDIo2Gn5I+8eJ141sOgh784fCDwHXtewOPik=;
        b=fTTH1+kIEYhb6gzZ4zWlS2nWiLhGcx/ogUYqlNG0/DtnJ5OE3e9yyrcEZtHaB6K/2d
         KZHAFWSPDCoVmgHZRSqqv4qejdIYoJsAu8Vh5CPr+xlUuWJBq4IVmmYTuHMGAX0gUth/
         jop30XmPo5LplIco5EFNIfIlHDLHKK2of27Odrz/RruvM8LnxxpjOX8Hw9oW2g3jtukl
         2At0BKedSY0Wd5sPb7ULA+9fKjDjxau7izNVmIES10fhohG26MRhwKISEGlWPS7Lhg/7
         QpUcZCAFJrJuCuce4/gPprEI7cG3JSYrg2sgYjES5g7tfTUm4ZPkXrLLYIZsv3sZ/lVD
         SLVQ==
X-Gm-Message-State: AOAM533o9bUlC/FUBmNctUPlFlV/OgVuTfZ2ceyxsEjvYTrtA2u6fS5m
        ZD79ojG8KqickqTJtyj8GDHm9GM+0BsQUEaYknWrFElQ01jGww2FMx4zEu1kIG08TIexXe535Et
        WDzrDV9FI1mcJc1znL5Fpko3H
X-Received: by 2002:a05:622a:13:b0:2f3:64ce:c72a with SMTP id x19-20020a05622a001300b002f364cec72amr8826935qtw.620.1650996942657;
        Tue, 26 Apr 2022 11:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1e4/M/au78sjUpZYL6OJmbQ+wWx6rD4GopCcbIHg0y7+HfqjhyaKxpYxh4L66r+tD+2xJhA==
X-Received: by 2002:a05:622a:13:b0:2f3:64ce:c72a with SMTP id x19-20020a05622a001300b002f364cec72amr8826912qtw.620.1650996942425;
        Tue, 26 Apr 2022 11:15:42 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm8103969qtx.72.2022.04.26.11.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:15:41 -0700 (PDT)
Message-ID: <6fb203ca8182c50156fdc7655146c803a3f22b05.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: fix returnvar.cocci warning
From:   Lyude Paul <lyude@redhat.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
Date:   Tue, 26 Apr 2022 14:15:40 -0400
In-Reply-To: <20220425114701.7182-1-guozhengkui@vivo.com>
References: <20220425114701.7182-1-guozhengkui@vivo.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in a moment

On Mon, 2022-04-25 at 19:47 +0800, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c:71:5-12:
> Unneeded variable: "disable". Return "0ULL" on line 85.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c
> index dc026ac1b595..3d0ab86c3115 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c
> @@ -68,7 +68,6 @@ gt215_devinit_disable(struct nvkm_devinit *init)
>         struct nvkm_device *device = init->subdev.device;
>         u32 r001540 = nvkm_rd32(device, 0x001540);
>         u32 r00154c = nvkm_rd32(device, 0x00154c);
> -       u64 disable = 0ULL;
>  
>         if (!(r001540 & 0x40000000)) {
>                 nvkm_subdev_disable(device, NVKM_ENGINE_MSPDEC, 0);
> @@ -82,7 +81,7 @@ gt215_devinit_disable(struct nvkm_devinit *init)
>         if (!(r00154c & 0x00000200))
>                 nvkm_subdev_disable(device, NVKM_ENGINE_CE, 0);
>  
> -       return disable;
> +       return 0ULL;
>  }
>  
>  static u32

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

