Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD2B5A638B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiH3MiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3MiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:38:03 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C14E1910;
        Tue, 30 Aug 2022 05:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661863080; x=1693399080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KMVms1okjhaV2snw0hlFk5TFIlPajKuiBR9O14Ww3n8=;
  b=cLYhblSl6KeYnCHN8Uz3lM4MvolTpaKSamlI8JkHWYzlq3iigz7G1CAO
   I3TXIDzhOuqMsNfWXpt42Yg809Uz5pyVdrXjvSQNbtqA6kamt46JRRF7s
   xZ9LI6KHiLtBOtcFUaJ9V9XTVzG9oNNAU+C0EpUtzaxOzSpDMe62W0t/R
   QrRkBQntO624vQMD4xy5m+UdqkU4hdedx5rMYt1XpEoLc63Di/YjiAGcd
   cg9pZFDdfpLjtNqsHODkfckF6ZaVRlFX6MWzqItVW6MHY4jeXJ86dRDCz
   fSMi9y/qYKvkj8yWXMCOIjOqBJrS5c3BLmOl856wnSMaTxoIJUL9WTEYc
   A==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654552800"; 
   d="scan'208";a="25885100"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 30 Aug 2022 14:37:58 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 30 Aug 2022 14:37:58 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 30 Aug 2022 14:37:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661863078; x=1693399078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KMVms1okjhaV2snw0hlFk5TFIlPajKuiBR9O14Ww3n8=;
  b=nYZdKKgpIujlfFZ5/wESI9ePXbHK/UgCMaoKXl1UoD0DyInz1+fqu3zh
   itiTfajYvYI3MXR09bnrxcR2+19/Haw49gBsUXLhAGI+SYWc+X/9c11fU
   b0FVYvMN1S4h5nPFELGLe09RVH9Ya6veh+yucWKrIh9kBjDaN2rjBkXLN
   PtML1vBitR+fPwbx+MbMae6HqWH7BSCILtPr+zCcW8K2XBdITMCkbabTv
   jPPG665UE7z1BEa+j+O9ekKArZZHAN6GtOHCwuWAWcmm6jcuhH8g6PFmI
   tgHhCivgKfGL6WdqVqEKO0otfeOSDg3n8xa0boYaS/R7IBoz4YxlFgzaB
   w==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654552800"; 
   d="scan'208";a="25885099"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 Aug 2022 14:37:58 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 23E9C280056;
        Tue, 30 Aug 2022 14:37:58 +0200 (CEST)
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
Date:   Tue, 30 Aug 2022 14:37:55 +0200
Message-ID: <2254919.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAGXv+5E788T01XJF-dYRW6ZB5-TTU_L5=0hT3AQ0g+zA=LzG2w@mail.gmail.com>
References: <20220822081424.1310926-1-wenst@chromium.org> <12115951.O9o76ZdvQC@steina-w> <CAGXv+5E788T01XJF-dYRW6ZB5-TTU_L5=0hT3AQ0g+zA=LzG2w@mail.gmail.com>
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

Hi,

