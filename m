Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042574D57F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345603AbiCKCRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiCKCRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:17:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A353D444C;
        Thu, 10 Mar 2022 18:16:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78894B829A0;
        Fri, 11 Mar 2022 02:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0693AC340E8;
        Fri, 11 Mar 2022 02:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646964975;
        bh=P4UXJvBMVSw4xZKtpaLhnm767CnDXICceIXlxsXa7Pw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jTwQxtL/o/CKQ0d/I442RKFZvJedp1M0O1AirEjMjQd6ngnjQkKEx7RHBwotfqfSR
         hSRTMn/bNkWhXSIW4lle8K5CFbcRsn8Gt+tJXc0S76Kqjh8rCnxk2YsjadlA63F/bV
         ecqap1OGI0Wma3hNyhjxKr4IY04XuJKIbd+sXDBwuN0dtaqH0QQA3V7EC2KbMNS6s1
         o3NQt9uQjWL0HSxiH/Z6c9xUulbsPblF+mE2VHxKMWHzNXP+aOMLLuYXaNILMEsgMp
         33JUOmzZp83r3IAPnwHLkHNBqLUCIFShMBWgfpuKugfWkG6ouYGNCRQRAt0FKF7JIx
         3H75ZO3aaxZYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0d9462d6f1fc6d5df71db2174facbb5bfc9f7d69.1643968653.git.michal.simek@xilinx.com>
References: <cover.1643968653.git.michal.simek@xilinx.com> <0d9462d6f1fc6d5df71db2174facbb5bfc9f7d69.1643968653.git.michal.simek@xilinx.com>
Subject: Re: [PATCH v9 2/2] clk: Add ccf driver for Renesas 8T49N241
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Alex Helms <alexander.helms.jy@renesas.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Cater <david.cater.jc@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     git@xilinx.com, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, monstr@monstr.eu
Date:   Thu, 10 Mar 2022 18:16:13 -0800
User-Agent: alot/0.10
Message-Id: <20220311021615.0693AC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michal Simek (2022-02-04 01:57:39)
> diff --git a/drivers/clk/8t49n24x-core.c b/drivers/clk/8t49n24x-core.c
> new file mode 100644
> index 000000000000..df6b4f6392b5
> --- /dev/null
> +++ b/drivers/clk/8t49n24x-core.c
> @@ -0,0 +1,752 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* 8t49n24x-core.c - Program 8T49N24x settings via I2C (common code)
> + *
> + * Copyright (C) 2018, Renesas Electronics America <david.cater.jc@renes=
as.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +#include "8t49n24x-core.h"
> +
> +/*
> + * In Timing Commander, Q0 is changed from 25MHz to Q0 75MHz, the follow=
ing
> + * changes occur:
> + *
> + * 2 bytes change in EEPROM data string.
> + *
> + * DSM_INT R0025[0],R0026[7:0] : 35 =3D> 30
> + * NS2_Q0 R0040[7:0],R0041[7:0] : 14 =3D> 4
> + *
> + * In EEPROM
> + * 1. R0026
> + * 2. R0041
> + *
> + * Note that VCO_Frequency (metadata) also changed (3500 =3D>3000).
> + * This reflects a change to DSM_INT.
> + *
> + * Note that the Timing Commander code has workarounds in the workflow s=
cripts
> + * to handle dividers for the 8T49N241 (because the development of that =
GUI
> + * predates chip override functionality). That affects NS1_Qx (x in 1-3)
> + * and NS2_Qx. NS1_Qx contains the upper bits of NS_Qx, and NS2_Qx conta=
ins
> + * the lower bits. That is NOT the case for Q0, though. In that case NS1=
_Q0
> + * is the 1st stage output divider (/5, /6, /4) and NS2_Q0 is the 16-bit
> + * second stage (with actual divide being twice the value stored in the
> + * register).
> + *
> + * NS1_Q0 R003F[1:0]
> + */
> +
> +#define R8T49N24X_VCO_MIN                      2999997000u
> +#define R8T49N24X_VCO_MAX                      4000004000u
> +#define R8T49N24X_VCO_OPT                      3500000000u
> +#define R8T49N24X_MIN_INT_DIVIDER      6
> +#define R8T49N24X_MIN_NS1                      4
> +#define R8T49N24X_MAX_NS1                      6
> +
> +static const u8 q0_ns1_options[3] =3D { 5, 6, 4 };
> +
> +/**
> + * __renesas_bits_to_shift - num bits to shift given specified mask
> + * @mask:      32-bit word input to count zero bits on right
> + *
> + * Given a bit mask indicating where a value will be stored in
> + * a register, return the number of bits you need to shift the value
> + * before ORing it into the register value.
> + *
> + * Return: number of bits to shift
> + */
> +int __renesas_bits_to_shift(unsigned int mask)
> +{
> +       if (mask)
> +               return __ffs(mask);
> +       else
> +               return 0;
> +}
> +
> +int __renesas_i2c_write_bulk(struct i2c_client *client, struct regmap *m=
ap,
> +                            unsigned int reg, u8 val[], size_t val_count)
> +{
> +       u8 block[WRITE_BLOCK_SIZE];
> +       unsigned int block_offset =3D reg;
> +       unsigned int i, currentOffset =3D 0;
> +       int err =3D 0;
> +
> +       dev_dbg(&client->dev,
> +               "I2C->0x%04x : [hex] . First byte: %02x, Second byte: %02=
x",

printks need newlines. There are so many here though. regmap already has
tracing so why can't that be used here?

> +               reg, reg >> 8, reg & 0xFF);
> +
> +       print_hex_dump_debug("i2c_write_bulk: ", DUMP_PREFIX_NONE,
> +                            16, 1, val, val_count, false);
> +
> +       for (i =3D 0; i < val_count; i++) {
> +               block[currentOffset++] =3D val[i];
> +
> +               if (i > 0 && (i + 1) % WRITE_BLOCK_SIZE =3D=3D 0) {
> +                       err =3D regmap_bulk_write(map, block_offset, bloc=
k, WRITE_BLOCK_SIZE);
> +                       if (err)
> +                               break;
> +                       block_offset +=3D WRITE_BLOCK_SIZE;
> +                       currentOffset =3D 0;
> +               }
> +       }
> +
> +       if (err =3D=3D 0 && currentOffset > 0)
> +               err =3D regmap_bulk_write(map, block_offset, block, curre=
ntOffset);
> +
> +       return err;
> +}
> +
> +static int __i2c_write(struct i2c_client *client, struct regmap *map,
> +                      unsigned int reg, unsigned int val)
> +{
> +       dev_dbg(&client->dev, "I2C->0x%x : [hex] %x", reg, val);

Missing newline.

> +       return regmap_write(map, reg, val);
> +}
> +
> +static int __i2c_write_with_mask(struct i2c_client *client, struct regma=
p *map,
> +                                unsigned int reg, u8 val, u8 original, u=
8 mask)
> +{
> +       return __i2c_write(client, map, reg,
> +                          ((val << __renesas_bits_to_shift(mask)) & mask=
) | (original & ~mask));

It would be better to use some local variables instead of packing it all
into one statement.

> +}
> +
> +void r8t49n24x_get_offsets(u8 output_num, struct clk_register_offsets *o=
ffsets)

