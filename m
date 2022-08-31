Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E275A77AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiHaHkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHaHkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:40:16 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA614AD78;
        Wed, 31 Aug 2022 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661931614; x=1693467614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L76+i4iOV1VqYzI6KegPl3xwtYsecfKw3SFYj2xfKNc=;
  b=QrNLX3a1e16R1vWWC6E7dj7wdbBetZ8RBdxNpuDS0IcmnYcQ3qtzPUWj
   t/NNsTGeYYcBTvm44aTgCtHr+9RJtRcgPb4z0dlrhQrTGLhroqK5nxk3Q
   NGSkvXFS7Jbbv9Ksv7B6dSwNnFCztU3QIu2H9zyfX0J9xnxObvexES6eX
   ZpgQPHxn/BuvLAJlxcoHGSN05cQu2GJDNjlbShSTf8z9x8BFalWSz0KNR
   +AZ01pkMCaWJlEoK9uimpQoKXWQpEmilwVw2TgN8OFJRQQ58xVTMo89Kg
   YosH8kfXA4NJbQrdtCHcg0c7BO0YedBUiqT0y+IMA23nGYAxccM0d11eH
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654552800"; 
   d="scan'208";a="25901125"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Aug 2022 09:40:10 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 31 Aug 2022 09:40:10 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 31 Aug 2022 09:40:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661931610; x=1693467610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L76+i4iOV1VqYzI6KegPl3xwtYsecfKw3SFYj2xfKNc=;
  b=FeN05n9SqCPjMLANiMDmpdSpysXK1u0tWtbz7LgSwMVsGu7Y3B59Ythu
   Yy1myAPypoapLHQPu++SHk8NOEN7eTa+O/TO/XIJdNGFQH0uOvoV/AF1q
   +N3hKhOURXjA+TVPI4FzeRWJRD8k+abwh/WOKbTQ71wsJPxQ3Sf/6IDpI
   HXQ7tNvu6ljKcBbZ34DKuiuuMCkEikd4CMQdICZ1Zn9qftCDE0k/Joa2A
   mTrTj8y5sZGFA0EQ/ZpCqpBcHH+6LKBVrk63oqGzv2+l5NM6X788VkGL7
   k8AEU+K/dJjuezwagptBD0Z3lhg/OH6SExhzCM6J1lhOUMpB02V6RIw40
   g==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654552800"; 
   d="scan'208";a="25901124"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Aug 2022 09:40:10 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E51BA280056;
        Wed, 31 Aug 2022 09:40:09 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?ISO-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
