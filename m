Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B1552E122
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbiETAXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiETAXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:23:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF312B032
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:23:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i40so8863188eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkNsmxiQk+nW3UDbjO7QxzvaqncjAzBvhuR1VH6Vk60=;
        b=bA4kB8OhrG3AO6xz5No7HEoss1T72t7wOhdeRdSsdZLYCzD5aJYviGdcdpnznfPifZ
         yuRj+lDxOoXXam02skD8mXDZraaqUDT3pVNFce59ArewYDhYNcYKJahlU2Ir6PagSJtJ
         9VEQUM21705l7JBJccvc9ZdGE5VGkEK28WMdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkNsmxiQk+nW3UDbjO7QxzvaqncjAzBvhuR1VH6Vk60=;
        b=pqRg6tzuaS/hIy4uqmWB4t5ZicqcVOLhKTxSWzz0/Xm30vpxSCFplOc2viC1ogr6xd
         bdKYo2HLlwrGKajMOEI7SMGMpglTZn7suQnrcS/LT1dGKldigkGUIXZ2o6fnOXRZIOUj
         0LTuTgGX4NEC3y3nf0FvvltAdFrGTwpuXWBFpvCOF8NAcqMqpT0juwLS+5aatmpyj0G0
         mroNWR1QjSKcqLTL4dG4bnfH9Ln5VU0PweictlhKCn1CKNUlAcg2w8MuCQ72kFxKw/Ai
         fFcmLhkCdL3OviUz9+qTAi1ZgRbErNNVqcg44Ci79PRzumZrF4hTC72ZSC/bGfWMyW1Q
         5Adg==
X-Gm-Message-State: AOAM530YWp7kWhrFusstoXyRRyI+K6LIaorC5CCkYccezXLr8wfJgO4v
        sLnJ+8BMXP9XWeUqFuf4SYwOAETQeMHPxaO6gBk=
X-Google-Smtp-Source: ABdhPJwUQNQScKvDeDzQQltWTFMY4oQtgUC9hlKrHBnGUUdcyE6V5qyG95VtC+J4HRklt8uIkYoylA==
X-Received: by 2002:a05:6402:1393:b0:42a:c36d:67a6 with SMTP id b19-20020a056402139300b0042ac36d67a6mr8335125edv.158.1653006220789;
        Thu, 19 May 2022 17:23:40 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id qx16-20020a170907b59000b006f3ef214e60sm2553085ejc.198.2022.05.19.17.23.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 17:23:39 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso1242928wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:23:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3c99:b0:392:b49c:7b79 with SMTP id
 bg25-20020a05600c3c9900b00392b49c7b79mr5830883wmb.199.1653006218866; Thu, 19
 May 2022 17:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220509161733.v2.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
In-Reply-To: <20220509161733.v2.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 May 2022 17:23:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWYFDMYvZJWDnV2Yc+5X=NThYnE78aOeMrhrEvBiDLkQ@mail.gmail.com>
Message-ID: <CAD=FV=XWYFDMYvZJWDnV2Yc+5X=NThYnE78aOeMrhrEvBiDLkQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: Document the power requirements for DP AUX transfers
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 9, 2022 at 4:18 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> When doing DP AUX transfers there are two actors that need to be
> powered in order for the DP AUX transfer to work: the DP source and
> the DP sink. Commit bacbab58f09d ("drm: Mention the power state
> requirement on side-channel operations") added some documentation
> saying that the DP source is required to power itself up (if needed)
> to do AUX transfers. However, that commit doesn't talk anything about
> the DP sink.
>
> For full fledged DP the sink isn't really a problem. It's expected
> that if an external DP monitor isn't plugged in that attempting to do
> AUX transfers won't work. It's also expected that if a DP monitor is
> plugged in (and thus asserting HPD) then AUX transfers will work.
>
> When we're looking at eDP, however, things are less obvious. Let's add
> some documentation about expectations. Here's what we'll say:
>
> 1. We don't expect the DP AUX transfer function to power on an eDP
> panel. If an eDP panel is physically connected but powered off then it
> makes sense for the transfer to fail.
>
> 2. We'll document that the official way to power on a panel is via the
> bridge chain, specifically by making sure that the panel's prepare
> function has been called (which is called by
> panel_bridge_pre_enable()). It's already specified in the kernel doc
> of drm_panel_prepare() that this is the way to power the panel on and
> also that after this call "it is possible to communicate with any
> integrated circuitry via a command bus."
>
> 3. We'll also document that for code running in the panel driver
> itself that it is legal for the panel driver to power itself up
> however it wants (it doesn't need to officially call
> drm_panel_pre_enable()) and then it can do AUX bus transfers. This is
> currently the way that edp-panel works when it's running atop the DP
> AUX bus.
>
> NOTE: there was much discussion of all of this in response to v1 [1]
> of this patch. A summary of that is:
> * With the Intel i195 driver, apparently eDP panels do get powered
>   up. We won't forbid this but it is expected that code that wants to
>   run on a variety of platforms should ensure that the drm_panel's
>   prepare() function has been called.
> * There is at least a reasonable amount of agreement that the
>   transfer() functions itself shouldn't be responsible for powering
>   the panel. It's proposed that if we need the DP AUX dev nodes to be
>   robust for eDP that the code handling the DP AUX dev nodes could
>   handle powering the panel by ensuring that the panel's prepare()
>   call was made. Potentially drm_dp_aux_dev_get_by_minor() could be a
>   good place to do this. This is left as a future exercise. Until
>   that's fixed the DP AUX dev nodes for eDP are probably best just
>   used for debugging.
> * If a panel could be in PSR and DP AUX via the dev node needs to be
>   reliable then we need to be able to pull the panel out of PSR. On
>   i915 this is also apparently handled as part of the transfer()
>   function.
>
> [1] https://lore.kernel.org/r/20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> ---
> Hopefully I've resolved everything here to everyone's
> satisfaction. There's no crazy hurry here. I'll give this a week or so
> and then land it on drm-misc if there is no additional discussion.
>
> Changes in v2:
> - Updated wording as per discussion on v1.
> - Updated commit message as per discussion on v1.
> - Add pointer to v1 discussion for future reference.
>
>  include/drm/display/drm_dp_helper.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Pushed to drm-misc-next:

69ef4a192bba drm: Document the power requirements for DP AUX transfers
