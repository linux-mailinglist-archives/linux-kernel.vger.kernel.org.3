Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745DF596285
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiHPSgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiHPSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6846D7AC07
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660674970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZ54moplpvPdL/wHH71E1xm/y/yfzS3drqv2XjiZKiI=;
        b=I7PgTU+iPPvz1jfckS7oOgBKTp+U//kvOo2u7YgYs8wFtLbfQHrBOS/LaqgXLalZeUJF+O
        c9U4fLCxhcuuMrWyj6ujswYVhy1LAI374uCpog6UkoJmxnhv9GXmvG4BFWLUqKG2K4J0iR
        nFBpesTwKnCzim6dH9EipffBMygY21A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-258-g8hYIl7HM4m0zdstDHdlIA-1; Tue, 16 Aug 2022 14:36:09 -0400
X-MC-Unique: g8hYIl7HM4m0zdstDHdlIA-1
Received: by mail-qt1-f200.google.com with SMTP id z6-20020ac875c6000000b0034454b14c91so6755497qtq.15
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=vZ54moplpvPdL/wHH71E1xm/y/yfzS3drqv2XjiZKiI=;
        b=GqwsTsjWukikWg94NpJZthjtp/QPXTl7Rr8bcX5aauYDoleb4wUicoqUVavYod+uHU
         jzwCZudpyf5cpzWtYNcpgGXpyvJ6vRrKDLfkfuwfr0eorJN6OMinZdy0feiKxdwG7TaM
         XlvP3/YyMOMUho/NEpeG8rpdPEnivACZwl+WLecdootzJaYLYnJsQt3QeDZoMXgjLgQ9
         rFoJmGAXDxrGzr5h1gVicyuE7lGXJsk3r9X3zhg0s0o61deVhma1wqXcyy3Agy2NjBzu
         ICuolAL1FPMEM7KVX/vkW/tHx8G8+0jiSGNc1v+uw/PveTTV3CDXKfa5geyPsyNnty+A
         RoaQ==
X-Gm-Message-State: ACgBeo2Qeb2KHH1tPRhYR8DXXzCAGQTfwdy8HkSVeySz2G8LnBF0IkAI
        GnqPg2rDbCHzYGLKvMG+Uv+Vdk61qXJhxKJR/A9J+ze2habWMS2iuMUcVaQ3wUd+YvqitWzqx06
        ijIJ0tKwm5aWGcI8VvuvoOk1z
X-Received: by 2002:a05:620a:1a16:b0:6b8:7789:8ca4 with SMTP id bk22-20020a05620a1a1600b006b877898ca4mr15412806qkb.292.1660674968884;
        Tue, 16 Aug 2022 11:36:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4pBMBPqG1MbQXxD8HnOKy/7fIUAIk8c46xMr2no8av4BkE3TC1MFkX6/q9a32Znp2C+k72IQ==
X-Received: by 2002:a05:620a:1a16:b0:6b8:7789:8ca4 with SMTP id bk22-20020a05620a1a1600b006b877898ca4mr15412789qkb.292.1660674968609;
        Tue, 16 Aug 2022 11:36:08 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id bb12-20020a05622a1b0c00b0031ef67386a5sm10612124qtb.68.2022.08.16.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:36:06 -0700 (PDT)
Message-ID: <d1bf4ebe8378e32fa047ecd8912abf772695534c.camel@redhat.com>
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
Date:   Tue, 16 Aug 2022 14:36:03 -0400
In-Reply-To: <b8ebc447ea464371102df765882fc5010cc0c784.camel@redhat.com>
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
         <87leror4sl.fsf@intel.com>
         <CAAd53p76ut7QRFdM4NjaRua=Hc4bu9_=7+Q_t8ExJysEAhJf=Q@mail.gmail.com>
         <b8ebc447ea464371102df765882fc5010cc0c784.camel@redhat.com>
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

