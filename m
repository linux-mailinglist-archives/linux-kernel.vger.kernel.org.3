Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B689543DD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiFHUvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiFHUvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C2DF11045C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654721499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbMyK7TZQftKTG3O3T1f3sHboTsvCwRpAGDUWPiFV1k=;
        b=MarAa6tH1/H2ynDWOEtQooksqez0mWauMY8yDToI1lq49yRXU8wY4kBIdcUalbmLAyLvT9
        JoAjtiRX9WjvEumDsce6DNoTq3k6/VA6ZxlmxmhOr8zMV5MoNq4FyrQIFF2Cm+WqFxdDh7
        Sp81PDRZXoAl0DIh2cmAHPYaqgS/nHY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-LoA_2CL_NFqboymF1q1PFA-1; Wed, 08 Jun 2022 16:51:37 -0400
X-MC-Unique: LoA_2CL_NFqboymF1q1PFA-1
Received: by mail-qk1-f198.google.com with SMTP id c8-20020a05620a268800b0069c0f1b3206so17540094qkp.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 13:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=bbMyK7TZQftKTG3O3T1f3sHboTsvCwRpAGDUWPiFV1k=;
        b=ic7ivGB7Bfk2BGt1qsJWhtddNEO9BYujJqPU9Wz9koM3+r4Stul1+I8lvXdPxBbBkZ
         sv0uDmZPewfNvBZAqhu76ehUXeUvzx/cQWBM6Klc29F9+lObXqgTd9Oq6fLIhxPHtKVe
         +2VwBWC7/mtd243NI4OcSsWZg5VTTU7PaX2JPE9++6TlbymYHDlhhO0tNVhwhiHeSh6C
         uny0d5DQyesDILP6EYDsLviPr9lfW0Rw9cwClNLR3dZVLH+1GNdEpkb0Sa8j32lRXPwu
         mlMjZRRfl9bB0oc//timFTb9/fWoKyFHGQ/6QOHpujc8dsFG2Zhv/jNuEKKPO1Xe2/F6
         dvIg==
X-Gm-Message-State: AOAM530axquRTEXmJ97qdSNRk2XnfKW67zTdjFrLWbyx9LwBLXhKAYOl
        whclTBBdoRBGtpdCern1uE59xdU9dEMG2RPuw20sm1IuaP3wyDrd50GnNJ8zJAd0Bobr1oRj924
        eJXZBcUVtnFClnlc2bdB8XXRH
X-Received: by 2002:a05:620a:240a:b0:6a6:b841:a635 with SMTP id d10-20020a05620a240a00b006a6b841a635mr12580520qkn.689.1654721495648;
        Wed, 08 Jun 2022 13:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw563j9Ikgp8UZy2o2Gq0mZYMB0zAtGvX1GX/jgOO02fGrg6IbIAPJH0fNtTotm//aCk+tO/A==
X-Received: by 2002:a05:620a:240a:b0:6a6:b841:a635 with SMTP id d10-20020a05620a240a00b006a6b841a635mr12580506qkn.689.1654721495392;
        Wed, 08 Jun 2022 13:51:35 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a268300b006a6be577535sm8283564qkp.85.2022.06.08.13.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 13:51:34 -0700 (PDT)
Message-ID: <f548e6d03daf6c56cd011bd1a9ce46001e93590c.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau/bios: Rename prom_init() and friends
 functions
From:   Lyude Paul <lyude@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Jun 2022 16:51:33 -0400
In-Reply-To: <8c6e570f5e65e4f5abebc136d40d567e9af4f940.camel@redhat.com>
References: <7e0612b61511ec8030e3b2dcbfaa7751781c8b91.1647684507.git.christophe.leroy@csgroup.eu>
         <f6e72c6e6d9ae9019ad675081493372f745cbbf5.camel@redhat.com>
         <8735ggeih2.fsf@mpe.ellerman.id.au>
         <8c6e570f5e65e4f5abebc136d40d567e9af4f940.camel@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, dim's pushing it now. sorry about that!

