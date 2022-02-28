Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C797D4C79AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiB1UHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiB1UHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:07:48 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E334F454
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:07:08 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q5so14277492oij.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3/hnEGttHw+ykEYwuEW4fvQITLLLeGWeScAdvHl/KA=;
        b=gma3fcbTcxZs3ntTjPMhGnHZHMQhmpr/uq9NeQaA/FpHt4PaWcWXyyH8LNzrSfx0a6
         hWWWhBwmCCtiQdtL9EGlRtEH8eX0XZkWrQPYviWFPnRfcZ58Bo9uYvkT9gadQpsFyn4l
         OGvWJt25QD5DNWSKVbQC9N8mNXyRpjj5T5esY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3/hnEGttHw+ykEYwuEW4fvQITLLLeGWeScAdvHl/KA=;
        b=ECIBdhIx6G5ckwIUjEF+X127dWFZIXiig1eeWxxM6+uZ0QsttnT115jLOWQQWrm8sa
         GUyATT5iKq4o4Q5BQsAFC7jhV8nSnm/vYm1ZkIygb23lr9zV6ft7BWko0UcS2tL8DBOq
         u0cf9PmmYmeWQgUjk/xu8n+NGmpCtXGYLwTBUhEoPEHapZ+NXRf84dMrHsNTLZVSfRuo
         B0xLY90asJOgkoqQk3/N06XGV8ZPPJQTHMOh9PE1oubJ/6GB2eVxZTu87abJLLxDX75Z
         HH2e3bTgueZffu28opc8HuAp/QDw7UMPITpofVH5PWXCc5hbbhfA5p2uFEgf+t7j5MLt
         n9cg==
X-Gm-Message-State: AOAM5308XN7U+knopbkUYPbOqErfY5roKMbS9lI76o94kYY1vluFBA8x
        P2pcW23abPkNs1HBNWr/quIV12qiON0GXw==
X-Google-Smtp-Source: ABdhPJzDYsNn48unXYH4O3iS+uiYeYCxWy4BO4tIycIPT7ENVeXV7f7vgfTsFpMEqN3tEDZd18vWdw==
X-Received: by 2002:a05:6808:f93:b0:2d4:f855:aadd with SMTP id o19-20020a0568080f9300b002d4f855aaddmr9989240oiw.21.1646078827617;
        Mon, 28 Feb 2022 12:07:07 -0800 (PST)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id u15-20020a056870700f00b000d180722f8dsm4839242oae.36.2022.02.28.12.07.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:07:07 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id x6-20020a4a4106000000b003193022319cso20085058ooa.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:07:07 -0800 (PST)
X-Received: by 2002:aca:5e86:0:b0:2ce:de77:5256 with SMTP id
 s128-20020aca5e86000000b002cede775256mr12030360oib.117.1646078402626; Mon, 28
 Feb 2022 12:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20220215235420.1284208-1-briannorris@chromium.org>
 <20220215155417.2.Ic15a2ef69c540aee8732703103e2cff51fb9c399@changeid> <6344d1828760d4d8625a87243fcc5f5b1096b9d4.camel@oss.nxp.com>
In-Reply-To: <6344d1828760d4d8625a87243fcc5f5b1096b9d4.camel@oss.nxp.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 28 Feb 2022 11:59:51 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOFcmLO_UBfzZ37NmQ3i3n_=5XPcHa_7=OLFvg6xg=YHg@mail.gmail.com>
Message-ID: <CA+ASDXOFcmLO_UBfzZ37NmQ3i3n_=5XPcHa_7=OLFvg6xg=YHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/atomic: Force bridge self-refresh-exit on CRTC switch
To:     Liu Ying <victor.liu@oss.nxp.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        stable <stable@vger.kernel.org>, Sean Paul <sean@poorly.run>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Mon, Feb 28, 2022 at 1:02 AM Liu Ying <victor.liu@oss.nxp.com> wrote:
> On Tue, 2022-02-15 at 15:54 -0800, Brian Norris wrote:
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -1011,9 +1011,19 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
> >               return drm_atomic_crtc_effectively_active(old_state);
> >
> >       /*
> > -      * We need to run through the crtc_funcs->disable() function if the CRTC
> > -      * is currently on, if it's transitioning to self refresh mode, or if
> > -      * it's in self refresh mode and needs to be fully disabled.
> > +      * We need to disable bridge(s) and CRTC if we're transitioning out of
> > +      * self-refresh and changing CRTCs at the same time, because the
> > +      * bridge tracks self-refresh status via CRTC state.
> > +      */
> > +     if (old_state->self_refresh_active && new_state->enable &&
> > +         old_state->crtc != new_state->crtc)
> > +             return true;
>
> I think 'new_state->enable' should be changed to 'new_state->active',
> because 'active' is the one to enable/disable the CRTC while 'enable'
> reflects whether a mode blob is set to CRTC state.  The overall logic
> added above is ok to me. Let's see if others have any comments.

Thanks for the review, and good catch. This actually shows that most
of my development was before commit 69e630016ef4 ("drm/atomic: Check
new_crtc_state->active to determine if CRTC needs disable in self
refresh mode"). In fact, the "state->enable" condition was included
here mostly as a complement to the "!state->enable" condition that was
present previously, and I didn't adapt it properly upon rebase.

In practice, this portion of the condition is not needed at all; we
really want to exit PSR on CRTC-switch regardless of the new-CRTC
state. So rather than change "enable" to "active", I plan to remove it
entirely.

I'll give it some local tests and send v2 eventually.

Thanks,
Brian
