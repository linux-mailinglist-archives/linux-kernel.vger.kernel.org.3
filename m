Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B894A52477A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351257AbiELH5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbiELH5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:57:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6C98689A4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:57:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 674371042;
        Thu, 12 May 2022 00:57:04 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 149C83F73D;
        Thu, 12 May 2022 00:57:02 -0700 (PDT)
Date:   Thu, 12 May 2022 08:56:59 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Rob Herring <rob.herring@calxeda.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ARM: highbank: Fix refcount leak in highbank_init
Message-ID: <20220512085659.678db0b3@donnerap.cambridge.arm.com>
In-Reply-To: <20220512031259.56459-1-linmq006@gmail.com>
References: <20220512031259.56459-1-linmq006@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 07:12:58 +0400
Miaoqian Lin <linmq006@gmail.com> wrote:

Hi,

> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 220e6cf7b793 ("ARM: add Highbank core platform support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

That is basically the same patch as this one:
https://lore.kernel.org/linux-arm-kernel/20220408094817.2494756-1-lv.ruyi@zte.com.cn/

Arnd, Olof, can you please take the older one through the soc tree? Maybe
adding the Fixes tag from this one?

Thanks,
Andre

> ---
>  arch/arm/mach-highbank/highbank.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index db607955a7e4..af9488854fe3 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -142,6 +142,7 @@ static void __init highbank_init(void)
>  	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
>  	sregs_base = of_iomap(np, 0);
>  	WARN_ON(!sregs_base);
> +	of_node_put(np);
>  
>  	pm_power_off = highbank_power_off;
>  	highbank_pm_init();

