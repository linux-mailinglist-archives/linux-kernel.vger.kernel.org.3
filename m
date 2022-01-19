Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E63649325A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350686AbiASBay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350680AbiASBaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:30:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A96C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:30:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 30so3636261edv.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObzWOFozxlrYSTqy3Vly2Oy/aim15nW57FvB/rEORCI=;
        b=rrKJfAqvrVA47ByhBSqJQSdawaCBuK8ZON1w8xmGXpZDGYgXclWgZGeI56VRHDzvM6
         Soldo6cqw5VdRU8wITrFF2SSoOK/ipoEEjdeHC4k1Gq+qt7z1Naf9A/YNLGQdrKlapCc
         gZD7l+1ksWg0+5M28eITncO3RprOCZGr9SUlLk1mR4XM1eK8Ccxi3ElPAVgSe+diCe4C
         0ukOsehEz6X54k8WxFPcbUvV1EnS70GRNv8b2Q5THdbL/KemKiTtuoBrzTPff5zTmVtx
         tB0gW7HOo5U4Hl/SkXRu9HMSUKImUAFrW10E0y+S6/X/ZpnpYbwmOGIYVgT9LxuTf6Dl
         whUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObzWOFozxlrYSTqy3Vly2Oy/aim15nW57FvB/rEORCI=;
        b=hqMLdP6ifHRkvgQrvJzo+5P595brMESO+nb01YDEunRe9plNLLur4F0nn+N2c217oU
         /4orgxKZzxaNbRyfvjyua8w0tWYGpQizsHZfCbC7IFQGkvxUFrEma5ZixPhaqmgIl815
         XISKLYjKKu/uxPhxatZyfQ9/wj/xktixGXeb8b0Zjj3SeJyvVtc1e7zibDwpaTwdvr2y
         RQicoVJ2ar2Zq0rwynqJRifId6dw9+fN5a2E9qLCIW4XkNEQfI5gMPby5fAfcgLNpoSJ
         UUBFwJ+wqAlvUEH7tgWv/8qRUickkIZBiQW9zIelF6M4Ih2WpHNm3dO/Lfmz41PdV7/1
         ZMrw==
X-Gm-Message-State: AOAM5309PUWyZE2tGfi7gizqKULV7Hn7YqjGnRC56phYdfqqpY1Y7whE
        7hqt2ViTMZt3Sm4K6edbnigH3C3hXU2DiQnhveFjxQ==
X-Google-Smtp-Source: ABdhPJw8FgRwtjJo/mUrHumHyy+5UgblK4uNn9ooMNerZhb50kaYpgW5QuemaW4CsmPJqOMuXQXorYQj+BhKWkFEtIc=
X-Received: by 2002:a17:907:6da5:: with SMTP id sb37mr22217371ejc.631.1642555849271;
 Tue, 18 Jan 2022 17:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20220115080657.2780989-1-sboyd@kernel.org> <CAGS_qxpbOM4KuRe_SZ+es7K49_dV+2A1rwKX9bvjeGfSn04s6w@mail.gmail.com>
 <20220119012051.E3738C340E0@smtp.kernel.org>
