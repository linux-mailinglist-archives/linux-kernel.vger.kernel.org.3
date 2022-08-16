Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718F8596255
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiHPSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbiHPSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56759696F1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660674290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4APrCzNvCJvZdPPei2VGvsAl7TnezkG7b9sD5lHxu5w=;
        b=Upja8xbvLbonlVRadJMto3T+iLGBNADdZu2tE3R/YfWmW5TmXP8dgJFq3BkpaSLKS4EYd9
        v9h5YVoM17/T8Rp949qk0Q12jjqCJqQWRYimZwpK3OHW53+klDd+wi9wZhe+2xaC4wu+Fj
        a4zJWHXtKVMSrMSGcQ4GF8rVEg3Nw+E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-94-Z50mV2z1PPi9CNuHdvgwgg-1; Tue, 16 Aug 2022 14:24:49 -0400
X-MC-Unique: Z50mV2z1PPi9CNuHdvgwgg-1
Received: by mail-qt1-f198.google.com with SMTP id s2-20020ac85cc2000000b00342f8ad1f40so8901524qta.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=4APrCzNvCJvZdPPei2VGvsAl7TnezkG7b9sD5lHxu5w=;
        b=xi2ZLMG0pYOdrpig3zZ0OTkLCMF6i99I8Itx+38N98pYChfw3s91D0JHAkvz/ZfUzG
         dzr4C+rKn0KRunjQK67OLb+O6fB6aN0ZVrPkMj3hAOamvuOk6onXAnJvEZasHCvOalzv
         fPjpJ6y/VMT1mfNuNYfhd/06namrzb+uqTU2dRwQOqnQ9nMT/hVB1FwyuzEOw9vDoJrI
         ukL+T3erb7Aag2OtfF1EL0/BMWftov4nqg9994AZKHJRcOMbGDRzunhjlQn3161ESPh5
         Wo3+NwXOF7vGArNsjWtUKLQ/cCOr1KMr1/M9PTM+75VVg4vyVlaZfYV3oJ8YVz64abzo
         VD+g==
X-Gm-Message-State: ACgBeo0YT/SrFCWZ29tGekCk9Q8AYGTrGhzjCaaLtrokxOO/QLU3qSvN
        +wB+H704w42+7n0SB7l5h+a9azEq1WtbEuZ0PLH9J7gAzR4k/+19pu59F5JULB2fSGER3pE3QKZ
        gyA5rT+xanD8Whfd5UNwhKQb3
X-Received: by 2002:a05:6214:1cc8:b0:46e:1920:70f8 with SMTP id g8-20020a0562141cc800b0046e192070f8mr19091597qvd.6.1660674288849;
        Tue, 16 Aug 2022 11:24:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Ti0MgWn0jiwlVJ6LdWNLM26lzw3bFgeBehbTERAFTZ4fs8kfkv9GKykgPccJegrzfWy3cMQ==
X-Received: by 2002:a05:6214:1cc8:b0:46e:1920:70f8 with SMTP id g8-20020a0562141cc800b0046e192070f8mr19091582qvd.6.1660674288564;
        Tue, 16 Aug 2022 11:24:48 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a450300b006b5df4d2c81sm13607026qkp.94.2022.08.16.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:24:47 -0700 (PDT)
Message-ID: <b8ebc447ea464371102df765882fc5010cc0c784.camel@redhat.com>
Subject: Re: [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when it's supported
From:   Lyude Paul <lyude@redhat.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Zenghui Yu <yuzenghui@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Aug 2022 14:24:46 -0400
In-Reply-To: <CAAd53p76ut7QRFdM4NjaRua=Hc4bu9_=7+Q_t8ExJysEAhJf=Q@mail.gmail.com>
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
         <87leror4sl.fsf@intel.com>
         <CAAd53p76ut7QRFdM4NjaRua=Hc4bu9_=7+Q_t8ExJysEAhJf=Q@mail.gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-16 at 19:29 +0800, Kai-Heng Feng wrote:
> On Tue, Aug 16, 2022 at 4:06 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > 
> > On Tue, 16 Aug 2022, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> > > dGFX so external monitors are routed to dGFX, and more monitors can be
> > > supported as result.
> > > 
> > > To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> > > on intel_dsm_guid2. This method is described in Intel document 632107.

Is this documentation released anywhere? We've been wondering about these
interfaces for quite a long time, and it would be good to know if there's docs
for this we haven't really been seeing.

> > 
> > Is this the policy decision that we want to unconditionally make,
> > though?
> 
> I believes so, so more external monitors can be supported at the same time.
> 
> Kai-Heng

Is this for systems with dual Intel GPUs? I ask because if this affects
Intel/Nvidia hybrid systems then this is a huge no from me. Nouveau is able to
support these systems, but at a limited capacity. This would imply that we are
making external displays work for users of the nvidia proprietary driver, at
the expense making external display support for mainline kernel users
substantially worse for people who are using the mainline kernel. Which isn't
a choice we should be making, because nvidia's OOT driver is not a mainline
kernel driver.

If this is just for Intel/Intel systems though that's probably fine, and it
might also be fine for AMD systems.

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

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

