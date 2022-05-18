Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A110D52B2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiERGoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiERGn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:43:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724F427C9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3343B81E96
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BB0C385AA;
        Wed, 18 May 2022 06:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652856233;
        bh=RZJeo2ZvTUQTJ2KxE6AqWZbbIpL1jC4oQk2DeGAQ0IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rg5OrV9ziFA19WmwJSxzMMHi/rH2Fme1daVsFXzh49gMxtzkacoPz4O0VHuBwfA/j
         qBQTZ8P66J4cP0g6woW+tDMlB7zZWDBAdAU1RVrFn/OdgJhkLHC8OqQ7TPzAnc/K/J
         dT2XicFSVty1eIXF1E5oG5iRPCxnfoBTXXNFvYg0=
Date:   Wed, 18 May 2022 08:43:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
        mchehab+huawei@kernel.org, eugenis@google.com, tony.luck@intel.com,
        pcc@google.com, peterz@infradead.org, marcos@orca.pet,
        conor.dooley@microchip.com, nicolas.ferre@microchip.com,
        marcan@marcan.st, linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 7/8] x86: Add Kconfig/Makefile to build hardware
 prefetch control driver
Message-ID: <YoSVpAlKA2wF41o3@kroah.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-8-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518063032.2377351-8-tarumizu.kohei@fujitsu.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:30:31PM +0900, Kohei Tarumizu wrote:
> This adds Kconfig/Makefile to build hardware prefetch control driver
> for x86 support. This also adds a MAINTAINERS entry.
> 
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---
>  MAINTAINERS                  | 1 +
>  arch/x86/Kconfig             | 6 ++++++
>  arch/x86/kernel/cpu/Makefile | 2 ++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd1345087881..9759c3606c7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8623,6 +8623,7 @@ K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
>  HARDWARE PREFETCH CONTROL DRIVERS
>  M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
>  S:	Maintained
> +F:	arch/x86/kernel/cpu/x86-pfctl.c
>  F:	drivers/base/pfctl.c
>  F:	drivers/soc/fujitsu/a64fx-pfctl.c
>  F:	include/linux/pfctl.h
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4bed3abf444d..81df9efc69e5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1359,6 +1359,12 @@ config X86_CPUID
>  	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
>  	  /dev/cpu/31/cpuid.
>  
> +config X86_HWPF_CONTROL
> +	tristate "x86 Hardware Prefetch Control support"
> +	depends on X86_64 && HWPF_CONTROL
> +	help
> +	  This adds Hardware Prefetch driver control support for X86.
> +

You need a lot more text here about what this is, what it does, why you
would want it, and the module name it will create.

thanks,

greg k-h
