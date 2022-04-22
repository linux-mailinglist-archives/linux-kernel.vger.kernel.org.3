Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6C50BBCF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449202AbiDVPnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449169AbiDVPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:40:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C355AECC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:37:28 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nhvLN-0000qE-AP; Fri, 22 Apr 2022 17:37:13 +0200
Message-ID: <3d5969cc-2210-3c7c-01c8-3f5c3789e54b@pengutronix.de>
Date:   Fri, 22 Apr 2022 17:37:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/8] ARM: stm32: select OPTEE on MPU family
Content-Language: en-US
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>, arnd@arndb.de,
        robh+dt@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        soc@kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        etienne.carriere@st.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-6-alexandre.torgue@foss.st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220422150952.20587-6-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,

On 22.04.22 17:09, Alexandre Torgue wrote:
> Select CONFIG_OPTEE for STM32MP15 and STM32MP13 by default. Final
> activation will done thanks to device tree.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
> index 98145031586f..b322cf2a136f 100644
> --- a/arch/arm/mach-stm32/Kconfig
> +++ b/arch/arm/mach-stm32/Kconfig
> @@ -6,6 +6,8 @@ menuconfig ARCH_STM32
>  	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
>  	select ARM_GIC if ARCH_MULTI_V7
>  	select ARM_PSCI if ARCH_MULTI_V7
> +	select TEE if ARCH_MULTI_V7
> +	select OPTEE if ARCH_MULTI_V7

Users may want to use OPTEE as a module without it being a SCMI provider
or not use OPTEE at all. I'd prefer you drop this patch and leave it
to users to configure their kernel appropriately.

Cheers,
Ahmad


>  	select ARM_AMBA
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select CLKSRC_STM32




-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