Am Montag, 29. August 2022, 11:22:16 CEST schrieb Chen-Yu Tsai:
> Hi,
>=20
> On Fri, Aug 26, 2022 at 8:28 PM Alexander Stein
>=20
> <alexander.stein@ew.tq-group.com> wrote:
> > Hi everybody,
> >=20
> > Am Montag, 22. August 2022, 10:14:23 CEST schrieb Chen-Yu Tsai:
> > > In the previous commits that added CLK_OPS_PARENT_ENABLE, support for
> > > this flag was only added to rate change operations (rate setting and
> > > reparent) and disabling unused subtree. It was not added to the
> > > clock gate related operations. Any hardware driver that needs it for
> > > these operations will either see bogus results, or worse, hang.
> > >=20
> > > This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
> > > drivers set this, but dumping debugfs clk_summary would cause it
> > > to hang.
> > >=20
> > > Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents
> > > enable (part 2)") Fixes: a4b3518d146f ("clk: core: support clocks whi=
ch
> > > requires parents enable (part 1)") Signed-off-by: Chen-Yu Tsai
> > > <wenst@chromium.org>
> > > Reviewed-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
> > > Tested-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
> > > ---
> > >=20
> > >  drivers/clk/clk.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >=20
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 7fc191c15507..9b365cd6d14b 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -196,6 +196,9 @@ static bool clk_core_rate_is_protected(struct
> > > clk_core
> > > *core) return core->protect_count;
> > >=20
> > >  }
> > >=20
> > > +static int clk_core_prepare_enable(struct clk_core *core);
> > > +static void clk_core_disable_unprepare(struct clk_core *core);
> > > +
> > >=20
> > >  static bool clk_core_is_prepared(struct clk_core *core)
> > >  {
> > > =20
> > >       bool ret =3D false;
> > >=20
> > > @@ -208,7 +211,11 @@ static bool clk_core_is_prepared(struct clk_core
> > > *core) return core->prepare_count;
> > >=20
> > >       if (!clk_pm_runtime_get(core)) {
> > >=20
> > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > +                     clk_core_prepare_enable(core->parent);
> > >=20
> > >               ret =3D core->ops->is_prepared(core->hw);
> > >=20
> > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > +                     clk_core_disable_unprepare(core->parent);
> > >=20
> > >               clk_pm_runtime_put(core);
> > >      =20
> > >       }
> > >=20
> > > @@ -244,7 +251,13 @@ static bool clk_core_is_enabled(struct clk_core
> > > *core)
> > >=20
> > >               }
> > >      =20
> > >       }
> > >=20
> > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > +             clk_core_prepare_enable(core->parent);
> > > +
> > >=20
> > >       ret =3D core->ops->is_enabled(core->hw);
> > >=20
> > > +
> > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > +             clk_core_disable_unprepare(core->parent);
> > >=20
> > >  done:
> > >       if (core->rpm_enabled)
> > >      =20
> > >               pm_runtime_put(core->dev);
> > >=20
> > > @@ -812,6 +825,9 @@ int clk_rate_exclusive_get(struct clk *clk)
> > >=20
> > >  }
> > >  EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
> > >=20
> > > +static int clk_core_enable_lock(struct clk_core *core);
> > > +static void clk_core_disable_lock(struct clk_core *core);
> > > +
> > >=20
> > >  static void clk_core_unprepare(struct clk_core *core)
> > >  {
> > > =20
> > >       lockdep_assert_held(&prepare_lock);
> > >=20
> > > @@ -835,6 +851,9 @@ static void clk_core_unprepare(struct clk_core
> > > *core)
> > >=20
> > >       WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core-
> > >
> > >name);
> > >
> > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > +             clk_core_enable_lock(core->parent);
> > > +
> > >=20
> > >       trace_clk_unprepare(core);
> > >      =20
> > >       if (core->ops->unprepare)
> > >=20
> > > @@ -843,6 +862,9 @@ static void clk_core_unprepare(struct clk_core
> > > *core)
> > >=20
> > >       clk_pm_runtime_put(core);
> > >      =20
> > >       trace_clk_unprepare_complete(core);
> > >=20
> > > +
> > > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > +             clk_core_disable_lock(core->parent);
> > >=20
> > >       clk_core_unprepare(core->parent);
> > > =20
> > >  }
> > >=20
> > > @@ -891,6 +913,9 @@ static int clk_core_prepare(struct clk_core *core)
> > >=20
> > >               if (ret)
> > >              =20
> > >                       goto runtime_put;
> > >=20
> > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > +                     clk_core_enable_lock(core->parent);
> > > +
> > >=20
> > >               trace_clk_prepare(core);
> > >              =20
> > >               if (core->ops->prepare)
> > >=20
> > > @@ -898,6 +923,9 @@ static int clk_core_prepare(struct clk_core *core)
> > >=20
> > >               trace_clk_prepare_complete(core);
> > >=20
> > > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > > +                     clk_core_disable_lock(core->parent);
> > > +
> > >=20
> > >               if (ret)
> > >              =20
> > >                       goto unprepare;
> > >      =20
> > >       }
> >=20
> > Unfortunately this completely locks up my i.MX8M Plus based board during
> > early boot.
> > I'm currently running on next-20220826 using
> > arch/arm64/boot/dts/freescale/
> > imx8mp-tqma8mpql-mba8mpxl.dts
> > Reverting this patch gets my board booting again. dmesg until hard lock=
up
> > below.
>=20
> The standard logs don't have anything to go on. Could you add some printk
> calls to the clk core around the areas this patch touchs? That would help.
>=20
> Could you also provide a dump of /sys/kernel/debug/clk/clk_summary? That
> would help to understand the clock tree.

