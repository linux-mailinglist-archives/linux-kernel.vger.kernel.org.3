Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1C5A6573
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiH3NtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiH3Ns2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:48:28 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2188F107C60
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:46:13 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id y64so2442387ede.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=zeqCrYbLRqbzzFt4QKomGEJNQndGCiBbRSxMMbNW/MY=;
        b=iD+jR834O/23Q1+XGpSqyaXld/4kkuf5B9D8H8ohS0Wdymhqe+RRZ9WcD4amHdx77O
         reCUJoXHQzu409HzizTeEctZKVSH7LOB9XXzESSb7cgYmnjcUfgK5K77a91FRvRtuJDA
         0+qQ7FqFVUzCL4pdaqo1AmviIaZT3D4mUlSsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=zeqCrYbLRqbzzFt4QKomGEJNQndGCiBbRSxMMbNW/MY=;
        b=OMlMrjDfbuNkgE4I9HYclWTkp9FyvliY7pjp3vCiEJ1GybtR36kgwvte6cWdgkfTT+
         cfrBIyGEKx7jRBE+PxPXTuD1rFM6F6fXngeUceyD7mGtCoI5QhRZUXyudQlyR5qpoxEP
         AnZ+AMxKFYnzfcDL1ZVMysDzqaVlczZkoEUi8pS3hW/UJrYh0N9SSc87PWewqNcAMkbm
         azlJgDJRe2BI8YXkiiJlPoHJyWWhiF2O9PYnYttQIIrAL+KsilKMxJ39jb3ArWgEF/0r
         ncKWaqdobveuy18/2mn7zKoMQ7tZeuL/bmCOG8giYZlgwZEBJAJD6AbLlTiv3E/VQnPz
         KRKQ==
X-Gm-Message-State: ACgBeo1deoDX0X4azdKM3zNulB24xXZ2pZxPPpjUlbjw9GgGbyc0DuIY
        T9A+HVB7LrlRoHEi9nY5gIbph9xpthmsIGfraZIXTg==
X-Google-Smtp-Source: AA6agR7u8cywbHV4Qndx4R3eFD3tb1TBNDA1nKLbYkdYbLwCOrN/QBJqqMMKopj+F5/B11o3QKmyXjxIVKUoCqGy1s4=
X-Received: by 2002:a05:6402:27d3:b0:43e:5490:27ca with SMTP id
 c19-20020a05640227d300b0043e549027camr21062997ede.307.1661866864670; Tue, 30
 Aug 2022 06:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220822081424.1310926-1-wenst@chromium.org> <12115951.O9o76ZdvQC@steina-w>
 <CAGXv+5E788T01XJF-dYRW6ZB5-TTU_L5=0hT3AQ0g+zA=LzG2w@mail.gmail.com> <2254919.ElGaqSPkdT@steina-w>
