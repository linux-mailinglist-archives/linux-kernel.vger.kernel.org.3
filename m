Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FB548F99B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 22:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiAOVs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 16:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiAOVs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 16:48:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC15C06161C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 13:48:56 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a18so48275638edj.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZoXGvWvIfilwjm2pZvuzx+cBp1chJa54Bqg+TlkGlY=;
        b=E8FwHrkYRHbP1vN08FIMmoyWmRIeJBnxJPuvDG2QtNqoMo0aPJKLXNoJ41jThE3pp0
         0InRCtO6F6lphVAkS+1fe28eWFFufKb9DEPxClRQ+x4nGRQah+j5zeG4efxsm/dKsgYv
         kqXm9J/A0TzmepPffZxvXyitNZ+md5k85FdHu95+YTb6zVTgs76c6WllkELuxrSW8waO
         +mUidJjwZ3syb10rQSSjWPGx+lcKWHI0BbeYQ9o0IvD6n27x3UFR/cGEHmHI4xX61g43
         Rem27XuuXhwU6W4QJgKK5oCe/YKqvcQEYc30HXpUB3Ju6FeG1/MXsWZ7A0ZFRD82iUP3
         PXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZoXGvWvIfilwjm2pZvuzx+cBp1chJa54Bqg+TlkGlY=;
        b=ita8Sd1q0EDsk82YhKVHcaG+m9q/hvOyVa5ZSw6/184ODahGz9sCNFFUhLpc+2PlWo
         /S5eJO3x9tig0OYpYu4yfIpDsmC0r6/pLJBZgiClaYjnT8WhT19pYpN0ezdv+7CrdJR/
         tQQi3WfqmYV1N/v5VKNHTKJJW3fQECeX+0/50NpYBL2IvMLhDpqwYrJ9PDhXTDhAhSkZ
         ooc/j45HDGicafawIwJLbZkJXrZOwsDpq8OUDO2+30FimzGCXAlYeTJaE10+cL8bLGXz
         gqBUOPDxHio2OtN6DfacydNiJBCEeHKzCikOQUa2jg4j5DSF7PfJjb7ea2djb99u+hjL
         //HQ==
X-Gm-Message-State: AOAM5309z2MaoC8vB261VUqBsa0C3pjezlLShBVcDtuMOUSWcyNndi6Q
        f37YjzTrIDV2/B140jwAgyZgCQ1rFsjdaEzHBcdZTA==
X-Google-Smtp-Source: ABdhPJxJyDO7w0pPt5X8XlctCB8Qc6rPC5pBc5i/BgBP0cI08/xndc4N1F6amMS5949NSLCyTDTvKH/Jqizzo1UoyKo=
X-Received: by 2002:a50:bb0c:: with SMTP id y12mr14523411ede.247.1642283334434;
 Sat, 15 Jan 2022 13:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20220115080657.2780989-1-sboyd@kernel.org>
In-Reply-To: <20220115080657.2780989-1-sboyd@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Sat, 15 Jan 2022 13:48:42 -0800
Message-ID: <CAGS_qxpbOM4KuRe_SZ+es7K49_dV+2A1rwKX9bvjeGfSn04s6w@mail.gmail.com>
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

On Sat, Jan 15, 2022 at 12:07 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Test various parts of the clk gate implementation with the kunit testing
> framework.
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: <kunit-dev@googlegroups.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Nice!
Some minor nits and suggestions re kunit usage below.

Acked-by: Daniel Latypov <dlatypov@google.com>

> ---
>
> This is a resend of the RFC[1] from almost two years ago! It will be
> merged after the merge window closes.
>
> [1] https://lore.kernel.org/r/20200408035637.110858-1-sboyd@kernel.org
>
>  drivers/clk/Kconfig         |   8 +
>  drivers/clk/Makefile        |   1 +
>  drivers/clk/clk-gate-test.c | 481 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 490 insertions(+)
>  create mode 100644 drivers/clk/clk-gate-test.c
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c5b3dc97396a..41e560249370 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -421,4 +421,12 @@ source "drivers/clk/x86/Kconfig"
>  source "drivers/clk/xilinx/Kconfig"
>  source "drivers/clk/zynqmp/Kconfig"
>
> +# Kunit test cases
> +config CLK_GATE_TEST
> +       tristate "Basic gate type Kunit test"
> +       depends on KUNIT
> +       default KUNIT
> +       help
> +         Kunit test for the basic clk gate type.