Sure,

These are the last kernel log lines before hard lockup:
[    0.686357] io scheduler mq-deadline registered
[    0.690907] io scheduler kyber registered
[    0.699275] clk_core_prepare: clk: main_axi CLK_OPS_PARENT_ENABLE

main_axi is also the only debug output up to this point. This is the used=20
patch for debugging:
=2D--8<---
=2D-- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -211,8 +211,10 @@ static bool clk_core_is_prepared(struct clk_core *core)
                return core->prepare_count;
=20
        if (!clk_pm_runtime_get(core)) {
=2D               if (core->flags & CLK_OPS_PARENT_ENABLE)
+               if (core->flags & CLK_OPS_PARENT_ENABLE) {
+                       pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n",=20
__func__, core->name);
                        clk_core_prepare_enable(core->parent);
+               }
                ret =3D core->ops->is_prepared(core->hw);
                if (core->flags & CLK_OPS_PARENT_ENABLE)
                        clk_core_disable_unprepare(core->parent);
@@ -251,8 +253,10 @@ static bool clk_core_is_enabled(struct clk_core *core)
                }
        }
=20
=2D       if (core->flags & CLK_OPS_PARENT_ENABLE)
+       if (core->flags & CLK_OPS_PARENT_ENABLE) {
+               pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n", __func__, co=
re-
>name);
                clk_core_prepare_enable(core->parent);
+       }
=20
        ret =3D core->ops->is_enabled(core->hw);
=20
@@ -851,8 +855,10 @@ static void clk_core_unprepare(struct clk_core *core)
=20
        WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core->name=
);
=20
=2D       if (core->flags & CLK_OPS_PARENT_ENABLE)
+       if (core->flags & CLK_OPS_PARENT_ENABLE) {
+               pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n", __func__, co=
re-
>name);
                clk_core_enable_lock(core->parent);
+       }
=20
        trace_clk_unprepare(core);
=20
@@ -912,8 +918,10 @@ static int clk_core_prepare(struct clk_core *core)
                if (ret)
                        goto runtime_put;
=20
=2D               if (core->flags & CLK_OPS_PARENT_ENABLE)
+               if (core->flags & CLK_OPS_PARENT_ENABLE) {
+                       pr_info("%s: clk: %s CLK_OPS_PARENT_ENABLE\n",=20
__func__, core->name);
                        clk_core_enable_lock(core->parent);
+               }
=20
                trace_clk_prepare(core);
=20

=2D--8<---

And here is the output of clk_summary with 35b0fac808b9 reverted:

                                 enable  prepare  protect                  =
             =20
duty  hardware
   clock                          count    count    count        rate  =20
accuracy phase  cycle    enable
=2D------------------------------------------------------------------------=
=2D-----------------------------
 pcf85063-clkout                      0        0        0           0      =
   =20
0     0  50000         Y
 dummy                                0        0        0           0      =
   =20
0     0  50000         Y
 clk_ext4                             0        0        0   133000000      =
   =20
0     0  50000         Y
 clk_ext3                             0        0        0   133000000      =
   =20
0     0  50000         Y
 clk_ext2                             0        0        0   133000000      =
   =20
0     0  50000         Y
 clk_ext1                             0        0        0   133000000      =
   =20
0     0  50000         Y
 osc_24m                              8       12        0    24000000      =
   =20
