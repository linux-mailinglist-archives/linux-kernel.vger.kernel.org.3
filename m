Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F13494702
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 06:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358610AbiATFiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 00:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiATFiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 00:38:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA148C061574;
        Wed, 19 Jan 2022 21:38:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30C93610E8;
        Thu, 20 Jan 2022 05:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C17C340E0;
        Thu, 20 Jan 2022 05:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642657090;
        bh=krlYkHrswJrLWdvAVEVUNEkGSQeLkLwmuTkvBa6OJYM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Iwtfpy94QA2FGa/t8fhAYL79dun1O2tuURscaQ6ETfUVyP+1S00BMp69WNqCRxWnA
         RNb6dLSB3I3OAKnGR2MSkC4/Tj6rob+FA+5ayZzW05q7HItH2zuPzr6qfK/aRhOYU5
         b045RPYQ58cqJX28BpKy5rz2HSrVMKZryfQ/4HwrX9oKG5U8sN2lFfCUl437SOiouc
         l8pLrnZpn/Rtuk/dsZ6L4ejPXRly8l0oFRAHoCEK156Lx5wS8KhzRSNUSGMJeHzgyw
         Orpk1HkwjgqJdFDb3UHMwEthaKaHyBZogLXo2zTfoTplYFSKkhc2Y3TCoikg6QAqWN
         PZBeu4jL+g0hw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220118191839.64086-3-povik+lin@protonmail.com>
References: <20220118191839.64086-1-povik+lin@protonmail.com> <20220118191839.64086-3-povik+lin@protonmail.com>
Subject: Re: [PATCH v2 2/3] clk: clk-apple-nco: Add driver for Apple NCO
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org,
        Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@protonmail.com>
To:     Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@protonmail.com>,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Wed, 19 Jan 2022 21:38:08 -0800
User-Agent: alot/0.10
Message-Id: <20220120053810.71C17C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Povi=C5=A1er (2022-01-18 11:21:10)
> diff --git a/drivers/clk/clk-apple-nco.c b/drivers/clk/clk-apple-nco.c
> new file mode 100644
> index 000000000000..593f5b5ce5b7
> --- /dev/null
> +++ b/drivers/clk/clk-apple-nco.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Driver for an SoC block (Numerically Controlled Oscillator)
> + * found on t8103 (M1) and other Apple chips
> + *
> + * Copyright (C) The Asahi Linux Contributors
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_clk.h>

Is this include used? If not, please drop it.

Please include kernel.h for container_of() usage.

> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +#define NCO_CHANNEL_STRIDE     0x4000
> +#define NCO_CHANNEL_REGSIZE    20
> +
> +#define REG_CTRL       0
> +#define CTRL_ENABLE    BIT(31)
> +#define REG_DIV                4
> +#define DIV_FINE       GENMASK(1, 0)
> +#define DIV_COARSE     GENMASK(12, 2)
> +#define REG_INC1       8
> +#define REG_INC2       12
> +#define REG_ACCINIT    16
> +
> +/*
> + * Theory of operation (postulated)
> + *
> + * The REG_DIV register indirectly expresses a base integer divisor, rou=
ghly
> + * corresponding to twice the desired ratio of input to output clock. Th=
is
> + * base divisor is adjusted on a cycle-by-cycle basis based on the state=
 of a
> + * 32-bit phase accumulator to achieve a desired precise clock ratio ove=
r the
> + * long term.
> + *
> + * Specifically an output clock cycle is produced after (REG_DIV divisor=
)/2
> + * or (REG_DIV divisor + 1)/2 input cycles, the latter taking effect whe=
n top
> + * bit of the 32-bit accumulator is set. The accumulator is incremented =
each
> + * produced output cycle, by the value from either REG_INC1 or REG_INC2,=
 which
> + * of the two is selected depending again on the accumulator's current t=
op bit.
> + *
> + * Because the NCO hardware implements counting of input clock cycles in=
 part
> + * in a Galois linear-feedback shift register, the higher bits of divisor
> + * are programmed into REG_DIV by picking an appropriate LFSR state. See
> + * nco_compute_tables/nco_div_translate for details on this.
> + */
> +
> +struct nco_tables;

Please declare the struct here.

> +
> +struct nco_channel {
> +       void __iomem *base;
> +       struct nco_tables *tbl;
> +       struct clk_hw hw;
> +
> +       spinlock_t lock;
> +};
> +
> +#define to_nco_channel(_hw) container_of(_hw, struct nco_channel, hw)
> +
> +#define LFSR_POLY      0xa01
> +#define LFSR_INIT      0x7ff
> +#define LFSR_LEN       11
> +#define LFSR_PERIOD    ((1 << LFSR_LEN) - 1)
> +#define LFSR_TBLSIZE   (1 << LFSR_LEN)
> +
> +/* The minimal attainable coarse divisor (first value in table) */
> +#define COARSE_DIV_OFFSET 2
> +
> +struct nco_tables {
> +       u16 fwd[LFSR_TBLSIZE];
> +       u16 inv[LFSR_TBLSIZE];
> +};

