Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ACE5AA8CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiIBHfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:35:36 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB776402E9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:35:34 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id y18so875118qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I0BzN+oySEF5bQ4YY03gLnpAlLeJEFGcm1NmTucRGdY=;
        b=2s26t0DUHDfTe1mB/QFM+EbIDrmRCx2xfNAHZmF63LH8oUhTiJ483E8UfBXj7OptzE
         S6RCSalMnX8Ja+8wAc50WCp4eALmigGMwxuemFOVRORMEacfeJ//28xt0SiwsjFIaVR/
         0gQsIMs/7/7Sby1yWSV5tMmIutIaqvR5sDmoyYjtWk995vdNLVRWwHElmp8GoRI6BXVp
         d5sYlXPVLXQkyYAPDQ+FMw5vOhBmY7fOwRNuKjewrCJ5ZJSyOUtuXjobVUPr0xOOAOby
         eaWM73VKdPtbohRnROdmaR/BCt+yD/nK54hdhdjsOPy7JbZXhV+Pce7A4/jb0MIQiONq
         qlWw==
X-Gm-Message-State: ACgBeo0G3r31vwlR2SCyVpNiti1bdMMGxyfZ4ZOsdyOJSGPTsBqdHnLC
        5kZnuchNUgRKz5jkdXTv+fRhAkkYap2OiQ==
X-Google-Smtp-Source: AA6agR4XRkECRnOEGczGKpLD94roBsXc9ZRA4h33H3T2DszlPnHTf8Vz9CRTH0T414gER22xMQQRyA==
X-Received: by 2002:ac8:7f0f:0:b0:344:2fd8:8a66 with SMTP id f15-20020ac87f0f000000b003442fd88a66mr27228944qtk.98.1662104133473;
        Fri, 02 Sep 2022 00:35:33 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id l2-20020ac87242000000b0034455ff76ddsm626013qtp.34.2022.09.02.00.35.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 00:35:32 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-33da3a391d8so8934227b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:35:31 -0700 (PDT)
X-Received: by 2002:a81:750b:0:b0:341:10ef:2c37 with SMTP id
 q11-20020a81750b000000b0034110ef2c37mr20502429ywc.316.1662104131692; Fri, 02
 Sep 2022 00:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-9-459522d653a7@cerno.tech> <30a9d7cd-d9ff-3177-ac6c-e7c1f966d89a@gmail.com>
In-Reply-To: <30a9d7cd-d9ff-3177-ac6c-e7c1f966d89a@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 2 Sep 2022 09:35:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_yfr1ybNM9Dyk6n34Cqv5WJv1wZxQ_ZGJ_T8JCOeB2g@mail.gmail.com>
Message-ID: <CAMuHMdU_yfr1ybNM9Dyk6n34Cqv5WJv1wZxQ_ZGJ_T8JCOeB2g@mail.gmail.com>
Subject: Re: [PATCH v2 09/41] drm/connector: Add TV standard property
To:     Mateusz Kwiatkowski <kfyatek@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <dom@raspberrypi.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz,

On Fri, Sep 2, 2022 at 12:00 AM Mateusz Kwiatkowski <kfyatek@gmail.com> wrote:
> W dniu 29.08.2022 o 15:11, Maxime Ripard pisze:
> > The TV mode property has been around for a while now to select and get the
> > current TV mode output on an analog TV connector.
> >
> > Despite that property name being generic, its content isn't and has been
> > driver-specific which makes it hard to build any generic behaviour on top
> > of it, both in kernel and user-space.
> >
> > Let's create a new bitmask tv norm property, that can contain any of the
> > analog TV standards currently supported by kernel drivers. Each driver can
> > then pass in a bitmask of the modes it supports.
>
> This is not a bitmask property anymore, you've just changed it to an enum.
> The commit message is now misleading.
>
> > +static const struct drm_prop_enum_list drm_tv_mode_enum_list[] = {
> > +    { DRM_MODE_TV_MODE_NTSC_443, "NTSC-443" },
> > +    { DRM_MODE_TV_MODE_NTSC_J, "NTSC-J" },
> > +    { DRM_MODE_TV_MODE_NTSC_M, "NTSC-M" },
> > +    { DRM_MODE_TV_MODE_PAL_60, "PAL-60" },
> > +    { DRM_MODE_TV_MODE_PAL_B, "PAL-B" },
> > +    { DRM_MODE_TV_MODE_PAL_D, "PAL-D" },
> > +    { DRM_MODE_TV_MODE_PAL_G, "PAL-G" },
> > +    { DRM_MODE_TV_MODE_PAL_H, "PAL-H" },
> > +    { DRM_MODE_TV_MODE_PAL_I, "PAL-I" },
> > +    { DRM_MODE_TV_MODE_PAL_M, "PAL-M" },
> > +    { DRM_MODE_TV_MODE_PAL_N, "PAL-N" },
> > +    { DRM_MODE_TV_MODE_PAL_NC, "PAL-Nc" },
> > +    { DRM_MODE_TV_MODE_SECAM_60, "SECAM-60" },
> > +    { DRM_MODE_TV_MODE_SECAM_B, "SECAM-B" },
> > +    { DRM_MODE_TV_MODE_SECAM_D, "SECAM-D" },
> > +    { DRM_MODE_TV_MODE_SECAM_G, "SECAM-G" },
> > +    { DRM_MODE_TV_MODE_SECAM_K, "SECAM-K" },
> > +    { DRM_MODE_TV_MODE_SECAM_K1, "SECAM-K1" },
> > +    { DRM_MODE_TV_MODE_SECAM_L, "SECAM-L" },
> > +};
>
> I did not comment on it the last time, but this list looks a little bit random.
>
> Compared to the standards defined by V4L2, you also define SECAM-60 (a good
> thing to define, because why not), but don't define PAL-B1, PAL-D1, PAL-K,
> SECAM-H, SECAM-LC (whatever that is - probably just another name for SECAM-L,
> see my comment about PAL-Nc below), or NTSC-M-KR (a Korean variant of NTSC).
>
> Like I mentioned previously, I'm personally not a fan of including all those
> CCIR/ITU system variants, as they don't mean any difference to the output unless
> there is an RF modulator involved. But I get it that they have already been used
> and regressing probably wouldn't be a very good idea. But in that case keeping
> it consistent with the set of values used by V4L2 would be wise, I think.

Exactly. Anything outputting RGB (e.g. through a SCART or VGA connector)
doesn't care about the color subcarrier or modulator parts.  Likewise,
anything outputting CVBS doesn't care about the modulator part.

Perhaps "generic" variants of NSTC and PAL/SECAM should be added, which
would really just mean 525/60 resp. 625/50.

Alternatively, the tv_mode field could be split in two parts (either
two separate fields, or bitwise), to maintain a clear separation between
lines/fields versus color encoding and RF modulation (with zero for the
latter meaning a generic version)? That would also keep the door open
for TV_MODE_405_50, TV_MODE_819_50, TV_MODE_750_50, TV_MODE_750_60, ...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
