Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244264736A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbhLMVnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbhLMVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:43:22 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F7BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:43:20 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id n66so24914398oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=TmGwTxtk1ApFzRT5JcuqotjuO1Eq6SC3X6wTg4aSOGc=;
        b=eNaZByPA3A9BMSPWspOZQZYK28rssM3XgZvdRx5XCTDo+TI+Z8nG1+mtIgUfxDnjCQ
         bTEdUbOAJjsIjMzHXemYzUBdwPs2m2wTR//V0+o7cw+D60ALBLxTHVQuUEx5jmat3Cjs
         p1UaXu+fZVvCxOFZfcOs4V3KjhAoTqrodl634=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=TmGwTxtk1ApFzRT5JcuqotjuO1Eq6SC3X6wTg4aSOGc=;
        b=JQoacq42YxiCum7FmvU3dJMr3UmphcuUts+FA3Yo9n4P6FE+9tXgZC/7b8KZmBdAN2
         vobBlP2lJrT1/+EYJCYYRT1KTrWSyArIfbJRqYA0CcgT4M6fnfk/qETgas8/qwRB9NlL
         A9V3Z4EWC2uZ1usaUGGflw4HLICoWEQ33sa8msSPApWn4fIenKGVpwHxcVQrpGsWhanO
         pz1MadgeXiO8nJgxNyFThEl1pid1xhxpe7IH7GvQemGCI7rX/f0V5QdmpBdoYtb+EScX
         bQLQuE2+hhcKQRv87gbMkIRQm4xjTO2G6Qr3p6dEKY9l6bbr5M6rS/XulfiKdl+X9EMI
         Bm+w==
X-Gm-Message-State: AOAM532ttOX83//guJslCEgBnD5QswpjCu91cv+MSZFMAn4r9Z0fTnlL
        JGCvXSbbMtK2Ds/wwU4vHavf5xW4MTJ/g6mTeoR+1g==
X-Google-Smtp-Source: ABdhPJwBmJUtITTggfiBEHtxlPNAqOaF12KYEh1ljweCao7w72Js/U/c7J5QINoBhIaZJpcXb7QiXAChzLKfd0d+7y0=
X-Received: by 2002:a05:6808:211f:: with SMTP id r31mr1129616oiw.64.1639431800144;
 Mon, 13 Dec 2021 13:43:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Dec 2021 13:43:19 -0800
MIME-Version: 1.0
In-Reply-To: <Ya+mV/zuRVVIGVy1@phenom.ffwll.local>
References: <20211202222732.2453851-1-swboyd@chromium.org> <Ya+mV/zuRVVIGVy1@phenom.ffwll.local>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 13 Dec 2021 13:43:19 -0800
Message-ID: <CAE-0n53dnsAdjBUVmDMbcvrSJEE=RPu7PGX_zaWCZ_ZBUAythA@mail.gmail.com>
Subject: Re: [PATCH v4 00/34] component: Make into an aggregate bus
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emma Anholt <emma@anholt.net>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Inki Dae <inki.dae@samsung.com>,
        James Qian Wang <james.qian.wang@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Joerg Roedel <joro@8bytes.org>,
        John Stultz <john.stultz@linaro.org>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Sandy Huang <hjc@rock-chips.com>,
        Saravana Kannan <saravanak@google.com>,
        Sebastian Reichel <sre@kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Will Deacon <will@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2021-12-07 10:22:15)
> On Thu, Dec 02, 2021 at 02:26:58PM -0800, Stephen Boyd wrote:
> > This series is from discussion we had on reordering the device lists for
> > drm shutdown paths[1]. I've introduced an 'aggregate' bus that we put
> > the aggregate device onto and then we probe the aggregate device once
> > all the components are probed and call component_add(). The probe/remove
> > hooks are where the bind/unbind calls go, and then a shutdown hook is
> > added that can be used to shutdown the drm display pipeline at the right
> > time.
> >
> > This works for me on my sc7180 board. I no longer get a warning from i2c
> > at shutdown that we're trying to make an i2c transaction after the i2c
> > bus has been shutdown. There's more work to do on the msm drm driver to
> > extract component device resources like clks, regulators, etc. out of
> > the component bind function into the driver probe but I wanted to move
> > everything over now in other component drivers before tackling that
> > problem.
> >
> > Tested-by tags would be appreciated, and Acked-by/Reviewed-by tags too.
>
> Thanks for pushing this forward. Unfortunately I'm completely burried and
> it's just not improving, so merge plan:
>
> - please get Greg KH to ack the bus/driver core stuff
>
> - please get one of the drm-misc committers we have from Google's Chromeos
>   team (there should be a few by now) to review&push this.

Sounds like a plan. Thanks!

>
> Otherwise I fear this might get stuck and I'd really like to avoid that.
>
