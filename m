Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6B55470C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357247AbiFVJIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357137AbiFVJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:07:54 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F813A1AF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:06:48 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id c1so23827417qvi.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ct+WoF/8EA0gYLIVTa+7U23fzJ0aSx4jkfEHvfFCTRE=;
        b=e8kc8L6CkT86R8wXfH8H+X7goI4UhzY8+zMUr66kDCkte3RUEJ0RM5TIIrK9oZYVdo
         BircPDiXYkCVFdRsj8VTsWv6NyI/owcYqAprnxzG9exbvy3eAKwZqcYT0KvFGU2XROsP
         lsNsnljviCcHbzFP71jJdE9KVWN2su+kY4NqkarxEGtvyJ0plc3WUsvTsZM9gtx7Ow4o
         XgCE9NgmgP6eIvz3UWf/ULZC4oMmK9LDMXduYVQ+ZcaE2+G6O8XwMFVh/n4qEQDEHcqm
         3zRQsR6DTsoARE1K9VHOi6QbHd3xSS7rgSb+bCbemTpBZPtF65ljbb1dFZy2O1aaX79/
         aTkg==
X-Gm-Message-State: AJIora9mKxlrDI5s8rgKtgUaT2BsdeOX0KKym/8FFyab6p5LjDH9FANJ
        v94BjOxW10k5qsdfYBD7SKfmcw3B/7mOtA==
X-Google-Smtp-Source: AGRyM1s/QJ5sQUNS6dE12knoGaYPJ1n+Kgn0O7ugxVY5kipBz3NG6tb3w1Sko/SXs5+soLFG6xbCFQ==
X-Received: by 2002:a05:6214:518e:b0:470:64d8:ed05 with SMTP id kl14-20020a056214518e00b0047064d8ed05mr1049268qvb.77.1655888807437;
        Wed, 22 Jun 2022 02:06:47 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a25c900b006ab93e0e053sm12545429qko.30.2022.06.22.02.06.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:06:46 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id x38so29070418ybd.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:06:46 -0700 (PDT)
X-Received: by 2002:a05:6902:1141:b0:669:3f2a:c6bb with SMTP id
 p1-20020a056902114100b006693f2ac6bbmr2581553ybu.365.1655888806340; Wed, 22
 Jun 2022 02:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <43645c9b5cd657664c1340d40133f2116c8cef43.1655818025.git.geert+renesas@glider.be>
 <88f11e5c4704bd8510c2c6a171536484a2232f82.camel@nxp.com>
In-Reply-To: <88f11e5c4704bd8510c2c6a171536484a2232f82.camel@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jun 2022 11:06:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAh+m-tuAem0qENGEnuTw9LB_nBO3SXbVAMW8wbBtqiQ@mail.gmail.com>
Message-ID: <CAMuHMdUAh+m-tuAem0qENGEnuTw9LB_nBO3SXbVAMW8wbBtqiQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: imx: i.MX8 bridge drivers should depend on ARCH_MXC
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marek Vasut <marex@denx.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Liu,

On Tue, Jun 21, 2022 at 5:47 PM Liu Ying <victor.liu@nxp.com> wrote:
> On Tue, 2022-06-21 at 15:30 +0200, Geert Uytterhoeven wrote:
> > The various Freescale i.MX8MP display bridges are only present on
> > Freescale i.MX8 SoCs.  Hence add a dependency on ARCH_MXC, to prevent
> > asking the user about these drivers when configuring a kernel without
> > i.MX SoC support.
>
> s/i.MX8MP/i.MX8/

Oops. Fixed.

> For now, only i.MX8qm and i.MX8qxp display bridge drivers are in
> bridge/imx directory, no i.MX8MP display bridge driver.
>
> With this fixed:
> Reviewed-by: Liu Ying <victor.liu@nxp.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
