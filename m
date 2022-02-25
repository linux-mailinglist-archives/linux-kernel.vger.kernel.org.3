Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665934C3B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiBYB4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiBYB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:56:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7929F40A;
        Thu, 24 Feb 2022 17:55:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44363612F0;
        Fri, 25 Feb 2022 01:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEC3C340E9;
        Fri, 25 Feb 2022 01:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645754151;
        bh=gPX7D8TWcwgfwGimCjLecj2OhwEh5+nLirnvtc31utY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Bk5AE9LtcZhk1Sp2LiQ0xOGl0DZm6uuUlgBWZynVcxHgumzwXubAEskCGvw9DNDat
         K5TvSRMw3TxcVOfVv+IRlYp+DBuUCKmra1GA29RQxlGQjgQXbr+AA7YU53ZIsM72FL
         Wwq+bcG5CQZ6IRAuJ3ptGjHc7OL0XpxYgm9bql3waPKoGsf1O4jMk2+tCOO134YzNx
         xxp6ZeiyNjszfzAmbS4GFOFBJcB0KXIZAHoKK1WAgkPMLDX5PwcDZnMK+uICGc5BPR
         J7eKMKuWsqWx4R2T1/iad/1U5gNCu91IzfDP/bddGGEXY3abs1U1YuHsqukHTraS4h
         xGNKK3XdYikYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220225014234.1766305-5-peng.fan@oss.nxp.com>
References: <20220225014234.1766305-1-peng.fan@oss.nxp.com> <20220225014234.1766305-5-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V5 4/5] clk: imx: support fracn gppll
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Thu, 24 Feb 2022 17:55:49 -0800
User-Agent: alot/0.10
Message-Id: <20220225015551.9EEC3C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2022-02-24 17:42:33)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> This PLL module is a Fractional-N synthesizer,
> supporting 30-bit numerator and denominator. Numerator is a signed
> number. It has feature to adjust fractional portion of feedback
> divider dynamically. This fracn gppll is used in i.MX93.
>=20
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/Makefile          |   1 +
>  drivers/clk/imx/clk-fracn-gppll.c | 324 ++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h             |  21 ++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
>=20
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 36c04922d789..60c8a4bb7574 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -5,6 +5,7 @@ mxc-clk-objs +=3D clk-busy.o
>  mxc-clk-objs +=3D clk-composite-7ulp.o
>  mxc-clk-objs +=3D clk-composite-8m.o
>  mxc-clk-objs +=3D clk-composite-93.o
> +mxc-clk-objs +=3D clk-fracn-gppll.o
>  mxc-clk-objs +=3D clk-cpu.o
>  mxc-clk-objs +=3D clk-divider-gate.o
>  mxc-clk-objs +=3D clk-fixup-div.o
> diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-frac=
n-gppll.c
> new file mode 100644
> index 000000000000..57b38147f05a
> --- /dev/null
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#include <asm/div64.h>

Please include this after linux headers

> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>

Is this include used?

> +
> +#include "clk.h"
> +