Or put struct nco_channel here.

> +
> +static void nco_enable_nolock(struct clk_hw *hw);
> +static void nco_disable_nolock(struct clk_hw *hw);
> +static int nco_is_enabled(struct clk_hw *hw);

Define the functions here so we don't need forward declarations.

> +
> +static void nco_compute_tables(struct nco_tables *tbl)
> +{
> +       int i;
> +       u32 state =3D LFSR_INIT;
> +
> +       /*
> +        * Go through the states of a Galois LFSR and build
> +        * a coarse divisor translation table.
> +        */
> +       for (i =3D LFSR_PERIOD; i > 0; i--) {
> +               if (state & 1)
> +                       state =3D (state >> 1) ^ (LFSR_POLY >> 1);
> +               else
> +                       state =3D (state >> 1);
> +               tbl->fwd[i] =3D state;
> +               tbl->inv[state] =3D i;
> +       }
> +
> +       /* Zero value is special-cased */
> +       tbl->fwd[0] =3D 0;
> +       tbl->inv[0] =3D 0;
> +}
> +
> +static bool nco_div_out_of_range(unsigned int div)
> +{
> +       unsigned int coarse =3D div / 4;

Nitpick: Newline here

> +       return coarse < COARSE_DIV_OFFSET ||
> +               coarse >=3D COARSE_DIV_OFFSET + LFSR_TBLSIZE;
> +}
> +
> +static u32 nco_div_translate(struct nco_tables *tbl, unsigned int div)
> +{
> +       unsigned int coarse =3D div / 4;
> +
> +       if (WARN_ON(nco_div_out_of_range(div)))

Maybe worth knowing which clk is out of range?

> +               return 0;
> +
> +       return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET=
]) |
> +                       FIELD_PREP(DIV_FINE, div % 4);
> +}
> +
> +static unsigned int nco_div_translate_inv(struct nco_tables *tbl, u32 re=
gval)
> +{
> +       unsigned int coarse, fine;
> +
> +       coarse =3D tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_O=
FFSET;
> +       fine =3D FIELD_GET(DIV_FINE, regval);
> +
> +       return coarse * 4 + fine;
> +}
> +
> +static int nco_set_rate(struct clk_hw *hw, unsigned long rate,
> +                               unsigned long parent_rate)
> +{
> +       struct nco_channel *chan =3D to_nco_channel(hw);
> +       unsigned long flags;
> +       u32 div;
> +       s32 inc1, inc2;
> +       bool was_enabled;
> +
> +       div =3D 2 * parent_rate / rate;
> +       inc1 =3D 2 * parent_rate - div * rate;
> +       inc2 =3D -((s32) (rate - inc1));

Is the cast necessary?

> +
> +       if (nco_div_out_of_range(div))
> +               return -EINVAL;
> +
> +       div =3D nco_div_translate(chan->tbl, div);
> +
> +       spin_lock_irqsave(&chan->lock, flags);
> +       was_enabled =3D nco_is_enabled(hw);
> +       nco_disable_nolock(hw);
> +
> +       writel_relaxed(div,  chan->base + REG_DIV);
> +       writel_relaxed(inc1, chan->base + REG_INC1);
> +       writel_relaxed(inc2, chan->base + REG_INC2);
> +
> +       /* Presumably a neutral initial value for accumulator */
> +       writel_relaxed(1 << 31, chan->base + REG_ACCINIT);
> +
> +       if (was_enabled)
> +               nco_enable_nolock(hw);
> +       spin_unlock_irqrestore(&chan->lock, flags);
> +
> +       return 0;
> +}
> +
> +static unsigned long nco_recalc_rate(struct clk_hw *hw,
> +                               unsigned long parent_rate)
> +{
> +       struct nco_channel *chan =3D to_nco_channel(hw);
> +       u32 div;
> +       s32 inc1, inc2, incbase;
> +
> +       div =3D nco_div_translate_inv(chan->tbl,
> +                       readl_relaxed(chan->base + REG_DIV));
> +
> +       inc1 =3D readl_relaxed(chan->base + REG_INC1);
> +       inc2 =3D readl_relaxed(chan->base + REG_INC2);
> +
> +       /*
> +        * We don't support wraparound of accumulator
> +        * nor the edge case of both increments being zero
> +        */
> +       if (inc1 < 0 || inc2 > 0 || (inc1 =3D=3D 0 && inc2 =3D=3D 0))
> +               return 0;
> +
> +       /* Scale both sides of division by incbase to maintain precision =
*/
> +       incbase =3D inc1 - inc2;
> +
> +       return div_u64(((u64) parent_rate) * 2 * incbase,
> +                       ((u64) div) * incbase + inc1);

Why is the divisor casted to 64 bits? div_u64() takes a u32 divisor so
if it's going to overflow 32 bits we're in trouble.
> +}
> +
> +static long nco_round_rate(struct clk_hw *hw, unsigned long rate,
> +                               unsigned long *parent_rate)
> +{
> +       unsigned long lo =3D *parent_rate / (COARSE_DIV_OFFSET + LFSR_TBL=
SIZE) + 1;
> +       unsigned long hi =3D *parent_rate / COARSE_DIV_OFFSET;
> +
> +       return clamp(rate, lo, hi);
> +}
> +
> +static void nco_enable_nolock(struct clk_hw *hw)
> +{
> +       struct nco_channel *chan =3D to_nco_channel(hw);
> +       u32 val;
> +
> +       val =3D readl_relaxed(chan->base + REG_CTRL);
> +       writel_relaxed(val | CTRL_ENABLE, chan->base + REG_CTRL);
> +}
> +
> +static void nco_disable_nolock(struct clk_hw *hw)
> +{
> +       struct nco_channel *chan =3D to_nco_channel(hw);
> +       u32 val;
> +
> +       val =3D readl_relaxed(chan->base + REG_CTRL);
> +       writel_relaxed(val & ~CTRL_ENABLE, chan->base + REG_CTRL);
> +}
> +
> +static int nco_is_enabled(struct clk_hw *hw)
> +{
> +       struct nco_channel *chan =3D to_nco_channel(hw);
> +
> +       return (readl_relaxed(chan->base + REG_CTRL) & CTRL_ENABLE) !=3D =
0;
> +}
> +
> +static int nco_enable(struct clk_hw *hw)
> +{
> +       struct nco_channel *chan =3D to_nco_channel(hw);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&chan->lock, flags);
> +       nco_enable_nolock(hw);
> +       spin_unlock_irqrestore(&chan->lock, flags);
> +
> +       return 0;
> +}
> +
> +static void nco_disable(struct clk_hw *hw)
> +{
> +       struct nco_channel *chan =3D to_nco_channel(hw);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&chan->lock, flags);
> +       nco_disable_nolock(hw);
> +       spin_unlock_irqrestore(&chan->lock, flags);
> +}
> +
> +static const struct clk_ops nco_ops =3D {

Perhaps apple_nco_ops (and apple_ prefix for the functions) so that tags
in the global namespace don't conflict.

> +       .set_rate =3D nco_set_rate,
> +       .recalc_rate =3D nco_recalc_rate,
> +       .round_rate =3D nco_round_rate,
> +       .enable =3D nco_enable,
> +       .disable =3D nco_disable,
> +       .is_enabled =3D nco_is_enabled,
> +};
> +
> +static int apple_nco_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct clk_parent_data pdata =3D { .index =3D 0 };
> +       struct clk_init_data init;
> +       struct clk_hw_onecell_data *onecell_data;
> +       void __iomem *regs;

