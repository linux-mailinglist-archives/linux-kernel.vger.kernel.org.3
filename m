Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF904C776D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiB1STg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbiB1SSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:18:14 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3D3AC050
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:54:53 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p14so26378842ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKyFAXCmKAYNuarZ8yzonNl7KAxrf0Qm9q5cbYgdEIY=;
        b=JDy8fgGUxf0IGJHfk/O0WyiqfUorrv0vNRQq82dCqBFpjXsWqco4CzrVWvadRg1/0t
         n+RDd3ztRNk5y4or+DUO9bjKQaeqkhnkPAXva+M2qMDwMS9w1ybbP4a+pECwFE+qimRA
         Uk39Oshxgwz/pp7FehPY5V1w9jkfkplrbf25w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKyFAXCmKAYNuarZ8yzonNl7KAxrf0Qm9q5cbYgdEIY=;
        b=mQzE5CuL74draORiucHV96UhDK+DIQ+kHPzSDE5Eh9UBkLQlloFHyFEUcn0PObQbph
         Xc3s054DBDf6Ui/GRhes99rCEwJG7gAPesKGztMy/ROqoTj+8IxBK457ILbXvgyZ8i5M
         1S4bJq3UFT5rLJFmTcsB1Um5RGSo5Hw+UPU4w4pKn8zgZs9EjSthSUaeDYgIVcWz53Z5
         v0P9ZCT1hfpy0VK48aT/tAx8+0SG5fYmXtFlVOC2hy4Ft6uoFHittXjBYUGwtFIW8Dt5
         h+ZVXb3FrKp8w6tpwxRpspm+biljLieSwx7udZ+IGQLThsh0AzAEfK8VllLfunJKOhQH
         eAOQ==
X-Gm-Message-State: AOAM530LOAf3W5Opq3zX4+i9M7R08neY1WSv8GGHl7mb57XiJMYzPEKo
        jzAqaO+scRiQ9WPOQS/0TPPEW2tkk0c10w==
X-Google-Smtp-Source: ABdhPJwx+OlBimZvHKZi4UYPcNaywTvZFFyIJLMncMm4n0aMyV4bB4shzMKBR4A/gx2Xc/5MPxghTw==
X-Received: by 2002:a17:907:9691:b0:6d1:711d:9050 with SMTP id hd17-20020a170907969100b006d1711d9050mr16625508ejc.755.1646070891585;
        Mon, 28 Feb 2022 09:54:51 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id n24-20020a509358000000b00410bedd9eb4sm6463795eda.88.2022.02.28.09.54.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 09:54:50 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id j17so16776712wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:54:49 -0800 (PST)
X-Received: by 2002:a5d:6543:0:b0:1ef:7194:3efc with SMTP id
 z3-20020a5d6543000000b001ef71943efcmr12481297wrv.422.1646070889301; Mon, 28
 Feb 2022 09:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20220222141838.1.If784ba19e875e8ded4ec4931601ce6d255845245@changeid>
 <CACRpkdbQ9U22afR74YiZs95qCm7dnLb2k4_nT3Le__hJPpDGUw@mail.gmail.com>
 <YhXBIxbx63IXBU7L@pendragon.ideasonboard.com> <CAD=FV=UV+3PNF=O8Zv4UJK50gvDx=WHbamLLhH5ANZUBeCxjdQ@mail.gmail.com>
 <YhZY+FLTlv7V5BIB@pendragon.ideasonboard.com>
In-Reply-To: <YhZY+FLTlv7V5BIB@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Feb 2022 09:54:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ux9aPqNnbs4vj1EO49smW7f6VVm4VyGTy246QjGUfqHg@mail.gmail.com>
Message-ID: <CAD=FV=Ux9aPqNnbs4vj1EO49smW7f6VVm4VyGTy246QjGUfqHg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Hi Doug,
>
> On Wed, Feb 23, 2022 at 07:43:27AM -0800, Doug Anderson wrote:
> > On Tue, Feb 22, 2022 at 9:08 PM Laurent Pinchart wrote:
> > > On Tue, Feb 22, 2022 at 11:44:54PM +0100, Linus Walleij wrote:
> > > > On Tue, Feb 22, 2022 at 11:19 PM Douglas Anderson wrote:
> > > > >
> > > > > The PM Runtime docs say:
> > > > >   Drivers in ->remove() callback should undo the runtime PM changes done
> > > > >   in ->probe(). Usually this means calling pm_runtime_disable(),
> > > > >   pm_runtime_dont_use_autosuspend() etc.
> > > > >
> > > > > We weren't doing that for autosuspend. Let's do it.
> > > > >
> > > > > Fixes: 9bede63127c6 ("drm/bridge: ti-sn65dsi86: Use pm_runtime autosuspend")
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > >
> > > > Hm. I know a few places in drivers where I don't do this :/
> > >
> > > It seems to be a very common problem indeed, I haven't seen any driver
> > > yet that uses pm_runtime_dont_use_autosuspend(). We could play a game of
> > > whack-a-mole, but we'll never win. Could this be solved in the runtime
> > > PM framework instead ? pm_runtime_disable() could disable auto-suspend.
> > > If there are legitimate use cases for disabling runtime PM temporarily
> > > without disabling auto-suspend, then a new function designed
> > > specifically for remove() that would take care of cleaning everything up
> > > could be another option.
> >
> > Yeah, it would be good. It's probably not a yak I have time to shave
> > right now, though. :(
>
> I don't insist on shaving that yak right now :-) This patch is fine.

Landed in drm-misc-fixes:

26d347434829 drm/bridge: ti-sn65dsi86: Properly undo autosuspend

-Doug