Date:   Wed, 31 Aug 2022 09:40:07 +0200
Message-ID: <8113103.T7Z3S40VBb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAGXv+5Hf0n5jkqwuQmh0PG8ejxDND6BRVG47J9HTQrqz9OhLdQ@mail.gmail.com>
References: <20220822081424.1310926-1-wenst@chromium.org> <2254919.ElGaqSPkdT@steina-w> <CAGXv+5Hf0n5jkqwuQmh0PG8ejxDND6BRVG47J9HTQrqz9OhLdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. August 2022, 15:40:53 CEST schrieb Chen-Yu Tsai:
> On Tue, Aug 30, 2022 at 8:37 PM Alexander Stein
>=20
> <alexander.stein@ew.tq-group.com> wrote:
> > Hi,
> >=20
> > Am Montag, 29. August 2022, 11:22:16 CEST schrieb Chen-Yu Tsai:
> > > Hi,
> > >=20
> > > On Fri, Aug 26, 2022 at 8:28 PM Alexander Stein
> > >=20
> > > <alexander.stein@ew.tq-group.com> wrote:
> > > > Hi everybody,
> > > >=20
> > > > Am Montag, 22. August 2022, 10:14:23 CEST schrieb Chen-Yu Tsai:
> > > > > In the previous commits that added CLK_OPS_PARENT_ENABLE, support
> > > > > for
> > > > > this flag was only added to rate change operations (rate setting =
and
> > > > > reparent) and disabling unused subtree. It was not added to the
> > > > > clock gate related operations. Any hardware driver that needs it =
for
> > > > > these operations will either see bogus results, or worse, hang.
> > > > >=20
> > > > > This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
> > > > > drivers set this, but dumping debugfs clk_summary would cause it
> > > > > to hang.
> > > > >=20
> > > > > Fixes: fc8726a2c021 ("clk: core: support clocks which requires
> > > > > parents
> > > > > enable (part 2)") Fixes: a4b3518d146f ("clk: core: support clocks
> > > > > which
> > > > > requires parents enable (part 1)") Signed-off-by: Chen-Yu Tsai
> > > > > <wenst@chromium.org>
> > > > > Reviewed-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
> > > > > Tested-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
> > > > > ---
> > > > >=20
> > > > >  drivers/clk/clk.c | 28 ++++++++++++++++++++++++++++
> > > > >  1 file changed, 28 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > index 7fc191c15507..9b365cd6d14b 100644
> > > > > --- a/drivers/clk/clk.c
> > > > > +++ b/drivers/clk/clk.c
> > > > > @@ -196,6 +196,9 @@ static bool clk_core_rate_is_protected(struct
> > > > > clk_core
> > > > > *core) return core->protect_count;
> > > > >=20
> > > > >  }
> > > > >=20
> > > > > +static int clk_core_prepare_enable(struct clk_core *core);
> > > > > +static void clk_core_disable_unprepare(struct clk_core *core);
> > > > > +
> > > > >=20
> > > > >  static bool clk_core_is_prepared(struct clk_core *core)
> > > > >  {
> > > > > =20
> > > > >       bool ret =3D false;
> > > > >=20
> > > > > @@ -208,7 +211,11 @@ static bool clk_core_is_prepared(struct
> > > > > clk_core
> > > > > *core) return core->prepare_count;
> > > > >=20
> > > > >       if (!clk_pm_runtime_get(core)) {
> > > > >=20
> > > > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > > +                     clk_core_prepare_enable(core->parent);
> > > > >=20
> > > > >               ret =3D core->ops->is_prepared(core->hw);
> > > > >=20
> > > > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > > +                     clk_core_disable_unprepare(core->parent);
> > > > >=20
> > > > >               clk_pm_runtime_put(core);
> > > > >      =20
> > > > >       }
> > > > >=20
> > > > > @@ -244,7 +251,13 @@ static bool clk_core_is_enabled(struct clk_c=
ore
> > > > > *core)
> > > > >=20
> > > > >               }
> > > > >      =20
> > > > >       }
> > > > >=20
> > > > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > > +             clk_core_prepare_enable(core->parent);
> > > > > +
> > > > >=20
> > > > >       ret =3D core->ops->is_enabled(core->hw);
> > > > >=20
> > > > > +
> > > > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > > +             clk_core_disable_unprepare(core->parent);
> > > > >=20
> > > > >  done:
> > > > >       if (core->rpm_enabled)
> > > > >      =20
> > > > >               pm_runtime_put(core->dev);
> > > > >=20
> > > > > @@ -812,6 +825,9 @@ int clk_rate_exclusive_get(struct clk *clk)
> > > > >=20
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
> > > > >=20
> > > > > +static int clk_core_enable_lock(struct clk_core *core);
> > > > > +static void clk_core_disable_lock(struct clk_core *core);
> > > > > +
> > > > >=20
> > > > >  static void clk_core_unprepare(struct clk_core *core)
> > > > >  {
> > > > > =20
> > > > >       lockdep_assert_held(&prepare_lock);
> > > > >=20
> > > > > @@ -835,6 +851,9 @@ static void clk_core_unprepare(struct clk_core
> > > > > *core)
> > > > >=20
> > > > >       WARN(core->enable_count > 0, "Unpreparing enabled %s\n", co=
re-
> > > > >
> > > > >name);
> > > > >
> > > > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > > +             clk_core_enable_lock(core->parent);
> > > > > +
> > > > >=20
> > > > >       trace_clk_unprepare(core);
> > > > >      =20
> > > > >       if (core->ops->unprepare)
> > > > >=20
> > > > > @@ -843,6 +862,9 @@ static void clk_core_unprepare(struct clk_core
> > > > > *core)
> > > > >=20
> > > > >       clk_pm_runtime_put(core);
> > > > >      =20
> > > > >       trace_clk_unprepare_complete(core);
> > > > >=20
> > > > > +
> > > > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > > +             clk_core_disable_lock(core->parent);
> > > > >=20
> > > > >       clk_core_unprepare(core->parent);
> > > > > =20
> > > > >  }
> > > > >=20
> > > > > @@ -891,6 +913,9 @@ static int clk_core_prepare(struct clk_core
> > > > > *core)
> > > > >=20
> > > > >               if (ret)
> > > > >              =20
> > > > >                       goto runtime_put;
> > > > >=20
> > > > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > > +                     clk_core_enable_lock(core->parent);
> > > > > +
> > > > >=20
> > > > >               trace_clk_prepare(core);
> > > > >              =20
> > > > >               if (core->ops->prepare)
> > > > >=20
> > > > > @@ -898,6 +923,9 @@ static int clk_core_prepare(struct clk_core
> > > > > *core)
> > > > >=20
> > > > >               trace_clk_prepare_complete(core);
> > > > >=20
> > > > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > > > +                     clk_core_disable_lock(core->parent);
> > > > > +
> > > > >=20
> > > > >               if (ret)
> > > > >              =20
> > > > >                       goto unprepare;
> > > > >      =20
> > > > >       }
> > > >=20
> > > > Unfortunately this completely locks up my i.MX8M Plus based board
> > > > during
> > > > early boot.
> > > > I'm currently running on next-20220826 using
> > > > arch/arm64/boot/dts/freescale/
> > > > imx8mp-tqma8mpql-mba8mpxl.dts
> > > > Reverting this patch gets my board booting again. dmesg until hard
> > > > lockup
> > > > below.
> > >=20
> > > The standard logs don't have anything to go on. Could you add some
> > > printk
> > > calls to the clk core around the areas this patch touchs? That would
> > > help.
> > >=20
> > > Could you also provide a dump of /sys/kernel/debug/clk/clk_summary? T=
hat
> > > would help to understand the clock tree.
> >=20
> > Sure,
> >=20
> > These are the last kernel log lines before hard lockup:
> > [    0.686357] io scheduler mq-deadline registered
> > [    0.690907] io scheduler kyber registered
> > [    0.699275] clk_core_prepare: clk: main_axi CLK_OPS_PARENT_ENABLE
> >=20
> > main_axi is also the only debug output up to this point. This is the us=
ed
> > patch for debugging:
> > ---8<---
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -211,8 +211,10 @@ static bool clk_core_is_prepared(struct clk_core
> > *core)>=20
> >                 return core->prepare_count;
> >        =20
> >         if (!clk_pm_runtime_get(core)) {
> >=20
> > -               if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +               if (core->flags & CLK_OPS_PARENT_ENABLE) {
> > +                       pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n",
> > __func__, core->name);
> >=20
> >                         clk_core_prepare_enable(core->parent);
> >=20
> > +               }
> >=20
> >                 ret =3D core->ops->is_prepared(core->hw);
> >                 if (core->flags & CLK_OPS_PARENT_ENABLE)
> >                =20
> >                         clk_core_disable_unprepare(core->parent);
> >=20
> > @@ -251,8 +253,10 @@ static bool clk_core_is_enabled(struct clk_core
> > *core)
> >=20
> >                 }
> >        =20
> >         }
> >=20
> > -       if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +       if (core->flags & CLK_OPS_PARENT_ENABLE) {
> > +               pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n", __func__,
> > core->=20
> > >name);
> > >
> >                 clk_core_prepare_enable(core->parent);
> >=20
> > +       }
> >=20
> >         ret =3D core->ops->is_enabled(core->hw);
> >=20
> > @@ -851,8 +855,10 @@ static void clk_core_unprepare(struct clk_core *co=
re)
> >=20
> >         WARN(core->enable_count > 0, "Unpreparing enabled %s\n",
> >         core->name);
> >=20
> > -       if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +       if (core->flags & CLK_OPS_PARENT_ENABLE) {
> > +               pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n", __func__,
> > core->=20
> > >name);
> > >
> >                 clk_core_enable_lock(core->parent);
> >=20
> > +       }
> >=20
> >         trace_clk_unprepare(core);
> >=20
> > @@ -912,8 +918,10 @@ static int clk_core_prepare(struct clk_core *core)
> >=20
> >                 if (ret)
> >                =20
> >                         goto runtime_put;
> >=20
> > -               if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +               if (core->flags & CLK_OPS_PARENT_ENABLE) {
> > +                       pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n",
> > __func__, core->name);
> >=20
> >                         clk_core_enable_lock(core->parent);
> >=20
> > +               }
> >=20
> >                 trace_clk_prepare(core);
> >=20
> > ---8<---
>=20
> Thanks. So the part of the clock tree that's problematic is this:
>=20
>  osc_24m (fixed)
>     sys_pll1_ref_sel (mux)
>        sys_pll1 (imx pll14xx)
>           sys_pll1_bypass (mux)
>              sys_pll1_out (gate)
>                 sys_pll1_800m (fixed factor)
>                    main_axi (composite CLK_IS_CRITICAL)
>=20
> Would it be possible for you to produce a stack dump as well? And also
> enable lock debugging? This likely still won't catch anything if it's
> a spinlock deadlock though.

