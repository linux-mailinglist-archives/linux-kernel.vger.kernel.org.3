Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A55A0163
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiHXSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiHXSdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10725EDDE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661366027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0n4dqY837mNTXGdz/cVnVTltMFIhOJZdTntnOSeC6R4=;
        b=bGIA6wwv0UKbEakUGclm5S+WvNi90UuiD3xxEcwsX0+WJbwcfaFWDxiJIsKHittn4bzG6m
        7k2rgklJqT9d6zgBeq4nQt0y6TwhtgceszjzKxPEZJqk4hKkJhLmUkb4ryg+mkJ4P31m0K
        N1NuyF9OezHSD9bV42BuxSnT+QgXO0A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-a8uOHua3NrOJEWdyQtlBnw-1; Wed, 24 Aug 2022 14:33:46 -0400
X-MC-Unique: a8uOHua3NrOJEWdyQtlBnw-1
Received: by mail-qk1-f197.google.com with SMTP id h20-20020a05620a245400b006bb0c6074baso15291686qkn.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0n4dqY837mNTXGdz/cVnVTltMFIhOJZdTntnOSeC6R4=;
        b=pBeJcjiqTlk3GEcBUAiVNiOlI+mLWQwAVPi8A19KaKmlTO8R8vG4fyWPKDLBX4BP4P
         eW9rHS7nZaslOmh6/m0cFfsVR5S5QQZZkwoA28U0SzMXDVg+0ppPKhDIl7TySlwfTJb7
         IVjpcO9vz7nZqFEJDSlBWoUT5MoVigQAb5u7pDDbIKSxy+wKQZGiIXYGrBQ4x/O7+6OZ
         ec/W3HwRF2JWRYifAKTYQV3ZI/5m8J3+5nJebonrYAe9oU1Fsx/vE88F+gdJtHFeu/4X
         4pZ3QsWx11T/bQ0CMNy6h1RwvvE3jHc/EuO0O9OVZhsje+uVaw3thonq4JI5bH2v8HBS
         mvZA==
X-Gm-Message-State: ACgBeo1lCKsE15OfTulm6L41Fizm84hBGrWyKf2yulbUoiMOAknOaR9m
        0FlGl+0EaWYmklhShekYRMuZ7sv3BEQUyG6V+YsGZTeUVrGDe5XRNI7udSTjHK82iDigcbLtqLQ
        4m1YYqr7qYwiVWr44JhDPaXEoXUPwIjRpktMVtvOm
X-Received: by 2002:a05:620a:29c3:b0:6bb:33ac:9130 with SMTP id s3-20020a05620a29c300b006bb33ac9130mr419561qkp.701.1661366025737;
        Wed, 24 Aug 2022 11:33:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5YNAMRcfgkNYZIACaTJO3W9NnhhxFU0G/NCwVzCMPMo5UtCoVhNkGA66kcYnnRPVt3gi8apd5nzE3r9HNR9ho=
X-Received: by 2002:a05:620a:29c3:b0:6bb:33ac:9130 with SMTP id
 s3-20020a05620a29c300b006bb33ac9130mr419546qkp.701.1661366025540; Wed, 24 Aug
 2022 11:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
 <87leror4sl.fsf@intel.com> <CAAd53p76ut7QRFdM4NjaRua=Hc4bu9_=7+Q_t8ExJysEAhJf=Q@mail.gmail.com>
In-Reply-To: <CAAd53p76ut7QRFdM4NjaRua=Hc4bu9_=7+Q_t8ExJysEAhJf=Q@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 24 Aug 2022 20:33:34 +0200
Message-ID: <CACO55tubRD3egnjLd=Qg2u+4_qmURmDY7kb0DxqW7s41_5hS9g@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when it's supported
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        tvrtko.ursulin@linux.intel.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>, rodrigo.vivi@intel.com,
        Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 7:50 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Tue, Aug 16, 2022 at 4:06 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > On Tue, 16 Aug 2022, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> > > dGFX so external monitors are routed to dGFX, and more monitors can be
> > > supported as result.
> > >
> > > To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> > > on intel_dsm_guid2. This method is described in Intel document 632107.
> >
> > Is this the policy decision that we want to unconditionally make,
> > though?
>
> I believes so, so more external monitors can be supported at the same time.
>

if there wouldn't be any drawbacks, yes, but sadly there are and I
don't see that hurting _all_ users affected with this by making their
system consume/generate around 10-15W more power/heat just that maybe
one user can use 4 instead of 3 displays at 4K is really worth it...

> Kai-Heng
>
> >
> > BR,
> > Jani.
> >
> > >
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
> > >                 0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
> > >
> > >  #define INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED 0 /* No args */
> > > +#define INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX 20 /* No args */
> > >
> > >  static const guid_t intel_dsm_guid2 =
> > >       GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> > > @@ -187,6 +188,7 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> > >       struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> > >       acpi_handle dhandle;
> > >       union acpi_object *obj;
> > > +     int supported = 0;
> > >
> > >       dhandle = ACPI_HANDLE(&pdev->dev);
> > >       if (!dhandle)
> > > @@ -194,8 +196,22 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> > >
> > >       obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> > >                               INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
> > > -     if (obj)
> > > +     if (obj) {
> > > +             if (obj->type == ACPI_TYPE_INTEGER)
> > > +                     supported = obj->integer.value;
> > > +
> > >               ACPI_FREE(obj);
> > > +     }
> > > +
> > > +     /* Tiger Lake H DP-IN Boot Time Switching from iGfx to dGfx */
> > > +     if (supported & BIT(20)) {
> > > +             obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2,
> > > +                                     INTEL_DSM_REVISION_ID,
> > > +                                     INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX,
> > > +                                     NULL);
> > > +             if (obj)
> > > +                     ACPI_FREE(obj);
> > > +     }
> > >  }
> > >
> > >  /*
> >
> > --
> > Jani Nikula, Intel Open Source Graphics Center
>

