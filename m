Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71515A78ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiHaIWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiHaIWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:22:11 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9CC6FED
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:20:49 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so22453307fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tL3Pu80GajPbXIuFp2pntr8ejcDbNLFHN+ltW3MDRBA=;
        b=chJsU8jivhcSNYsXVa+DgMSXCb6DoJVCBM8TXfnPpXZ3XdTVVMtmoO6bEijJ3U5fQA
         UWLCp6sC2KWSiU9TM80WQlQjZmhYmQ1FqeMouQFYw6FodO9bMPmftMjEJmMOhGkDu3en
         UpMRQtM4NGoFgQs5NvgCPtr0RGc2rT1izdZrb75fdEyTQDL3S9jWCRQw8+wDwpsZRrxF
         KGJ6RXEGBdeJh2sdcwvci5C9WpXazoJZvDpumCrsFTB8MaQCTPd7u9t68me6Ld1m+pi7
         wHILAp9hMMx3Pgf6QGcORJD+Jm709tvWxnIGLV9C46TZCj2/z0TPKJ1fFWlGN3uKY5On
         40qw==
X-Gm-Message-State: ACgBeo1eQUA+6RjZpnlrxSXHcJUvTzhMnI4Ywm2miFp2Xbd6SPe3e1cM
        9Swudo2OroV6SXTFgY2BW3xEB0yL6v+zLw==
X-Google-Smtp-Source: AA6agR7q026XxgBpdRrFOScaBbFQ67VPyKlV9qohD3PZaz+u9+cjK9VkdB4N+r8cxK9hWnFuYU0K0g==
X-Received: by 2002:a05:6870:a103:b0:11d:2441:668b with SMTP id m3-20020a056870a10300b0011d2441668bmr970892oae.263.1661934016861;
        Wed, 31 Aug 2022 01:20:16 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id 65-20020aca0544000000b00339befdfad0sm7299210oif.50.2022.08.31.01.20.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 01:20:16 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so9780160otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:20:16 -0700 (PDT)
X-Received: by 2002:a25:24b:0:b0:696:4e87:7cec with SMTP id
 72-20020a25024b000000b006964e877cecmr14439821ybc.202.1661933679611; Wed, 31
 Aug 2022 01:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-459522d653a7@cerno.tech> <242d272b-5b79-986c-9aaf-64e62f6b37ff@gmail.com>
In-Reply-To: <242d272b-5b79-986c-9aaf-64e62f6b37ff@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 Aug 2022 10:14:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWq3aOO4-2AReDeaC2VBJb=QJF2dTMZP=DGmwCg6ZOffA@mail.gmail.com>
Message-ID: <CAMuHMdWq3aOO4-2AReDeaC2VBJb=QJF2dTMZP=DGmwCg6ZOffA@mail.gmail.com>
Subject: Re: [PATCH v2 10/41] drm/modes: Add a function to generate analog
 display modes
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz,

On Wed, Aug 31, 2022 at 3:44 AM Mateusz Kwiatkowski <kfyatek@gmail.com> wrote:
> Wow. That's an enormous amount of effort put into this patch.
>
> But I'm tempted to say that this is actually overengineered quite a bit :D
> Considering that there's no way to access all these calculations from user
> space, and I can't imagine anybody using anything else than those standard
> 480i/576i (and maybe 240p/288p) modes at 13.5 MHz any time soon... I'm not
> sure if we actually need all this.

We'll need it when we get an Amiga DRM driver, which will use
7/14/28 MHz pixel clocks.

> But anyway, I'm not the maintainer of this subsystem, so I'm not the one to
> decide.
>
> > +enum drm_mode_analog {
> > +    DRM_MODE_ANALOG_NTSC,
> > +    DRM_MODE_ANALOG_PAL,
> > +};
>
> Using "NTSC" and "PAL" to describe the 50Hz and 60Hz analog TV modes is common,
> but strictly speaking a misnomer. Those are color encoding systems, and your
> patchset fully supports lesser used, but standard encodings for those (e.g.
> PAL-M for 60Hz and SECAM for 50Hz). I'd propose switching to some more neutral
> naming scheme. Some ideas:
>
> - DRM_MODE_ANALOG_60_HZ / DRM_MODE_ANALOG_50_HZ (after standard refresh rate)
> - DRM_MODE_ANALOG_525_LINES / DRM_MODE_ANALOG_625_LINES (after standard line
>   count)

IMHO these are bad names, as e.g. VGA640x480@60 is also analog, using
60 Hz and 525 lines.  Add "TV" to the name?

> - DRM_MODE_ANALOG_JM / DRM_MODE_ANALOG_BDGHIKLN (after corresponding ITU System
>   Letter Designations)

Or DRM_MODE_ITU_*?
But given the long list of letters, this looks fragile to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