Sure thing, I added a dump_stack() call to all of the above debug outputs a=
s=20
well as the name of the parent clock, just to be sure, and here is the resu=
lt=20
output:
[    1.142386] io scheduler mq-deadline registered
[    1.146902] io scheduler kyber registered
[    1.177345] clk_core_prepare: clk: main_axi CLK_OPS_PARENT_ENABLE
[    1.180713] clk_core_prepare: clk->parent: sys_pll1_800m
[    1.186025] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc3-
next-20220831+ #619 9c82e5b9075d735fa07e2c558603ffb720d72983
[    1.197274] Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL (=
DT)
[    1.204275] Call trace:
[    1.206723]  dump_backtrace+0xd8/0x120
[    1.210485]  show_stack+0x14/0x50
[    1.213811]  dump_stack_lvl+0x88/0xb0
[    1.217486]  dump_stack+0x14/0x2c
[    1.220811]  clk_core_prepare+0x1fc/0x240
[    1.224834]  __clk_core_init+0x208/0x4dc
[    1.228772]  __clk_register+0x160/0x240
[    1.232622]  clk_hw_register+0x1c/0x5c
[    1.236384]  __clk_hw_register_composite+0x1e8/0x2d0
[    1.241372]  clk_hw_register_composite+0x40/0x50
[    1.246009]  __imx8m_clk_hw_composite+0x130/0x210
[    1.250734]  imx8mp_clocks_probe+0x13ac/0x3750
[    1.255199]  platform_probe+0x64/0x100
[    1.258959]  call_driver_probe+0x28/0x140
[    1.262984]  really_probe+0xc0/0x334
[    1.266572]  __driver_probe_device+0x84/0x144
[    1.270947]  driver_probe_device+0x38/0x130
[    1.275147]  __driver_attach+0xd4/0x240
[    1.278997]  bus_for_each_dev+0x6c/0xbc
[    1.282847]  driver_attach+0x20/0x30
[    1.286436]  bus_add_driver+0x178/0x250
[    1.290284]  driver_register+0x74/0x120
[    1.294134]  __platform_driver_register+0x24/0x30
[    1.298859]  imx8mp_clk_driver_init+0x18/0x20
[    1.303234]  do_one_initcall+0x48/0x180
[    1.307084]  do_initcalls+0x164/0x19c
[    1.310759]  kernel_init_freeable+0xf4/0x138
[    1.315047]  kernel_init+0x2c/0x140
[    1.318549]  ret_from_fork+0x10/0x20

Enabling lock debugging results in no additional output.

Best regards,
Alexander



