Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E9C4CC9B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiCCXDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbiCCXDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:03:25 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01090CDF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 15:02:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i11so8520212eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 15:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYz72xS4UEUEZyA/zmJjeRPqsPKoO6eSb+1q4FNlVR8=;
        b=l6FIj3aats2SLjz57UHUFzeX+1E7k3S4Dlpstfnlv80RVlxrN8PxjndVH7iYewpCSq
         Xyhxd+QRKRv3vVvSZb2z4KiSw3xMy1qgAriSSd2zu2wTAj9I5snO+A0DBK9Sv3Cr4A7n
         f39aaXyoc2P3YxjLzmAQQ0cYuuX07Cz/93Qug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYz72xS4UEUEZyA/zmJjeRPqsPKoO6eSb+1q4FNlVR8=;
        b=F07lkiCAiuKGv3gJiSw2SjVKtNkZ/rt/VSeR353tGFZRRP/SGijcR7nWnDg+kGW6XS
         X3EZ2sikKOnsznpncX4r9ALVBvCCuMUqwV0EbOLgkLD6FX0xlg0fpIe/H2Hrgj7aPFus
         NGdRA8nVJj5OAdSO5DB231K1uDcmWekYuf3PdE7TNmE+IZps/EuDureFG8J0QnL8mRK9
         Vv6fbP7geKCe4WUxEYCQKMWrAO+a262SS3P7IseswaNuKAA6MJ58k6Hp1n0DKc6k5Bpw
         M+YIdbw+9rfVWaGHbAEYrSY2DCrZR79tidQHVUCPh0cZYilbr492noZ2zezFD954SoxL
         /1Vg==
X-Gm-Message-State: AOAM533SBZQO6nC8ZQv6a+t5xOKDlSJL9oG76LwO1rF7a+6IupE3rDAw
        10MzL3j59yx1frzBfjcdAAe6IzFY1dXE8w==
X-Google-Smtp-Source: ABdhPJyIZdb8Szc0KviewFA/v8XW0TOZsUgOnLWKNu3fjnSvFvVjmzxpwXF+PirClYV9EpsxF+AxZg==
X-Received: by 2002:a05:6402:424b:b0:410:92aa:30b1 with SMTP id g11-20020a056402424b00b0041092aa30b1mr36374049edb.297.1646348552763;
        Thu, 03 Mar 2022 15:02:32 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm1389343edt.3.2022.03.03.15.02.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 15:02:32 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id d3so10051561wrf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 15:02:31 -0800 (PST)
X-Received: by 2002:a5d:64ed:0:b0:1f0:6672:f10c with SMTP id
 g13-20020a5d64ed000000b001f06672f10cmr1270642wri.679.1646348551347; Thu, 03
 Mar 2022 15:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20220301181107.v4.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
 <20220301181107.v4.2.I48b18ab197c9b649d376cf8cfd934e59d338f86d@changeid>
In-Reply-To: <20220301181107.v4.2.I48b18ab197c9b649d376cf8cfd934e59d338f86d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Mar 2022 15:02:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X6jf-UbCzB23MjBWwfs0HcHuoE9ozd3FZxN1U-H_8Saw@mail.gmail.com>
Message-ID: <CAD=FV=X6jf-UbCzB23MjBWwfs0HcHuoE9ozd3FZxN1U-H_8Saw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/bridge: analogix_dp: Enable autosuspend
To:     Brian Norris <briannorris@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Sean Paul <sean@poorly.run>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
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

On Tue, Mar 1, 2022 at 6:11 PM Brian Norris <briannorris@chromium.org> wrote:
>
> DP AUX transactions can consist of many short operations. There's no
> need to power things up/down in short intervals.
>
> I pick an arbitrary 100ms; for the systems I'm testing (Rockchip
> RK3399), runtime-PM transitions only take a few microseconds.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v4:
>  - call pm_runtime_mark_last_busy() and
>    pm_runtime_dont_use_autosuspend()
>  - drop excess pm references around drm_get_edid(), now that we grab and
>    hold in the dp-aux helper
>
> Changes in v3:
>  - New in v3
>
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

This looks great to me now, thanks.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Though I'm not a massive expert on the Analogix DP driver, I'm pretty
confident about the DP AUX stuff that Brian is touching. I just
checked and I see that this driver isn't changing lots and the last
change landed in drm-misc, which means that I can commit this. Thus,
unless someone else shouts, I'll plan to wait until next week and
commit these two patches to drm-misc.

The first of the two patches is a "Fix" but since it's been broken
since 2016 I'll assume that nobody is chomping at the bit for these to
get into stable and that it would be easier to land both in
"drm-misc-next". Please yell if someone disagrees.

-Doug