On Tue, 2022-08-16 at 14:24 -0400, Lyude Paul wrote:
> On Tue, 2022-08-16 at 19:29 +0800, Kai-Heng Feng wrote:
> > On Tue, Aug 16, 2022 at 4:06 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > 
> > > On Tue, 16 Aug 2022, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > > On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> > > > dGFX so external monitors are routed to dGFX, and more monitors can be
> > > > supported as result.
> > > > 
> > > > To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> > > > on intel_dsm_guid2. This method is described in Intel document 632107.
> 
> Is this documentation released anywhere? We've been wondering about these
> interfaces for quite a long time, and it would be good to know if there's docs
> for this we haven't really been seeing.
> 
> > > 
> > > Is this the policy decision that we want to unconditionally make,
> > > though?
> > 
> > I believes so, so more external monitors can be supported at the same time.
> > 
> > Kai-Heng
> 
> Is this for systems with dual Intel GPUs? I ask because if this affects
> Intel/Nvidia hybrid systems then this is a huge no from me. Nouveau is able to
> support these systems, but at a limited capacity. This would imply that we are
> making external displays work for users of the nvidia proprietary driver, at
> the expense making external display support for mainline kernel users
> substantially worse for people who are using the mainline kernel. Which isn't
> a choice we should be making, because nvidia's OOT driver is not a mainline
> kernel driver.

Doing some quick research, unless the models mentioned in the commit message
are unreleased some of them are definitely Intel/Nvidia hybrids. So I'm going
to say:

NAK-by: Lyude Paul <lyude@redhat.com>

If you'd like to resubmit this for systems with amdgpus and Intel only, that's
perfectly fine with me if the Intel folks are ok with it. But please hold off
on this for Nvidia systems, at least until we've got GSP reworks functional in
nouveau. If nvidia's interested in making this work for their driver, they're
welcome to do the work there. For reference: the main limitations you would
hit as a result of this patch would be lagginess on the external displays as a
result of us not being able to reclock the GPU, which means PCIe bandwidth
will be pretty limited.

> 
> If this is just for Intel/Intel systems though that's probably fine, and it
> might also be fine for AMD systems.
> 
> > 
> > > 
> > > BR,
> > > Jani.
> > > 
> > > > 
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >  drivers/gpu/drm/i915/display/intel_acpi.c | 18 +++++++++++++++++-
> > > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> > > > index e78430001f077..3bd5930e2769b 100644
> > > > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> > > > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> > > > @@ -20,6 +20,7 @@ static const guid_t intel_dsm_guid =
> > > >                 0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
> > > > 
> > > >  #define INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED 0 /* No args */
> > > > +#define INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX 20 /* No args */
> > > > 
> > > >  static const guid_t intel_dsm_guid2 =
> > > >       GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
> > > > @@ -187,6 +188,7 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> > > >       struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> > > >       acpi_handle dhandle;
> > > >       union acpi_object *obj;
> > > > +     int supported = 0;
> > > > 
> > > >       dhandle = ACPI_HANDLE(&pdev->dev);
> > > >       if (!dhandle)
> > > > @@ -194,8 +196,22 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
> > > > 
> > > >       obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> > > >                               INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
> > > > -     if (obj)
> > > > +     if (obj) {
> > > > +             if (obj->type == ACPI_TYPE_INTEGER)
> > > > +                     supported = obj->integer.value;
> > > > +
> > > >               ACPI_FREE(obj);
> > > > +     }
> > > > +
> > > > +     /* Tiger Lake H DP-IN Boot Time Switching from iGfx to dGfx */
> > > > +     if (supported & BIT(20)) {
> > > > +             obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2,
> > > > +                                     INTEL_DSM_REVISION_ID,
> > > > +                                     INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX,
> > > > +                                     NULL);
> > > > +             if (obj)
> > > > +                     ACPI_FREE(obj);
> > > > +     }
> > > >  }
> > > > 
> > > >  /*
> > > 
> > > --
> > > Jani Nikula, Intel Open Source Graphics Center
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

