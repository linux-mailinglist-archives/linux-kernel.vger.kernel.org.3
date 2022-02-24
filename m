Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E053E4C25DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiBXIVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBXIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:21:38 -0500
X-Greylist: delayed 1062 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 00:21:07 PST
Received: from www.kot-begemot.co.uk (ivanoab7.miniserver.com [37.128.132.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0367251E79;
        Thu, 24 Feb 2022 00:21:07 -0800 (PST)
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1nN95r-000Aam-Fy; Thu, 24 Feb 2022 08:03:23 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1nN95n-008sBW-Vo; Thu, 24 Feb 2022 08:03:18 +0000
Subject: Re: [PATCH] clk: lan966x: Depend on CONFIG_IOMEM
To:     David Gow <davidgow@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org
References: <20220224035902.1594253-1-davidgow@google.com>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <e2a5b8f1-2117-c1be-9223-91904de885d5@kot-begemot.co.uk>
Date:   Thu, 24 Feb 2022 08:03:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220224035902.1594253-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2022 03:59, David Gow wrote:
> The lan966x clk driver depends on IOMEM functions, in particular
> devm_platform_ioremap_resource(), but doesn't state a formal dependency
> on it in Kconfig.
> 
> Add such a dependency, which prevents this driver from being enabled
> on UML configurations without IOMEM.
> 
> This fixes the following build failure:
> 
> /usr/bin/ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
> clk-lan966x.c:(.text+0x294): undefined reference to `devm_platform_ioremap_resource'
> /usr/bin/ld: clk-lan966x.c:(.text+0x3aa): undefined reference to `devm_ioremap_resource'
> collect2: error: ld returned 1 exit status
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   drivers/clk/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 3cdf33470a75..7b5db8a9eb4f 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -231,6 +231,7 @@ config COMMON_CLK_GEMINI
>   
>   config COMMON_CLK_LAN966X
>   	bool "Generic Clock Controller driver for LAN966X SoC"
> +	depends on IOMEM
>   	help
>   	  This driver provides support for Generic Clock Controller(GCK) on
>   	  LAN966X SoC. GCK generates and supplies clock to various peripherals
> 

Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/
