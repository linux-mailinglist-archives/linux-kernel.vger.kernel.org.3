Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCBC570BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiGKU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiGKU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2B887F66;
        Mon, 11 Jul 2022 13:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 415226162A;
        Mon, 11 Jul 2022 20:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B1CC341CE;
        Mon, 11 Jul 2022 20:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571214;
        bh=yppWtMlpzGxhTVCbUitFL8uc/Qbx8CgTBfd7qCKLRQA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Qin4VdXGfP4lSvhaVW9agm6dNAbmCuEsi8tD/yw3yjAp402r3CMwbBj/GDujIDNSo
         /49UbqPjkcCNyFcfGuELL5UzCZVdGgMzaI6+HQj9y43oGLpTbT06yx2/eoaxVATVlP
         I8Ly2O9fE6fBgHK3bG5ekdNhnUI3meXc6DiyvUUHk3c5a1o7ILjgvyPi9zVfAxO/pb
         5c3bUwDMsJLEVxsky74vVIMuETCS7huTqEr3FEVBINGfmUelBNfwZCnfZWAL4koeul
         54EVWIWPBJHpf2FryCzxkxQPopx5NJybNX7GgGK3rztQm6McnrIGr76Hen9Dp+WbVw
         7CWgEq5jJpz/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220505101433.1575096-5-gengcixi@gmail.com>
References: <20220505101433.1575096-1-gengcixi@gmail.com> <20220505101433.1575096-5-gengcixi@gmail.com>
Subject: Re: [PATCH v5 4/4] clk: sprd: Add clocks support for UMS512
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Cixi Geng <gengcixi@gmail.com>, baolin.wang7@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        mturquette@baylibre.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        zhang.lyra@gmail.com
Date:   Mon, 11 Jul 2022 13:26:52 -0700
User-Agent: alot/0.10
Message-Id: <20220711202654.91B1CC341CE@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cixi Geng (2022-05-05 03:14:33)
> diff --git a/drivers/clk/sprd/ums512-clk.c b/drivers/clk/sprd/ums512-clk.c
> new file mode 100644
> index 000000000000..53ed58de61cd
> --- /dev/null
> +++ b/drivers/clk/sprd/ums512-clk.c
> @@ -0,0 +1,2199 @@
> +// SPDX-License-Identifier: GPL

Please pick an appropriate license.

WARNING: 'SPDX-License-Identifier: GPL' is not supported in LICENSES/...
#49: FILE: drivers/clk/sprd/ums512-clk.c:1:
+// SPDX-License-Identifier: GPL

> +/*
> + * Unisoc UMS512 clock driver
> + *
> + * Copyright (C) 2022 Unisoc, Inc.
> + * Author: Xiaolong Zhang <xiaolong.zhang@unisoc.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/sprd,ums512-clk.h>
> +
> +#include "common.h"
> +#include "composite.h"
> +#include "div.h"
> +#include "gate.h"
> +#include "mux.h"
> +#include "pll.h"
> +
> +#define UMS512_MUX_FLAG        \
> +       (CLK_GET_RATE_NOCACHE | CLK_SET_RATE_NO_REPARENT)

Why do we need nocache?

> +
> +/* pll gate clock */
> +/* some pll clocks configure CLK_IGNORE_UNUSED because hw dvfs does not =
call
> + * clock interface. hw dvfs can not gate the pll clock.
> + */
> +static CLK_FIXED_FACTOR_FW_NAME(clk_26m_aud, "clk-26m-aud", "ext-26m", 1=
, 1, 0);
[...]
> +       .hw_clks        =3D &ums512_pmu_gate_hws,
> +};
> +
> +/* pll clock at g0 */
> +static const u64 itable_dpll0[7] =3D {6, 0, 0,

Please put space after '{' and before '}'

> +                       1173000000ULL, 1475000000ULL,
> +                       1855000000ULL, 1866000000ULL};
> +
[...]
> +
> +static int ums512_clk_probe(struct platform_device *pdev)
> +{
> +       const struct sprd_clk_desc *desc;
> +
> +       desc =3D device_get_match_data(&pdev->dev);
> +       if (!desc)
> +               return -ENODEV;
> +
> +       sprd_clk_regmap_init(pdev, desc);

Check for error please

> +
> +       return sprd_clk_probe(&pdev->dev, desc->hw_clks);
> +}
> +
