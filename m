Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906D47154C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhLKSNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhLKSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:13:23 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87896C061751
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 10:13:23 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t23so17663325oiw.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 10:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZKuXDdMqteEEKXb+96og2uMkZKlBM9xGB/3xrHMNNJ4=;
        b=aWs1p9AyHBbvhMn//ieXmew23uafLMJkWDAEFpKLr/y3EDFmf/hAW9aqurfWekiYJa
         5Y1mrm8+8O1+DctJZZ2x203nP/1PwLA1IforTxfWsg3iai7cKVIsegSiJtT77NzfsMxN
         i3OAM1FhXsDcRi3Rl7pQZccNNGGmSlpGrh3CYXLV2Ka1U4baeL3O5R54nGYFWtIaq5Cq
         IguHuhJ2jT5eEkAx5asn/T8vP7onjdwjd+qEmmL8QPvjHD6nlYJSopu5rLo2RVp7/kEZ
         lZ6fMoyk0ht++uIEsgPGXNbCGBJAHDdAhzgeDYkqtfz7WC9AEbkZvfrZHVXfDsofSoF6
         lMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZKuXDdMqteEEKXb+96og2uMkZKlBM9xGB/3xrHMNNJ4=;
        b=kfux2ds4Qu45MokKPY4bIhAE2Tu//wNbZbO9ITdHHyBxvRo0p30mFEKYumst6Qb42q
         XGn2uWDx1JDOgxmA9OK9DZFnNMhuswKRdgZTt5CQlgNxRSiCW9Pr478bSnYPwC9UVaE+
         zAunSC6DYb7AuR2fz+xJ086xmOogmgz/moKfs2uEn3dSSVseZOdXnh4npCHIEUB/9N8/
         cV8K1xCXrJth4TvPEdbmimbfJfmpZgVpuMQ/BM/ycP3hAzaypVwm077aEgY07nu92SqG
         gmJV/G0JrHqT6Teo18Nj8JDKGX9ye51Cs7ta3SRha1RV7tQNiQPsc68nnWG5V72VlF61
         zGaw==
X-Gm-Message-State: AOAM530skjYnJK5NncSwE8bVjcbf8eki6XpYWclLHTkzQgn03Re5544L
        txjp8BGrTVpMHBhDx3UoHzAcVg==
X-Google-Smtp-Source: ABdhPJwJgs25lTgbpqlRe9kzvrGm41yKRcwXPaPnmvLa062O2KlX0HXEsj/sNKm6DJR4tJAdo1WZPA==
X-Received: by 2002:a05:6808:1a2a:: with SMTP id bk42mr19079854oib.118.1639246402724;
        Sat, 11 Dec 2021 10:13:22 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y12sm1641771oiv.49.2021.12.11.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 10:13:22 -0800 (PST)
Date:   Sat, 11 Dec 2021 12:13:17 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: qcom: Add clock driver for SM8450
Message-ID: <YbTqPfs7026l6LFE@builder.lan>
References: <20211207114003.100693-1-vkoul@kernel.org>
 <20211207114003.100693-3-vkoul@kernel.org>
 <20211209082537.1AF6CC341C8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209082537.1AF6CC341C8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Dec 02:25 CST 2021, Stephen Boyd wrote:

> Quoting Vinod Koul (2021-12-07 03:40:03)
> > diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
> > new file mode 100644
> > index 000000000000..82ac419718d7
> > --- /dev/null
> > +++ b/drivers/clk/qcom/gcc-sm8450.c
> > @@ -0,0 +1,3303 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2021, Linaro Limited
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <dt-bindings/clock/qcom,gcc-sm8450.h>
> > +
> > +#include "clk-alpha-pll.h"
> > +#include "clk-branch.h"
> > +#include "clk-rcg.h"
> > +#include "clk-regmap.h"
> > +#include "clk-regmap-divider.h"
> > +#include "clk-regmap-mux.h"
> > +#include "gdsc.h"
> > +#include "reset.h"
> > +
> > +enum {
> > +       P_BI_TCXO,
> > +       P_GCC_GPLL0_OUT_EVEN,
> > +       P_GCC_GPLL0_OUT_MAIN,
> > +       P_GCC_GPLL4_OUT_MAIN,
> > +       P_GCC_GPLL9_OUT_MAIN,
> > +       P_PCIE_0_PIPE_CLK,
> > +       P_PCIE_1_PHY_AUX_CLK,
> > +       P_PCIE_1_PIPE_CLK,
> > +       P_SLEEP_CLK,
> > +       P_UFS_PHY_RX_SYMBOL_0_CLK,
> > +       P_UFS_PHY_RX_SYMBOL_1_CLK,
> > +       P_UFS_PHY_TX_SYMBOL_0_CLK,
> > +       P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
> > +};
> > +
> > +static struct clk_alpha_pll gcc_gpll0 = {
> > +       .offset = 0x0,
> > +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
> > +       .clkr = {
> > +               .enable_reg = 0x62018,
> > +               .enable_mask = BIT(0),
> > +               .hw.init = &(struct clk_init_data){
> > +                       .name = "gcc_gpll0",
> > +                       .parent_data = &(const struct clk_parent_data){
> > +                               .fw_name = "bi_tcxo",
> 
> Maybe you want to drop these strings and use the dt index directly? That
> may actually be faster because we don't do as many string comparisons
> and the code may be smaller if we don't have to store bi_tcxo. I suppose
> to make it more readable we could have #defines for each DT index like
> 
>  #define DT_BI_TCXO	0
>  #define DT_SLEEP_CLK	1
> 
> Blaze a new trail!
> 

I like the idea, and iiuc it's just a matter of replacing .fw_name with
.index?

I am however worried that people will get the order wrong as they are
hacking on their dts/drivers, because (at least in my view) the order of
clocks & clock-names has been seen as "a dt binding requirement" up
until such change. But if we replace the names with indices such enum
would have to be kept in sync with the DT binding and there's no way to
validate it.

If we do this we should force the driver and dts-writers to rely on the
binding document by omitting clock-names from the binding (and hence
dts). Otherwise people will (I will) assume that the clock-names are
still what matters...

Regards,
Bjorn

> > +                       },
> > +                       .num_parents = 1,
> > +                       .ops = &clk_alpha_pll_fixed_lucid_evo_ops,
> > +               },
> > +       },
> > +};