0     0  50000         Y
    sai7                              0        0        0    24000000      =
   =20
0     0  50000         N
    vpu_vc8000e                       0        0        0    24000000      =
   =20
0     0  50000         N
       vpu_vc8ke_root_clk             0        0        0    24000000      =
   =20
0     0  50000         N
    pdm                               0        0        0    24000000      =
   =20
0     0  50000         N
    media_mipi_test_byte              0        0        0    24000000      =
   =20
0     0  50000         N
    mem_repair                        1        1        0    24000000      =
   =20
0     0  50000         Y
    media_ldb                         0        0        0    24000000      =
   =20
0     0  50000         N
    media_cam2_pix                    0        0        0    24000000      =
   =20
0     0  50000         N
       media_cam2_pix_root_clk        0        0        0    24000000      =
   =20
0     0  50000         N
    media_disp1_pix                   0        0        0    24000000      =
   =20
0     0  50000         N
       media_disp1_pix_root_clk       0        0        0    24000000      =
   =20
0     0  50000         N
    media_cam1_pix                    0        0        0    24000000      =
   =20
0     0  50000         N
       media_cam1_pix_root_clk        0        0        0    24000000      =
   =20
0     0  50000         N
    hdmi_ref_266m                     0        0        0    24000000      =
   =20
0     0  50000         N
    hdmi_24m                          0        0        0    24000000      =
   =20
0     0  50000         N
    hdmi_fdcc_tst                     0        0        0    24000000      =
   =20
0     0  50000         N
    ipp_do_clko2                      0        0        0    24000000      =
   =20
0     0  50000         N
    ipp_do_clko1                      0        0        0    24000000      =
   =20
0     0  50000         N
    wdog                              1        1        0    24000000      =
   =20
0     0  50000         Y
       wdog3_root_clk                 0        0        0    24000000      =
   =20
0     0  50000         N
       wdog2_root_clk                 0        0        0    24000000      =
   =20
0     0  50000         N
       wdog1_root_clk                 1        1        0    24000000      =
   =20
0     0  50000         Y
    gpt6                              0        0        0    24000000      =
   =20
0     0  50000         N
       gpt6_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    gpt5                              0        0        0    24000000      =
   =20
0     0  50000         N
       gpt5_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    gpt4                              0        0        0    24000000      =
   =20
0     0  50000         N
       gpt4_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    gpt3                              0        0        0    24000000      =
   =20
0     0  50000         N
       gpt3_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    gpt2                              0        0        0    24000000      =
   =20
0     0  50000         N
       gpt2_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    gpt1                              0        0        0    24000000      =
   =20
0     0  50000         N
       gpt1_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    pwm4                              0        0        0    24000000      =
   =20
0     0  50000         N
       pwm4_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    pwm3                              0        0        0    24000000      =
   =20
0     0  50000         N
       pwm3_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    pwm2                              0        0        0    24000000      =
   =20
0     0  50000         N
       pwm2_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    pwm1                              0        0        0    24000000      =
   =20
0     0  50000         N
       pwm1_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    usb_core_ref                      0        0        0    24000000      =
   =20
0     0  50000         N
    uart4                             1        1        0    24000000      =
   =20
0     0  50000         Y
       uart4_root_clk                 4        4        0    24000000      =
   =20
0     0  50000         Y
    i2c4                              0        1        0    24000000      =
   =20
0     0  50000         N
       i2c4_root_clk                  0        1        0    24000000      =
   =20
0     0  50000         N
    i2c3                              0        0        0    24000000      =
   =20
0     0  50000         N
       i2c3_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    i2c2                              0        1        0    24000000      =
   =20
0     0  50000         N
       i2c2_root_clk                  0        1        0    24000000      =
   =20
0     0  50000         N
    i2c1                              0        1        0    24000000      =
   =20
0     0  50000         N
       i2c1_root_clk                  0        1        0    24000000      =
   =20
0     0  50000         N
    sai6                              0        0        0    24000000      =
   =20
