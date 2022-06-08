Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C9543DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiFHUst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiFHUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05A69EC3D6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654721318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clHxW3sgfzzmzoMvOGIzcMmgsX8xQLBmlm21w7Tbfi4=;
        b=YQ8cW5qT5UGXdUThhOeM3EHmGjuwjZZcrkQ6XLHMa0eln85VKlQP+5VotO1hIRrCqI37Vh
        S0FyTbbQeR16M2tPgMGgd8WtFmc4PyGxSDRzv9fi3zBcqajl3taws4q5kUmYQrrF5QXYIh
        8oHpUSYkNAhPWtMFVCsszO4qDMAnIkE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-WX-7R6BDMSuI8z11e0pyrQ-1; Wed, 08 Jun 2022 16:48:37 -0400
X-MC-Unique: WX-7R6BDMSuI8z11e0pyrQ-1
Received: by mail-qk1-f197.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso17537152qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 13:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=clHxW3sgfzzmzoMvOGIzcMmgsX8xQLBmlm21w7Tbfi4=;
        b=7Upn0y+y55hLUIU+il8s48/TBMk+rw/Qe5Wh9v5v42/mK8l9TLlOBEr50D3sQ6NScx
         LQsEhbl46cvpUNLA9zJBYf3IK3xIwfgD8dcLNua1iRvSU8BIkQduuuF1isiLZTvHuLHi
         qBmJpr3RzwlIQl/yUmSC9m8czeCdA2AN3Mab/ugJxJA/6STKjZlxpCwIzVwn2ShliB1D
         Nz+GaypQ/nCTsiW9o/0dDXd9CuEZaCfOi6vae2c81I9IJYUcWl5+kJFYHdv2KSaNHy6y
         C0s5jhD0446JsNCHWCe/Bu7ldkRXxKRY8+qYYIsLGUICpCdXO91gIJv0b18JprFxt7Oi
         yXBA==
X-Gm-Message-State: AOAM532Wb4MJ23ei2VV9OfrG2uwdEHwVZeEbhWqAsNTvvX5L5oRm0bdc
        LDJM92GXSmvd5/sAqu8kIqtYmLDOwfupaHq24r5xutCYr42ITW3IpEpC138RIUGX8r4c/CrRZyE
        TigegFtrVR+znWGQ/ZsQw0Ug2
X-Received: by 2002:a05:620a:1792:b0:6a6:c734:d983 with SMTP id ay18-20020a05620a179200b006a6c734d983mr10766260qkb.682.1654721316180;
        Wed, 08 Jun 2022 13:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4yQbEU3fDKosIS7kn5Gst5/farh3YaMGcVhxk0pUHaesd9XyYZl1qpwf5KBt+5Wbey6VZiQ==
X-Received: by 2002:a05:620a:1792:b0:6a6:c734:d983 with SMTP id ay18-20020a05620a179200b006a6c734d983mr10766244qkb.682.1654721315912;
        Wed, 08 Jun 2022 13:48:35 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id de13-20020a05620a370d00b006a6d7c3a82esm4812257qkb.15.2022.06.08.13.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 13:48:35 -0700 (PDT)
Message-ID: <8c6e570f5e65e4f5abebc136d40d567e9af4f940.camel@redhat.com>
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
Date:   Wed, 08 Jun 2022 16:48:34 -0400
In-Reply-To: <8735ggeih2.fsf@mpe.ellerman.id.au>
References: <7e0612b61511ec8030e3b2dcbfaa7751781c8b91.1647684507.git.christophe.leroy@csgroup.eu>
         <f6e72c6e6d9ae9019ad675081493372f745cbbf5.camel@redhat.com>
         <8735ggeih2.fsf@mpe.ellerman.id.au>
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

Whoops, it totally may have. Thank you for the reminder, I will double check
and make sure this gets pushed today