Is u8 important? It probably makes code worse when unsigned int can be
used.

> +{
> +       offsets->oe_offset =3D 0;
> +       offsets->oe_mask =3D 0;
> +       offsets->dis_mask =3D 0;
> +       offsets->n_17_16_offset =3D 0;
> +       offsets->n_17_16_mask =3D 0;
> +       offsets->n_15_8_offset =3D 0;
> +       offsets->n_7_0_offset =3D 0;
> +       offsets->nfrac_27_24_offset =3D 0;
> +       offsets->nfrac_27_24_mask =3D 0;
> +       offsets->nfrac_23_16_offset =3D 0;
> +       offsets->nfrac_15_8_offset =3D 0;
> +       offsets->nfrac_7_0_offset =3D 0;

This is every item? Why not

	memset(offsets, 0, sizeof(*offsets));

> +
> +       switch (output_num) {
> +       case 0:
> +               offsets->oe_offset =3D R8T49N24X_REG_OUTEN;
> +               offsets->oe_mask =3D R8T49N24X_REG_OUTEN0_MASK;
> +               offsets->dis_mask =3D R8T49N24X_REG_Q0_DIS_MASK;
> +               break;
> +       case 1:
> +               offsets->oe_offset =3D R8T49N24X_REG_OUTEN;
> +               offsets->oe_mask =3D R8T49N24X_REG_OUTEN1_MASK;
> +               offsets->dis_mask =3D R8T49N24X_REG_Q1_DIS_MASK;
> +               offsets->n_17_16_offset =3D R8T49N24X_REG_N_Q1_17_16;
> +               offsets->n_17_16_mask =3D R8T49N24X_REG_N_Q1_17_16_MASK;
> +               offsets->n_15_8_offset =3D R8T49N24X_REG_N_Q1_15_8;
> +               offsets->n_7_0_offset =3D R8T49N24X_REG_N_Q1_7_0;
> +               offsets->nfrac_27_24_offset =3D R8T49N24X_REG_NFRAC_Q1_27=
_24;
> +               offsets->nfrac_27_24_mask =3D R8T49N24X_REG_NFRAC_Q1_27_2=
4_MASK;
> +               offsets->nfrac_23_16_offset =3D R8T49N24X_REG_NFRAC_Q1_23=
_16;
> +               offsets->nfrac_15_8_offset =3D R8T49N24X_REG_NFRAC_Q1_15_=
8;
> +               offsets->nfrac_7_0_offset =3D R8T49N24X_REG_NFRAC_Q1_7_0;
> +               break;
> +       case 2:
> +               offsets->oe_offset =3D R8T49N24X_REG_OUTEN;
> +               offsets->oe_mask =3D R8T49N24X_REG_OUTEN2_MASK;
> +               offsets->dis_mask =3D R8T49N24X_REG_Q2_DIS_MASK;
> +               offsets->n_17_16_offset =3D R8T49N24X_REG_N_Q2_17_16;
> +               offsets->n_17_16_mask =3D R8T49N24X_REG_N_Q2_17_16_MASK;
> +               offsets->n_15_8_offset =3D R8T49N24X_REG_N_Q2_15_8;
> +               offsets->n_7_0_offset =3D R8T49N24X_REG_N_Q2_7_0;
> +               offsets->nfrac_27_24_offset =3D R8T49N24X_REG_NFRAC_Q2_27=
_24;
> +               offsets->nfrac_27_24_mask =3D R8T49N24X_REG_NFRAC_Q2_27_2=
4_MASK;
> +               offsets->nfrac_23_16_offset =3D R8T49N24X_REG_NFRAC_Q2_23=
_16;
> +               offsets->nfrac_15_8_offset =3D R8T49N24X_REG_NFRAC_Q2_15_=
8;
> +               offsets->nfrac_7_0_offset =3D R8T49N24X_REG_NFRAC_Q2_7_0;
> +               break;
> +       case 3:
> +               offsets->oe_offset =3D R8T49N24X_REG_OUTEN;
> +               offsets->oe_mask =3D R8T49N24X_REG_OUTEN3_MASK;
> +               offsets->dis_mask =3D R8T49N24X_REG_Q3_DIS_MASK;
> +               offsets->n_17_16_offset =3D R8T49N24X_REG_N_Q3_17_16;
> +               offsets->n_17_16_mask =3D R8T49N24X_REG_N_Q3_17_16_MASK;
> +               offsets->n_15_8_offset =3D R8T49N24X_REG_N_Q3_15_8;
> +               offsets->n_7_0_offset =3D R8T49N24X_REG_N_Q3_7_0;
> +               offsets->nfrac_27_24_offset =3D R8T49N24X_REG_NFRAC_Q3_27=
_24;
> +               offsets->nfrac_27_24_mask =3D R8T49N24X_REG_NFRAC_Q3_27_2=
4_MASK;
> +               offsets->nfrac_23_16_offset =3D R8T49N24X_REG_NFRAC_Q3_23=
_16;
> +               offsets->nfrac_15_8_offset =3D R8T49N24X_REG_NFRAC_Q3_15_=
8;
> +               offsets->nfrac_7_0_offset =3D R8T49N24X_REG_NFRAC_Q3_7_0;
> +               break;
> +       }
> +}
> +
> +/**
> + * r8t49n24x_calc_div_q0 - Calculate dividers and VCO freq to generate
> + *             the specified Q0 frequency.
> + * @chip:      Device data structure. contains all requested frequencies
> + *             for all outputs.
> + *
> + * The actual output divider is ns1 * ns2 * 2. fOutput =3D fVCO / (ns1 *=
 ns2 * 2)
> + *
> + * The options for ns1 (when the source is the VCO) are 4,5,6. ns2 is a
> + * 16-bit value.
> + *
> + * chip->divs: structure for specifying ns1/ns2 values. If 0 after this
> + * function, Q0 is not requested
> + */
> +static void r8t49n24x_calc_div_q0(struct clk_r8t49n24x_chip *chip)
> +{
> +       unsigned int i;
> +       unsigned int min_div =3D 0, max_div =3D 0, best_vco =3D 0;
> +       unsigned int min_ns2 =3D 0, max_ns2 =3D 0;
> +       bool is_lower_vco =3D false;
> +
> +       chip->divs.ns1_q0 =3D 0;
> +       chip->divs.ns2_q0 =3D 0;
> +
> +       if (chip->clk[0].requested =3D=3D 0)
> +               return;
> +
> +       min_div =3D (R8T49N24X_VCO_MIN / 2 / chip->clk[0].requested * 2) =
* 2;
> +       max_div =3D (R8T49N24X_VCO_MAX / 2 / chip->clk[0].requested * 2) =
* 2;
> +
> +       dev_dbg(&chip->i2c_client->dev,
> +               "requested: %lu, min_div: %u, max_div: %u",
> +               chip->clk[0].requested, min_div, max_div);
> +
> +       min_ns2 =3D min_div / (R8T49N24X_MAX_NS1 * 2);
> +       max_ns2 =3D max_div / (R8T49N24X_MIN_NS1 * 2);
> +
> +       dev_dbg(&chip->i2c_client->dev, "min_ns2: %u, max_ns2: %u", min_n=
s2, max_ns2);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(q0_ns1_options); i++) {
> +               unsigned int j =3D min_ns2;
> +
> +               while (j <=3D max_ns2) {
> +                       unsigned int actual_div =3D q0_ns1_options[i] * j=
 * 2;
> +                       unsigned int current_vco =3D actual_div * chip->c=
lk[0].requested;
> +
> +                       if (current_vco < R8T49N24X_VCO_MIN)
> +                               dev_dbg(&chip->i2c_client->dev,
> +                                       "ignore div: (ns1=3D%u * ns2=3D%u=
 * 2 * %lu) =3D=3D %u < %u",
> +                                       q0_ns1_options[i], j,
> +                                       chip->clk[0].requested, current_v=
co,
> +                                       R8T49N24X_VCO_MIN);
> +                       else if (current_vco > R8T49N24X_VCO_MAX) {
> +                               dev_dbg(&chip->i2c_client->dev,
> +                                       "ignore div: (ns1=3D%u * ns2=3D%u=
 * 2 * %lu) =3D=3D %u > %u. EXIT LOOP.",
> +                                       q0_ns1_options[i], j,
> +                                       chip->clk[0].requested, current_v=
co,
> +                                       R8T49N24X_VCO_MAX);
> +                               j =3D max_ns2;
> +                       } else {
> +                               bool use =3D false;
> +
> +                               dev_dbg(&chip->i2c_client->dev,
> +                                       "contender: (ns1=3D%u * ns2=3D%u =
* 2 * %lu) =3D=3D %u [in range]",
> +                                       q0_ns1_options[i], j,
> +                                       chip->clk[0].requested, current_v=
co);
> +                               if (current_vco <=3D R8T49N24X_VCO_OPT) {
> +                                       if (current_vco > best_vco || !is=
_lower_vco) {
> +                                               is_lower_vco =3D true;
> +                                               use =3D true;
> +                                       }
> +                               } else if (!is_lower_vco && current_vco >=
 best_vco) {
> +                                       use =3D true;
> +                               }
> +                               if (use) {
> +                                       chip->divs.ns1_q0 =3D i;
> +                                       chip->divs.ns2_q0 =3D j;
> +                                       best_vco =3D current_vco;
> +                               }
> +                       }
> +                       j++;
> +               }
> +       }
> +
> +       dev_dbg(&chip->i2c_client->dev,
> +               "best: (ns1=3D%u [/%u] * ns2=3D%u * 2 * %lu) =3D=3D %u",
> +               chip->divs.ns1_q0, q0_ns1_options[chip->divs.ns1_q0],
> +               chip->divs.ns2_q0, chip->clk[0].requested, best_vco);

