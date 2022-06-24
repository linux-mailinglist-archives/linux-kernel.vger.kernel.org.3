Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9110755A06B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiFXR6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiFXR6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:58:09 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D910FCD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:58:06 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-101d2e81bceso4844255fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqe2BcnXvHPlqIWzjEeLMU7FqAv/n1XXHRJeEUKzlKg=;
        b=Kwt9moQUmYxkfufWsGqYBe5lp3LxFQbCnc0bamVdgN/b93sQhP6MEbkSTB7dkyROlE
         EyqGapHYCUabHsQjh7Hx6PJftkV7ojjZ4a5esOjA/2X0G5Xr6i0M/y2yRW98HfqLoNgG
         Tx/vQZXQDex2uzamvTdL9PY543Zsz0xr9Ggx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqe2BcnXvHPlqIWzjEeLMU7FqAv/n1XXHRJeEUKzlKg=;
        b=mra8FLixSutxix2Gw7G0XZwIpLWmufyVKNeyXLXJ0HNqccZuVhBzA823qH5niUUBtD
         UWsrqLqvAwbcpbahIeSJo3hOhY2P2dGyjkYu22tZ7934WrRLsXdRboADT9S4e3EIdlS3
         3VFXOq5xSMMDYGS6hSgjsbmKbnTuYpm1KH9PtHqV1GJjzkcGjinSfuE5274CmgQmDEmj
         OZegntQUAvro/qY1ee/q3Bibspmr68+/2n62h5puh/9U+g6t0K6E6Ff1BrhcFAws6W6g
         OIo7/603ERmm0EOaUsbvf44nX7mmF8l21uMGfVs/itlk7gPq1qmYldc2fSZirAMyaJxA
         8qPA==
X-Gm-Message-State: AJIora/uf3EaVJQmfyGaF1WcmFsqvGfxz3LelePFkjD674lvB4+bmtiL
        /52sN1glbGEOjc7HRLSf9j2cStIU1a/lEQ==
X-Google-Smtp-Source: AGRyM1uaBw6LFfJ5aka5BCsJw4Ym7lGP51clFrB0Aw6gbR9ZRHwDaSjZz23VoEQqSJD0+9ZujU8wxg==
X-Received: by 2002:a05:6870:15ce:b0:101:8329:27e1 with SMTP id k14-20020a05687015ce00b00101832927e1mr127553oad.298.1656093485959;
        Fri, 24 Jun 2022 10:58:05 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id 44-20020a9d032f000000b006169f5547e0sm1893895otv.30.2022.06.24.10.58.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:58:05 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-101dc639636so4764646fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:58:05 -0700 (PDT)
X-Received: by 2002:a05:6870:f71d:b0:f2:a4c5:191a with SMTP id
 ej29-20020a056870f71d00b000f2a4c5191amr2897379oab.257.1656093484616; Fri, 24
 Jun 2022 10:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid>
 <CAD=FV=Wsp6GA=L4GsEVjMqazgtw4qG40gtLq1HT++5e9eRrvTw@mail.gmail.com> <4196825.8hzESeGDPO@phil>
In-Reply-To: <4196825.8hzESeGDPO@phil>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 24 Jun 2022 10:57:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOzhoooDDJUWV7rKpz-7GkMR5v=3gKQt4XazTSgnY51WQ@mail.gmail.com>
Message-ID: <CA+ASDXOzhoooDDJUWV7rKpz-7GkMR5v=3gKQt4XazTSgnY51WQ@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: vop: Don't crash for invalid duplicate_state()
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Sean Paul <seanpaul@chromium.org>
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

On Fri, Jun 24, 2022 at 12:23 AM Heiko Stuebner <heiko@sntech.de> wrote:
> The interesting question would be, do we want some fixes tag for it?

I'm not aware of any currently-upstream code that will hit this [1].
I've hit it in out-of-tree code (or, code that I submitted to
dri-devel, but wasn't accepted as-is), and this is the "belt and
braces" part -- the primary fix is that we should avoid calling things
like drm_atomic_get_crtc_state() at inappropriate times.

So, is the "extra safety" check really something that should go to
-stable? (Because let's be honest, everything with a Fixes tag goes
there.) Maybe?

Anyway, if you want to "blame" anything, this commit actually dropped
the safety check:

4e257d9eee23 drm/rockchip: get rid of rockchip_drm_crtc_mode_config

Brian

[1] But I'm not omniscient. So maybe it's good to have anyway.