minor nit: since the previous version, there is now
https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-kconfig-entries

so something like:
config CLK_GATE_KUNIT_TEST
  tristate "Basic gate type KUnit test" if !KUNIT_ALL_TESTS
  depends on KUNIT
  default KUNIT_ALL_TESTS
...

would be the way to go.

On a related note, you could add a .kunitconfig file to make running
this easier:
$ cat drivers/clk/.kunitconfig
CONFIG_KUNIT=y
CONFIG_COMMON_CLK=y
CONFIG_CLK_GATE_TEST=y

$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/clk
...
Testing complete. Passed: 17, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0

There's not much in the way of dependencies here so it doesn't help that much.
But it is an option if you want a one-liner way to be able to run the test.

> +
>  endif
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e42312121e51..dcdb75712940 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_COMMON_CLK)        += clk-divider.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-factor.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-rate.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-gate.o
> +obj-$(CONFIG_CLK_GATE_TEST)    += clk-gate-test.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-multiplier.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-mux.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-composite.o
> diff --git a/drivers/clk/clk-gate-test.c b/drivers/clk/clk-gate-test.c
> new file mode 100644
> index 000000000000..b499c2ffa815
> --- /dev/null
> +++ b/drivers/clk/clk-gate-test.c

again a minor nit: clk_gate_test.c or clk_gate_kunit.c would be the
preferred names now:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-kconfig-entries

Note that KUnit itself doesn't follow its own naming guidelines unfortunately.

> @@ -0,0 +1,481 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kunit test for clk gate basic type
> + */
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include <kunit/test.h>
> +
> +static void clk_gate_register_test_dev(struct kunit *test)
> +{
> +       struct clk_hw *ret;
> +       struct platform_device *pdev;
> +
> +       pdev = platform_device_register_simple("test_gate_device", -1, NULL, 0);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       ret = clk_hw_register_gate(&pdev->dev, "test_gate", NULL, 0, NULL,
> +                                  0, 0, NULL);
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ret);

I think we want ASSERT here, otherwise we segfault below.

> +       KUNIT_EXPECT_STREQ(test, "test_gate", clk_hw_get_name(ret));
> +       KUNIT_EXPECT_EQ(test, 0UL, clk_hw_get_flags(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       platform_device_put(pdev);
> +}
> +
> +static void clk_gate_register_test_parent_names(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *ret;
> +
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           1000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       ret = clk_hw_register_gate(NULL, "test_gate", "test_parent", 0, NULL,
> +                                  0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> +       KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       clk_hw_unregister_fixed_rate(parent);
> +}
> +
> +static void clk_gate_register_test_parent_data(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *ret;
> +       struct clk_parent_data pdata = { };
> +
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           1000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +       pdata.hw = parent;
> +
> +       ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
> +                                              NULL, 0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> +       KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       clk_hw_unregister_fixed_rate(parent);
> +}
> +
> +static void clk_gate_register_test_parent_data_legacy(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *ret;
> +       struct clk_parent_data pdata = { };
> +
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           1000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +       pdata.name = "test_parent";
> +
> +       ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
> +                                              NULL, 0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> +       KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       clk_hw_unregister_fixed_rate(parent);
> +}
> +
> +static void clk_gate_register_test_parent_hw(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *ret;
> +
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           1000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       ret = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0, NULL,
> +                                            0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> +       KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       clk_hw_unregister_fixed_rate(parent);
> +}
> +
> +static void clk_gate_register_test_hiword_invalid(struct kunit *test)
> +{
> +       struct clk_hw *ret;
> +
> +       ret = clk_hw_register_gate(NULL, "test_gate", NULL, 0, NULL,
> +                                  20, CLK_GATE_HIWORD_MASK, NULL);
> +
> +       KUNIT_EXPECT_TRUE(test, IS_ERR(ret));
> +}
> +
> +static struct kunit_case clk_gate_register_test_cases[] = {
> +       KUNIT_CASE(clk_gate_register_test_dev),
> +       KUNIT_CASE(clk_gate_register_test_parent_names),
> +       KUNIT_CASE(clk_gate_register_test_parent_data),
> +       KUNIT_CASE(clk_gate_register_test_parent_data_legacy),
> +       KUNIT_CASE(clk_gate_register_test_parent_hw),
> +       KUNIT_CASE(clk_gate_register_test_hiword_invalid),
> +       {}
> +};
> +
> +static struct kunit_suite clk_gate_register_test_suite = {
> +       .name = "clk-gate-register-test",
> +       .test_cases = clk_gate_register_test_cases,
> +};
> +
> +struct clk_gate_test_context {
> +       void __iomem *fake_mem;
> +       struct clk_hw *hw;
> +       struct clk_hw *parent;
> +       u32 fake_reg; /* Keep at end, KASAN can detect out of bounds */
> +};
> +
> +static struct clk_gate_test_context *clk_gate_test_alloc_ctx(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx;
> +
> +       test->priv = ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);

It looks like kunit_kzalloc() here would work as well.
It should also be a bit safer, i.e. we won't leak ctx if
clk_hw_register_fixed_rate() errors out in the init func.

> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +       ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
> +
> +       return ctx;
> +}
> +
> +static void clk_gate_test_parent_rate(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       unsigned long prate = clk_hw_get_rate(parent);
> +       unsigned long rate = clk_hw_get_rate(hw);
> +
> +       KUNIT_EXPECT_EQ(test, prate, rate);
> +}
> +
> +static void clk_gate_test_enable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       int ret;
> +       u32 enable_val = BIT(5);
> +
> +       ret = clk_prepare_enable(clk);
> +       KUNIT_ASSERT_EQ(test, ret, 0);

optional: in the cases where it's short enough, I'd personally favor
KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);

