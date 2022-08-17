Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D0596702
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiHQBtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiHQBtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7B5E324
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660700942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2TVY8TMJPxioaZBXVec5JdNU9LSGZ0P5etQctTE53pw=;
        b=fIbenng1hgeLy1jyLghgh4grmwgK/NYJaA6yO8uNVm5oDw7VzxPFELpuYSe87U/eTOjbss
        6qgjjhVetLD56wuWHXdowTazrVSGSewNIE5kWHAsyFcW8D8wMVZ30D9fiqREdW2HTh4VeS
        7Vz0bI59qqxzuwnh/xtzScRW1aFoP3o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-SAtIRu-YMkOo7F7ZQPFXew-1; Tue, 16 Aug 2022 21:49:01 -0400
X-MC-Unique: SAtIRu-YMkOo7F7ZQPFXew-1
Received: by mail-qv1-f71.google.com with SMTP id o6-20020ad443c6000000b00495d04028a6so1453544qvs.18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2TVY8TMJPxioaZBXVec5JdNU9LSGZ0P5etQctTE53pw=;
        b=ht/5k72ReyFwWBmgywTMbQlG3SPSFiwBmWebd0rip8oLHpDEKn9a2qjmC7uZWazf4J
         XFp81OK7ffFWj4YtsmpHl8ncaoHv6fkcclh1hJ+UT22PRb+nCVvIcpIXg8ryk1FJr0zi
         PD+eVIaZ/Tc8Ebw41l72UBELWXurVABF4aFBD0eEwv4QnVPTl7a/6dronISJ/1uGmqST
         FTKl6hC80tUl6KBepWqRnJg/19TThR5XMYukwfvU+jiq9a0bk68nroI2s5Tc+JMfQa10
         1vevTNYTaTpOBjuCIkULCAKNI26OaYxmOEonPW4LHj+tosXvn50cop/YkY/JhT0/7ayb
         anIA==
X-Gm-Message-State: ACgBeo1DPWI4sgL8oQExo4gpp7tg9JK4yBZasS9wq6420G15XS97LxbX
        uHO0g2P4As31TQO04McWS4f/kcKN4rEQD6xm6h9zsgyIX5FN6lVyiH8jPoTYVSLp0J1iTgaacNy
        ttzNp6O1bnwXWKGAL6NOqbhfAVkvr4L0JW05vduJL
X-Received: by 2002:a05:622a:53:b0:344:6f46:9b16 with SMTP id y19-20020a05622a005300b003446f469b16mr5792711qtw.664.1660700941234;
        Tue, 16 Aug 2022 18:49:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4gHCrR40uV7QffHRDW/lFTeHdJ8qvvyniB8BpRcxgy0lUxNzSjdlNT4AIgpmsDR0LEaZfQGdV3c0pKtV+DBlM=
X-Received: by 2002:a05:622a:53:b0:344:6f46:9b16 with SMTP id
 y19-20020a05622a005300b003446f469b16mr5792703qtw.664.1660700940947; Tue, 16
 Aug 2022 18:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
 <CACO55tt=Op=0E94kK+1M8cDXNCk5Tkc=FMR8=OQFc5ohehjwaw@mail.gmail.com> <CAAd53p49X95MKrTDUq92LuHw3y2i09fUA2HEPzM1EcO8xO97Eg@mail.gmail.com>
In-Reply-To: <CAAd53p49X95MKrTDUq92LuHw3y2i09fUA2HEPzM1EcO8xO97Eg@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 17 Aug 2022 03:48:50 +0200
Message-ID: <CACO55tvgmb4Vog701idDYGuh125S9mjWPXhftxDMZ7hg-nQXBw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when it's supported
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 3:18 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Wed, Aug 17, 2022 at 2:50 AM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Tue, Aug 16, 2022 at 4:53 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> > > dGFX so external monitors are routed to dGFX, and more monitors can be
> > > supported as result.
> > >
> > > To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> > > on intel_dsm_guid2. This method is described in Intel document 632107.
> > >
> >
> > Can we please not do things like this just because?
>
> I there's a very good reason to support more external monitors,
> especially when eDP is already 4K so iGPU don't have enough buffer for
> more displays.
>