Usually it's called 'base'

> +       struct resource *regs_res;

Usually it's called 'res'

> +       struct nco_tables *tbl;
> +       unsigned int nchannels;
> +       int ret, i;
> +
> +       regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &regs_re=
s);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
> +
> +       if (resource_size(regs_res) < NCO_CHANNEL_REGSIZE)
> +               return -EINVAL;
> +       nchannels =3D (resource_size(regs_res) - NCO_CHANNEL_REGSIZE)
> +                       / NCO_CHANNEL_STRIDE + 1;

Is this some sort of DIV_ROUND_UP()?

> +
> +       onecell_data =3D devm_kzalloc(&pdev->dev, struct_size(onecell_dat=
a, hws,
> +                                                       nchannels), GFP_K=
ERNEL);
> +       if (!onecell_data)
> +               return -ENOMEM;
> +       onecell_data->num =3D nchannels;
> +
> +       tbl =3D devm_kzalloc(&pdev->dev, sizeof(*tbl), GFP_KERNEL);
> +       if (!tbl)
> +               return -ENOMEM;
> +       nco_compute_tables(tbl);
> +
> +       for (i =3D 0; i < nchannels; i++) {
> +               struct nco_channel *chan;
> +
> +               chan =3D devm_kzalloc(&pdev->dev, sizeof(*chan), GFP_KERN=
EL);
> +               if (!chan)
> +                       return -ENOMEM;
> +               chan->base =3D regs + NCO_CHANNEL_STRIDE*i;

Please add space around * above.

> +               chan->tbl =3D tbl;
> +               spin_lock_init(&chan->lock);
> +
> +               memset(&init, 0, sizeof(init));
> +               init.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +                                               "%s-%d", np->name, i);
> +               init.ops =3D &nco_ops;
> +               init.parent_data =3D &pdata;
> +               init.num_parents =3D 1;
> +               init.flags =3D 0;
> +
> +               chan->hw.init =3D &init;
> +               ret =3D devm_clk_hw_register(&pdev->dev, &chan->hw);
> +               if (ret)
> +                       return ret;
> +
> +               onecell_data->hws[i] =3D &chan->hw;
> +       }
> +
> +       return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_=
get,
> +                                                       onecell_data);