0     0  50000         N
    sai5                              0        0        0    24000000      =
   =20
0     0  50000         N
    sai4                              0        0        0    24000000      =
   =20
0     0  50000         N
    sai3                              0        0        0    24000000      =
   =20
0     0  50000         N
    sai2                              0        0        0    24000000      =
   =20
0     0  50000         N
    sai1                              0        0        0    24000000      =
   =20
0     0  50000         N
    i2c6                              0        1        0    24000000      =
   =20
0     0  50000         N
       i2c6_root_clk                  0        1        0    24000000      =
   =20
0     0  50000         N
    i2c5                              0        0        0    24000000      =
   =20
0     0  50000         N
       i2c5_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    pcie_aux                          0        0        0    24000000      =
   =20
0     0  50000         N
       pcie_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    vpu_g2                            0        0        0    24000000      =
   =20
0     0  50000         N
       vpu_g2_root_clk                0        0        0    24000000      =
   =20
0     0  50000         N
    vpu_g1                            0        0        0    24000000      =
   =20
0     0  50000         N
       vpu_g1_root_clk                0        0        0    24000000      =
   =20
0     0  50000         N
    media_disp2_pix                   0        0        0    24000000      =
   =20
0     0  50000         N
       media_disp2_pix_root_clk       0        0        0    24000000      =
   =20
0     0  50000         N
    mipi_dsi_esc_rx                   0        0        0    24000000      =
   =20
0     0  50000         N
    ml_ahb                            0        0        0    24000000      =
   =20
0     0  50000         N
    ml_axi                            0        0        0    24000000      =
   =20
0     0  50000         N
    hdmi_axi                          0        0        0    24000000      =
   =20
0     0  50000         N
       hdmi_root_clk                  0        0        0    24000000      =
   =20
0     0  50000         N
    vpu_bus                           0        0        0    24000000      =
   =20
0     0  50000         N
       vpu_root_clk                   0        0        0    24000000      =
   =20
0     0  50000         N
    media_isp                         0        0        0    24000000      =
   =20
0     0  50000         N
       media_isp_root_clk             0        0        0    24000000      =
   =20
0     0  50000         N
    ml_core                           0        0        0    24000000      =
   =20
0     0  50000         N
       npu_root_clk                   0        0        0    24000000      =
   =20
0     0  50000         N
    sys_pll3_ref_sel                  0        0        0    24000000      =
   =20
0     0  50000         Y
       sys_pll3                       0        0        0   600000000      =
   =20
0     0  50000         Y
          sys_pll3_bypass             0        0        0   600000000      =
   =20
0     0  50000         Y
             sys_pll3_out             0        0        0   600000000      =
   =20
0     0  50000         N
    sys_pll2_ref_sel                  1        1        0    24000000      =
   =20
0     0  50000         Y
       sys_pll2                       1        1        0  1000000000      =
   =20
0     0  50000         Y
          sys_pll2_bypass             1        1        0  1000000000      =
   =20
0     0  50000         Y
             sys_pll2_out             5        5        0  1000000000      =
   =20
0     0  50000         Y
                sys_pll2_1000m        1        1        0  1000000000      =
   =20
0     0  50000         Y
                   noc                1        1        0  1000000000      =
   =20
0     0  50000         Y
                   media_axi          0        0        0   500000000      =
   =20
0     0  50000         N
                      media_axi_root_clk       0        0        0   500000=
000         =20
0     0  50000         N
                sys_pll2_500m         1        1        0   500000000      =
   =20
0     0  50000         Y
                   hsio_axi           0        0        0   500000000      =
   =20
0     0  50000         N
                      usb_root_clk       0        0        0   500000000   =
      =20
0     0  50000         N
                   gic                1        1        0   500000000      =
   =20
0     0  50000         Y
                   nand               0        0        0   500000000      =
   =20
0     0  50000         N
                      nand_root_clk       0        0        0   500000000  =
       =20
0     0  50000         N
                sys_pll2_333m         0        0        0   333333333      =
   =20
