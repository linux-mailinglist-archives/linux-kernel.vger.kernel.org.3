Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1936D4E45F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbiCVS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbiCVS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 163529134D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647973527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXgow+Fz8VabLqwfX1YnqBgMgAP8Ti50IVG/j8LoHic=;
        b=IuV/wIVN70hk/ql4WzWrrM11mjj8ZKkgjsRcu+C5TLjWehVyfVZUxLmLapNWpL7yPl4U2b
        WKVODo31YOOTNbypeuWRZO1sOcUteV2wec+SNuvy2o9uVVZ01OZAPuFmiMTGtkLOJc5atN
        uuE1V6tGYbtS/E/uHDyu/A4J2jWwavI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-EtiWy3zhN4-xG14pr2xyQA-1; Tue, 22 Mar 2022 14:25:26 -0400
X-MC-Unique: EtiWy3zhN4-xG14pr2xyQA-1
Received: by mail-qt1-f198.google.com with SMTP id y23-20020ac85257000000b002e06697f2ebso12197769qtn.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=rXgow+Fz8VabLqwfX1YnqBgMgAP8Ti50IVG/j8LoHic=;
        b=haO6H51OWTFQm0xzbzBHQ5bW9kwJofZ+U3aSeNJqgLoGYWf8cu8umDAOPCy0mr5Ngt
         8uEwMCbYi1/6J6RsCDH5qBDaGN1C/JLRArVRLdSqDkpfxHQb2bgFuZCSJkCCf/ni9AUZ
         5fNac3Il3ymRGPkoYUR7ihcGJ6NBVr/SfLd5c1BftNIYNugCRui4aC7wErBxIQ2HifjF
         zf/qxF6/fG5sKNIxMtIwTKuBUDPixpXHjUPNT6tcGXMBDM4n9gQFLk58l34qkPaCqsrK
         YMIVDCtBk/tIo9SzB0DGnUA1vsxo+o4nJyghdYKOIE/e0D1CuyU+/4CmEC8cDo8ZeYV/
         Y6lQ==
X-Gm-Message-State: AOAM531SwmST1FkrX6Io1TA44qWLLd5jwIEJNFhk0P1SKa0wzlHMZfUp
        2jX2MxYaKFGbyDezubiQo2N8y3tC9Empxpi3AbbSvUlEdyMHcHtlu2TYB4OMQeNdpt1ibJHI4Gk
        bT2P5Z3CQJbvwO6t0pTVIzQh9
X-Received: by 2002:a05:6214:29ef:b0:441:4a7a:4c9e with SMTP id jv15-20020a05621429ef00b004414a7a4c9emr2654878qvb.119.1647973525189;
        Tue, 22 Mar 2022 11:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6T8sOKqIqpt6ZuCZug9+YoVTnq3+e/xMkvpjYvSkbwVcTedcsYTtRt1S+tnn4xKVvozA1LQ==
X-Received: by 2002:a05:6214:29ef:b0:441:4a7a:4c9e with SMTP id jv15-20020a05621429ef00b004414a7a4c9emr2654861qvb.119.1647973524924;
        Tue, 22 Mar 2022 11:25:24 -0700 (PDT)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net. [96.230.100.15])
        by smtp.gmail.com with ESMTPSA id i7-20020ac85e47000000b002e22bad4717sm525995qtx.1.2022.03.22.11.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:25:24 -0700 (PDT)
Message-ID: <f6e72c6e6d9ae9019ad675081493372f745cbbf5.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau/bios: Rename prom_init() and friends
 functions
From:   Lyude Paul <lyude@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Mar 2022 14:25:22 -0400
In-Reply-To: <7e0612b61511ec8030e3b2dcbfaa7751781c8b91.1647684507.git.christophe.leroy@csgroup.eu>
References: <7e0612b61511ec8030e3b2dcbfaa7751781c8b91.1647684507.git.christophe.leroy@csgroup.eu>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next

On Sat, 2022-03-19 at 11:27 +0100, Christophe Leroy wrote:
> While working at fixing powerpc headers, I ended up with the
> following error.
> 
>         drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c:48:1: error:
> conflicting types for 'prom_init'; have 'void *(struct nvkm_bios *, const
> char *)'
>         make[5]: *** [scripts/Makefile.build:288:
> drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.o] Error 1
> 
> powerpc and a few other architectures have a prom_init() global function.
> One day or another it will conflict with the one in shadowrom.c
> 
> Those being static, they can easily be renamed. Do it.
> 
> While at it, also rename the ops structure as 'nvbios_prom' instead of
> 'nvbios_rom' in order to make it clear that it refers to the
> NV_PROM device.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: using nvbios_prom prefix instead of nvbios_rom. Changed structure name
> to keep things consistant.
> 
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h    |  2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |  2 +-
>  .../gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c   | 14 +++++++-------
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> index fac1bff1311b..cfa8a0c356dd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> @@ -19,7 +19,7 @@ struct nvbios_source {
>  int nvbios_extend(struct nvkm_bios *, u32 length);
>  int nvbios_shadow(struct nvkm_bios *);
>  
> -extern const struct nvbios_source nvbios_rom;
> +extern const struct nvbios_source nvbios_prom;
>  extern const struct nvbios_source nvbios_ramin;
>  extern const struct nvbios_source nvbios_acpi_fast;
>  extern const struct nvbios_source nvbios_acpi_slow;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> index 4b571cc6bc70..19188683c8fc 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> @@ -171,7 +171,7 @@ nvbios_shadow(struct nvkm_bios *bios)
>         struct shadow mthds[] = {
>                 { 0, &nvbios_of },
>                 { 0, &nvbios_ramin },
> -               { 0, &nvbios_rom },
> +               { 0, &nvbios_prom },
>                 { 0, &nvbios_acpi_fast },
>                 { 4, &nvbios_acpi_slow },
>                 { 1, &nvbios_pcirom },
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> index ffa4b395220a..39144ceb117b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> @@ -25,7 +25,7 @@
>  #include <subdev/pci.h>
>  
>  static u32
> -prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
> +nvbios_prom_read(void *data, u32 offset, u32 length, struct nvkm_bios
> *bios)
>  {
>         struct nvkm_device *device = data;
>         u32 i;
> @@ -38,14 +38,14 @@ prom_read(void *data, u32 offset, u32 length, struct
> nvkm_bios *bios)
>  }
>  
>  static void
> -prom_fini(void *data)
> +nvbios_prom_fini(void *data)
>  {
>         struct nvkm_device *device = data;
>         nvkm_pci_rom_shadow(device->pci, true);
>  }
>  
>  static void *
> -prom_init(struct nvkm_bios *bios, const char *name)
> +nvbios_prom_init(struct nvkm_bios *bios, const char *name)
>  {
>         struct nvkm_device *device = bios->subdev.device;
>         if (device->card_type == NV_40 && device->chipset >= 0x4c)
> @@ -55,10 +55,10 @@ prom_init(struct nvkm_bios *bios, const char *name)
>  }
>  
>  const struct nvbios_source
> -nvbios_rom = {
> +nvbios_prom = {
>         .name = "PROM",
> -       .init = prom_init,
> -       .fini = prom_fini,
> -       .read = prom_read,
> +       .init = nvbios_prom_init,
> +       .fini = nvbios_prom_fini,
> +       .read = nvbios_prom_read,
>         .rw = false,
>  };

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