On Wed, 2022-06-08 at 16:48 -0400, Lyude Paul wrote:
> Whoops, it totally may have. Thank you for the reminder, I will double check
> and make sure this gets pushed today
> 
> On Tue, 2022-06-07 at 23:00 +1000, Michael Ellerman wrote:
> > Lyude Paul <lyude@redhat.com> writes:
> > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > 
> > > Will push to drm-misc-next
> > 
> > I don't see this patch in mainline or drm-misc-next, did it get lost?
> > 
> > cheers
> > 
> > > On Sat, 2022-03-19 at 11:27 +0100, Christophe Leroy wrote:
> > > > While working at fixing powerpc headers, I ended up with the
> > > > following error.
> > > > 
> > > >         drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c:48:1:
> > > > error:
> > > > conflicting types for 'prom_init'; have 'void *(struct nvkm_bios *,
> > > > const
> > > > char *)'
> > > >         make[5]: *** [scripts/Makefile.build:288:
> > > > drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.o] Error 1
> > > > 
> > > > powerpc and a few other architectures have a prom_init() global
> > > > function.
> > > > One day or another it will conflict with the one in shadowrom.c
> > > > 
> > > > Those being static, they can easily be renamed. Do it.
> > > > 
> > > > While at it, also rename the ops structure as 'nvbios_prom' instead of
> > > > 'nvbios_rom' in order to make it clear that it refers to the
> > > > NV_PROM device.
> > > > 
> > > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > > ---
> > > > v2: using nvbios_prom prefix instead of nvbios_rom. Changed structure
> > > > name
> > > > to keep things consistant.
> > > > 
> > > >  drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h    |  2 +-
> > > >  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |  2 +-
> > > >  .../gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c   | 14 +++++++------
> > > > -
> > > >  3 files changed, 9 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> > > > index fac1bff1311b..cfa8a0c356dd 100644
> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> > > > @@ -19,7 +19,7 @@ struct nvbios_source {
> > > >  int nvbios_extend(struct nvkm_bios *, u32 length);
> > > >  int nvbios_shadow(struct nvkm_bios *);
> > > >  
> > > > -extern const struct nvbios_source nvbios_rom;
> > > > +extern const struct nvbios_source nvbios_prom;
> > > >  extern const struct nvbios_source nvbios_ramin;
> > > >  extern const struct nvbios_source nvbios_acpi_fast;
> > > >  extern const struct nvbios_source nvbios_acpi_slow;
> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> > > > index 4b571cc6bc70..19188683c8fc 100644
> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> > > > @@ -171,7 +171,7 @@ nvbios_shadow(struct nvkm_bios *bios)
> > > >         struct shadow mthds[] = {
> > > >                 { 0, &nvbios_of },
> > > >                 { 0, &nvbios_ramin },
> > > > -               { 0, &nvbios_rom },
> > > > +               { 0, &nvbios_prom },
> > > >                 { 0, &nvbios_acpi_fast },
> > > >                 { 4, &nvbios_acpi_slow },
> > > >                 { 1, &nvbios_pcirom },
> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> > > > index ffa4b395220a..39144ceb117b 100644
> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> > > > @@ -25,7 +25,7 @@
> > > >  #include <subdev/pci.h>
> > > >  
> > > >  static u32
> > > > -prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
> > > > +nvbios_prom_read(void *data, u32 offset, u32 length, struct nvkm_bios
> > > > *bios)
> > > >  {
> > > >         struct nvkm_device *device = data;
> > > >         u32 i;
> > > > @@ -38,14 +38,14 @@ prom_read(void *data, u32 offset, u32 length,
> > > > struct
> > > > nvkm_bios *bios)
> > > >  }
> > > >  
> > > >  static void
> > > > -prom_fini(void *data)
> > > > +nvbios_prom_fini(void *data)
> > > >  {
> > > >         struct nvkm_device *device = data;
> > > >         nvkm_pci_rom_shadow(device->pci, true);
> > > >  }
> > > >  
> > > >  static void *
> > > > -prom_init(struct nvkm_bios *bios, const char *name)
> > > > +nvbios_prom_init(struct nvkm_bios *bios, const char *name)
> > > >  {
> > > >         struct nvkm_device *device = bios->subdev.device;
> > > >         if (device->card_type == NV_40 && device->chipset >= 0x4c)
> > > > @@ -55,10 +55,10 @@ prom_init(struct nvkm_bios *bios, const char
> > > > *name)
> > > >  }
> > > >  
> > > >  const struct nvbios_source
> > > > -nvbios_rom = {
> > > > +nvbios_prom = {
> > > >         .name = "PROM",
> > > > -       .init = prom_init,
> > > > -       .fini = prom_fini,
> > > > -       .read = prom_read,
> > > > +       .init = nvbios_prom_init,
> > > > +       .fini = nvbios_prom_fini,
> > > > +       .read = nvbios_prom_read,
> > > >         .rw = false,
> > > >  };
> > > 
> > > -- 
> > > Cheers,
> > >  Lyude Paul (she/her)
> > >  Software Engineer at Red Hat
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

