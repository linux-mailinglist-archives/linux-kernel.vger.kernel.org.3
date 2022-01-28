Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0749F6F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbiA1KQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343706AbiA1KQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:16:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B25C061714;
        Fri, 28 Jan 2022 02:16:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 553B061E42;
        Fri, 28 Jan 2022 10:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B43C340E0;
        Fri, 28 Jan 2022 10:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643364983;
        bh=AtryLqdfbP2bIln80y7o32pcX0GHQcTsCpCHopwzoaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pn5jTamHjupkOw2EA3/yJptuMJNs3Xifhj0g2lj1WVKw7S0TdpTWYfvp0YH+lczZM
         x6SSsd8UBu2y/+mfUslNcEaVzH8J/q80kBqN/DYZTdUJ079em/VeyWwceJmkT69xfm
         EUQYvt6JMa91tdukdRPuaXflMhYE/tCc18XLamN8=
Date:   Fri, 28 Jan 2022 11:16:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: Fix a NULL pointer dereference in
 imx_register_uart_clocks()
Message-ID: <YfPCdPuoB3RYgzL8@kroah.com>
References: <20220124165206.55059-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124165206.55059-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:52:06AM +0800, Zhou Qingyang wrote:
> In imx_register_uart_clocks(), the global variable imx_uart_clocks is
> assigned by kcalloc() and there is a dereference of in the next for loop,
> which could introduce a NULL pointer dereference on failure of kcalloc().
> 
> Fix this by adding a NULL check of imx_uart_clocks.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 379c9a24cc23 ("clk: imx: Fix reparenting of UARTs not associated with stdout")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/clk/imx/clk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 7cc669934253..99249ab361d2 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -173,6 +173,8 @@ void imx_register_uart_clocks(unsigned int clk_count)
>  		int i;
>  
>  		imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> +		if (!imx_uart_clocks)
> +			return;
>  
>  		if (!of_stdout)
>  			return;
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

