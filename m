Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4884EAB45
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiC2KfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiC2KfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8332C65A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54FF16122C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55664C340ED;
        Tue, 29 Mar 2022 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648549997;
        bh=5FgUcZbB4cY37HO0BUEW/2PUtsj7QGFtqc1d2v0/2BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=voCtLj+BHaw6L6o43Gjn26OkZsTfiSI7kCCitCS4IjDywBTq6asy4eBWSoguNCfem
         MyPuyiJ0QIrOlTiLjURiqcURF5Tw8ulbJhpwXKTWoC+72uysp2F7oYadIdX2B580c4
         dZ8V0bnrTotXMNwbocLb6b3sQicpw69kamBvxKgc=
Date:   Tue, 29 Mar 2022 12:33:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>,
        Jason M Bills <jason.m.bills@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] peci: PECI should depend on ARCH_ASPEED
Message-ID: <YkLgapMN2JqM+Lte@kroah.com>
References: <f7ea35c723da72a89028da5b976ad417fbd7bf52.1648545587.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ea35c723da72a89028da5b976ad417fbd7bf52.1648545587.git.geert@linux-m68k.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 11:21:37AM +0200, Geert Uytterhoeven wrote:
> The Platform Environment Control Interface (PECI) is only available on
> Baseboard Management Controllers (BMC) for Intel processors.  Currently
> the only supported BMCs are ASpeed BMC SoCs.  Hence add a dependency on
> ARCH_ASPEED, to prevent asking the user about the PECI subsystem when
> configuring a kernel without ASpeed SoC support.
> 
> Fixes: 6523d3b2ffa238ac ("peci: Add core infrastructure")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/peci/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/peci/Kconfig b/drivers/peci/Kconfig
> index 89872ad833201510..0d3ef8ba0998d649 100644
> --- a/drivers/peci/Kconfig
> +++ b/drivers/peci/Kconfig
> @@ -2,6 +2,7 @@
>  
>  menuconfig PECI
>  	tristate "PECI support"
> +	depends on ARCH_ASPEED || COMPILE_TEST

I hate ARCH_ dependencies as there is nothing specific with that one
platform that means that this driver subsystem will only work on that
one.

I'm all for fixing build dependancies, but it should be fine to build
all drivers for all arches.

So sorry, I don't like this change.

greg k-h