well.. they do have it. What's the limit? 3 or 4 4K displays with gen
11th+? I find conflicting information, but 3 4K displays are no
problem. It might be if you get to higher refresh rates or something.

I know that 2 work quite reliably and I know I can put even more on
the Intel GPU.

> >
> > It forces the discrete GPU to be on leading to higher thermal pressure
> > and power consumption of the system. Lower battery runtime or higher
> > fan noise is the result. Not everybody wants to use an AC simply just
> > because they attach an external display.
>
> The system is designed in this way.
>

?!? This makes no sense. If the discrete GPU is turned on, it means
the system has to cool away more heat, because it consumes more power.
It then causes louder fans. No idea how a "system design" can just go
around simple physics...

Even the CPU consumes more power, because on some systems it prevents
deeper package sleeping modes due to the active PCIe bridge
controller.

But if you have certain systems where you want to enable this behavior
despite the drawbacks, maybe maintain a list of systems where to apply
this method?

> And many (if not all) gaming laptops and mobile workstations use
> discrete GPU for external monitors.
> We just recently found out we have to use a switch to make it work.
>

yeah some do, and if people buy those, they already deal with loud
fans and just accept this fact.

Others might want silent fans... and why do you have to switch? Out of
the box Intel GPUs support 3 4K displays. I want to see the general
use case for 4 4K displays.

So what systems are actually affected and do users have the option to
disable it, if they prefer a more silent system?

> >
> > If the problem is "we run out of displays" then can we have something
> > more dynamic, where we are doing this only and only if we run out of
> > resources to drive as that many displays.
>
> This is a boot-time switch, so it's not possible to switch it dynamically.
>

This makes it even worse.

> >
> > Most users will be fine with ports being driven by the iGPU. Why hurt
> > most users, because of some weird special case with mostly only
> > drawbacks?
>
> This is a use case that hardware vendor never bother to test.
> And this is not a special case - the system is designed to use dGPU
> for external monitors.
>
> Kai-Heng
>

so instead of hard wiring, they added a software switch to do the same thing?

And then don't bother to test both possibilities?

Anyway.. it doesn't make any sense and this opens up more questions
than I initially had.

I honestly still don't see the point here and still doubt that
pleasing a handful of users is worth accepting the drawbacks.

I also have no say if it comes to the i915 driver, but from a user
perspective none of this makes much sense tbh.

> >
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/gpu/drm/i915/display/intel_acpi.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> > > index e78430001f077..3bd5930e2769b 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> > > @@ -20,6 +20,7 @@ static const guid_t intel_dsm_guid =
> > >                   0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
> > >
> > >  #define INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED 0 /* No args */
> > > +#define INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX 20 /* No args */
> > >
> > >  static const guid_t intel_dsm_guid2 =
> > >         GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> > > @@ -187,6 +188,7 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> > >         struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> > >         acpi_handle dhandle;
> > >         union acpi_object *obj;
> > > +       int supported = 0;
> > >
> > >         dhandle = ACPI_HANDLE(&pdev->dev);
> > >         if (!dhandle)
> > > @@ -194,8 +196,22 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> > >
> > >         obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> > >                                 INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
> > > -       if (obj)
> > > +       if (obj) {
> > > +               if (obj->type == ACPI_TYPE_INTEGER)
> > > +                       supported = obj->integer.value;
> > > +
> > >                 ACPI_FREE(obj);
> > > +       }
> > > +
> > > +       /* Tiger Lake H DP-IN Boot Time Switching from iGfx to dGfx */
> > > +       if (supported & BIT(20)) {
> > > +               obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2,
> > > +                                       INTEL_DSM_REVISION_ID,
> > > +                                       INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX,
> > > +                                       NULL);
> > > +               if (obj)
> > > +                       ACPI_FREE(obj);
> > > +       }
> > >  }
> > >
> > >  /*
> > > --
> > > 2.36.1
> > >
> >
>

