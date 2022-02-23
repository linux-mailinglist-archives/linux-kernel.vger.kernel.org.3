Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BDF4C1763
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbiBWPoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiBWPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:44:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F02F49246
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:43:44 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so53311247eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNj6ryohEmGxkSudgErczfib5Ibt/V3cLh7GtBRzD10=;
        b=gJaQwx4eevOVwsKrwWXNsstVK35l21ZhxUXcexV97F4OMPT7FBMwqOtg9P1x6V85jW
         CMgV2yl9NHMLDrVtF6f9wSMvDmSt1iGQqEQ4L2z/CeKBU4GbzbO0aPHxLD4VDoKRCVtX
         i/dgoOQ//jF55Uh3YPeiI2eds1LYYSJE3ZtmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNj6ryohEmGxkSudgErczfib5Ibt/V3cLh7GtBRzD10=;
        b=0GXpBIdUODceyFtsdhxHi867iidit+c2Qvn7TEgeJJqgx1X9ZWhQmdUfUg3/0XMIhy
         rVaQ3jMimM1cwD38eHNeq5S6hgPAU5wIf095itAK1Crdw9MyM1hv9JuM0woytc45pYIu
         Xqlxh6GnyAv0JritX1CVbbT7ZVwbY8TP2WsTbzg6lCV5pROMbXJVQv+OdAX2PzIh8UZa
         /7mlS9ZaGmIIbxL7sM+jRaCus3Rv0mpScMFB1R0t6T69c/9iqKmnONixgC4hK1LtZb0/
         bnaAZHHiUzyPn2cdFj+8wAO2MIf3k6t+DYotdWRegkI/6R80Wf6Ai2jGe43MkQZS9GST
         u+Sw==
X-Gm-Message-State: AOAM530EOoSVZC0M+e1NDJHkZYKOSukBdWxCVhL8AAgCzOCAotKNbmZF
        URzyjVh6+UqNUGXzPontCUNy4aWELoDkM19yzjM=
X-Google-Smtp-Source: ABdhPJwOiI9cJS+k1Bmj9VSLq5pplNe2jL/olUnXBL/MqtZ1DfVOCgqAWZfP9KETkcUBtF1bsidmAQ==
X-Received: by 2002:a17:907:1dc4:b0:6ce:f3a8:49b7 with SMTP id og4-20020a1709071dc400b006cef3a849b7mr243892ejc.121.1645631022511;
        Wed, 23 Feb 2022 07:43:42 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id g8sm18107ejt.26.2022.02.23.07.43.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 07:43:41 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id j22so14216474wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:43:40 -0800 (PST)
X-Received: by 2002:adf:e4c2:0:b0:1e3:3e5d:bd65 with SMTP id
 v2-20020adfe4c2000000b001e33e5dbd65mr183769wrm.422.1645631020228; Wed, 23 Feb
 2022 07:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20220222141838.1.If784ba19e875e8ded4ec4931601ce6d255845245@changeid>
 <CACRpkdbQ9U22afR74YiZs95qCm7dnLb2k4_nT3Le__hJPpDGUw@mail.gmail.com> <YhXBIxbx63IXBU7L@pendragon.ideasonboard.com>
In-Reply-To: <YhXBIxbx63IXBU7L@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 23 Feb 2022 07:43:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UV+3PNF=O8Zv4UJK50gvDx=WHbamLLhH5ANZUBeCxjdQ@mail.gmail.com>
Message-ID: <CAD=FV=UV+3PNF=O8Zv4UJK50gvDx=WHbamLLhH5ANZUBeCxjdQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Properly undo autosuspend
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Brian Norris <briannorris@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 22, 2022 at 9:08 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Feb 22, 2022 at 11:44:54PM +0100, Linus Walleij wrote:
> > On Tue, Feb 22, 2022 at 11:19 PM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > The PM Runtime docs say:
> > >   Drivers in ->remove() callback should undo the runtime PM changes done
> > >   in ->probe(). Usually this means calling pm_runtime_disable(),
> > >   pm_runtime_dont_use_autosuspend() etc.
> > >
> > > We weren't doing that for autosuspend. Let's do it.
> > >
> > > Fixes: 9bede63127c6 ("drm/bridge: ti-sn65dsi86: Use pm_runtime autosuspend")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Hm. I know a few places in drivers where I don't do this :/
>
> It seems to be a very common problem indeed, I haven't seen any driver
> yet that uses pm_runtime_dont_use_autosuspend(). We could play a game of
> whack-a-mole, but we'll never win. Could this be solved in the runtime
> PM framework instead ? pm_runtime_disable() could disable auto-suspend.
> If there are legitimate use cases for disabling runtime PM temporarily
> without disabling auto-suspend, then a new function designed
> specifically for remove() that would take care of cleaning everything up
> could be another option.

Yeah, it would be good. It's probably not a yak I have time to shave
right now, though. :(

I _suspect_ that there are legitimate reasons we can't just magically
do it in pm_runtime_disable(). If nothing else I believe there are
legitimate code paths during normal operation that look like this:

  pm_runtime_disable();
  do_something_that_needs_pm_runtime_disabled();
  pm_runtime_enable();

Also: if it were really a simple problem to solve one would have
thought that it would have been solved initially instead of adding
documentation particularly mentioning
pm_runtime_dont_use_autosuspend()

How about a middle ground, though: we could add a devm function that
does all the magic. Somewhat recently devm_pm_runtime_enable() was
added. What if we add a variant for those that use autosuspend, like:

devm_pm_runtime_enable_with_autosuspend(dev, initial_delay)

That would:
* pm_runtime_enable()
* pm_runtime_set_autosuspend_delay()
* pm_runtime_use_autosuspend()
* Use devm_add_action_or_reset() to undo everything.

Assuming that the pm_runtime folks are OK with that, we could
transition things over to the new function once it rolls into
mainline.

So this doesn't magically fix all existing code but provides a path to
make this more discoverable.

-Doug