In-Reply-To: <2254919.ElGaqSPkdT@steina-w>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 30 Aug 2022 21:40:53 +0800
Message-ID: <CAGXv+5Hf0n5jkqwuQmh0PG8ejxDND6BRVG47J9HTQrqz9OhLdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for
 clk gate ops
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 8:37 PM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Montag, 29. August 2022, 11:22:16 CEST schrieb Chen-Yu Tsai:
> > Hi,
> >
> > On Fri, Aug 26, 2022 at 8:28 PM Alexander Stein
> >
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Hi everybody,
> > >
> > > Am Montag, 22. August 2022, 10:14:23 CEST schrieb Chen-Yu Tsai:
> > > > In the previous commits that added CLK_OPS_PARENT_ENABLE, support f=
or
> > > > this flag was only added to rate change operations (rate setting an=
d
> > > > reparent) and disabling unused subtree. It was not added to the
> > > > clock gate related operations. Any hardware driver that needs it fo=
r
> > > > these operations will either see bogus results, or worse, hang.
> > > >
> > > > This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
> > > > drivers set this, but dumping debugfs clk_summary would cause it
> > > > to hang.
> > > >
> > > > Fixes: fc8726a2c021 ("clk: core: support clocks which requires pare=
nts
> > > > enable (part 2)") Fixes: a4b3518d146f ("clk: core: support clocks w=
hich
> > > > requires parents enable (part 1)") Signed-off-by: Chen-Yu Tsai
> > > > <wenst@chromium.org>
> > > > Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > > > Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > > > ---
> > > >
> > > >  drivers/clk/clk.c | 28 ++++++++++++++++++++++++++++
> > > >  1 file changed, 28 insertions(+)
> > > >
> > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > index 7fc191c15507..9b365cd6d14b 100644
> > > > --- a/drivers/clk/clk.c
> > > > +++ b/drivers/clk/clk.c
> > > > @@ -196,6 +196,9 @@ static bool clk_core_rate_is_protected(struct
> > > > clk_core
> > > > *core) return core->protect_count;
> > > >
> > > >  }
> > > >
> > > > +static int clk_core_prepare_enable(struct clk_core *core);
> > > > +static void clk_core_disable_unprepare(struct clk_core *core);
> > > > +
> > > >
> > > >  static bool clk_core_is_prepared(struct clk_core *core)
> > > >  {
> > > >
> > > >       bool ret =3D false;
> > > >
> > > > @@ -208,7 +211,11 @@ static bool clk_core_is_prepared(struct clk_co=
re
> > > > *core) return core->prepare_count;
> > > >
> > > >       if (!clk_pm_runtime_get(core)) {
> > > >
> > > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > +                     clk_core_prepare_enable(core->parent);
> > > >
> > > >               ret =3D core->ops->is_prepared(core->hw);
> > > >
> > > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > +                     clk_core_disable_unprepare(core->parent);
> > > >
> > > >               clk_pm_runtime_put(core);
> > > >
> > > >       }
> > > >
> > > > @@ -244,7 +251,13 @@ static bool clk_core_is_enabled(struct clk_cor=
e
> > > > *core)
> > > >
> > > >               }
> > > >
> > > >       }
> > > >
> > > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > +             clk_core_prepare_enable(core->parent);
> > > > +
> > > >
> > > >       ret =3D core->ops->is_enabled(core->hw);
> > > >
> > > > +
> > > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > +             clk_core_disable_unprepare(core->parent);
> > > >
> > > >  done:
> > > >       if (core->rpm_enabled)
> > > >
> > > >               pm_runtime_put(core->dev);
> > > >
> > > > @@ -812,6 +825,9 @@ int clk_rate_exclusive_get(struct clk *clk)
> > > >
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
> > > >
> > > > +static int clk_core_enable_lock(struct clk_core *core);
> > > > +static void clk_core_disable_lock(struct clk_core *core);
> > > > +
> > > >
> > > >  static void clk_core_unprepare(struct clk_core *core)
> > > >  {
> > > >
> > > >       lockdep_assert_held(&prepare_lock);
> > > >
> > > > @@ -835,6 +851,9 @@ static void clk_core_unprepare(struct clk_core
> > > > *core)
> > > >
> > > >       WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core=
-
> > > >
> > > >name);
> > > >
> > > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > +             clk_core_enable_lock(core->parent);
> > > > +
> > > >
> > > >       trace_clk_unprepare(core);
> > > >
> > > >       if (core->ops->unprepare)
> > > >
> > > > @@ -843,6 +862,9 @@ static void clk_core_unprepare(struct clk_core
> > > > *core)
> > > >
> > > >       clk_pm_runtime_put(core);
> > > >
> > > >       trace_clk_unprepare_complete(core);
> > > >
> > > > +
> > > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > +             clk_core_disable_lock(core->parent);
> > > >
> > > >       clk_core_unprepare(core->parent);
> > > >
> > > >  }
> > > >
> > > > @@ -891,6 +913,9 @@ static int clk_core_prepare(struct clk_core *co=
re)
> > > >
> > > >               if (ret)
> > > >
> > > >                       goto runtime_put;
> > > >
> > > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > +                     clk_core_enable_lock(core->parent);
> > > > +
> > > >
> > > >               trace_clk_prepare(core);
> > > >
> > > >               if (core->ops->prepare)
> > > >
> > > > @@ -898,6 +923,9 @@ static int clk_core_prepare(struct clk_core *co=
re)
> > > >
> > > >               trace_clk_prepare_complete(core);
> > > >
> > > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > +                     clk_core_disable_lock(core->parent);
> > > > +
> > > >
> > > >               if (ret)
> > > >
> > > >                       goto unprepare;
> > > >
> > > >       }
> > >
> > > Unfortunately this completely locks up my i.MX8M Plus based board dur=
ing
> > > early boot.
> > > I'm currently running on next-20220826 using
> > > arch/arm64/boot/dts/freescale/
> > > imx8mp-tqma8mpql-mba8mpxl.dts
> > > Reverting this patch gets my board booting again. dmesg until hard lo=
ckup
> > > below.
> >
> > The standard logs don't have anything to go on. Could you add some prin=
tk
> > calls to the clk core around the areas this patch touchs? That would he=
lp.
> >
> > Could you also provide a dump of /sys/kernel/debug/clk/clk_summary? Tha=
t
> > would help to understand the clock tree.
>
> Sure,
>
> These are the last kernel log lines before hard lockup:
> [    0.686357] io scheduler mq-deadline registered
> [    0.690907] io scheduler kyber registered
> [    0.699275] clk_core_prepare: clk: main_axi CLK_OPS_PARENT_ENABLE
>
> main_axi is also the only debug output up to this point. This is the used
> patch for debugging:
> ---8<---
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -211,8 +211,10 @@ static bool clk_core_is_prepared(struct clk_core *co=
re)
>                 return core->prepare_count;
>
>         if (!clk_pm_runtime_get(core)) {
> -               if (core->flags & CLK_OPS_PARENT_ENABLE)
> +               if (core->flags & CLK_OPS_PARENT_ENABLE) {
> +                       pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n",
> __func__, core->name);
>                         clk_core_prepare_enable(core->parent);
> +               }
>                 ret =3D core->ops->is_prepared(core->hw);
>                 if (core->flags & CLK_OPS_PARENT_ENABLE)
>                         clk_core_disable_unprepare(core->parent);
> @@ -251,8 +253,10 @@ static bool clk_core_is_enabled(struct clk_core *cor=
e)
>                 }
>         }
>
> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
> +       if (core->flags & CLK_OPS_PARENT_ENABLE) {
> +               pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n", __func__, =
core-
> >name);
>                 clk_core_prepare_enable(core->parent);
> +       }
>
>         ret =3D core->ops->is_enabled(core->hw);
>
> @@ -851,8 +855,10 @@ static void clk_core_unprepare(struct clk_core *core=
)
>
>         WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core->na=
me);
>
> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
> +       if (core->flags & CLK_OPS_PARENT_ENABLE) {
> +               pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n", __func__, =
core-
> >name);
>                 clk_core_enable_lock(core->parent);
> +       }
>
>         trace_clk_unprepare(core);
>
> @@ -912,8 +918,10 @@ static int clk_core_prepare(struct clk_core *core)
>                 if (ret)
>                         goto runtime_put;
>
> -               if (core->flags & CLK_OPS_PARENT_ENABLE)
> +               if (core->flags & CLK_OPS_PARENT_ENABLE) {
> +                       pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n",
> __func__, core->name);
>                         clk_core_enable_lock(core->parent);
> +               }
>
>                 trace_clk_prepare(core);
>
>
> ---8<---

Thanks. So the part of the clock tree that's problematic is this:

 osc_24m (fixed)
    sys_pll1_ref_sel (mux)
       sys_pll1 (imx pll14xx)
          sys_pll1_bypass (mux)
             sys_pll1_out (gate)
                sys_pll1_800m (fixed factor)
                   main_axi (composite CLK_IS_CRITICAL)

Would it be possible for you to produce a stack dump as well? And also
enable lock debugging? This likely still won't catch anything if it's
a spinlock deadlock though.


Thanks
ChenYu
