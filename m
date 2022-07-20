Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCCE57C031
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiGTWml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiGTWmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:42:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7771948CA0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:42:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w12so117131edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KuBSeD48AXgXk0Y7RnBVCdR0V4hjzjRzCq3VFtUSmXU=;
        b=hM1UrZ2kalbQlptKuH3fj5NcVp93Bz/8tn9oJq5IQEFtIepQAjgmF2oYEksVjL31KB
         e9LMOlkKA3bfMgkiuGzd1pbAGoeWM1l3rCYMAEyTFiFQbIUVXsUfBgcDxyeIpATWToPj
         DsMiLq1btPhMB8rNiehlMRFMF/tlaDAlKu2qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KuBSeD48AXgXk0Y7RnBVCdR0V4hjzjRzCq3VFtUSmXU=;
        b=WirauCga/BDxVNSlcd1p6ztZIXAmkyKVtw3iIBJo8ll0HuTqWBSMh54DKQM46+ZKdt
         9yNmSL7dauSFuKAYbYnfhLfOH/pnxcSKq9cGqq09cAMPw5oH/cVBdwg0wX1q//WSdVUw
         0V9Xor4bLb1iTTjRSSORVJR3E8rj8cy9LWGgrvecLVj9swkZCs7vZCrHBQY2+78gnuhc
         J1bGF2n/uoI+bwkVQua8q/LR5kSPlf6hOwTcI8tNS6ZTDYMJ3/MvftvXOPpvH+lTHt6i
         emZiJRj9VJ6igkOW46K8oqDGL0rrfyUaLYByIUTjah0Z0hbmAtia8whu7Z1GMI3XxgPC
         KmgA==
X-Gm-Message-State: AJIora8OaNxLj0qJoaXAOU73CtXIy9gTLpRb+wYvtm0PwegGN+XK7NOB
        IOWA5/vOh/otTLjyYl4JDieK+m18chiwca0e
X-Google-Smtp-Source: AGRyM1tRc0UcZWxmInfx7PQT1j/kr6AZ6xeyUlllulgQRYcJ64zFudbcmkptsHJuz533pYJESkdPJw==
X-Received: by 2002:a05:6402:34c3:b0:43a:c323:274f with SMTP id w3-20020a05640234c300b0043ac323274fmr54863726edc.67.1658356955852;
        Wed, 20 Jul 2022 15:42:35 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id y3-20020aa7ccc3000000b0043577da51f1sm112068edt.81.2022.07.20.15.42.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 15:42:34 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id e15so22818701wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:42:34 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr32970096wrn.138.1658356953852; Wed, 20
 Jul 2022 15:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220706191442.1150634-1-swboyd@chromium.org> <CAD=FV=UrYCwm2ByN_5EN3fq-ayMJNjmWfJ5sooRy51ZiCoMcjA@mail.gmail.com>
 <CAF6AEGt_J6f1T+-6KtyCrUJrY2fh7Sz10L1AV1FSe8hueGREtQ@mail.gmail.com>
In-Reply-To: <CAF6AEGt_J6f1T+-6KtyCrUJrY2fh7Sz10L1AV1FSe8hueGREtQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Jul 2022 15:42:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+VWtpTKAoyQpYMFteZy8iYB7-o=ACqkjr7YX7uCxZvg@mail.gmail.com>
Message-ID: <CAD=FV=W+VWtpTKAoyQpYMFteZy8iYB7-o=ACqkjr7YX7uCxZvg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 20, 2022 at 1:46 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Jul 8, 2022 at 8:25 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Jul 6, 2022 at 12:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Set the panel orientation in drm when the panel is directly connected,
> > > i.e. we're not using an external bridge. The external bridge case is
> > > already handled by the panel bridge code, so we only update the path we
> > > take when the panel is directly connected/internal. This silences a
> > > warning splat coming from __drm_mode_object_add() on Wormdingler boards.
> > >
> > > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > > Cc: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >
> > > This relies on commit 5e41b01a7808 ("drm/panel: Add an API to allow drm
> > > to set orientation from panel") which is in drm-misc
> > >
> > >  drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > I don't personally have objections to this, but (to my understanding)
> > "the future" is that everyone should use panel_bridge. If we made the
> > move to panel_bridge today then we wouldn't need to do this. In
> > general I think panel_bridge would end up letting us delete a bunch of
> > code...
> >
> > See commit 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with
> > panel-bridge") for when this was done by ti-sn65dsi86.
> >
> > Then again, I spent a small amount of time looking into this and it's
> > definitely non-trivial. Still likely worthwhile, but not worth
> > blocking a tiny fix like this. It also should be fairly obvious that
> > we should delete this when we switch to panel_bridge.
> >
> > Thus:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > I'll assume that we'll just snooze this commit until drm-misc-next
> > merges into a tree that msm-next is based on, which will probably be
> > the next -rc1. If desired and Acked I could land this in
> > drm-misc-next, but it's probably not worth it?
>
> if you want to land this patch via drm-misc, which might be the
> easier/faster route, then:
>
> Acked-by: Rob Clark <robdclark@gmail.com>

As per discussion on IRC, I'm not going to apply this to drm-misc-next.

Given where we are in the cycle landing in drm-misc-next means it
won't be in mainline for a couple versions and I suspect that'll cause
merge conflicts with Dmitry's series [1]. ...and, of course, if
Dmitry's series lands then we don't even need ${SUBJECT} patch...

So I think the plan is:

1. Snooze waiting for the next -rc1 since
drm_connector_set_orientation_from_panel() won't be in mainline until
then.

2. If Dmitry's series looks like a long way off, we could land
${SUBJECT} patch in msm-next as a stopgap fix.


[1] https://lore.kernel.org/r/20220711094320.368062-5-dmitry.baryshkov@linaro.org/

-Doug
