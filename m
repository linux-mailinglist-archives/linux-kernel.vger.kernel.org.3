Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83885A4F11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiH2OWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiH2OWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:22:22 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68378B988
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:22:21 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-11edd61a9edso4483898fac.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+LNH7GWYgSUzsjvph8IQNcroBifhiDios4fo6CTY2/U=;
        b=XVunXF3kjTus4d6ghRjoX/G3g6du/2+bZ0NFdJ4nJuVzrU0bZ1yCuXay3gzzk+mu60
         fNgmJcD5phH4nVkxv3kCXO53Q8YaIVADSbrxGNyF17xXWi1OxEN8NI1ggco5qqjYQxqm
         HP8C3P61XtqKmEGfrUWrxDjwD6Wulwehdu7ZbWogo/QrCcqFIb0xl/rDioRX4+qb/VME
         MPVID9JCMLttgQa6eUivOkemGZ5Z2HnpLjjUvH97HIapXJIsaQzg4/sNHbnEUweLfVoY
         QZzmAi4+iy/E65r/vqrvNzzfIamgrLCf8xW1rZmaXQ5qNXVCc2FqvBvgEEGL8zNvJyAC
         EsWw==
X-Gm-Message-State: ACgBeo2Q26yaxRm6RU8zqlq/IZCcbpDxfq1irAHB+AdsJHNKuhO+C4j6
        zv7bby7Uk6c/HeaO/IqKrv8t3wXcIlFXSA==
X-Google-Smtp-Source: AA6agR5N1A2Gvptc6i3QpAjwFZ0eyDsy6gap/xa1uX6YGTUyIDM3KSvJBCY2l+mVv0zkfBvbhqb+qA==
X-Received: by 2002:a05:6870:438b:b0:11c:ecf2:e4ca with SMTP id r11-20020a056870438b00b0011cecf2e4camr8141008oah.122.1661782940808;
        Mon, 29 Aug 2022 07:22:20 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id g10-20020acab60a000000b0034516ca90dcsm4791240oif.23.2022.08.29.07.22.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 07:22:20 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so5973619otq.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:22:20 -0700 (PDT)
X-Received: by 2002:a25:415:0:b0:696:814:7c77 with SMTP id 21-20020a250415000000b0069608147c77mr8612505ybe.36.1661782506395;
 Mon, 29 Aug 2022 07:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUusnhYodWGCxJBu-1Hd2KW-xdT8jxE_iVdQjDo8b3Y5Q@mail.gmail.com>
 <20220817131454.qcuywcuc4ts4hswm@houat> <CAMuHMdVPEgnnsY-4uuf=FDJ0YxWpch-0kZWFT_TZfcDvXLtwWQ@mail.gmail.com>
 <20220818123934.eim2bfrgbxsmviqx@houat> <CAMuHMdWXbHkrBZgsmUnU=q52+q7UZZNO3tgQW7Men+msQ1JDwQ@mail.gmail.com>
 <20220818134200.cr22bftmjn226ehn@houat> <CAMuHMdX6dyQaB34oeXwiCa2rDkxks0qNh=ekqh7Wd2kSNED9TA@mail.gmail.com>
 <20220818154641.ouvrar5s74qu74zn@houat> <CAMuHMdUjE0mwu8z5AksW4h1OwzDCQ5h1ZoCWDi+rC4p2Pu5O4g@mail.gmail.com>
 <6d1dfaad-7310-a596-34dd-4a6d9aa95f65@gmail.com> <20220829132953.sfv5yex2dhv76vrq@houat>
In-Reply-To: <20220829132953.sfv5yex2dhv76vrq@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Aug 2022 16:14:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXxoEYV7v-R+o4eMJEiV_xGUgpN6sUbZ95r_qewV5QpRA@mail.gmail.com>
Message-ID: <CAMuHMdXxoEYV7v-R+o4eMJEiV_xGUgpN6sUbZ95r_qewV5QpRA@mail.gmail.com>
Subject: Re: [PATCH v1 04/35] drm/modes: Introduce 480i and 576i modes
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mateusz Kwiatkowski <kfyatek@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <dom@raspberrypi.com>
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

Hi Maxime,

On Mon, Aug 29, 2022 at 3:30 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Wed, Aug 24, 2022 at 06:42:18PM +0200, Mateusz Kwiatkowski wrote:
> > - Speaking of closed captioning... a lot of different stuff were put in the
> >   blanking interval over the years. Like teletext in Europe. There are projects
> >   like VBIT2 <https://github.com/peterkvt80/vbit2> which intentionally
> >   reconfigure the Raspberry Pi composite output to include the blanking interval
> >   in the framebuffer so that teletext can be output by drawing on the edge of
> >   the "screen" (from the computer point of view).
>
> I'm not sure how we would support this in KMS to be honest. Asking for a
> wider mode and the userspace putting whatever it wants in the margins
> seems like a good choice.

s/wider/higher/

Teletext is transmitted in the "visible" parts of (horizontal) lines, but during
the vertical blank.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
