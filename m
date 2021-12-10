Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3DF46FD5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbhLJJJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbhLJJJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:09:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FEAC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:05:55 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k4so5849397plx.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkZCXGvo7zlBCfHv5goewvZ5xrMRAZ+VhM3/1H8V2Z0=;
        b=fJfIcPbq/5wSbuhuhEmVgGmzCKHohM94gsOFdJOHshWxLrGpNPmiqTcdlaUuKprXiL
         mr1hq6zvm1WzAzHP02/XZJrg8pcZfk+P1mZkOjrd48mijYXylexXT0I6U2F0hQB37t8j
         v9We/lANMNS+tq8+5GLkhzQXQ2dYEAvwXQVhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkZCXGvo7zlBCfHv5goewvZ5xrMRAZ+VhM3/1H8V2Z0=;
        b=X97DG+ixsPTvfXwozCa5jf6ooe98qtlq0gjCGXxnmybbuRUQlQP7F5oowx5HGN+mOk
         rxhRtTt9ckOCryCtNW5/xQxoiQpVombPJfFX5tLfx3abiqaS+VJrQEqxvdTbe17kWolG
         RkKTy7IWVZTk9uxTMXfa8Z8qtnDKyi8Yj5drdqULbuDEkVdcI26PEK3sMBWmm7Q0E+Da
         sTeJ8SmrJrAAqwCPam26I6cl9eeeDDyJzjrE8CY0PnIB67zYV/puMoQWmsGmNXZN3Z0E
         D3/G8fdE4GccvL/3VoM4FxFw4lDg930RJiBU7Dco2OqDX5Dh2M9knwRYjOqq600vsn3z
         rZEA==
X-Gm-Message-State: AOAM533Hjo3rkJ7Mv6uNdHC5A9lu1U5qFxxCdGNyBi26JGyDZh+bOAVD
        TWwQ+loccc5N5/L4+t8yzz+CNl6LacjeF4MBA9repQ==
X-Google-Smtp-Source: ABdhPJw+JYpv2WA2SL5fMfjRTzoTsn6BugpkZTpvF9tP6lgFMqC10DtYu5fTqzBRZ48dv/rnyEIgy0h3ZyHpjC1OwG8=
X-Received: by 2002:a17:90a:6906:: with SMTP id r6mr22292943pjj.118.1639127154572;
 Fri, 10 Dec 2021 01:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20211016145827.586870-1-michael@amarulasolutions.com>
 <CAOf5uw=DffhS=WAh-OFXOCO+4kd5ey=2Eqf0Zhyrgd_d5D8meA@mail.gmail.com>
 <CAPY8ntCvAnu9HS1WxWRkveXnQ_vD8EOdshX-ob8vGuGqOKp+RA@mail.gmail.com> <CAOf5uwmGjwXsQdVm-tyvkcPY0bJ++KFbewvrQ-esU=9FStmg+A@mail.gmail.com>
In-Reply-To: <CAOf5uwmGjwXsQdVm-tyvkcPY0bJ++KFbewvrQ-esU=9FStmg+A@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 10 Dec 2021 10:05:42 +0100
Message-ID: <CAOf5uwmn4UM8iE71DjcGpX+pQU_wkU6bBNV-=b6kT-x-LtsnMg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: ilitek-ili9881c: Avoid unbalance prepare/unprepare
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave

some questions below

