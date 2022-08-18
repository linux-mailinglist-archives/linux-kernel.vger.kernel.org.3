Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E6597A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 02:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbiHRAFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 20:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiHRAFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:05:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553F98CA8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:05:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x23so163345pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=9NPHiwtqPNxre28yxS9d6mP+OzEpWsKHpFGaBIQfFHo=;
        b=c+DJzCuX9b6UWy6q7vk0GytTDEQMUQyzBFnpcsDiJ9tCy1ABA43FcTGNlAIPnVqPMr
         QaWw66gDAEQTgLy3/0VfJ/04Z1K6nN9aaW4pTRhqT67BTeSJxgbBGXKw+20Voq541cRj
         ODOwicIGH/Mx7CEEKBuzJ8CGkQn8XZ+Tm1UMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9NPHiwtqPNxre28yxS9d6mP+OzEpWsKHpFGaBIQfFHo=;
        b=XaneukyKhdgIP22X4PBsnwTdl0PkOyHT2Dc/W1dXPWtdiITw5R0SfjaOucz5nGmOVo
         UZ8gAxzNHSUq8mzPW5JDR4qtIyuGVll7enP4VCl8PmYkR1iyEgSgpds6U/mpTJLGMHMd
         c3Z/0BBK8Z43Bj42asaEzPNMbb1zA8k64JgCjrodNAbyguQFF+LVBGttKkNmrjDs1EH1
         jqpH9gdgGTZdBAodJszDMi692MCLpYAgJpcgMt23cViY5NPld8b16HCM0TXuStwrm8U3
         sVZCaWF0qfnmNr2OqqerVfdwJIpTafrWymkff2Ud2fSdHo848QGfwBjZkc4kowppMBqu
         e/GA==
X-Gm-Message-State: ACgBeo224n+CpJF5FI4L8b0dfKwaEHe59RIiuYaOaXgguW+mQY4iKuM/
        V9LOxJC6VapeCIpIuRZ3SRGjHA==
X-Google-Smtp-Source: AA6agR7/+tWwxFjVP+riQJr2uC9V324WisdRiSzdK+MoNM0HMBujlY6r7A39hGMOzongkyP5xfr1jQ==
X-Received: by 2002:a17:902:d50b:b0:172:a41f:b204 with SMTP id b11-20020a170902d50b00b00172a41fb204mr384268plg.70.1660781119748;
        Wed, 17 Aug 2022 17:05:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d8a:a33:bbd8:836e])
        by smtp.gmail.com with ESMTPSA id g4-20020aa79f04000000b0052516db7123sm112413pfr.35.2022.08.17.17.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 17:05:19 -0700 (PDT)
Date:   Wed, 17 Aug 2022 17:05:16 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Zhang Zekun <zhangzekun11@huawei.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        xuqiang36@huawei.com
Subject: Re: [PATCH -next] drm/bridge: Add missing clk_disable_unprepare() in
 analogix_dp_resume()
Message-ID: <Yv2CPBD3Picg/gVe@google.com>
References: <20220816064231.60473-1-zhangzekun11@huawei.com>
 <CA+ASDXMGbJSJ2PC_4_2HL_01hO2aDoiWyxmosvtOze43aaeWpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXMGbJSJ2PC_4_2HL_01hO2aDoiWyxmosvtOze43aaeWpw@mail.gmail.com>
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 01:34:13PM -0700, Brian Norris wrote:
> On Mon, Aug 15, 2022 at 11:46 PM Zhang Zekun <zhangzekun11@huawei.com> wrote:
> >
> > Add the missing clk_disable_unprepare() before return from
> > analogix_dp_resume() in the error handling case.
> >
> > Fixes: 211f276ed3d9 ("drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time")
> > Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Hmm, actually I'm going to have to retract that now that I've given it
some more testing locally. I happen to have a system where I commonly
hit this error case, and I'm thinking commit 211f276ed3d9 is actually
wrong, and so we shouldn't be "fixing" its error handling -- we should
be reverting it.

In particular, drm_panel_prepare()/drm_panel_unprepare() are *not*
reference-counted APIs, and this is already managed by
analogix_dp_bridge_disable(), which is called by the core DRM helpers
during suspend. Thus, analogix_dp_suspend()/analogix_dp_resume() is
serving to be an unwanted *second* client trying to {un,}prepare the
panel.

The panel drivers tend to handle this OK to some extent, as they (e.g.,
panel-edp.c) guard against redundant operations, but *we* don't --
notice that analogix_dp_suspend() ignores drm_panel_unprepare() errors
for one.

Also, I don't believe device management really handles resume() failures
quite right; in the end, this patch ends up un-balancing the clk count
on the RK3399 Gru-Bob systems I'm testing.

(Side note: every other bridge driver seems to ignore
drm_panel_prepare() failures.)

It's possible this was correct (or at least, not terribly broken) back
when it was written, but then, the DRM core frameworks have evolved
since then. Today, I think we do not need to manage the panel state
directly in suspend()/resume().

All in all:

Nacked-by: Brian Norris <briannorris@chromium.org>
Tested-and-failed-by: Brian Norris <briannorris@chromium.org>

Now separately, I have to figure out why I'm hitting this error case in
the first place...