There's still a lot of dev_dbg() in this patch. It really makes it hard
to read because almost everything is surrounded by debug prints that
won't be used after the driver is tested and works. Can you please
remove them?

> +}
> +
> +/**
> + * r8t49n24x_calc_divs - Calculate dividers to generate the specified fr=
equency.

We don't really need kernel-doc on static functions but OK.

> + * @chip:      Device data structure. contains all requested frequencies
> + *             for all outputs.
> + *
> + * Calculate the clock dividers (dsmint, dsmfrac for vco; ns1/ns2 for q0,
> + * n/nfrac for q1-3) for a given target frequency.
> + *
> + * Return: 0 on success, negative errno otherwise.
> + */
> +static int r8t49n24x_calc_divs(struct clk_r8t49n24x_chip *chip)
> +{
> +       unsigned int i;
> +       unsigned int vco =3D 0;
> +       unsigned int pfd =3D 0;
> +       unsigned long rem =3D 0;
> +
> +       r8t49n24x_calc_div_q0(chip);
> +
> +       dev_dbg(&chip->i2c_client->dev,
> +               "after r8t49n24x_calc_div_q0. ns1: %u [/%u], ns2: %u",
> +               chip->divs.ns1_q0, q0_ns1_options[chip->divs.ns1_q0],
> +               chip->divs.ns2_q0);
> +
> +       chip->divs.dsmint =3D 0;
> +       chip->divs.dsmfrac =3D 0;
> +
> +       if (chip->clk[0].requested > 0) {
> +               /* Q0 is in use and is governing the actual VCO freq */
> +               vco =3D q0_ns1_options[chip->divs.ns1_q0] * chip->divs.ns=
2_q0
> +                       * 2 * chip->clk[0].requested;
> +       } else {
> +               unsigned int freq =3D 0;
> +               unsigned int min_div =3D 0, max_div =3D 0;
> +               unsigned int i =3D 0;
> +               bool is_lower_vco =3D false;
> +
> +               /*
> +                * Q0 is not in use. Use the first requested (fractional)
> +                * output frequency as the one controlling the VCO.
> +                */
> +               for (i =3D 1; i < NUM_OUTPUTS; i++) {
> +                       if (chip->clk[i].requested !=3D 0) {
> +                               freq =3D chip->clk[i].requested;
> +                               break;
> +                       }
> +               }
> +
> +               if (!freq) {
> +                       dev_err(&chip->i2c_client->dev, "NO FREQUENCIES S=
PECIFIED");
> +                       return -EINVAL;
> +               }
> +
> +               /*
> +                * First, determine the min/max div for the output freque=
ncy.
> +                */
> +               min_div =3D R8T49N24X_MIN_INT_DIVIDER;
> +               max_div =3D (R8T49N24X_VCO_MAX / 2 / freq) * 2;
> +
> +               dev_dbg(&chip->i2c_client->dev,
> +                       "calc_divs for fractional output. freq: %u, min_d=
iv: %u, max_div: %u",
> +                       freq, min_div, max_div);
> +
> +               i =3D min_div;
> +
> +               while (i <=3D max_div) {
> +                       unsigned int current_vco =3D freq * i;
> +
> +                       dev_dbg(&chip->i2c_client->dev,
> +                               "calc_divs for fractional output. walk: %=
u, freq: %u, vco: %u",
> +                               i, freq, vco);
> +
> +                       if (current_vco >=3D R8T49N24X_VCO_MIN &&
> +                           vco <=3D R8T49N24X_VCO_MAX) {
> +                               if (current_vco <=3D R8T49N24X_VCO_OPT) {
> +                                       if (current_vco > vco || !is_lowe=
r_vco) {
> +                                               is_lower_vco =3D true;
> +                                               vco =3D current_vco;
> +                                       }
> +                               } else if (!is_lower_vco && current_vco >=
 vco) {
> +                                       vco =3D current_vco;
> +                               }
> +                       }
> +                       /* Divider must be even. */
> +                       i +=3D 2;
> +               }
> +       }
> +
> +       if (!vco) {
> +               dev_err(&chip->i2c_client->dev, "no integer divider in ra=
nge found. NOT SUPPORTED.");
> +               return -EINVAL;
> +       }
> +
> +       /* Setup dividers for outputs with fractional dividers. */
> +       for (i =3D 1; i < NUM_OUTPUTS; i++) {
> +               if (chip->clk[i].requested) {
> +                       /*
> +                        * The value written to the chip is half
> +                        * the calculated divider.
> +                        */
> +                       rem =3D vco % (chip->clk[i].requested * 2);
> +                       chip->divs.nint[i - 1] =3D vco / chip->clk[i].req=
uested * 2;
> +                       chip->divs.nfrac[i - 1] =3D div64_ul(rem << 28,
> +                                                          chip->clk[i].r=
equested * 2);
> +
> +                       dev_dbg(&chip->i2c_client->dev,
> +                               "div to get Q%i freq %lu from vco %u: int=
 part: %u, rem: %lu, frac part: %u",
> +                               i, chip->clk[i].requested,
> +                               vco, chip->divs.nint[i - 1], rem,
> +                               chip->divs.nfrac[i - 1]);
> +               }
> +       }
> +
> +       /* Calculate freq for pfd */
> +       pfd =3D chip->input_clk_freq * (chip->doubler_disabled ? 1 : 2);
> +
> +       /*
> +        * Calculate dsmint & dsmfrac:
> +        * -----------------------------
> +        * dsm =3D float(vco)/float(pfd)
> +        * dsmfrac =3D dsm-floor(dsm) * 2^21
> +        * rem =3D vco % pfd
> +        * therefore:
> +        * dsmfrac =3D (rem * 2^21)/pfd
> +        */
> +       rem =3D vco % pfd;
> +       chip->divs.dsmint =3D vco / pfd;
> +       chip->divs.dsmfrac =3D div64_ul(rem << 21, pfd);
> +
> +       dev_dbg(&chip->i2c_client->dev,
> +               "vco: %u, pfd: %u, dsmint: %u, dsmfrac: %u, rem: %lu",
> +               vco, pfd, chip->divs.dsmint,
> +               chip->divs.dsmfrac, rem);
> +
> +       return 0;
> +}
> +
> +/**
> + * r8t49n24x_enable_output - Enable/disable a particular output
> + * @chip:      Device data structure
> + * @output:    Output to enable/disable
> + * @enable:    Enable (true/false)
> + *
> + * Return: passes on regmap_write return value.
> + */
> +int r8t49n24x_enable_output(struct clk_r8t49n24x_chip *chip, u8 output, =
bool enable)

Again, u8 probably isn't helping.

> +{
> +       int err;
> +       struct clk_register_offsets offsets;
> +       struct i2c_client *client =3D chip->i2c_client;
> +
> +       /*
> +        * When an output is enabled, enable it in the original
> +        * data read from the chip and cached. Otherwise it may be
> +        * accidentally turned off when another output is enabled.
> +        *
> +        * E.g., the driver starts with all outputs off in reg_out_en_x.
> +        * Q1 is enabled with the appropriate mask. Q2 is then enabled,
> +        * which results in Q1 being turned back off (because Q1 was off
> +        * in reg_out_en_x).
> +        */
> +
> +       r8t49n24x_get_offsets(output, &offsets);
> +
> +       dev_dbg(&client->dev,
> +               "q%u enable? %d. reg_out_en_x before: 0x%x, reg_out_mode_=
0_1 before: 0x%x",
> +               output, enable, chip->reg_out_en_x, chip->reg_out_mode_0_=
1);
> +
> +       dev_dbg(&client->dev, "reg_out_mode_2_3 before: 0x%x, reg_qx_dis =
before: 0x%x",
> +               chip->reg_out_mode_2_3, chip->reg_qx_dis);
> +
> +       chip->reg_out_en_x =3D chip->reg_out_en_x & ~offsets.oe_mask;
> +       if (enable)
> +               chip->reg_out_en_x |=3D BIT(__renesas_bits_to_shift(offse=
ts.oe_mask));
> +
> +       chip->reg_qx_dis =3D chip->reg_qx_dis & ~offsets.dis_mask;
> +       dev_dbg(&client->dev,
> +               "q%u enable? %d. reg_qx_dis mask: 0x%x, before checking e=
nable: 0x%x",
> +               output, enable, offsets.dis_mask, chip->reg_qx_dis);
> +
> +       if (!enable)
> +               chip->reg_qx_dis |=3D BIT(__renesas_bits_to_shift(offsets=
.dis_mask));
> +
> +       dev_dbg(&client->dev,
> +               "q%u enable? %d. reg_out_en_x after: 0x%x, reg_qx_dis aft=
er: 0x%x",
> +               output, enable, chip->reg_out_en_x, chip->reg_qx_dis);
> +
> +       err =3D __i2c_write(client, chip->regmap, R8T49N24X_REG_OUTEN, ch=
ip->reg_out_en_x);
> +       if (err) {
> +               dev_err(&client->dev, "error setting %s: %i", "R8T49N24X_=
REG_OUTEN", err);
> +               return err;
> +       }
> +
> +       err =3D __i2c_write(client, chip->regmap, R8T49N24X_REG_OUTMODE0_=
1, chip->reg_out_mode_0_1);
> +       if (err) {
> +               dev_err(&client->dev, "error setting %s: %i", "R8T49N24X_=
REG_OUTMODE0_1", err);
> +               return err;
> +       }
> +
> +       err =3D __i2c_write(client, chip->regmap, R8T49N24X_REG_OUTMODE2_=
3, chip->reg_out_mode_2_3);
> +       if (err) {
> +               dev_err(&client->dev, "error setting %s: %i", "R8T49N24X_=
REG_OUTMODE2_3", err);
> +               return err;
> +       }
> +
> +       err =3D __i2c_write(client, chip->regmap, R8T49N24X_REG_Q_DIS, ch=
ip->reg_qx_dis);
> +       if (err) {
> +               dev_err(&client->dev, "error setting %s: %i", "R8T49N24X_=
REG_Q_DIS", err);
> +               return err;
> +       }

This is super hard to read and is missing newlines everywhere on the
printk()s. Maybe __i2c_write() can print the error message instead of
the caller? But really I'd rather just have regmap_write() called here
directly instead of using a wrapper function so that it's clearer what's
going on. Then this code would be just a bunch of writes and returns on
failures and if something goes wrong we can look at regmap traces to
figure out which write failed.

> +
> +       return 0;
> +}
> +
> +/**
> + * r8t49n24x_update_device - write registers to the chip
> + * @chip:      Device data structure
> + *
> + * Write all values to hardware that we        have calculated.
> + *
> + * Return: passes on regmap_bulk_write return value.
> + */
> +static int r8t49n24x_update_device(struct clk_r8t49n24x_chip *chip)
> +{
> +       int err;
> +       unsigned int i;
> +       struct i2c_client *client =3D chip->i2c_client;
> +
> +       dev_dbg(&client->dev, "setting DSM_INT_8 (val %u @ %u)",
> +               chip->divs.dsmint >> 8, R8T49N24X_REG_DSM_INT_8);
> +
> +       err =3D __i2c_write_with_mask(client, chip->regmap, R8T49N24X_REG=
_DSM_INT_8,
> +                                   (chip->divs.dsmint >> 8) & R8T49N24X_=
REG_DSM_INT_8_MASK,
> +                                   chip->reg_dsm_int_8, R8T49N24X_REG_DS=
M_INT_8_MASK);
> +       if (err) {
> +               dev_err(&client->dev, "error setting R8T49N24X_REG_DSM_IN=
T_8: %i", err);
> +               return err;
[...]
> diff --git a/drivers/clk/8t49n24x-core.h b/drivers/clk/8t49n24x-core.h
> new file mode 100644
> index 000000000000..93621fbdbe6b
> --- /dev/null
> +++ b/drivers/clk/8t49n24x-core.h
> @@ -0,0 +1,242 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * 8t49n24x-core.h - Program 8T49N24x settings via I2C (common code)
> + *
> + * Copyright (C) 2018, Renesas Electronics America <david.cater.jc@renes=
as.com>
> + */
> +
> +#ifndef __8T49N24X_CORE_H_
> +#define __8T49N24X_CORE_H_
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +
[...]
> +
> +/**
> + * r8t49n24x_clk_notifier_cb - Clock rate change callback
> + * @nb:                Pointer to notifier block
> + * @event:     Notification reason
> + * @data:      Pointer to notification data object
> + *
> + * This function is called when the input clock frequency changes.
> + * The callback checks whether a valid bus frequency can be generated af=
ter the
> + * change. If so, the change is acknowledged, otherwise the change is ab=
orted.
> + * New dividers are written to the HW in the pre- or post change notific=
ation
> + * depending on the scaling direction.
> + *
> + * Return:     NOTIFY_STOP if the rate change should be aborted, NOTIFY_=
OK
> + *             to acknowledge the change, NOTIFY_DONE if the notificatio=
n is
> + *             considered irrelevant.
> + */
> +static int r8t49n24x_clk_notifier_cb(struct notifier_block *nb,
> +                                    unsigned long event, void *data)
> +{
> +       struct clk_notifier_data *ndata =3D data;
> +       struct clk_r8t49n24x_chip *chip =3D to_clk_r8t49n24x_from_nb(nb);
> +       int err;
> +
> +       dev_info(&chip->i2c_client->dev, "input changed: %lu Hz. event: %=
lu",
> +                ndata->new_rate, event);

Drop this?

> +
> +       switch (event) {
> +       case PRE_RATE_CHANGE: {
> +               dev_dbg(&chip->i2c_client->dev, "PRE_RATE_CHANGE\n");
> +               return NOTIFY_OK;
> +       }

Why does this one have braces

> +       case POST_RATE_CHANGE:

But this one doesn't?

> +               chip->input_clk_freq =3D ndata->new_rate;
> +               /*
> +                * Can't call clock API clk_set_rate here; I believe
> +                * it will be ignored if the rate is the same as we
> +                * set previously. Need to call our internal function.
> +                */
> +               dev_dbg(&chip->i2c_client->dev, "POST_RATE_CHANGE. Callin=
g r8t49n24x_set_frequency\n");
> +               err =3D r8t49n24x_set_frequency(chip);

Would implementing a clk provider set_rate clk_op for this function
work? That would allow the provider to get a callback when the input
rate changes to adjust the rate internally. It looks like an error isn't
stopping the rate change (and this is post rate so it would be too late)
so probably the ndata->new_rate here could just be parent_rate in the
set_rate clk op and then no notifier is needed.

> +               if (err)
> +                       dev_dbg(&chip->i2c_client->dev, "error setting fr=
equency (%i)\n", err);
> +               return NOTIFY_OK;
> +       case ABORT_RATE_CHANGE:
> +               return NOTIFY_OK;
> +       default:
> +               return NOTIFY_DONE;
> +       }
> +}
> +
> +static struct clk_hw *of_clk_r8t49n24x_get(struct of_phandle_args *clksp=
ec,
> +                                          void *_data)
> +{
> +       struct clk_r8t49n24x_chip *chip =3D _data;
> +       unsigned int idx =3D clkspec->args[0];
> +
> +       if (idx >=3D ARRAY_SIZE(chip->clk)) {
> +               pr_err("invalid clock index %u for provider %pOF\n", idx,=
 clkspec->np);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return &chip->clk[idx].hw;
> +}
> +
> +/**
> + * r8t49n24x_probe - main entry point for ccf driver
> + * @client:    pointer to i2c_client structure
> + * @id:                pointer to i2c_device_id structure
> + *
> + * Main entry point function that gets called to initialize the driver.
> + *
> + * Return: 0 for success.
> + */
> +static int r8t49n24x_probe(struct i2c_client *client,
> +                          const struct i2c_device_id *id)
> +{
> +       struct clk_r8t49n24x_chip *chip;
> +       struct clk_init_data init;

Use

init =3D {};

so it's all zeroed out.

> +
> +       int err, i;
> +       char buf[6];
> +
> +       chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +       if (!chip)
> +               return -ENOMEM;
> +
> +       init.ops =3D &r8t49n24x_clk_ops;
> +       init.flags =3D 0;
> +       init.num_parents =3D 0;

Then we don't need this.

> +       chip->i2c_client =3D client;
> +
> +       chip->min_freq =3D R8T49N24X_MIN_FREQ;
> +       chip->max_freq =3D R8T49N24X_MAX_FREQ;
> +
> +       for (i =3D 0; i <=3D NUM_INPUTS; i++) {
> +               char name[12];
> +
> +               sprintf(name, i =3D=3D NUM_INPUTS ? "xtal" : "clk%i", i);
> +               dev_dbg(&client->dev, "attempting to get %s", name);
> +               chip->input_clk =3D devm_clk_get_optional(&client->dev, n=
ame);
> +               if (chip->input_clk) {
> +                       err =3D 0;
> +                       chip->input_clk_num =3D i;
> +                       break;
> +               }
> +       }
> +
> +       if (IS_ERR(chip->input_clk)) {
> +               return dev_err_probe(&client->dev, PTR_ERR(chip->input_cl=
k),
> +                                    "can't get input clock/xtal\n");
> +       }
> +
> +       chip->input_clk_freq =3D clk_get_rate(chip->input_clk);
> +       dev_dbg(&client->dev, "Frequency from clk in device tree: %uHz", =
chip->input_clk_freq);
> +
> +       chip->input_clk_nb.notifier_call =3D r8t49n24x_clk_notifier_cb;
> +       if (clk_notifier_register(chip->input_clk, &chip->input_clk_nb))
> +               dev_warn(&client->dev, "Unable to register clock notifier=
 for input_clk.");
> +
> +       dev_dbg(&client->dev, "about to read settings: %zu", ARRAY_SIZE(c=
hip->settings));
> +
> +       err =3D of_property_read_u8_array(client->dev.of_node, "renesas,s=
ettings", chip->settings,
> +                                       ARRAY_SIZE(chip->settings));
> +       if (!err) {
> +               dev_dbg(&client->dev, "settings property specified in DT"=
);
> +               chip->has_settings =3D true;
> +       } else if (err =3D=3D -EOVERFLOW) {
> +               dev_dbg(&client->dev, "EOVERFLOW reading settings. ARRAY_=
SIZE: %zu",
> +                       ARRAY_SIZE(chip->settings));
> +                       return err;
> +       } else {
> +               dev_dbg(&client->dev,
> +                       "settings property missing in DT (or an error tha=
t can be ignored: %i).",
> +                       err);
> +       }
> +
> +       /*
> +        * Requested output frequencies cannot be specified in the DT.
> +        * Either a consumer needs to use the clock API to request the ra=
te.
> +        * Use clock-names in DT to specify the output clock.
> +        */
> +
> +       chip->regmap =3D devm_regmap_init_i2c(client, &r8t49n24x_regmap_c=
onfig);
> +       if (IS_ERR(chip->regmap)) {
> +               dev_err(&client->dev, "failed to allocate register map\n"=
);
> +               return PTR_ERR(chip->regmap);
> +       }
> +
> +       dev_dbg(&client->dev, "call i2c_set_clientdata");
> +       i2c_set_clientdata(client, chip);
> +
> +       if (chip->has_settings) {
> +               /*
> +                * A raw settings array was specified in the DT. Write the
> +                * settings to the device immediately.
> +                */
> +               err =3D __renesas_i2c_write_bulk(chip->i2c_client, chip->=
regmap, 0, chip->settings,
> +                                              ARRAY_SIZE(chip->settings)=
);
> +               if (err) {
> +                       dev_err(&client->dev, "error writing all settings=
 to chip (%i)\n", err);

Yay a newline!

> +                       return err;
> +               }
> +               dev_dbg(&client->dev, "successfully wrote full settings a=
rray");

Aww no newline.

> +       }
> +
> +       /*
> +        * Whether or not settings were written to the device, read all
> +        * current values from the hw.
> +        */
> +       dev_dbg(&client->dev, "read from HW");

Drop.

> +       err =3D r8t49n24x_read_from_hw(chip);
> +       if (err)
> +               return err;
> +
> +       /* Create all 4 clocks */
> +       for (i =3D 0; i < NUM_OUTPUTS; i++) {
> +               init.name =3D kasprintf(GFP_KERNEL, "%s.Q%i", client->dev=
.of_node->name, i);
