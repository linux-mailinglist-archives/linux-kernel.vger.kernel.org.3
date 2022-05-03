Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0851924E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbiECXae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiECXaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:30:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5D23DDF6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:26:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba17so1459110edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 16:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmRfPAr6JZvSMMEYps49l7OQt2BG72EiV04cQ5yBwG8=;
        b=Qp6K9wf6dlpNyoy939Dn6hh5itEXUXpYYLAyjFahUWzal31jv7FTaHbho8tYaKYLZj
         cODleYspomtiXLDJM25z+o9AzVGfXqevKn2foOvcnS1mn5lJVk9Xhebs8kWBJP1FmBc0
         kOJP9tqSPF9DOLEoXKPHYw2BfTgwksMKucSwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmRfPAr6JZvSMMEYps49l7OQt2BG72EiV04cQ5yBwG8=;
        b=61ZGw3K3XWYgg0uxq/fMOsv26vpJ2gIWR+amv0+kh2J+Dwk9ekCgQNomqpMLTwtAna
         nQaTCcUl1W1oqzFVHnclcd0+ekXNhw1fNDwUipiOuO1DpjRmYrB5B2rK3nlpBQk2UF23
         qoxSDthfuZe89p2sSAz9iJUj/YSqX8XgEWbH86y3WvksnH2YloEAZWoUo2p651/gyYdD
         2PgHaYWZBVEB4efZxgkhXnmLOqP6qXNVFuat+n/qR3vcdi1WvqH/PBZ6q0i9bqk55bVD
         f3QpU3eTcbWn9O7o0JHo2l5kCzaLqPvwOsV7u6rVyCui2QvM7oYmw4ndmT0sB3va2vdv
         Yqhw==
X-Gm-Message-State: AOAM532pa3wldxBh8bVUgzssNHLg9vMKLWceuogbQZFjm6F6pdUcBwgX
        WrsvBTVSWIa+aj/XQDqpI5lLa+9KdQXrKLmI
X-Google-Smtp-Source: ABdhPJxtE2xnqCQ/1x4Rw3XJ9W80xJeSgBQdFuO1oVQlKn8AYc/C0tv4YolmRgzRQ+4FsrTKGlEBMw==
X-Received: by 2002:a05:6402:c9c:b0:425:d5e0:b69 with SMTP id cm28-20020a0564020c9c00b00425d5e00b69mr20361960edb.271.1651620413658;
        Tue, 03 May 2022 16:26:53 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id ml13-20020a170906cc0d00b006f3ef214e08sm5030217ejb.110.2022.05.03.16.26.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 16:26:53 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id m62so10672690wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 16:26:53 -0700 (PDT)
X-Received: by 2002:a7b:c4c8:0:b0:394:26c5:b79e with SMTP id
 g8-20020a7bc4c8000000b0039426c5b79emr5256168wmk.15.1651620401765; Tue, 03 May
 2022 16:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220418171757.2282651-1-dianders@chromium.org>
In-Reply-To: <20220418171757.2282651-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 16:26:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBwkSSKHd+EorS54gEtiqpZLbCmmoXW3X7duFvo77Bog@mail.gmail.com>
Message-ID: <CAD=FV=XBwkSSKHd+EorS54gEtiqpZLbCmmoXW3X7duFvo77Bog@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] drm/dp: Introduce wait_hpd_asserted() for the DP
 AUX bus
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Kees Cook <keescook@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 18, 2022 at 10:18 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> This is the 2nd four patches from my RFC series ("drm/dp: Improvements
> for DP AUX channel") [1]. I've broken the series in two so we can make
> progress on the two halves separately.
>
> v2 of this series changes to add wait_hpd_asserted() instead of
> is_hpd_asserted(). This allows us to move the extra delay needed for
> ps8640 into the ps8640 driver itself.
>
> The idea for this series came up during the review process of
> Sankeerth's series trying to add eDP for Qualcomm SoCs [2].
>
> This _doesn't_ attempt to fix the Analogix driver. If this works out,
> ideally someone can post a patch up to do that.
>
> [1] https://lore.kernel.org/r/20220409023628.2104952-1-dianders@chromium.org/
> [2] https://lore.kernel.org/r/1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com/
>
> Changes in v3:
> - Don't check "hpd_asserted" boolean when unset.
> - Handle errors from gpiod_get_value_cansleep() properly.
>
> Changes in v2:
> - Change is_hpd_asserted() to wait_hpd_asserted()
>
> Douglas Anderson (4):
>   drm/dp: Add wait_hpd_asserted() callback to struct drm_dp_aux
>   drm/panel-edp: Take advantage of wait_hpd_asserted() in struct
>     drm_dp_aux
>   drm/panel: atna33xc20: Take advantage of wait_hpd_asserted() in struct
>     drm_dp_aux
>   drm/bridge: parade-ps8640: Provide wait_hpd_asserted() in struct
>     drm_dp_aux
>
>  drivers/gpu/drm/bridge/parade-ps8640.c        | 34 +++++++++------
>  drivers/gpu/drm/panel/panel-edp.c             | 33 ++++++++++-----
>  .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 41 +++++++++++++------
>  include/drm/dp/drm_dp_helper.h                | 26 ++++++++++++
>  4 files changed, 98 insertions(+), 36 deletions(-)

It's been about 2 weeks and I haven't seen any review. Dmitry: since
this came up due to your feedback, any chance you'd be willing to
review at least the drm-framework pieces? Philip is no longer on the
Chrome OS team, so I suspect he won't be reviewing the ps8640 patches.
Stephen: maybe you'd be willing to?

Thanks!

-Doug
