Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD9048151B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbhL2Qe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:34:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37302 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhL2QeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:34:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B564D6150C;
        Wed, 29 Dec 2021 16:34:24 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id A06AEC36AE7;
        Wed, 29 Dec 2021 16:34:20 +0000 (UTC)
Date:   Wed, 29 Dec 2021 16:40:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] mips: bcm63xx: add support for clk_set_parent()
Message-ID: <20211229164005.6f5a76a0@jic23-huawei>
In-Reply-To: <20211229000553.32240-1-rdunlap@infradead.org>
References: <20211229000553.32240-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 16:05:53 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> The MIPS BMC63XX subarch does not provide/support clk_set_parent().
> This causes build errors in a few drivers, so add a simple implementation
> of that function so that callers of it will build without errors.
> 
> Fixes these build errors:
> 
> ERROR: modpost: "clk_set_parent" [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
> ERROR: modpost: "clk_set_parent" [sound/soc/atmel/snd-soc-atmel-i2s.ko] undefined!
> 
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs." )
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Hi Randy,

As with the other one, perhaps consider a WARN_ON()
With or without that FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/mips/bcm63xx/clk.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- linux-next-20211224.orig/arch/mips/bcm63xx/clk.c
> +++ linux-next-20211224/arch/mips/bcm63xx/clk.c
> @@ -387,6 +387,12 @@ struct clk *clk_get_parent(struct clk *c
>  }
>  EXPORT_SYMBOL(clk_get_parent);
>  
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_parent);
> +
>  unsigned long clk_get_rate(struct clk *clk)
>  {
>  	if (!clk)

