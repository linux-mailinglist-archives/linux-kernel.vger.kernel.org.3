Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2784990BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376431AbiAXUDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:03:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36996 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356415AbiAXTqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:46:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E598B8121C;
        Mon, 24 Jan 2022 19:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB7EC340E7;
        Mon, 24 Jan 2022 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643053567;
        bh=gJlHbxnMW0wTSxm4hKs/P78n5KAVQuBy0pzkZMpkAGQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pBLf/juVpsFO6ypTkWqRMy7awwXjZ8Rw3n3NDnpqdQKeMJ2cgvfQLL0GpUqvtulR+
         bmo/qL875hJXqkr81U3qQrQyZ5F5D8Jyzdc5HuVrYZyuTlaU1tRRH075D6tlF9Z7yu
         vsY/HEQSCUklTYdk89aYoyEc7/7AcqfhvgEJk6fBGMHQMkIkc3yUqVOreEUWcwq0+j
         QJjAbkykYxXP2DL9/i1fPlNuezzba0ip2ANz3M3yC8Bc/07GKj4wGg9z5l+Fo9JiLZ
         6rAjcIZjA9t0P2KKfQ5Ni3rLGfv9fm3mDEPQGkLcOzqJR2FtIeiFs+i2iVeep0n3+7
         WBkVgCU05PHgw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220124162442.29497-3-tdas@codeaurora.org>
References: <20220124162442.29497-1-tdas@codeaurora.org> <20220124162442.29497-3-tdas@codeaurora.org>
Subject: Re: [PATCH v3 2/2] clk: qcom: lpass: Add support for LPASS clock controller for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Mon, 24 Jan 2022 11:46:05 -0800
User-Agent: alot/0.10
Message-Id: <20220124194607.BCB7EC340E7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-01-24 08:24:42)
> diff --git a/drivers/clk/qcom/lpasscorecc-sc7280.c b/drivers/clk/qcom/lpa=
sscorecc-sc7280.c
> new file mode 100644
> index 000000000000..3ac62ea5767e
> --- /dev/null
> +++ b/drivers/clk/qcom/lpasscorecc-sc7280.c
> @@ -0,0 +1,430 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>

Is the of.h include used?

> +#include <linux/pm_clock.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "gdsc.h"
> +
[...]
> +
> +static struct regmap_config lpass_core_cc_sc7280_regmap_config =3D {
> +       .reg_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .val_bits =3D 32,
> +       .fast_io =3D true,

What's the max_register? Please set it so that debugfs works.