0     0  50000         Y
                sys_pll2_250m         0        0        0   250000000      =
   =20
0     0  50000         Y
                sys_pll2_200m         0        0        0   200000000      =
   =20
0     0  50000         Y
                   ecspi3             0        0        0    50000000      =
   =20
0     0  50000         N
                      ecspi3_root_clk       0        0        0    50000000=
         =20
0     0  50000         N
                   ecspi2             0        0        0    50000000      =
   =20
0     0  50000         N
                      ecspi2_root_clk       0        0        0    50000000=
         =20
0     0  50000         N
                   ecspi1             0        0        0    50000000      =
   =20
0     0  50000         N
                      ecspi1_root_clk       0        0        0    50000000=
         =20
0     0  50000         N
                   m7_core            0        0        0   200000000      =
   =20
0     0  50000         N
                sys_pll2_166m         0        0        0   166666666      =
   =20
0     0  50000         Y
                sys_pll2_125m         2        2        0   125000000      =
   =20
0     0  50000         Y
                   enet_ref           1        1        0   125000000      =
   =20
0     0  50000         Y
                   enet_qos           1        1        0   125000000      =
   =20
0     0  50000         Y
                   hdmi_apb           0        0        0   125000000      =
   =20
0     0  50000         N
                sys_pll2_100m         2        2        0   100000000      =
   =20
0     0  50000         Y
                   enet_timer         1        1        0   100000000      =
   =20
0     0  50000         Y
                   enet_qos_timer       1        1        0   100000000    =
     =20
0     0  50000         Y
                sys_pll2_50m          1        1        0    50000000      =
   =20
0     0  50000         Y
                   enet_phy_ref       1        1        0    50000000      =
   =20
0     0  50000         Y
    sys_pll1_ref_sel                  1        1        0    24000000      =
   =20
0     0  50000         Y
       sys_pll1                       1        1        0   800000000      =
   =20
0     0  50000         Y
          sys_pll1_bypass             1        1        0   800000000      =
   =20
0     0  50000         Y
             sys_pll1_out             5        5        0   800000000      =
   =20
0     0  50000         Y
                sys_pll1_800m         3        3        0   800000000      =
   =20
0     0  50000         Y
                   gpu2d_core         0        0        0   800000000      =
   =20
0     0  50000         N
                      gpu2d_root_clk       0        0        0   800000000 =
        =20
0     0  50000         N
                   gpu3d_shader_core       0        0        0   800000000 =
        =20
0     0  50000         N
                   gpu3d_core         0        0        0   800000000      =
   =20
0     0  50000         N
                      gpu3d_root_clk       0        0        0   800000000 =
        =20
0     0  50000         N
                   gpu_ahb            0        0        0   400000000      =
   =20
0     0  50000         N
                   gpu_axi            0        0        0   800000000      =
   =20
0     0  50000         N
                      gpu_root_clk       0        0        0   800000000   =
      =20
0     0  50000         N
                   audio_axi          0        0        0   800000000      =
   =20
0     0  50000         N
                   audio_ahb          0        0        0   400000000      =
   =20
0     0  50000         N
                      audio_root_clk       0        0        0   400000000 =
        =20
0     0  50000         N
                   noc_io             1        1        0   800000000      =
   =20
0     0  50000         Y
                   arm_a53_div        0        0        0   800000000      =
   =20
0     0  50000         N
                   dram_apb           1        1        0   160000000      =
   =20
0     0  50000         Y
                   media_apb          0        0        0   200000000      =
   =20
0     0  50000         N
                      media_apb_root_clk       0        0        0   200000=
000         =20
0     0  50000         N
                   main_axi           1        1        0   400000000      =
   =20
0     0  50000         Y
                sys_pll1_400m         0        0        0   400000000      =
   =20
0     0  50000         Y
                   usdhc3             0        0        0   400000000      =
   =20
0     0  50000         N
                      usdhc3_root_clk       0        0        0   400000000=
         =20
0     0  50000         N
                   usdhc2             0        0        0   400000000      =
   =20
