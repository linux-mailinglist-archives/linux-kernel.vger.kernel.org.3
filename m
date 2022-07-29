Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045085856C7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiG2WMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiG2WMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:12:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808382C66C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:12:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tk8so10717101ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5pUodpWMMYknb87Q/iOWoD6ROI6Lgw19uUzBdPJ3Uyg=;
        b=ccG1+zJ7elZwhNagMS5JcpEVguCuMJpnXq4J+9UD0xVVeLupKVDjJ86X+7fzk2RCY8
         qq6oycJ/rCAUrHbBuK/sk5W9RXbIIiFDikRsuh5+GFMFCH9pJQRG+zSbamJUlvEfuP31
         PUPvv8ZNOeLbnW7w0LPgc4o5CWidkTFzV3vzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5pUodpWMMYknb87Q/iOWoD6ROI6Lgw19uUzBdPJ3Uyg=;
        b=6CGDex1VgVrM+oDkB4jqZQl9Foa9hDT12O8zhIU/9z3Rg5JIfzqdvzlEkCJaisoepd
         1BqTOh4w6gaVu15cZxlWwOU8+h1YFRq3E4PqwR84iTns6H8RrRjAkOJH8VGC/wu2O8jd
         skhIW1VBZSt5aZR26TUOjRj2gKmq015lpcdBSJJatvEw2Qr1PYvtLzEvHYeHxbx77YtQ
         dJI9Stx9noy3RV27/QeoaL9OQ/4i+yRjWuOtElyBkxcj4hNDnU3WBbjJfwE7n/uQcZSD
         mo48GuW13d/G6R7AoS1Jek87zp53cr9gH6TtTX7dHzBTbHQdJ5nkcXw3BNEmQK4MSC7e
         AYeQ==
X-Gm-Message-State: AJIora9Lqcq7I3IEMHac+/2kM+34m9y7Z8ij6siu92IrHylzEjo6IYza
        1alxkLkB0GPg9pLjfJ+uZ44aqWiNWojyFyU0zH0=
X-Google-Smtp-Source: AGRyM1t9lTi1yUpBxbVnuhHDl+qaVqP7pel5U0eZX1468pwQsX9CDVwTPTPIK3pfwHEK1bP/87akNQ==
X-Received: by 2002:a17:907:75f2:b0:72b:564c:465e with SMTP id jz18-20020a17090775f200b0072b564c465emr4093921ejc.689.1659132761604;
        Fri, 29 Jul 2022 15:12:41 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id n20-20020a1709062bd400b00711edab7622sm2144558ejg.40.2022.07.29.15.12.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 15:12:40 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id id17so3165302wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:12:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1e0f:b0:3a3:191c:a3c8 with SMTP id
 ay15-20020a05600c1e0f00b003a3191ca3c8mr3873397wmb.151.1659132759907; Fri, 29
 Jul 2022 15:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220720155445.RFC.1.I2999ac2d08643f0c2f3fe916cca86f8c832c8142@changeid>
 <CAA8EJpombZYHKXKd=rLte0pUaXjep0t7+H-uz_sFTuJwjH3y9A@mail.gmail.com>
In-Reply-To: <CAA8EJpombZYHKXKd=rLte0pUaXjep0t7+H-uz_sFTuJwjH3y9A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 29 Jul 2022 15:12:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUWouY58oX+6iBThz_PiDe1_zrs7Ls4gBKER8bo_Y8QQ@mail.gmail.com>
Message-ID: <CAD=FV=VUWouY58oX+6iBThz_PiDe1_zrs7Ls4gBKER8bo_Y8QQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/panel-edp: Allow overriding the eDP EDID
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>,
        LinusW <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 21, 2022 at 4:36 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 21 Jul 2022 at 01:55, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > I found that writing to `/sys/kernel/debug/dri/*/eDP*/edid_override`