On Tue, 2022-06-07 at 23:00 +1000, Michael Ellerman wrote:
> Lyude Paul <lyude@redhat.com> writes:
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > 
> > Will push to drm-misc-next
> 
> I don't see this patch in mainline or drm-misc-next, did it get lost?
> 
> cheers
> 
> > On Sat, 2022-03-19 at 11:27 +0100, Christophe Leroy wrote:
> > > While working at fixing powerpc headers, I ended up with the
> > > following error.
> > > 
> > >         drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c:48:1:
> > > error:
> > > conflicting types for 'prom_init'; have 'void *(struct nvkm_bios *,
> > > const
> > > char *)'
> > >         make[5]: *** [scripts/Makefile.build:288:
> > > drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.o] Error 1
> > > 
> > > powerpc and a few other architectures have a prom_init() global
> > > function.
> > > One day or another it will conflict with the one in shadowrom.c
> > > 
> > > Those being static, they can easily be renamed. Do it.
> > > 
> > > While at it, also rename the ops structure as 'nvbios_prom' instead of
> > > 'nvbios_rom' in order to make it clear that it refers to the
> > > NV_PROM device.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > > v2: using nvbios_prom prefix instead of nvbios_rom. Changed structure
> > > name
> > > to keep things consistant.
> > > 
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h    |  2 +-
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |  2 +-
> > >  .../gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c   | 14 +++++++-------
> > >  3 files changed, 9 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> > > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> > > index fac1bff1311b..cfa8a0c356dd 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> > > @@ -19,7 +19,7 @@ struct nvbios_source {
> > >  int nvbios_extend(struct nvkm_bios *, u32 length);
> > >  int nvbios_shadow(struct nvkm_bios *);
> > >  
> > > -extern const struct nvbios_source nvbios_rom;
> > > +extern const struct nvbios_source nvbios_prom;
> > >  extern const struct nvbios_source nvbios_ramin;
> > >  extern const struct nvbios_source nvbios_acpi_fast;
> > >  extern const struct nvbios_source nvbios_acpi_slow;
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> > > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> > > index 4b571cc6bc70..19188683c8fc 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> > > @@ -171,7 +171,7 @@ nvbios_shadow(struct nvkm_bios *bios)
> > >         struct shadow mthds[] = {
> > >                 { 0, &nvbios_of },
> > >                 { 0, &nvbios_ramin },
> > > -               { 0, &nvbios_rom },
> > > +               { 0, &nvbios_prom },
> > >                 { 0, &nvbios_acpi_fast },
> > >                 { 4, &nvbios_acpi_slow },
> > >                 { 1, &nvbios_pcirom },
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> > > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> > > index ffa4b395220a..39144ceb117b 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> > > @@ -25,7 +25,7 @@
> > >  #include <subdev/pci.h>
> > >  
> > >  static u32
> > > -prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
> > > +nvbios_prom_read(void *data, u32 offset, u32 length, struct nvkm_bios
> > > *bios)
> > >  {
> > >         struct nvkm_device *device = data;
> > >         u32 i;
> > > @@ -38,14 +38,14 @@ prom_read(void *data, u32 offset, u32 length, struct
> > > nvkm_bios *bios)
> > >  }
> > >  
> > >  static void
> > > -prom_fini(void *data)
> > > +nvbios_prom_fini(void *data)
> > >  {
> > >         struct nvkm_device *device = data;
> > >         nvkm_pci_rom_shadow(device->pci, true);
> > >  }
> > >  
> > >  static void *
> > > -prom_init(struct nvkm_bios *bios, const char *name)
> > > +nvbios_prom_init(struct nvkm_bios *bios, const char *name)
> > >  {
> > >         struct nvkm_device *device = bios->subdev.device;
> > >         if (device->card_type == NV_40 && device->chipset >= 0x4c)
> > > @@ -55,10 +55,10 @@ prom_init(struct nvkm_bios *bios, const char *name)
> > >  }
> > >  
> > >  const struct nvbios_source
> > > -nvbios_rom = {
> > > +nvbios_prom = {
> > >         .name = "PROM",
> > > -       .init = prom_init,
> > > -       .fini = prom_fini,
> > > -       .read = prom_read,
> > > +       .init = nvbios_prom_init,
> > > +       .fini = nvbios_prom_fini,
> > > +       .read = nvbios_prom_read,
> > >         .rw = false,
> > >  };
> > 
> > -- 
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

