Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39CF595ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiHPLyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiHPLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:53:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA30CAC4F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:29:27 -0700 (PDT)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 057293F043
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660649366;
        bh=aSmJyx7D+51w1LpJgRV3eRqde7lEGdt1JKguqJZK45s=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dHalwpEu3omyda1I5IGxIu/SF2e/Rlkw5HSK9Qm5loTF3VIaXu/+ZEWopawrWFG4i
         58uPhncVGMD0b5ys9xrgG0sAM10fyjRyR+wgj4kKaqbT12LL3f+O4AMgRkEnwXOthR
         RD2TTc9wtvPjouJQqiQ5jHgMZ7jf4WFyVBKmlXFXeMp9mvQoArSVFDXBxHnYuLrBo+
         n8CrNiOv3Vo+swhyVQXGGK7/A+sfAp48JisyhgIw5xyKGU2CF4OCeMhSXFfPjn8uvN
         Qa3P2MIvFSQqtsMlY5HTLTOA9WM3bfof69WodCPx9/Uv7IvSdcvHU/saXF8Q2EbWNd
         PV3n+P9ojGGBw==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-112b79a5407so2472821fac.16
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aSmJyx7D+51w1LpJgRV3eRqde7lEGdt1JKguqJZK45s=;
        b=yqL6UF9n6Co0yL4v6mcnnIH5HT44A/lHyq7DZyUuD0ZSvu9ROugMUC8EOLwWldxfzO
         aeiykUlUfnPFeeONFkg3zdXD841OpSeV1MyUyeYExeXIwPbZiRFRvDI4tetcjY72fSIL
         T/0HIZGDTMNBADXnHAuxhOl+toEvEOWhf5BwsEpa/Y7fZT1qi+OEdtKlkBxfIX/2gVKv
         BQ0s1Cz+savYBdYxLGEUvRFi05U33CocjqrRtfvm0Fgxksi/GVk1UUrYp44VRfuK0oam
         LL4XV4rk4k1emOA8qINZFzxlvLQVEXcJkQHDS+2Y/I/U8vThpcjQLdYZ9mPuzjiypatt
         J3sQ==
X-Gm-Message-State: ACgBeo01HffloOtmsSJsJ4CCPEmeMVH4iadDN6Oppd+7RyHQgRoXqtLt
        DvwJH4Ru9dikH4Yko9wDBGpl/HwpSwOWHdegUoi0rJXwdwF5fyPqe5Rv/U+FIoz4bOetJiGZyhv
        mWVnOdyylb1OOtGASl95sIpogSQ3yoaRqiKA7boW1z3Ol3SCrSX9k3q8fbg==
X-Received: by 2002:a9d:f05:0:b0:637:1068:1081 with SMTP id 5-20020a9d0f05000000b0063710681081mr7028763ott.224.1660649364937;
        Tue, 16 Aug 2022 04:29:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR40aLi1aejRJbmvKkK+SamiRZIPYXn99+43Y4C0pFABoznjtNDPzRNRT6iTGkRayNIBEZgpA6ErMuo6SjBRYzA=
X-Received: by 2002:a9d:f05:0:b0:637:1068:1081 with SMTP id
 5-20020a9d0f05000000b0063710681081mr7028758ott.224.1660649364645; Tue, 16 Aug
 2022 04:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220816025217.618181-1-kai.heng.feng@canonical.com> <87leror4sl.fsf@intel.com>
In-Reply-To: <87leror4sl.fsf@intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 16 Aug 2022 19:29:11 +0800
Message-ID: <CAAd53p76ut7QRFdM4NjaRua=Hc4bu9_=7+Q_t8ExJysEAhJf=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when it's supported
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 4:06 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Tue, 16 Aug 2022, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> > dGFX so external monitors are routed to dGFX, and more monitors can be
> > supported as result.
> >
> > To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> > on intel_dsm_guid2. This method is described in Intel document 632107.
>
> Is this the policy decision that we want to unconditionally make,
> though?

I believes so, so more external monitors can be supported at the same time.

Kai-Heng

>
> BR,
> Jani.
>
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_acpi.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> > index e78430001f077..3bd5930e2769b 100644
> > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> > @@ -20,6 +20,7 @@ static const guid_t intel_dsm_guid =
> >                 0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
> >
> >  #define INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED 0 /* No args */
> > +#define INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX 20 /* No args */
> >
> >  static const guid_t intel_dsm_guid2 =
> >       GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> > @@ -187,6 +188,7 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> >       struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> >       acpi_handle dhandle;
> >       union acpi_object *obj;
> > +     int supported = 0;
> >
> >       dhandle = ACPI_HANDLE(&pdev->dev);
> >       if (!dhandle)
> > @@ -194,8 +196,22 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> >
> >       obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> >                               INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
> > -     if (obj)
> > +     if (obj) {
> > +             if (obj->type == ACPI_TYPE_INTEGER)
> > +                     supported = obj->integer.value;
> > +
> >               ACPI_FREE(obj);
> > +     }
> > +
> > +     /* Tiger Lake H DP-IN Boot Time Switching from iGfx to dGfx */
> > +     if (supported & BIT(20)) {
> > +             obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2,
> > +                                     INTEL_DSM_REVISION_ID,
> > +                                     INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX,
> > +                                     NULL);
> > +             if (obj)
> > +                     ACPI_FREE(obj);
> > +     }
> >  }
> >
> >  /*
>
> --
> Jani Nikula, Intel Open Source Graphics Center
