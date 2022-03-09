Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0004D33D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiCIQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiCIQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:08:00 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D4515471A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:04:17 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id yy13so6143420ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZqCvAf0xgF95WkOEHDGm/vV6tt9EczTXGvjsdd1WwE=;
        b=OrxNHdDIFcqZV/a5MLxU2Ga+L+3AhRk/xIdWG4X6CSM8T9JSvLsWCzqG2gdhBVtm+w
         I2R5dYX3JEgvMByVLyxwG5LU9G7iMJGA2/St5e+WlHM3UHASFMB+Be4NEXN3uJRfKZt4
         fqSO0EYAd4ll6cQJ3PUK1BZcENVS1MwedBTio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZqCvAf0xgF95WkOEHDGm/vV6tt9EczTXGvjsdd1WwE=;
        b=7ZwxnbnmEVAcg06jKZm03Nzt4dRfb1ZtJPMIowmODWh9zKZ/9dfzuMuVbbiVwfpaxR
         o5PRRtnP5iyGVYzYZFC2tosUJaXHp0/oEUXZTObMeu8WImiuDJKsLyAJgMcyVHme79Pb
         2IuWBqQV/GEEw4i5gevWFOwvBtXKtkyi8mpAhPdYu/YrxEqvFCUMkgn1Ii14ZTVr3lne
         Eew0HU2PqKKPN8AHTy3sfpmRH77U+Nt9qWm4pGCzXhEyzfalXMTGL0JV0RazTxmOp3Xp
         ZpnDcIftSJNxJP/hrh0dFSr5YDNHUW7Ll0w/D+j/dOalqRqIUWUnVughqn4Gd4O2L7Vt
         gzYA==
X-Gm-Message-State: AOAM532r2JC0Pj/BX7po1g8WPQXhxVyjt4O2uJIM2x2ISYBYthvcg7wV
        LnU6YfXiKUGsgtVkeKUbKTpwNuk/oFKOoace
X-Google-Smtp-Source: ABdhPJwCwNGzTrc2uL3k35CMppIcITRIi9eTCN9NFlLIaFnytiHNHyKQfQ7hjgi2Z7BgiyNlu0W6lA==
X-Received: by 2002:a17:906:2a50:b0:6da:ed06:b029 with SMTP id k16-20020a1709062a5000b006daed06b029mr421665eje.506.1646841855363;
        Wed, 09 Mar 2022 08:04:15 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id y14-20020a056402440e00b00416046b623csm1043133eda.2.2022.03.09.08.04.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 08:04:14 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so1752615wmp.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:04:14 -0800 (PST)
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id
 o24-20020a1c7518000000b0037c07ebf255mr8067411wmc.29.1646841853982; Wed, 09
 Mar 2022 08:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20220301181107.v4.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
 <20220301181107.v4.2.I48b18ab197c9b649d376cf8cfd934e59d338f86d@changeid> <CAD=FV=X6jf-UbCzB23MjBWwfs0HcHuoE9ozd3FZxN1U-H_8Saw@mail.gmail.com>
In-Reply-To: <CAD=FV=X6jf-UbCzB23MjBWwfs0HcHuoE9ozd3FZxN1U-H_8Saw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Mar 2022 08:04:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V+HNSihpg+nMS52w9VWhfkbv+HR4F-XfS+GZ8JdSJBJw@mail.gmail.com>
Message-ID: <CAD=FV=V+HNSihpg+nMS52w9VWhfkbv+HR4F-XfS+GZ8JdSJBJw@mail.gmail.com>
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

On Thu, Mar 3, 2022 at 3:02 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Mar 1, 2022 at 6:11 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > DP AUX transactions can consist of many short operations. There's no
> > need to power things up/down in short intervals.
> >
> > I pick an arbitrary 100ms; for the systems I'm testing (Rockchip
> > RK3399), runtime-PM transitions only take a few microseconds.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> > Changes in v4:
> >  - call pm_runtime_mark_last_busy() and
> >    pm_runtime_dont_use_autosuspend()
> >  - drop excess pm references around drm_get_edid(), now that we grab and
> >    hold in the dp-aux helper
> >
> > Changes in v3:
> >  - New in v3
> >
> >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
>
> This looks great to me now, thanks.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Though I'm not a massive expert on the Analogix DP driver, I'm pretty
> confident about the DP AUX stuff that Brian is touching. I just
> checked and I see that this driver isn't changing lots and the last
> change landed in drm-misc, which means that I can commit this. Thus,
> unless someone else shouts, I'll plan to wait until next week and
> commit these two patches to drm-misc.
>
> The first of the two patches is a "Fix" but since it's been broken
> since 2016 I'll assume that nobody is chomping at the bit for these to
> get into stable and that it would be easier to land both in
> "drm-misc-next". Please yell if someone disagrees.

Pushed both to drm-misc-next:

f28dd5075675 drm/bridge: analogix_dp: Enable autosuspend
8fb6c44fe846 drm/bridge: analogix_dp: Grab runtime PM reference for DP-AUX

-Doug
