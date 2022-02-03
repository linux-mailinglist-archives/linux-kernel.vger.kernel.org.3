Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE04A8863
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiBCQM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbiBCQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:12:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C7BC061714;
        Thu,  3 Feb 2022 08:12:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82451CE205D;
        Thu,  3 Feb 2022 16:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A7BC340EF;
        Thu,  3 Feb 2022 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643904738;
        bh=tHVZdpOeaDUJxjE7UYVAKrIDf5NQfx3p8v5KExnPRz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRtSFsbtCY6tw10trp0cRyK09ca2gwiH/rIdXiTLJzjOGCzluAwBbkC/FOneKXb4m
         wyu4NLQe1771JC36tpnNVoatGhSIQBdAMx4NcHdmEH51GeEvrvf93g1McL0a8Jhjaj
         DfNlgXSmy9+Z626IupK/gzi9yYKOyVLgRAddCvd61yiEhYPS0ltjVAd3HmAkDgXhZA
         XH2tEtfQ0aPHT7W4E1jbkjBuIWG9J6a2mPnLw1mOU8wsFu14bGHddJw6OpXodxsDX9
         WpVAI0ZTszicK8BqmkjzHK/QUy3gvA1cpgwneme6SvipZ9tDTww+vwcWixC/vI3gvi
         hNdmx75bfd68Q==
Date:   Thu, 3 Feb 2022 21:42:10 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 1/4] clk: actions: Terminate clk_div_table with
 sentinel element
Message-ID: <20220203161210.GA138829@thinkpad>
References: <20220203142153.260720-1-j.neuschaefer@gmx.net>
 <20220203142153.260720-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203142153.260720-2-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 03:21:50PM +0100, Jonathan Neuschäfer wrote:
> In order that the end of a clk_div_table can be detected, it must be
> terminated with a sentinel element (.div = 0).
> 
> Fixes: d47317ca4ade1 ("clk: actions: Add S700 SoC clock support")
> Fixes: d85d20053e195 ("clk: actions: Add S900 SoC clock support")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> I'm not so sure about usb3_mac_div_table. Maybe the { 0, 8 } element was
> meant to be { 0, 0 }? I'd appreciate if someone with access to the
> datasheet or hardware could verify what's correct.

USB3 factor table is not documented in the datasheet I have access to. But by
looking at the value, it looks to be a typo. So please change the last entry.
With that,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> 
> v2:
> - Add Fixes tags
> ---
>  drivers/clk/actions/owl-s700.c | 1 +
>  drivers/clk/actions/owl-s900.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
> index a2f34d13fb543..617174644f728 100644
> --- a/drivers/clk/actions/owl-s700.c
> +++ b/drivers/clk/actions/owl-s700.c
> @@ -162,6 +162,7 @@ static struct clk_div_table hdmia_div_table[] = {
> 
>  static struct clk_div_table rmii_div_table[] = {
>  	{0, 4},   {1, 10},
> +	{0, 0},
>  };
> 
>  /* divider clocks */
> diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
> index 790890978424a..f6f49100a865b 100644
> --- a/drivers/clk/actions/owl-s900.c
> +++ b/drivers/clk/actions/owl-s900.c
> @@ -139,8 +139,8 @@ static struct clk_div_table rmii_ref_div_table[] = {
>  };
> 
>  static struct clk_div_table usb3_mac_div_table[] = {
> -	{ 1, 2 }, { 2, 3 }, { 3, 4 },
> -	{ 0, 8 },
> +	{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 0, 8 },
> +	{ 0, 0 },
>  };
> 
>  static struct clk_div_table i2s_div_table[] = {
> --
> 2.34.1
> 