0     0  50000         N
                      usdhc2_root_clk       0        0        0   400000000=
         =20
0     0  50000         N
                   usdhc1             0        0        0   200000000      =
   =20
0     0  50000         N
                      usdhc1_root_clk       0        0        0   200000000=
         =20
0     0  50000         N
                sys_pll1_266m         2        2        0   266666666      =
   =20
0     0  50000         Y
                   nand_usdhc_bus       1        1        0   266666666    =
     =20
0     0  50000         Y
                      nand_usdhc_rawnand_clk       0        0        0  =20
266666666          0     0  50000         N
                   enet_axi           2        2        0   266666666      =
   =20
0     0  50000         Y
                      sim_enet_root_clk       2        2        0   2666666=
66         =20
0     0  50000         Y
                         enet_qos_root_clk       1        1        0  =20
266666666          0     0  50000         Y
                      enet1_root_clk       1        1        0   266666666 =
        =20
0     0  50000         Y
                sys_pll1_200m         0        0        0   200000000      =
   =20
0     0  50000         Y
                sys_pll1_160m         0        0        0   160000000      =
   =20
0     0  50000         Y
                sys_pll1_133m         1        1        0   133333333      =
   =20
0     0  50000         Y
                   ahb_root           9        4        0   133333333      =
   =20
0     0  50000         Y
                      ipg_root       11       11        0    66666667      =
   =20
0     0  50000         Y
                         tsensor_root_clk       1        1        0   =20
66666667          0     0  50000         Y
                         hsio_root_clk       0        0        0    6666666=
7         =20
0     0  50000         N
                         sdma1_root_clk       6        1        0    666666=
67         =20
0     0  50000         Y
                         qos_enet_root_clk       1        1        0   =20
66666667          0     0  50000         Y
                         qos_root_clk       0        0        0    66666667=
         =20
0     0  50000         N
                         ocotp_root_clk       0        0        0    666666=
67         =20
0     0  50000         N
                         mu_root_clk       0        0        0    66666667 =
        =20
0     0  50000         N
                         gpio5_root_clk       1        1        0    666666=
67         =20
0     0  50000         Y
                         gpio4_root_clk       1        1        0    666666=
67         =20
0     0  50000         Y
                         gpio3_root_clk       1        1        0    666666=
67         =20
0     0  50000         Y
                         gpio2_root_clk       1        1        0    666666=
67         =20
0     0  50000         Y
                         gpio1_root_clk       1        1        0    666666=
67         =20
0     0  50000         Y
                sys_pll1_100m         1        1        0   100000000      =
   =20
0     0  50000         Y
                   usb_phy_ref        0        0        0   100000000      =
   =20
0     0  50000         N
                      usb_phy_root_clk       0        0        0   10000000=
0         =20
0     0  50000         N
                   qspi               1        1        0   100000000      =
   =20
0     0  50000         Y
                      qspi_root_clk       2        2        0   100000000  =
       =20
0     0  50000         Y
                   dram_alt           0        0        0   100000000      =
   =20
0     0  50000         N
                      dram_alt_root       0        0        0    25000000  =
       =20
0     0  50000         Y
                sys_pll1_80m          0        0        0    80000000      =
   =20
0     0  50000         Y
                   uart2              0        0        0    80000000      =
   =20
0     0  50000         N
                      uart2_root_clk       0        0        0    80000000 =
        =20
0     0  50000         N
                   uart3              0        0        0    80000000      =
   =20
0     0  50000         N
                      uart3_root_clk       0        0        0    80000000 =
        =20
0     0  50000         N
                   uart1              0        0        0    80000000      =
   =20
0     0  50000         N
                      uart1_root_clk       0        0        0    80000000 =
        =20
0     0  50000         N
                sys_pll1_40m          2        2        0    40000000      =
   =20
0     0  50000         Y
                   can2               1        1        0    40000000      =
   =20
0     0  50000         Y
                      can2_root_clk       1        1        0    40000000  =
       =20
0     0  50000         Y
                   can1               1        1        0    40000000      =
   =20
