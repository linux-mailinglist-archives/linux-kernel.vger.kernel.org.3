Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8A49F736
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347843AbiA1KUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347823AbiA1KUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:20:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF6C06173B;
        Fri, 28 Jan 2022 02:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9854DB82513;
        Fri, 28 Jan 2022 10:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA18C340E0;
        Fri, 28 Jan 2022 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365214;
        bh=Ri15rNc/3mLfG4njoUOcHSEpoSDJCBH9sXE5sSDw1BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcmnsRG9M+MeKrDeGvT6z9uuzzkczZz3BGu2IXotIifQquqHIXlKi9UQvzsuxLyNj
         EjIesN6oqFVJhbKnYyqSO7qTDaJkJbglJ9c4Y988ujd3yywtUQmV8WKTJxykt/vGSI
         qLsW350ybaCpUE5HqmgvS1Ovu8NLf0KC3cRcFHSY=
Date:   Fri, 28 Jan 2022 11:20:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: x86: Fix a wild pointer dereference in
 fch_clk_probe()
Message-ID: <YfPDW1oCw2Dfyiws@kroah.com>
References: <20220107015744.22C22C36AE3@smtp.kernel.org>
 <20220107071559.65843-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107071559.65843-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 03:15:58PM +0800, Zhou Qingyang wrote:
> In fch_clk_probe(), the return value of clk_hw_register_mux() is
> assigned to hws[ST_CLK_MUX] and there is a dereference of it in
> fch_clk_probe(), which could lead to a wild pointer dereference on
> failure of clk_hw_register_mux().
> 
> Fix this bug by adding a check of hws[ST_CLK_MUX].
> 
> This bug was found by a static analyzer.
> 
> Builds with CONFIG_X86_AMD_PLATFORM_DEVICE=y show no new warnings, and
> our static analyzer no longer warns about this code.
> 
> Fixes: 19fe87fd854a ("clk: x86: Support RV architecture")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> --- 
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths
> and confirms that the inconsistent operations are not recovered in 
> the current function or the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Changes in v2:
>   -  Add error check to every register function calls.
>   -  Add error handling logic to every error path.
>   -  Turn clk_hw_register_mux to devm_clk_hw_register_mux.
>   -  Add error check of clk_set_parent().
> 
>  drivers/clk/x86/clk-fch.c | 53 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
> index 8f7c5142b0f0..47754761b19c 100644
> --- a/drivers/clk/x86/clk-fch.c
> +++ b/drivers/clk/x86/clk-fch.c
> @@ -36,6 +36,7 @@ static struct clk_hw *hws[ST_MAX_CLKS];
>  static int fch_clk_probe(struct platform_device *pdev)
>  {
>  	struct fch_clk_data *fch_data;
> +	int ret;
>  
>  	fch_data = dev_get_platdata(&pdev->dev);
>  	if (!fch_data || !fch_data->base)
> @@ -44,35 +45,79 @@ static int fch_clk_probe(struct platform_device *pdev)
>  	if (!fch_data->is_rv) {
>  		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
>  			NULL, 0, 48000000);
> +		if (IS_ERR(hws[ST_CLK_48M]))
> +			return PTR_ERR(hws[ST_CLK_48M]);
> +
>  		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
>  			NULL, 0, 25000000);
> +		if (IS_ERR(hws[ST_CLK_25M])) {
> +			ret = PTR_ERR(hws[ST_CLK_25M]);
> +			goto err_st_clk_25m;
> +		}
>  
> -		hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
> +		hws[ST_CLK_MUX] = devm_clk_hw_register_mux(NULL, "oscout1_mux",
>  			clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
>  			0, fch_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0,
>  			NULL);
> +		if (IS_ERR(hws[ST_CLK_MUX])) {
> +			ret = PTR_ERR(hws[ST_CLK_MUX]);
> +			goto err_st_clk_mux;
> +		}
>  
> -		clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
> +		ret = clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
> +		if (ret)
> +			goto err_clk_set_parent;
>  
>  		hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
>  			"oscout1_mux", 0, fch_data->base + MISCCLKCNTL1,
>  			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
> +		if (IS_ERR(hws[ST_CLK_GATE])) {
> +			ret = PTR_ERR(hws[ST_CLK_GATE]);
> +			goto err_st_clk_gate;
> +		}
>  
> -		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
> +		ret = devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
>  			"oscout1", NULL);
> +		if (ret)
> +			goto err_register_st_clk_gate;
>  	} else {
>  		hws[RV_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
>  			NULL, 0, 48000000);
> +		if (IS_ERR(hws[RV_CLK_48M]))
> +			return PTR_ERR(hws[RV_CLK_48M]);
>  
>  		hws[RV_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
>  			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
>  			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
> +		if (IS_ERR(hws[RV_CLK_GATE])) {
> +			ret = PTR_ERR(hws[RV_CLK_GATE]);
> +			goto err_rv_clk_gate;
> +		}
>  
> -		devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
> +		ret = devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
>  			"oscout1", NULL);
> +		if (ret)
> +			goto err_register_rv_clk_gate;
>  	}
>  
>  	return 0;
> +
> +err_register_st_clk_gate:
> +	clk_hw_unregister_gate(hws[ST_CLK_GATE]);
> +err_st_clk_gate:
> +err_clk_set_parent:
> +	clk_hw_unregister_mux(hws[ST_CLK_MUX]);
> +err_st_clk_mux:
> +	clk_hw_unregister_fixed_rate(hws[ST_CLK_25M]);
> +err_st_clk_25m:
> +	clk_hw_unregister_fixed_rate(hws[ST_CLK_48M]);
> +	return ret;
> +
> +err_register_rv_clk_gate:
> +	clk_hw_unregister_gate(hws[RV_CLK_GATE]);
> +err_rv_clk_gate:
> +	clk_hw_unregister_fixed_rate(hws[RV_CLK_48M]);
> +	return ret;
>  }
>  
>  static int fch_clk_remove(struct platform_device *pdev)
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

