Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7BB4CDE2F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiCDUZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiCDUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A55D1EEFA2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646425481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQnecUCi6JtX5H2+Imm8lSOq7dsr4zLE9x/tjqn4RLU=;
        b=O38MfvyxBDsUXq1TBlYVClS8SYW3ktH0MgSpbRLGRWidWv4YD5S7CfTFhy/rlGu+fJWiWA
        7t27UfJsiIxRTUAsrgAeBLgruQwLLMvlqoVAAcYonsO7RQDJUdrRfGS3BKAmU5x0ghgUDD
        OopYnJYAW/g7bxt7fhx+FFgnY6KQBJQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-2VXWT9WyMmq1k_3mwInDPA-1; Fri, 04 Mar 2022 15:24:39 -0500
X-MC-Unique: 2VXWT9WyMmq1k_3mwInDPA-1
Received: by mail-qv1-f71.google.com with SMTP id kd18-20020a056214401200b0042de5c14702so7775913qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=qQnecUCi6JtX5H2+Imm8lSOq7dsr4zLE9x/tjqn4RLU=;
        b=d5E42rarpj53BIdteDNRj/ITKjTwtIdmrTKtjWgD2rEMH7Nt/gdcl4jG8/co1dBUxC
         PPofMXLht53ptAbCZvA27dF0T4iwEx5U1dPfAzz7azTsP6o6EITnREWDqO9mmYz/XMiB
         H5/UF9elSSqcCjONqr65Wiu9KW0pPt9m65gt1MWtWM7jlT/ic5khi9SVNqfrV0vDScii
         n0t40BXO5H9OEc+/exD+con27cOq/nxWlEM/p87hckJ3UrqlcecDc1CBG1NmShcPpiyo
         MfaA7biu4hQSpetsMYrF7lodGTZvLUZ1JXR+0EILc9wsUEXwgFVqNKpsNY1MLCe9z2QX
         rRKA==
X-Gm-Message-State: AOAM531CDZK0DCPqxZD9OsyakB50NLc6td59HipzmggytU8UaKv8l1gJ
        xLfv8IA59yx/7tyF11swhQVEhd7W3sUlY26JIX9e6GoNcKM/eHLQQpfjJZiPC9XSVN4+QcUg+4N
        aZ0m29ZFxl/9MTrd4xM//xaJh
X-Received: by 2002:a37:492:0:b0:47d:e1d1:baca with SMTP id 140-20020a370492000000b0047de1d1bacamr248068qke.247.1646425479094;
        Fri, 04 Mar 2022 12:24:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgLMhureMazbApcHxoId0ovHTPxZ6IY2TMXkHtaF62KtRhKSEPCfFTIpWUImpKhXu+6GtUPg==
X-Received: by 2002:a37:492:0:b0:47d:e1d1:baca with SMTP id 140-20020a370492000000b0047de1d1bacamr248054qke.247.1646425478849;
        Fri, 04 Mar 2022 12:24:38 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net. [96.230.100.15])
        by smtp.gmail.com with ESMTPSA id y16-20020a37e310000000b00648c706dda1sm2874739qki.6.2022.03.04.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:24:38 -0800 (PST)
Message-ID: <47e09d6010852db928c0de29b89450ea7eee74d8.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/bios: Rename prom_init() and friends
 functions
From:   Lyude Paul <lyude@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Mar 2022 15:24:37 -0500
In-Reply-To: <2d97ae92b9c06214be0e088a72cf303eb591bf01.1646414295.git.christophe.leroy@csgroup.eu>
References: <2d97ae92b9c06214be0e088a72cf303eb591bf01.1646414295.git.christophe.leroy@csgroup.eu>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mostly looks good to me. Just one question (and one comment down below
that needs addressing). Is this with ppc32? (I ask because ppc64le doesn't
seem to hit this compilation error).

On Fri, 2022-03-04 at 18:20 +0100, Christophe Leroy wrote:
> While working on powerpc headers, I ended up with the following error.
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
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> index ffa4b395220a..9c951e90e622 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> @@ -25,7 +25,7 @@
>  #include <subdev/pci.h>
>  
>  static u32
> -prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
> +nvbios_rom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
>  {
>         struct nvkm_device *device = data;
>         u32 i;
> @@ -38,14 +38,14 @@ prom_read(void *data, u32 offset, u32 length, struct
> nvkm_bios *bios)
>  }
>  
>  static void
> -prom_fini(void *data)
> +nvbios_rom_fini(void *data)
>  {
>         struct nvkm_device *device = data;
>         nvkm_pci_rom_shadow(device->pci, true);
>  }
>  
>  static void *
> -prom_init(struct nvkm_bios *bios, const char *name)
> +nvbios_rom_init(struct nvkm_bios *bios, const char *name)
>  {
>         struct nvkm_device *device = bios->subdev.device;
>         if (device->card_type == NV_40 && device->chipset >= 0x4c)
> @@ -57,8 +57,8 @@ prom_init(struct nvkm_bios *bios, const char *name)
>  const struct nvbios_source
>  nvbios_rom = {
>         .name = "PROM",
> -       .init = prom_init,
> -       .fini = prom_fini,
> -       .read = prom_read,
> +       .init = nvbios_rom_init,
> +       .fini = nvbios_rom_fini,
> +       .read = nvbios_rom_read,

Seeing as the source name is prom, I think using the naming convention
nvbios_prom_* would be better then nvbios_rom_*.

>         .rw = false,
>  };

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

