Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE07C5962B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiHPSuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiHPSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A77880B77
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660675810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AkK5XVOSKnldgDxtfSJhIQ0VryUaBistREPEqG430YQ=;
        b=JOcvcCtlCsv2esMbSV0YocJZqb2bMVhSNn+vSucXSmOpZX8h145QVQ/FPbarCsEYUarBp5
        0Of93DcsYnmVZJjItIXnaWZFUf4HgZW+qgHFqXi14/ojB1Rgoa0UZUdQmMqQeSGGRTrfQD
        m686cBUhgtM2QbITWgPtVfnD3xEtUic=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-fgM9JszUNQGKQjquwrLOeA-1; Tue, 16 Aug 2022 14:50:09 -0400
X-MC-Unique: fgM9JszUNQGKQjquwrLOeA-1
Received: by mail-qt1-f198.google.com with SMTP id bz20-20020a05622a1e9400b003436a76c6e6so8901184qtb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AkK5XVOSKnldgDxtfSJhIQ0VryUaBistREPEqG430YQ=;
        b=YTdJ93tgZuGdYKZYbacy/dzexGdRTDrk5PgC4hny+FJWtvkMqNksvzWiMQQYovGQF3
         F5+Uh5mdQwG/ekHHIojwOYSQg2g7y09ek1nKfR5iAdciRoP2gkCsmvQBJpUhu/MSLOa9
         GcJnwH/IOLHGYEmYXsLyrjv9c8Wf+lZqIl9uovxEQgVgeG7b6YroQqiVhqGkil2Plajl
         AdEZkrvsmT9QHSfmOT1lipOU7OACL8Pwb+4RYFBIa9o5brh4/EZjExuVlPpTJ4JFu+fe
         b7eJwNGScjuow2otv0KYnVOQD8hACgRHVFGOEee7EAPt13t99vakPsjy+snw9ELTXaSh
         cO8Q==
X-Gm-Message-State: ACgBeo15eSmspzFZ+yDnhpdckp0140XLhOcWifZpc7L8f+riugwPz7Pj
        yYcc/FHrB01zwcTguyTDeDnaHdtOaTwGxjPbb//EB5e0R59z4Ed3keACt+UIzePDKAdRZnUAeZ+
        65wNVijorUiTKyod5mFP16RduCVIWZXInMxxmYG+L
X-Received: by 2002:a05:620a:2444:b0:6bb:3397:556b with SMTP id h4-20020a05620a244400b006bb3397556bmr7441194qkn.336.1660675809311;
        Tue, 16 Aug 2022 11:50:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5dUXuiPf2SvaQ6qdoG4GXaAVy4hA4WC5ASn4P0jVmQCPTsYvEx5t9BOulk4AEAIjwyNZlyUh+bojKePuTiVL4=
X-Received: by 2002:a05:620a:2444:b0:6bb:3397:556b with SMTP id
 h4-20020a05620a244400b006bb3397556bmr7441175qkn.336.1660675809065; Tue, 16
 Aug 2022 11:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220816025217.618181-1-kai.heng.feng@canonical.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 16 Aug 2022 20:49:58 +0200
Message-ID: <CACO55tt=Op=0E94kK+1M8cDXNCk5Tkc=FMR8=OQFc5ohehjwaw@mail.gmail.com>
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

On Tue, Aug 16, 2022 at 4:53 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> dGFX so external monitors are routed to dGFX, and more monitors can be
> supported as result.
>
> To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> on intel_dsm_guid2. This method is described in Intel document 632107.
>

Can we please not do things like this just because?

It forces the discrete GPU to be on leading to higher thermal pressure
and power consumption of the system. Lower battery runtime or higher
fan noise is the result. Not everybody wants to use an AC simply just
because they attach an external display.

If the problem is "we run out of displays" then can we have something
more dynamic, where we are doing this only and only if we run out of
resources to drive as that many displays.

Most users will be fine with ports being driven by the iGPU. Why hurt
most users, because of some weird special case with mostly only
drawbacks?

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/intel_acpi.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index e78430001f077..3bd5930e2769b 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -20,6 +20,7 @@ static const guid_t intel_dsm_guid =
>                   0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
>
>  #define INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED 0 /* No args */
> +#define INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX 20 /* No args */
>
>  static const guid_t intel_dsm_guid2 =
>         GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> @@ -187,6 +188,7 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
>         struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>         acpi_handle dhandle;
>         union acpi_object *obj;
> +       int supported = 0;
>
>         dhandle = ACPI_HANDLE(&pdev->dev);
>         if (!dhandle)
> @@ -194,8 +196,22 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
>
>         obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
>                                 INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
> -       if (obj)
> +       if (obj) {
> +               if (obj->type == ACPI_TYPE_INTEGER)
> +                       supported = obj->integer.value;
> +
>                 ACPI_FREE(obj);
> +       }
> +
> +       /* Tiger Lake H DP-IN Boot Time Switching from iGfx to dGfx */
> +       if (supported & BIT(20)) {
> +               obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2,
> +                                       INTEL_DSM_REVISION_ID,
> +                                       INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX,
> +                                       NULL);
> +               if (obj)
> +                       ACPI_FREE(obj);
> +       }
>  }
>
>  /*
> --
> 2.36.1
>

