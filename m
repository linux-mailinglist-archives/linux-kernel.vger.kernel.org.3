Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E7E481519
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbhL2Qd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:33:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36990 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhL2Qd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:33:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F615614B5;
        Wed, 29 Dec 2021 16:33:28 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 233E2C36AE9;
        Wed, 29 Dec 2021 16:33:23 +0000 (UTC)
Date:   Wed, 29 Dec 2021 16:39:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mips: lantiq: add support for clk_set_parent()
Message-ID: <20211229163908.2eaf3656@jic23-huawei>
In-Reply-To: <20211229000345.24199-1-rdunlap@infradead.org>
References: <20211229000345.24199-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 16:03:45 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Provide a simple implementation of clk_set_parent() in the lantiq
> subarch so that callers of it will build without errors.
> 
> Fixes these build errors:
> 
> ERROR: modpost: "clk_set_parent" [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
> ERROR: modpost: "clk_set_parent" [sound/soc/atmel/snd-soc-atmel-i2s.ko] undefined!
> 
> Fixes: 171bb2f19ed6 ("MIPS: Lantiq: Add initial support for Lantiq SoCs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> --to=linux-mips@vger.kernel.org --cc="John Crispin <john@phrozen.org>" --cc="Jonathan Cameron <jic23@kernel.org>" --cc="Russell King <linux@armlinux.org.uk>" --cc="Andy Shevchenko <andy.shevchenko@gmail.com>" --cc=alsa-devel@alsa-project.org --to="Thomas Bogendoerfer <tsbogend@alpha.franken.de>"

I guess hitting this sooner or later was inevitable given the recent fix
of adding clk_get_parent() to these two.  It might be worth adding a
WARN_ON() or similar to this function though so we know if anything
ever actually hits it at runtime.  Seems like at least some of the
other similar stubs do so (omap1 for example).

With or without a warning, LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/mips/lantiq/clk.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- linux-next-20211224.orig/arch/mips/lantiq/clk.c
> +++ linux-next-20211224/arch/mips/lantiq/clk.c
> @@ -164,6 +164,12 @@ struct clk *clk_get_parent(struct clk *c
>  }
>  EXPORT_SYMBOL(clk_get_parent);
>  
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_parent);
> +
>  static inline u32 get_counter_resolution(void)
>  {
>  	u32 res;

