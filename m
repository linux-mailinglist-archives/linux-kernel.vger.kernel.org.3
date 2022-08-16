Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19FB595E96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiHPOv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiHPOvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:51:23 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7864D4E1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:51:22 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id j5so12277542oih.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tf29XLGj+1bd58LVE065Hm1nPqeAKMph377e+8mce68=;
        b=SwBHs8yG4Tg/3TXir4UKOfOrFCKGlUdqY1sQWpzky3/gQ7L97Fdybana5InSZumxX6
         UgKpJgFsUnGn/hvO7+lV9uEkYvbZREi72CouxeDvssHrD8dkxgqwv8xtz50b8/m/CZlv
         pGVPCvm1ihCDehEFHYaWy4Jnhc2RKKnhUSZeWDqF/kJ08xp+UQn+SKc6zT7CYlcC1Qy5
         11zdMXFFTWdzgj2ffux4Nynsabc9XTK3JxpxEYaxRq9a0qHQTRpMMZlnGqKi5uQqguL0
         4UapGgwlmyTcO7x2ufTNGo0yXyZjNtFUGF6+VosrY9UfjwZq11X13Q7+WGQdiDJTfK/8
         HjPA==
X-Gm-Message-State: ACgBeo1YXxqp3Vo2hdVEa5KqlRBXAybxcKQWezq5tbta7ztWHBAwmdVw
        oItwQQas4cUwZy1zrPAs2ezZLnQ1TH0FqQ==
X-Google-Smtp-Source: AA6agR6YGFfGx38D5bFpGpiKyjV1HyIpHrVQ73sj7qtnEHG4oRQyeiKYpjl38/Il/Txfm+kscA9a1Q==
X-Received: by 2002:a05:6808:300a:b0:2f9:4722:fffc with SMTP id ay10-20020a056808300a00b002f94722fffcmr12485362oib.31.1660661481768;
        Tue, 16 Aug 2022 07:51:21 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id g19-20020a4ad313000000b0044ad7f9a033sm84202oos.33.2022.08.16.07.51.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 07:51:21 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id n16-20020a4a9550000000b0043568f1343bso1845657ooi.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:51:21 -0700 (PDT)
X-Received: by 2002:a81:b812:0:b0:328:68e4:c886 with SMTP id
 v18-20020a81b812000000b0032868e4c886mr16448315ywe.502.1660661082059; Tue, 16
 Aug 2022 07:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-9-3d53ae722097@cerno.tech>
 <CAMuHMdUiMEybnhgxgBXh1Cbv6syVe9iVU=sb17zHM72R8A2Dew@mail.gmail.com> <20220816134624.cmb5s6i6pkdhu3qj@houat>
In-Reply-To: <20220816134624.cmb5s6i6pkdhu3qj@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Aug 2022 16:44:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMMaGS_pEZ4OTdXn8jvFnx-Rx81qPseGUeGUcSBqys8A@mail.gmail.com>
Message-ID: <CAMuHMdWMMaGS_pEZ4OTdXn8jvFnx-Rx81qPseGUeGUcSBqys8A@mail.gmail.com>
Subject: Re: [PATCH v1 09/35] drm/modes: Move named modes parsing to a
 separate function
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <dom@raspberrypi.com>
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

Hi Maxime,

On Tue, Aug 16, 2022 at 3:46 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Fri, Aug 12, 2022 at 03:27:17PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Jul 29, 2022 at 6:36 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > The current construction of the named mode parsing doesn't allow to extend
> > > it easily. Let's move it to a separate function so we can add more
> > > parameters and modes.
> > >
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >
> > Thanks for your patch, which looks similar to my "[PATCH v2 2/5]
> > drm/modes: Extract drm_mode_parse_cmdline_named_mode()"
> > (https://lore.kernel.org/dri-devel/1371554419ae63cb54c2a377db0c1016fcf200bb.1657788997.git.geert@linux-m68k.org
> > ;-)
>
> Indeed, I forgot about that one, sorry :/
>
> I think I'd still prefer to have the check for refresh + named mode
> outside of the function, since I see them as an "integration" issue, not
> a parsing one.
>
> It's not the named mode parsing that fails, but the fact that we both
> have a valid refresh and a valid named mode.
>
> >
> > > --- a/drivers/gpu/drm/drm_modes.c
> > > +++ b/drivers/gpu/drm/drm_modes.c
> > > @@ -1773,6 +1773,28 @@ static const char * const drm_named_modes_whitelist[] = {
> > >         "PAL",
> > >  };
> > >
> > > +static bool drm_mode_parse_cmdline_named_mode(const char *name,
> > > +                                             unsigned int name_end,
> > > +                                             struct drm_cmdline_mode *cmdline_mode)
> > > +{
> > > +       unsigned int i;
> > > +
> > > +       for (i = 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
> > > +               int ret;
> > > +
> > > +               ret = str_has_prefix(name, drm_named_modes_whitelist[i]);
> > > +               if (ret != name_end)
> > > +                       continue;
> > > +
> > > +               strcpy(cmdline_mode->name, drm_named_modes_whitelist[i]);
> > > +               cmdline_mode->specified = true;
> > > +
> > > +               return true;
> > > +       }
> > > +
> > > +       return false;
> >
> > What's the point in returning a value, if it is never checked?
> > Just make this function return void?
>
> Yeah, it's something I went back and forth to between the dev, and it's
> an artifact.
>
> I'll drop that patch, take your version and move the refresh check to
> drm_mode_parse_command_line_for_connector if that's alright for you?

Fine for me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
