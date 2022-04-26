Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264D650F356
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbiDZIIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiDZIIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:08:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94C29DF3B;
        Tue, 26 Apr 2022 01:05:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A378580C0;
        Tue, 26 Apr 2022 08:02:23 +0000 (UTC)
Date:   Tue, 26 Apr 2022 11:05:23 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ren Yu <renyu@nfschina.com>
Cc:     aaro.koskinen@iki.fi, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        yuzhe@nfschina.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] plat-omap: check return value of ioremap()
Message-ID: <Ymenw5/haMIjFlCP@atomide.com>
References: <20220425110845.415439-1-renyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425110845.415439-1-renyu@nfschina.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Ren Yu <renyu@nfschina.com> [220425 11:08]:
> When ioremap() failed,return err

This file is no longer being used and getting removed in Linux next.
See commit 7058e68c2fed ("ARM: omap: remove debug-leds driver").

Thanks,

Tony

> Signed-off-by: Ren Yu <renyu@nfschina.com>
> ---
>  arch/arm/plat-omap/debug-leds.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
> index 2b698d074874..bf5034e10f6e 100644
> --- a/arch/arm/plat-omap/debug-leds.c
> +++ b/arch/arm/plat-omap/debug-leds.c
> @@ -109,6 +109,9 @@ static int fpga_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	fpga = ioremap(iomem->start, resource_size(iomem));
> +	if (!fpga)
> +		return -ENOMEM;
> +
>  	writew_relaxed(0xff, &fpga->leds);
>  
>  	for (i = 0; i < ARRAY_SIZE(dbg_leds); i++) {
> -- 
> 2.25.1
> 