> > wasn't working for me. I could see the new EDID take effect in
> > `/sys/class/drm/card*-eDP*/edid` but userspace wasn't seeing it..
> >
> > The problem was that panel-edp was caching the EDID that it read and
> > using that over and over again.
> >
> > Let's change panel-edp to look at the EDID that's stored in the
> > connector. This is still a cache, which is important since this
> > function is called multiple times and readin the EDID is slow, but
> > this property is automatically updated by drm_get_edid() (which reads
> > the EDID) and also updated when writing the edid_override in debugfs.
> >
> > Fixes: 63358e24ee79 ("drm/panel: panel-simple: Cache the EDID as long as we retain power")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> A different proposal for you to consider:
> Change drm_get_edid/drm_do_get_edid to return int rather than struct
> edid, while caching the EDID in the connector. Or maybe add a new API
> drm_read_edid() and make drm_get_edid() deprecated in favour of it.
> The goal should be to let all drivers use connector-cached EDID rather
> than getting  the EDID, parsing it and kfree()ing it immediately
> afterwards.

I think the majority of drivers don't actually want the cached EDID
behavior so the edp-panel case is actually pretty rare. For everyone
else I think DRM is handling things in a pretty reasonable way.
Looking closely, it looks like there have been a bunch of patches
landed in this area recently and so I assume people are happy enough
with the current design for the majority of cases.

I guess your point though, is that the way I'm using the API right now
in ${SUBJECT} patch is a bit gross and maybe the DRM core needs a
helper of some sort for this case? Essentially what we're saying is
that we have inside knowledge this is a built-in panel and thus the
EDID will never change and it's a waste of time to read it again and
again. We could somehow tell the DRM core that.

I guess I could add a function like drm_edid_read_if_needed(). That
would essentially use the existing blob if it was there and read it
otherwise. Does that work? Basically:

def drm_edid_read_if_needed(...):
  if (connector->edid_blob_ptr)
    return dupe_edid(connector->edid_blob_ptr);
  return drm_edid_read(...);

I guess maybe we'd want a _ddc variant too.

Adding Jani since the recent patches I see touching this were his and
there are even comments there about what to do about drivers that want
to cache the EDID.


> Most probably we should be able to move
> drm_connector_update_edid_property() into drm_do_get_edid() and drop
> it from the rest of the code. This might require additional thought
> about locking, to ensure that nobody pulls the cached edid out from
> under our feet.

This all looks like it's moving now, actually. Looking around at
recent changes, I see that now the property gets updated in a
different call.

Old (deprecated)
1. drm_get_edid() <-- Updates the EDID property
2. drm_add_edid_modes()

New:
1. drm_edid_read()
2. drm_edid_connector_update() <-- Updates the EDID property


 > Extra "bonus" points to consider:
> - Maybe it's time to add get_edid() to the drm_panel interface, teach
> panel_bridge about it and let drm_bridge_connector handle all the
> details?
>
> So, while this looks like a longer path, I think it's worth checking
> that we can refactor this piece of code.

It's certainly interesting to consider. At the moment, though, it
doesn't look super easy to do. Points to note:

1. We don't necessarily want to cache the EDID for all display types.
For builtin panels it makes sense to do so, but it's less obvious for
external displays. _In theory_ we could try to cache the EDID for
external devices if we're really certain that we'll notice when
they're unplugged / re-plugged again but I'm not convinced that all
drivers always handle this. In any case, I tend to assume that when
we're dealing with external displays we're a little less interested in
trying to optimize all of the milliseconds away. If nothing else there
are hundreds of milliseconds of hotplug detect debounce happening for
external displays. Yes, we could have a rule about only caching the
EDID only for eDP displays but then the motivation of moving it out of
edp-panel and to drm_bridge_connector is a lot less.

2. At the moment, drm_bridge_connector only calls get_modes() if it
doesn't have get_edid() implemented. At the moment the panel-edp code
actually _combines_ the EDID and any hardcoded modes that were
specified. I think we'd have to resolve this difference if we do what
you suggest. The panel-edp behavior comes from before the split out of
panel-simple and dates from 2013 when panel-simple was first added.
Certainly we could arbitrarily change one behavior or the other but I
don't know what the fallout would be.

3. We still don't have universal conversion to panel_bridge and
drm_bridge_connector. Some drivers are still calling the panel
functions directly. Until everything is converted it will be extra
cruft / scaffolding to make this change without breaking those calling
the panel directly. I don't think there's enough of a hurry to do this
that it's worth the extra cruft. There just aren't that many built-in
panels that read an EDID that aren't handled by the generic panel-edp.


-Doug
