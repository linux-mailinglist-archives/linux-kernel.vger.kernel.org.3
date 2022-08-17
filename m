Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C8D59783D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiHQUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHQUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:48:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF7A50F8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:48:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c39so4139521edf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+Cti20S/WWpY7aspWrYZ4xE3P/s0O+PHZV22YRy/CUE=;
        b=RUY2d9i5bIklJBMGlj1kJOw47zUbEvxdY1V+2zngZZk1/gVeOIgKDiz2urgv4l6Cpa
         4SgbFJshe0t5ZmI808R5aNZoUHqzHaqN3nRZzuaTWbgKyuf30NRCp7q12AdrmxbnSCT3
         Hum1AaJKsg24YJxa3NlN8SEYHrrLmnQp1xJAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+Cti20S/WWpY7aspWrYZ4xE3P/s0O+PHZV22YRy/CUE=;
        b=vcqtl1H/7f74Q+ypcx2XV1/V/QzWi9hrQK3U/EcoAIs7Y6A40l4P+LQ/zJa1rNERxZ
         BCZpQwOMnQkAxcBUDUh7Hr+14eImHrJ8/QoDArW4+55vJQeRyXWAf1pZmIje8A+Daw89
         AycuskVqIZFEEm6xndz5ZgtUffJHBh8go2hySFvtUwLRYItcuE+I0dE9hgmDhDa8p3TI
         xAytQsLgjIWEMDvRcV4pWRWmXt2WksIrPLLNqFCOMuWxnTyGVsRUMBse5cawAyKUgiPE
         tIrpUJKP+kMfpqALTZadNC894qmEhxTIYaAvPLGwKNs2fp1saDFL5S6iArPM40nhHXw6
         Y5Kw==
X-Gm-Message-State: ACgBeo2VTSvSTre4JfOFaFUJH64c6r9bY2HYndYFdkqCNhnk62CYi2q2
        wlSaSmnqp9Vi99dfYVDQuXgOjGkui8KOl/uq
X-Google-Smtp-Source: AA6agR6GMfRcLA5TRI5TWMgcz8dnidDsnYaMYcCMqgWFvEnaKgR8VKOEKziQlffCWhtfV7qAChE3ew==
X-Received: by 2002:a05:6402:510c:b0:43e:305c:a4d1 with SMTP id m12-20020a056402510c00b0043e305ca4d1mr23775977edd.35.1660769318676;
        Wed, 17 Aug 2022 13:48:38 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id op9-20020a170906bce900b0072b810897desm7242568ejb.105.2022.08.17.13.48.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 13:48:37 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r16so8288857wrm.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:48:37 -0700 (PDT)
X-Received: by 2002:a05:6000:1564:b0:225:17e4:4084 with SMTP id
 4-20020a056000156400b0022517e44084mr5308854wrz.617.1660769317514; Wed, 17 Aug
 2022 13:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220706191442.1150634-1-swboyd@chromium.org> <CAD=FV=UrYCwm2ByN_5EN3fq-ayMJNjmWfJ5sooRy51ZiCoMcjA@mail.gmail.com>
 <CAF6AEGt_J6f1T+-6KtyCrUJrY2fh7Sz10L1AV1FSe8hueGREtQ@mail.gmail.com> <CAD=FV=W+VWtpTKAoyQpYMFteZy8iYB7-o=ACqkjr7YX7uCxZvg@mail.gmail.com>
In-Reply-To: <CAD=FV=W+VWtpTKAoyQpYMFteZy8iYB7-o=ACqkjr7YX7uCxZvg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Aug 2022 13:48:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9Gr9MyCg2rsKaA-ssSi5e3W5zO9sC56At+ceN4A2XtA@mail.gmail.com>
Message-ID: <CAD=FV=W9Gr9MyCg2rsKaA-ssSi5e3W5zO9sC56At+ceN4A2XtA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Set panel orientation when directly connected
To:     Rob Clark <robdclark@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 20, 2022 at 3:42 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jul 20, 2022 at 1:46 PM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Fri, Jul 8, 2022 at 8:25 AM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Jul 6, 2022 at 12:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Set the panel orientation in drm when the panel is directly connected,
> > > > i.e. we're not using an external bridge. The external bridge case is
> > > > already handled by the panel bridge code, so we only update the path we
> > > > take when the panel is directly connected/internal. This silences a
> > > > warning splat coming from __drm_mode_object_add() on Wormdingler boards.
> > > >
> > > > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > Cc: Douglas Anderson <dianders@chromium.org>
> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > > ---
> > > >
> > > > This relies on commit 5e41b01a7808 ("drm/panel: Add an API to allow drm
> > > > to set orientation from panel") which is in drm-misc
> > > >
> > > >  drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > I don't personally have objections to this, but (to my understanding)
> > > "the future" is that everyone should use panel_bridge. If we made the
> > > move to panel_bridge today then we wouldn't need to do this. In
> > > general I think panel_bridge would end up letting us delete a bunch of
> > > code...
> > >
> > > See commit 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with
> > > panel-bridge") for when this was done by ti-sn65dsi86.
> > >
> > > Then again, I spent a small amount of time looking into this and it's
> > > definitely non-trivial. Still likely worthwhile, but not worth
> > > blocking a tiny fix like this. It also should be fairly obvious that
> > > we should delete this when we switch to panel_bridge.
> > >
> > > Thus:
> > >
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > I'll assume that we'll just snooze this commit until drm-misc-next
> > > merges into a tree that msm-next is based on, which will probably be
> > > the next -rc1. If desired and Acked I could land this in
> > > drm-misc-next, but it's probably not worth it?
> >
> > if you want to land this patch via drm-misc, which might be the
> > easier/faster route, then:
> >
> > Acked-by: Rob Clark <robdclark@gmail.com>
>
> As per discussion on IRC, I'm not going to apply this to drm-misc-next.
>
> Given where we are in the cycle landing in drm-misc-next means it
> won't be in mainline for a couple versions and I suspect that'll cause
> merge conflicts with Dmitry's series [1]. ...and, of course, if
> Dmitry's series lands then we don't even need ${SUBJECT} patch...
>
> So I think the plan is:
>
> 1. Snooze waiting for the next -rc1 since
> drm_connector_set_orientation_from_panel() won't be in mainline until
> then.
>
> 2. If Dmitry's series looks like a long way off, we could land
> ${SUBJECT} patch in msm-next as a stopgap fix.
>
>
> [1] https://lore.kernel.org/r/20220711094320.368062-5-dmitry.baryshkov@linaro.org/

Just checking up. What's the latest thinking here? Do we want to land
Stephen's change as a stopgap?
drm_connector_set_orientation_from_panel() is available in v6.0-rc1.

-Doug