In-Reply-To: <20220119012051.E3738C340E0@smtp.kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 18 Jan 2022 17:30:37 -0800
Message-ID: <CAGS_qxqzHq4ZQeSFg-Uxg30x70v5sCu23zooYNHFm9cX-XyPTQ@mail.gmail.com>
Subject: Re: [PATCH] clk: gate: Add some kunit test suites
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 5:20 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Daniel Latypov (2022-01-15 13:48:42)
> > On Sat, Jan 15, 2022 at 12:07 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Test various parts of the clk gate implementation with the kunit testing
> > > framework.
> > >
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > Cc: <kunit-dev@googlegroups.com>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> >
> > Nice!
> > Some minor nits and suggestions re kunit usage below.
> >
> > Acked-by: Daniel Latypov <dlatypov@google.com>
> >
> > > ---
> > >
> > > This is a resend of the RFC[1] from almost two years ago! It will be
> > > merged after the merge window closes.
> > >
> > > [1] https://lore.kernel.org/r/20200408035637.110858-1-sboyd@kernel.org
> > >
> > >  drivers/clk/Kconfig         |   8 +
> > >  drivers/clk/Makefile        |   1 +
> > >  drivers/clk/clk-gate-test.c | 481 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 490 insertions(+)
> > >  create mode 100644 drivers/clk/clk-gate-test.c
> > >
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index c5b3dc97396a..41e560249370 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -421,4 +421,12 @@ source "drivers/clk/x86/Kconfig"
> > >  source "drivers/clk/xilinx/Kconfig"
> > >  source "drivers/clk/zynqmp/Kconfig"
> > >
> > > +# Kunit test cases
> > > +config CLK_GATE_TEST
> > > +       tristate "Basic gate type Kunit test"
> > > +       depends on KUNIT
> > > +       default KUNIT
> > > +       help
> > > +         Kunit test for the basic clk gate type.
> >
> > minor nit: since the previous version, there is now
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-kconfig-entries
> >
> > so something like:
> > config CLK_GATE_KUNIT_TEST
> >   tristate "Basic gate type KUnit test" if !KUNIT_ALL_TESTS
> >   depends on KUNIT
> >   default KUNIT_ALL_TESTS
> > ...
> >
> > would be the way to go.
>
> Got it. Thanks!
>
> >
> > On a related note, you could add a .kunitconfig file to make running
> > this easier:
> > $ cat drivers/clk/.kunitconfig
> > CONFIG_KUNIT=y
> > CONFIG_COMMON_CLK=y
> > CONFIG_CLK_GATE_TEST=y
>
> Sure that works for me. I was using my own kunitconfig file and then
> running all 'clk*' tests. This would make it easier I suppose. Too bad
> the pattern match can't figure out what dependencies to enable.
>
> >
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/clk
> > ...
> > Testing complete. Passed: 17, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> >
> > There's not much in the way of dependencies here so it doesn't help that much.
> > But it is an option if you want a one-liner way to be able to run the test.
> >
> > > +
> > >  endif
> > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > > index e42312121e51..dcdb75712940 100644
> > > --- a/drivers/clk/Makefile
> > > +++ b/drivers/clk/Makefile
> > > @@ -6,6 +6,7 @@ obj-$(CONFIG_COMMON_CLK)        += clk-divider.o
> > >  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-factor.o
> > >  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-rate.o
> > >  obj-$(CONFIG_COMMON_CLK)       += clk-gate.o
> > > +obj-$(CONFIG_CLK_GATE_TEST)    += clk-gate-test.o
> > >  obj-$(CONFIG_COMMON_CLK)       += clk-multiplier.o
> > >  obj-$(CONFIG_COMMON_CLK)       += clk-mux.o
> > >  obj-$(CONFIG_COMMON_CLK)       += clk-composite.o
> > > diff --git a/drivers/clk/clk-gate-test.c b/drivers/clk/clk-gate-test.c
> > > new file mode 100644
> > > index 000000000000..b499c2ffa815
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-gate-test.c
> >
> > again a minor nit: clk_gate_test.c or clk_gate_kunit.c would be the
> > preferred names now:
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-kconfig-entries
> >
> > Note that KUnit itself doesn't follow its own naming guidelines unfortunately.
>
> How about clk-gate_test.c then? I'd like it to match the clk-gate.c
> file but can support the _test suffix.

That sounds completely reasonable to me.
I'd say go for it, if no one chimes in w/ any objections.

>
> >
> > > @@ -0,0 +1,481 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Kunit test for clk gate basic type
> > > + */
> > > +#include <linux/clk.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include <kunit/test.h>
> > > +
> > > +static void clk_gate_register_test_dev(struct kunit *test)
> > > +{
> > > +       struct clk_hw *ret;
> > > +       struct platform_device *pdev;
> > > +
> > > +       pdev = platform_device_register_simple("test_gate_device", -1, NULL, 0);
> > > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> > > +
> > > +       ret = clk_hw_register_gate(&pdev->dev, "test_gate", NULL, 0, NULL,
> > > +                                  0, 0, NULL);
> > > +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ret);
> >
> > I think we want ASSERT here, otherwise we segfault below.
>
> Fixed.
>
> >
> > > +       KUNIT_EXPECT_STREQ(test, "test_gate", clk_hw_get_name(ret));
> > > +       KUNIT_EXPECT_EQ(test, 0UL, clk_hw_get_flags(ret));
> > > +
> [...]
> > > +
> > > +static struct clk_gate_test_context *clk_gate_test_alloc_ctx(struct kunit *test)
> > > +{
> > > +       struct clk_gate_test_context *ctx;
> > > +
> > > +       test->priv = ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> >
> > It looks like kunit_kzalloc() here would work as well.
> > It should also be a bit safer, i.e. we won't leak ctx if
> > clk_hw_register_fixed_rate() errors out in the init func.
>
> Ok.
>
> >
> > > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> > > +       ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
> > > +
> > > +       return ctx;
> > > +}
> > > +
> > > +static void clk_gate_test_parent_rate(struct kunit *test)
> > > +{
> > > +       struct clk_gate_test_context *ctx = test->priv;
> > > +       struct clk_hw *parent = ctx->parent;
> > > +       struct clk_hw *hw = ctx->hw;
> > > +       unsigned long prate = clk_hw_get_rate(parent);
> > > +       unsigned long rate = clk_hw_get_rate(hw);
> > > +
> > > +       KUNIT_EXPECT_EQ(test, prate, rate);
> > > +}
> > > +
> > > +static void clk_gate_test_enable(struct kunit *test)
> > > +{
> > > +       struct clk_gate_test_context *ctx = test->priv;
> > > +       struct clk_hw *parent = ctx->parent;
> > > +       struct clk_hw *hw = ctx->hw;
> > > +       struct clk *clk = hw->clk;
> > > +       int ret;
> > > +       u32 enable_val = BIT(5);
> > > +
> > > +       ret = clk_prepare_enable(clk);
> > > +       KUNIT_ASSERT_EQ(test, ret, 0);
> >
> > optional: in the cases where it's short enough, I'd personally favor
> > KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
> >
> > That way we get more context in the assertion failure messages.
>
> Makes sense.
