Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CCC55D4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbiF1Eiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiF1Eiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:38:51 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE9D73B5;
        Mon, 27 Jun 2022 21:38:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6517B81BC;
        Tue, 28 Jun 2022 04:33:38 +0000 (UTC)
Date:   Tue, 28 Jun 2022 07:38:49 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Liang He <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: mach-omap2: omap4-common: Fix refcount leak bug
Message-ID: <YrqF2bXbxcYFsUy6@atomide.com>
References: <20220617035548.4003393-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617035548.4003393-1-windhl@126.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liang He <windhl@126.com> [220617 06:51]:
> In omap4_sram_init(), of_find_compatible_node() will return a node
> pointer with refcount incremented. We should use of_node_put() when
> it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/arm/mach-omap2/omap4-common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 6d1eb4eefefe..e981bf57e64f 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -135,6 +135,7 @@ static int __init omap4_sram_init(void)
>  		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
>  			__func__);
>  	sram_pool = of_gen_pool_get(np, "sram", 0);
> +	of_node_put(np);
>  	if (!sram_pool)
>  		pr_warn("%s:Unable to get sram pool needed to handle errata I688\n",
>  			__func__);

Here too sram_pool is used aftger of_node_put().

Regards,

Tony
