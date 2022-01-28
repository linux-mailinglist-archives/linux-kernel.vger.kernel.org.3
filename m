Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA749F733
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347845AbiA1KUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:20:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40712 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347832AbiA1KUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:20:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A975AB82519;
        Fri, 28 Jan 2022 10:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADECCC340E6;
        Fri, 28 Jan 2022 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365205;
        bh=bkei2eb19WMisDwh+tZOKfVPJ+LMN4YoDDIADFBqrxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NevbnbCGOUuaDu7DEzF9IUux0W/+b0Ikw3sxb8xA2bX4+9C72TCrmZFiOWYx4p9y3
         zJCM7mDOaNlkiF32Ax1+vcyPwB9GOSPb+Ynid7rYgszeUstzww+ieWj7zGQ3lb+fVe
         D8OcHpOlE9+nF3zUpat+hSnLWmcjxXjmTxrgvP34=
Date:   Fri, 28 Jan 2022 11:20:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: x86: Fix a wild pointer dereference in
 fch_clk_probe()
Message-ID: <YfPDUgE0+vUyQQFl@kroah.com>
References: <20220111051022.98479-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111051022.98479-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 01:10:21PM +0800, Zhou Qingyang wrote:
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
> Changes in v3:
>   -  Rebase this based on clk-next.
> 
> Changes in v2:
>   -  Add error check to every register function calls.
>   -  Add error handling logic to every error path.
>   -  Turn clk_hw_register_mux to devm_clk_hw_register_mux.
>   -  Add error check of clk_set_parent().
> 
>  drivers/clk/x86/clk-fch.c | 69 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
> index fdc060e75839..bb0ed6b2a126 100644
> --- a/drivers/clk/x86/clk-fch.c
> +++ b/drivers/clk/x86/clk-fch.c
> @@ -46,6 +46,7 @@ static int fch_clk_probe(struct platform_device *pdev)
>  {
>  	struct fch_clk_data *fch_data;
>  	struct pci_dev *rdev;
> +	int ret;
>  
>  	fch_data = dev_get_platdata(&pdev->dev);
>  	if (!fch_data || !fch_data->base)
> @@ -60,36 +61,88 @@ static int fch_clk_probe(struct platform_device *pdev)
>  	if (pci_match_id(fch_pci_ids, rdev)) {
>  		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
>  			NULL, 0, 48000000);
> +		if (IS_ERR(hws[ST_CLK_48M])) {
> +			ret = PTR_ERR(hws[ST_CLK_48M]);
> +			goto err_st_clk_48m;
> +		}
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
> -
> -		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
> -					    fch_data->name, NULL);
> +		if (IS_ERR(hws[ST_CLK_GATE])) {
> +			ret = PTR_ERR(hws[ST_CLK_GATE]);
> +			goto err_st_clk_gate;
> +		}
> +
> +		ret = devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
> +			fch_data->name, NULL);
> +		if (ret)
> +			goto err_register_st_clk_gate;
>  	} else {
>  		hws[CLK_48M_FIXED] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
>  			NULL, 0, 48000000);
> +		if (IS_ERR(hws[CLK_48M_FIXED])) {
> +			ret = PTR_ERR(hws[CLK_48M_FIXED]);
> +			goto err_clk_48m_fixed;
> +		}
>  
>  		hws[CLK_GATE_FIXED] = clk_hw_register_gate(NULL, "oscout1",
>  			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
>  			OSCCLKENB, 0, NULL);
> -
> -		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
> -					    fch_data->name, NULL);
> +		if (IS_ERR(hws[CLK_GATE_FIXED])) {
> +			ret = PTR_ERR(hws[CLK_GATE_FIXED]);
> +			goto err_clk_gate_fixed;
> +		}
> +
> +		ret = devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
> +			fch_data->name, NULL);
> +		if (ret)
> +			goto err_register_gate_fixed;
>  	}
>  
>  	pci_dev_put(rdev);
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
> +err_st_clk_48m:
> +	pci_dev_put(rdev);
> +	return ret;
> +
> +err_register_gate_fixed:
> +	clk_hw_unregister_gate(hws[CLK_GATE_FIXED]);
> +err_clk_gate_fixed:
> +	clk_hw_unregister_fixed_rate(hws[CLK_48M_FIXED]);
> +err_clk_48m_fixed:
> +	pci_dev_put(rdev);
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

