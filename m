Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D457049323D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350623AbiASBUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:20:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35770 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiASBUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:20:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A3CBB81888;
        Wed, 19 Jan 2022 01:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3738C340E0;
        Wed, 19 Jan 2022 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642555252;
        bh=IdKEiKpGHXzv1BpSQvf0H/cY6Y+Lf9aU6BjdVqTjtXA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VAOADwpenDmbm3NYL3N/LZ8k7ITTxcXGKcf+ourxpmgOZ7BpgCS2Wah6QnKru5tMq
         4E6U9UxkwbocpNU0sjOZP1BQHlb0aw4n1pAQx4hH8SmbtEiwz+jquvhIuZkFgoq1N/
         tz69w/fYZemPgswMjd8+W7H2OQonHP35ECxMOyB3QHRULQMH7z/UCLHU/JsPKH8nhI
         fK5u+f0wkh9xDu04of7bG76f411T5ycS3bQ0lTcQIPq0lSFGgip5u84t81Z2cYIAVF
         jywBzwOwO2Rs8PKZkZs53xvNZAYSsUN7UUeNvW5RZRLpUK5OGSNhOpFB7BNfXHpEfo
         RMkWobWcWdtNA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGS_qxpbOM4KuRe_SZ+es7K49_dV+2A1rwKX9bvjeGfSn04s6w@mail.gmail.com>
References: <20220115080657.2780989-1-sboyd@kernel.org> <CAGS_qxpbOM4KuRe_SZ+es7K49_dV+2A1rwKX9bvjeGfSn04s6w@mail.gmail.com>
Subject: Re: [PATCH] clk: gate: Add some kunit test suites
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com
To:     Daniel Latypov <dlatypov@google.com>
Date:   Tue, 18 Jan 2022 17:20:50 -0800
User-Agent: alot/0.10
Message-Id: <20220119012051.E3738C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Latypov (2022-01-15 13:48:42)
> On Sat, Jan 15, 2022 at 12:07 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Test various parts of the clk gate implementation with the kunit testing
> > framework.
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Cc: <kunit-dev@googlegroups.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>=20
> Nice!
> Some minor nits and suggestions re kunit usage below.
>=20
> Acked-by: Daniel Latypov <dlatypov@google.com>
>=20
> > ---
> >
> > This is a resend of the RFC[1] from almost two years ago! It will be
> > merged after the merge window closes.
> >
> > [1] https://lore.kernel.org/r/20200408035637.110858-1-sboyd@kernel.org
> >
> >  drivers/clk/Kconfig         |   8 +
> >  drivers/clk/Makefile        |   1 +
> >  drivers/clk/clk-gate-test.c | 481 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 490 insertions(+)
> >  create mode 100644 drivers/clk/clk-gate-test.c
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index c5b3dc97396a..41e560249370 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -421,4 +421,12 @@ source "drivers/clk/x86/Kconfig"
> >  source "drivers/clk/xilinx/Kconfig"
> >  source "drivers/clk/zynqmp/Kconfig"
> >
> > +# Kunit test cases
> > +config CLK_GATE_TEST
> > +       tristate "Basic gate type Kunit test"
> > +       depends on KUNIT
> > +       default KUNIT
> > +       help
> > +         Kunit test for the basic clk gate type.
>=20
> minor nit: since the previous version, there is now
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-kc=
onfig-entries
>=20
> so something like:
> config CLK_GATE_KUNIT_TEST
>   tristate "Basic gate type KUnit test" if !KUNIT_ALL_TESTS
>   depends on KUNIT
>   default KUNIT_ALL_TESTS
> ...
>=20
> would be the way to go.

Got it. Thanks!

>=20
> On a related note, you could add a .kunitconfig file to make running
> this easier:
> $ cat drivers/clk/.kunitconfig
> CONFIG_KUNIT=3Dy
> CONFIG_COMMON_CLK=3Dy
> CONFIG_CLK_GATE_TEST=3Dy

Sure that works for me. I was using my own kunitconfig file and then
running all 'clk*' tests. This would make it easier I suppose. Too bad
the pattern match can't figure out what dependencies to enable.

