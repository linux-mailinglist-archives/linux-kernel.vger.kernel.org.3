Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245BA4C18D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiBWQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiBWQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:38:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851DD56746
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:37:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cm8so35519864edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPh9TCCU1FAJ6L0nw1r/yFMlEhqZ0iSV9KTRMCutr8E=;
        b=LqlwQWPOa8LXnqmHsYoTpK4pvbOYGbQQ34WteGLMrkIism5/Klc4XRpHAKol7aLTvb
         zlqRHuYFwYNvqS42HbRPQYvPlXyznC8WhT63ZydGLurfb6iWZaxbpd2x21IN2BjfpcVp
         BenWI+IUL6RI9X4xoURquHRBIn2YSHISDzImY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPh9TCCU1FAJ6L0nw1r/yFMlEhqZ0iSV9KTRMCutr8E=;
        b=qgn1N09YSUPcTLS0hpwbPkfOZYodc3ZZWgRJBgiWROnT8Wu20xlZxdxWpVsGbdNmN5
         8xAw2ewl3aJ7ES5ThU6i3r8DNYQQycyAvcheCkQobYiCUn9sSKNEBEmuqxa2kkZfYWgK
         jo8IVZgpTDjUj9ifJsubFoYXdNgp8kaq2Tro9hhOn/vIn9T78DsP7EqHqsctCaf8E4eL
         r1gOiWMP/pTaoBK20/v7R3UjRRR1VNiF8dSzORYyPLenIn+t56HAp3pYrXAEi7jTE7u6
         jlCzQKyZRM3L1O4hr7rRQUqLqPrr7NI6b4HqGeFvpvZEe1VbvxzzL/AYPvpNixAhLIZh
         56tA==
X-Gm-Message-State: AOAM531hbdeEo+2P0RV3MrsP60ZwDFMtIuQV5iXehNc2bg78lgWfsKLT
        NcTAKW4PW0jrMoKj4jJ28nQfCNgBaJYUYfNvts8=
X-Google-Smtp-Source: ABdhPJwTjtEKs5/LKMVNYtR6YlH9BNPVwwxz/G9WMjYzKop8E8rUO5l8X0xJgaOsEhGvrJ7oHSZeOQ==
X-Received: by 2002:aa7:d74d:0:b0:410:b60a:c37e with SMTP id a13-20020aa7d74d000000b00410b60ac37emr242128eds.330.1645634278184;
        Wed, 23 Feb 2022 08:37:58 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id 17sm67251eja.57.2022.02.23.08.37.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 08:37:57 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id d17so5724039wrc.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:37:57 -0800 (PST)
X-Received: by 2002:a5d:64ea:0:b0:1ea:8148:6b97 with SMTP id
 g10-20020a5d64ea000000b001ea81486b97mr308399wri.679.1645634277050; Wed, 23
 Feb 2022 08:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20220222141838.1.If784ba19e875e8ded4ec4931601ce6d255845245@changeid>
 <CACRpkdbQ9U22afR74YiZs95qCm7dnLb2k4_nT3Le__hJPpDGUw@mail.gmail.com>
 <YhXBIxbx63IXBU7L@pendragon.ideasonboard.com> <CAD=FV=UV+3PNF=O8Zv4UJK50gvDx=WHbamLLhH5ANZUBeCxjdQ@mail.gmail.com>
 <YhZY+FLTlv7V5BIB@pendragon.ideasonboard.com>
In-Reply-To: <YhZY+FLTlv7V5BIB@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 23 Feb 2022 08:37:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UrNtsY0Adqd40ME1O74w2aaPWsey_ySGDQYEk-rLb4cw@mail.gmail.com>
Message-ID: <CAD=FV=UrNtsY0Adqd40ME1O74w2aaPWsey_ySGDQYEk-rLb4cw@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 7:55 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> > How about a middle ground, though: we could add a devm function that
> > does all the magic. Somewhat recently devm_pm_runtime_enable() was
> > added. What if we add a variant for those that use autosuspend, like:
> >
> > devm_pm_runtime_enable_with_autosuspend(dev, initial_delay)
> >
> > That would:
> > * pm_runtime_enable()
> > * pm_runtime_set_autosuspend_delay()
> > * pm_runtime_use_autosuspend()
> > * Use devm_add_action_or_reset() to undo everything.
> >
> > Assuming that the pm_runtime folks are OK with that, we could
> > transition things over to the new function once it rolls into
> > mainline.
> >
> > So this doesn't magically fix all existing code but provides a path to
> > make this more discoverable.
>
> Sounds like a good idea. I wonder if this could be handled by
> devm_pm_runtime_enable() actually. If a driver calls
> devm_pm_runtime_enable() and then enables auto-suspend, can't the
> runtime PM core reasonably expect that auto-suspend should be disabled
> at .remove() time ? The pm_runtime_disable_action() function could
> disable auto-suspend unconditionally (assuming
> pm_runtime_use_autosuspend() and pm_runtime_dont_use_autosuspend() don't
> need to be balanced, if they do, then I'll just go cry in a corner).

I like your idea. I think you're right that we can just leverage the
existing function. This yak didn't look to hairy, so I posted a patch:

https://lore.kernel.org/r/20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid

I guess now we see what Rafael thinks. ;-)

-Doug