0     0  50000         Y
                      can1_root_clk       1        1        0    40000000  =
       =20
0     0  50000         Y
                   wrclk              0        0        0    40000000      =
   =20
0     0  50000         N
    arm_pll_ref_sel                   1        1        0    24000000      =
   =20
0     0  50000         Y
       arm_pll                        1        1        0  1200000000      =
   =20
0     0  50000         Y
          arm_pll_bypass              1        1        0  1200000000      =
   =20
0     0  50000         Y
             arm_pll_out              1        1        0  1200000000      =
   =20
0     0  50000         Y
                arm_a53_core          1        1        0  1200000000      =
   =20
0     0  50000         Y
                   arm                1        1        0  1200000000      =
   =20
0     0  50000         Y
    vpu_pll_ref_sel                   0        0        0    24000000      =
   =20
0     0  50000         Y
       vpu_pll                        0        0        0   800000000      =
   =20
0     0  50000         Y
          vpu_pll_bypass              0        0        0   800000000      =
   =20
0     0  50000         Y
             vpu_pll_out              0        0        0   800000000      =
   =20
0     0  50000         N
    gpu_pll_ref_sel                   0        0        0    24000000      =
   =20
0     0  50000         Y
       gpu_pll                        0        0        0  1000000000      =
   =20
0     0  50000         Y
          gpu_pll_bypass              0        0        0  1000000000      =
   =20
0     0  50000         Y
             gpu_pll_out              0        0        0  1000000000      =
   =20
0     0  50000         N
    dram_pll_ref_sel                  1        1        0    24000000      =
   =20
0     0  50000         Y
       dram_pll                       1        1        0  1000000000      =
   =20
0     0  50000         Y
          dram_pll_bypass             1        1        0  1000000000      =
   =20
0     0  50000         Y
             dram_pll_out             1        1        0  1000000000      =
   =20
0     0  50000         Y
                dram_core_clk         2        2        0  1000000000      =
   =20
0     0  50000         Y
                   dram1_root_clk       1        1        0  1000000000    =
     =20
0     0  50000         Y
    video_pll1_ref_sel                0        0        0    24000000      =
   =20
0     0  50000         Y
       video_pll1                     0        0        0   594000000      =
   =20
0     0  50000         Y
          video_pll1_bypass           0        0        0   594000000      =
   =20
0     0  50000         Y
             video_pll1_out           0        0        0   594000000      =
   =20
0     0  50000         N
                media_mipi_phy1_ref       0        0        0    27000000  =
       =20
0     0  50000         N
                   media_mipi_phy1_ref_root       0        0        0   =20
27000000          0     0  50000         N
    audio_pll2_ref_sel                0        0        0    24000000      =
   =20
0     0  50000         Y
       audio_pll2                     0        0        0   361267196      =
   =20
0     0  50000         Y
          audio_pll2_bypass           0        0        0   361267196      =
   =20
0     0  50000         Y
             audio_pll2_out           0        0        0   361267196      =
   =20
0     0  50000         N
    audio_pll1_ref_sel                0        0        0    24000000      =
   =20
0     0  50000         Y
       audio_pll1                     0        0        0   393215995      =
   =20
0     0  50000         Y
          audio_pll1_bypass           0        0        0   393215995      =
   =20
0     0  50000         Y
             audio_pll1_out           0        0        0   393215995      =
   =20
0     0  50000         N
                clkout2_sel           0        0        0   393215995      =
   =20
0     0  50000         Y
                   clkout2_div        0        0        0   393215995      =
   =20
0     0  50000         Y
                      clkout2         0        0        0   393215995      =
   =20
0     0  50000         N
                clkout1_sel           0        0        0   393215995      =
   =20
0     0  50000         Y
                   clkout1_div        0        0        0   393215995      =
   =20
0     0  50000         Y
                      clkout1         0        0        0   393215995      =
   =20
0     0  50000         N
 osc_32k                              0        0        0       32768      =
   =20
0     0  50000         Y


Thanks for the work and best regards,
Alexander