>=20
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/clk
> ...
> Testing complete. Passed: 17, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
>=20
> There's not much in the way of dependencies here so it doesn't help that =
much.
> But it is an option if you want a one-liner way to be able to run the tes=
t.
>=20
> > +
> >  endif
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index e42312121e51..dcdb75712940 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -6,6 +6,7 @@ obj-$(CONFIG_COMMON_CLK)        +=3D clk-divider.o
> >  obj-$(CONFIG_COMMON_CLK)       +=3D clk-fixed-factor.o
> >  obj-$(CONFIG_COMMON_CLK)       +=3D clk-fixed-rate.o
> >  obj-$(CONFIG_COMMON_CLK)       +=3D clk-gate.o
> > +obj-$(CONFIG_CLK_GATE_TEST)    +=3D clk-gate-test.o
> >  obj-$(CONFIG_COMMON_CLK)       +=3D clk-multiplier.o
> >  obj-$(CONFIG_COMMON_CLK)       +=3D clk-mux.o
> >  obj-$(CONFIG_COMMON_CLK)       +=3D clk-composite.o
> > diff --git a/drivers/clk/clk-gate-test.c b/drivers/clk/clk-gate-test.c
> > new file mode 100644
> > index 000000000000..b499c2ffa815
> > --- /dev/null
> > +++ b/drivers/clk/clk-gate-test.c
>=20
> again a minor nit: clk_gate_test.c or clk_gate_kunit.c would be the
> preferred names now:
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-kc=
onfig-entries
>=20
> Note that KUnit itself doesn't follow its own naming guidelines unfortuna=
tely.

How about clk-gate_test.c then? I'd like it to match the clk-gate.c
file but can support the _test suffix.

>=20
> > @@ -0,0 +1,481 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Kunit test for clk gate basic type
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <kunit/test.h>
> > +
> > +static void clk_gate_register_test_dev(struct kunit *test)
> > +{
> > +       struct clk_hw *ret;
> > +       struct platform_device *pdev;
> > +
> > +       pdev =3D platform_device_register_simple("test_gate_device", -1=
, NULL, 0);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> > +
> > +       ret =3D clk_hw_register_gate(&pdev->dev, "test_gate", NULL, 0, =
NULL,
> > +                                  0, 0, NULL);
> > +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ret);
>=20
> I think we want ASSERT here, otherwise we segfault below.

Fixed.

>=20
> > +       KUNIT_EXPECT_STREQ(test, "test_gate", clk_hw_get_name(ret));
> > +       KUNIT_EXPECT_EQ(test, 0UL, clk_hw_get_flags(ret));
> > +
[...]
> > +
> > +static struct clk_gate_test_context *clk_gate_test_alloc_ctx(struct ku=
nit *test)
> > +{
> > +       struct clk_gate_test_context *ctx;
> > +
> > +       test->priv =3D ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
>=20
> It looks like kunit_kzalloc() here would work as well.
> It should also be a bit safer, i.e. we won't leak ctx if
> clk_hw_register_fixed_rate() errors out in the init func.

Ok.=20

>=20
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> > +       ctx->fake_mem =3D (void __force __iomem *)&ctx->fake_reg;
> > +
> > +       return ctx;
> > +}
> > +
> > +static void clk_gate_test_parent_rate(struct kunit *test)
> > +{
> > +       struct clk_gate_test_context *ctx =3D test->priv;
> > +       struct clk_hw *parent =3D ctx->parent;
> > +       struct clk_hw *hw =3D ctx->hw;
> > +       unsigned long prate =3D clk_hw_get_rate(parent);
> > +       unsigned long rate =3D clk_hw_get_rate(hw);
> > +
> > +       KUNIT_EXPECT_EQ(test, prate, rate);
> > +}
> > +
> > +static void clk_gate_test_enable(struct kunit *test)
> > +{
> > +       struct clk_gate_test_context *ctx =3D test->priv;
> > +       struct clk_hw *parent =3D ctx->parent;
> > +       struct clk_hw *hw =3D ctx->hw;
> > +       struct clk *clk =3D hw->clk;
> > +       int ret;
> > +       u32 enable_val =3D BIT(5);
> > +
> > +       ret =3D clk_prepare_enable(clk);
> > +       KUNIT_ASSERT_EQ(test, ret, 0);
>=20
> optional: in the cases where it's short enough, I'd personally favor
> KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
>=20
> That way we get more context in the assertion failure messages.

Makes sense.