That way we get more context in the assertion failure messages.

> +
> +       KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static void clk_gate_test_disable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       int ret;
> +       u32 enable_val = BIT(5);
> +       u32 disable_val = 0;
> +
> +       ret = clk_prepare_enable(clk);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +       KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> +
> +       clk_disable_unprepare(clk);
> +       KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static struct kunit_case clk_gate_test_cases[] = {
> +       KUNIT_CASE(clk_gate_test_parent_rate),
> +       KUNIT_CASE(clk_gate_test_enable),
> +       KUNIT_CASE(clk_gate_test_disable),
> +       {}
> +};
> +
> +static int clk_gate_test_init(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           2000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
> +                                           ctx->fake_mem, 5, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +
> +       ctx->hw = hw;
> +       ctx->parent = parent;
> +
> +       return 0;
> +}
> +
> +static void clk_gate_test_exit(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +
> +       clk_hw_unregister_gate(ctx->hw);
> +       clk_hw_unregister_fixed_rate(ctx->parent);
> +       kfree(ctx);
> +}
> +
> +static struct kunit_suite clk_gate_test_suite = {
> +       .name = "clk-gate-test",
> +       .init = clk_gate_test_init,
> +       .exit = clk_gate_test_exit,
> +       .test_cases = clk_gate_test_cases,
> +};
> +
> +static void clk_gate_test_invert_enable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       int ret;
> +       u32 enable_val = 0;
> +
> +       ret = clk_prepare_enable(clk);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static void clk_gate_test_invert_disable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       int ret;
> +       u32 enable_val = 0;
> +       u32 disable_val = BIT(15);
> +
> +       ret = clk_prepare_enable(clk);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +       KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> +
> +       clk_disable_unprepare(clk);
> +       KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static struct kunit_case clk_gate_test_invert_cases[] = {
> +       KUNIT_CASE(clk_gate_test_invert_enable),
> +       KUNIT_CASE(clk_gate_test_invert_disable),
> +       {}
> +};
> +
> +static int clk_gate_test_invert_init(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           2000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       ctx->fake_reg = BIT(15); /* Default to off */
> +       hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
> +                                           ctx->fake_mem, 15,
> +                                           CLK_GATE_SET_TO_DISABLE, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +
> +       ctx->hw = hw;
> +       ctx->parent = parent;
> +
> +       return 0;
> +}
> +
> +static struct kunit_suite clk_gate_test_invert_suite = {
> +       .name = "clk-gate-invert-test",
> +       .init = clk_gate_test_invert_init,
> +       .exit = clk_gate_test_exit,
> +       .test_cases = clk_gate_test_invert_cases,
> +};
> +
> +static void clk_gate_test_hiword_enable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       int ret;
> +       u32 enable_val = BIT(9) | BIT(9 + 16);
> +
> +       ret = clk_prepare_enable(clk);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static void clk_gate_test_hiword_disable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       int ret;
> +       u32 enable_val = BIT(9) | BIT(9 + 16);
> +       u32 disable_val = BIT(9 + 16);
> +
> +       ret = clk_prepare_enable(clk);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +       KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> +
> +       clk_disable_unprepare(clk);
> +       KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static struct kunit_case clk_gate_test_hiword_cases[] = {
> +       KUNIT_CASE(clk_gate_test_hiword_enable),
> +       KUNIT_CASE(clk_gate_test_hiword_disable),
> +       {}
> +};
> +
> +static int clk_gate_test_hiword_init(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           2000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
> +                                           ctx->fake_mem, 9,
> +                                           CLK_GATE_HIWORD_MASK, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +
> +       ctx->hw = hw;
> +       ctx->parent = parent;
> +
> +       return 0;
> +}
> +
> +static struct kunit_suite clk_gate_test_hiword_suite = {
> +       .name = "clk-gate-hiword-test",
> +       .init = clk_gate_test_hiword_init,
> +       .exit = clk_gate_test_exit,
> +       .test_cases = clk_gate_test_hiword_cases,
> +};
> +
> +static void clk_gate_test_is_enabled(struct kunit *test)
> +{
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       ctx->fake_reg = BIT(7);
> +       hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
> +                                 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +       KUNIT_ASSERT_TRUE(test, clk_hw_is_enabled(hw));
> +
> +       clk_hw_unregister_gate(hw);
> +       kfree(ctx);
> +}
> +
> +static void clk_gate_test_is_disabled(struct kunit *test)
> +{
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       ctx->fake_reg = BIT(4);
> +       hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
> +                                 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +       KUNIT_ASSERT_FALSE(test, clk_hw_is_enabled(hw));
> +
> +       clk_hw_unregister_gate(hw);
> +       kfree(ctx);
> +}
> +
> +static void clk_gate_test_is_enabled_inverted(struct kunit *test)
> +{
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       ctx->fake_reg = BIT(31);
> +       hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 2,
> +                                 CLK_GATE_SET_TO_DISABLE, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +       KUNIT_ASSERT_TRUE(test, clk_hw_is_enabled(hw));
> +
> +       clk_hw_unregister_gate(hw);
> +       kfree(ctx);
> +}
> +
> +static void clk_gate_test_is_disabled_inverted(struct kunit *test)
> +{
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       ctx->fake_reg = BIT(29);
> +       hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 29,
> +                                 CLK_GATE_SET_TO_DISABLE, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +       KUNIT_ASSERT_FALSE(test, clk_hw_is_enabled(hw));
> +
> +       clk_hw_unregister_gate(hw);
> +       kfree(ctx);
> +}
> +
> +static struct kunit_case clk_gate_test_enabled_cases[] = {
> +       KUNIT_CASE(clk_gate_test_is_enabled),
> +       KUNIT_CASE(clk_gate_test_is_disabled),
> +       KUNIT_CASE(clk_gate_test_is_enabled_inverted),
> +       KUNIT_CASE(clk_gate_test_is_disabled_inverted),
> +       {}
> +};
> +
> +static struct kunit_suite clk_gate_test_enabled_suite = {
> +       .name = "clk-gate-is_enabled-test",
> +       .test_cases = clk_gate_test_enabled_cases,
> +};
> +
> +kunit_test_suites(
> +       &clk_gate_register_test_suite,
> +       &clk_gate_test_suite,
> +       &clk_gate_test_invert_suite,
> +       &clk_gate_test_hiword_suite,
> +       &clk_gate_test_enabled_suite
> +);
> +MODULE_LICENSE("GPL v2");
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220115080657.2780989-1-sboyd%40kernel.org.