On Thu, Dec 9, 2021 at 7:10 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Dave
>
> On Thu, Dec 9, 2021 at 6:58 PM Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > Hi Michael
> >
> > On Thu, 9 Dec 2021 at 16:58, Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Hi all
> > >
> > > On Sat, Oct 16, 2021 at 4:58 PM Michael Trimarchi
> > > <michael@amarulasolutions.com> wrote:
> > > >
> > > > All the panel driver check the fact that their prepare/unprepare
> > > > call was already called. It's not an ideal solution but fix
> > > > for now the problem on ili9881c
> > > >
> > > > [ 9862.283296] ------------[ cut here ]------------
> > > > [ 9862.288490] unbalanced disables for vcc3v3_lcd
> > > > [ 9862.293555] WARNING: CPU: 0 PID: 1 at drivers/regulator/core.c:2851
> > > > _regulator_disable+0xd4/0x190
> > > >
> > > > from:
> > > >
> > > > [ 9862.038619]  drm_panel_unprepare+0x2c/0x4c
> > > > [ 9862.043212]  panel_bridge_post_disable+0x18/0x24
> > > > [ 9862.048390]  dw_mipi_dsi_bridge_post_disable+0x3c/0xf0
> > > > [ 9862.054153]  drm_atomic_bridge_chain_post_disable+0x8c/0xd0
> > > >
> > > > and:
> > > >
> > > > [ 9862.183103]  drm_panel_unprepare+0x2c/0x4c
> > > > [ 9862.187695]  panel_bridge_post_disable+0x18/0x24
> > > > [ 9862.192872]  drm_atomic_bridge_chain_post_disable+0x8c/0xd0
> > > > [ 9862.199117]  disable_outputs+0x120/0x31c
> >
> > This is down to the dw-mipi-dsi driver calling the post_disable hook
> > explicitly at [1], but then also allowing the framework to call it.
> > The explicit call is down to limitations in the DSI support, so we
> > can't control the DSI host state to a fine enough degree (an ongoing
> > discussion [2] [3]). There shouldn't be a need to handle mismatched
> > calling in individual panel drivers.
> >
> >   Dave
> >
> > [1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c#L894
> > [2] https://lists.freedesktop.org/archives/dri-devel/2021-November/332060.html
> > [3] https://lists.freedesktop.org/archives/dri-devel/2021-December/334007.html
>
> I'm in the second case. I need to enable HS mode after the panel is
> initialized. Time to time I have timeout
> on dsi command or I have wrong panel initialization. So I explicit call from
> the bridge but I understand that is not correct in the design point of view.
>
> So this patch can not be queued because it's a known problem that
> people are discussing
>
Author: Michael Trimarchi <michael@amarulasolutions.com>
Date:   Thu Dec 9 15:45:48 2021 +0100

    drm: bridge: samsung-dsim: Enable panel/bridge before exist from standby

    We need to exist from standby as last operation to have a proper video
    working. This code implement the same code was before the bridge
    migration

    Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
b/drivers/gpu/drm/bridge/samsung-dsim.c
index 654851edbd9b..21265ae80022 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1838,6 +1838,7 @@ static void samsung_dsim_atomic_enable(struct
drm_bridge *bridge,
                                       struct drm_bridge_state
*old_bridge_state)
 {
        struct samsung_dsim *dsi = bridge_to_dsi(bridge);
+       struct drm_atomic_state old_state;
        int ret;

        if (dsi->state & DSIM_STATE_ENABLED)
@@ -1859,6 +1860,9 @@ static void samsung_dsim_atomic_enable(struct
drm_bridge *bridge,
        }

        samsung_dsim_set_display_mode(dsi);
+
+       drm_atomic_bridge_chain_enable(dsi->out_bridge, &old_state);
+
        samsung_dsim_set_display_enable(dsi, true);

        dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;

Right now I'm doing this to enable the change. I must change the panel
to avoid double enabled

I have some questions:

- the chain is an element (bridge/panel) linked together via some
connector (I hope I understand) when I enable
a bridge chain, all the elements should move from some status to
another. If we mark them already this should
not avoid that one element can be enabled two times? An element that
sources two other elements should for instance
receive the enable from two times before switching on.

Michael

> Michael
>
> >
> >
> > > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> > > > index 103a16018975..f75eecb0e65c 100644
> > > > --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> > > > +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> > > > @@ -52,6 +52,8 @@ struct ili9881c {
> > > >
> > > >         struct regulator        *power;
> > > >         struct gpio_desc        *reset;
> > > > +
> > > > +       bool                    prepared;
> > > >  };
> > > >
> > >
> > > I found that this can be a general problem. Should not mandatory to
> > > track panel status
> > >
> > > DRM_PANEL_PREPARED
> > > DRM_PANEL_ENABLED
> > >
> > > Michael
> > > >  #define ILI9881C_SWITCH_PAGE_INSTR(_page)      \
> > > > @@ -707,6 +709,10 @@ static int ili9881c_prepare(struct drm_panel *panel)
> > > >         unsigned int i;
> > > >         int ret;
> > > >
> > > > +       /* Preparing when already prepared is a no-op */
> > > > +       if (ctx->prepared)
> > > > +               return 0;
> > > > +
> > > >         /* Power the panel */
> > > >         ret = regulator_enable(ctx->power);
> > > >         if (ret)
> > > > @@ -745,6 +751,8 @@ static int ili9881c_prepare(struct drm_panel *panel)
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > +       ctx->prepared = true;
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > > @@ -770,10 +778,16 @@ static int ili9881c_unprepare(struct drm_panel *panel)
> > > >  {
> > > >         struct ili9881c *ctx = panel_to_ili9881c(panel);
> > > >
> > > > +       /* Unpreparing when already unprepared is a no-op */
> > > > +       if (!ctx->prepared)
> > > > +               return 0;
> > > > +
> > > >         mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> > > >         regulator_disable(ctx->power);
> > > >         gpiod_set_value(ctx->reset, 1);
> > > >
> > > > +       ctx->prepared = false;
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > >
> > >
> > > --
> > > Michael Nazzareno Trimarchi
> > > Co-Founder & Chief Executive Officer
> > > M. +39 347 913 2170
> > > michael@amarulasolutions.com
> > > __________________________________
> > >
> > > Amarula Solutions BV
> > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > > T. +31 (0)85 111 9172
> > > info@amarulasolutions.com
> > > www.amarulasolutions.com
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
