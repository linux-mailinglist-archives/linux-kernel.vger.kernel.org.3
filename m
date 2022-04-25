Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76E950E7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbiDYSNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiDYSNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:13:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5770821A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:10:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A901FB;
        Mon, 25 Apr 2022 11:10:01 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32C1A3F5A1;
        Mon, 25 Apr 2022 11:10:00 -0700 (PDT)
Message-ID: <7660044a-17ec-740f-0595-7765bf7e74bc@arm.com>
Date:   Mon, 25 Apr 2022 19:09:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] soc: rockchip: Fix compile-testing SoC drivers
Content-Language: en-GB
To:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-rockchip@lists.infradead.org
References: <20220425171737.321813-1-briannorris@chromium.org>
 <20220425101646.v2.2.Id5f16dec920f620120c0a143a97a12e16d401760@changeid>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220425101646.v2.2.Id5f16dec920f620120c0a143a97a12e16d401760@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-25 18:17, Brian Norris wrote:
> Similar to commit 7f94b69ece51 ("ARM: ixp4xx: fix compile-testing soc
> drivers").
> 
> drivers/soc/rockchip/Kconfig makes plenty of provision for configuring
> drivers either for ARCH_ROCKCHIP or for COMPILE_TEST. But
> drivers/soc/Makefile pulls the rug out from under us, by refusing to
> build anything if we specified COMPILE_TEST but not ARCH_ROCKCHIP.
> 
> Currently, I'm not aware of anything that breaks without this patch, but
> it certainly makes for confusing builds (CONFIG_ROCKCHIP_PM_DOMAINS=y,
> but we didn't actually compile the driver?) and leaves room for future
> error (I have pending patches that break confusingly with COMPILE_TEST=y
> even though their Kconfig dependencies seem correct [1]).
> 
> Defer to drivers/soc/rockchip/{Makefile,Kconfig} to do the right thing.
> 
> We also need to force ARM/ARM64 dependencies for ROCKCHIP_PM_DOMAINS,
> because it uses ARM-specific macros (dsb()).

FWIW, those dsb()s could be replaced with generic wmb()s, assuming their 
purpose is to complete the previous write before polling for the result 
(TBH it's questionable whether that serves any practical purpose given 
the ordering rules for Device memory, but I doubt these are critical 
performance bottlenecks so there doesn't seem to be any real harm in 
being super-conservative). At worst they could be swapped for generic 
mb() with no functional change at all, but it seems even harder to 
justify why that might need to be.

Robin.

> [1] e.g.,
> https://lore.kernel.org/linux-rockchip/20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid/
> [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> Changes in v2:
>   * Depend on ARM||ARM64
> 
>   drivers/soc/Makefile         | 2 +-
>   drivers/soc/rockchip/Kconfig | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index fd7717d597fc..4c91705a8bb3 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -23,7 +23,7 @@ obj-y				+= pxa/
>   obj-y				+= amlogic/
>   obj-y				+= qcom/
>   obj-y				+= renesas/
> -obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
> +obj-y				+= rockchip/
>   obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
>   obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
>   obj-y				+= sunxi/
> diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
> index aff2f7e95237..785e1798d286 100644
> --- a/drivers/soc/rockchip/Kconfig
> +++ b/drivers/soc/rockchip/Kconfig
> @@ -25,6 +25,7 @@ config ROCKCHIP_IODOMAIN
>   config ROCKCHIP_PM_DOMAINS
>   	bool "Rockchip generic power domain"
>   	depends on PM
> +	depends on ARM || ARM64
>   	select PM_GENERIC_DOMAINS
>   	help
>   	  Say y here to enable power domain support.
