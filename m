Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC01B508AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379672AbiDTO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379655AbiDTO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:29:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B163443DC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:26:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274F023A;
        Wed, 20 Apr 2022 07:26:27 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD3DC3F5A1;
        Wed, 20 Apr 2022 07:26:25 -0700 (PDT)
Date:   Wed, 20 Apr 2022 15:26:17 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     cgel.zte@gmail.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ARM: highbank: Fix missing of_node_put in
 highbank_init()
Message-ID: <20220420152617.7b3c1d70@donnerap.cambridge.arm.com>
In-Reply-To: <20220408094817.2494756-1-lv.ruyi@zte.com.cn>
References: <20220408094817.2494756-1-lv.ruyi@zte.com.cn>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Apr 2022 09:48:17 +0000
cgel.zte@gmail.com wrote:

Hi,

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> of_find_compatible_node() returns node pointer with refcount incremented,
> use of_node_put() on it to decrease refcount when done.

Thanks for the patch, looks alright to me.
There is actually another occurrence in the same file, will send a patch
ASAP.

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Fixes: 220e6cf7b793d702596506a8c4bf1f4fd4040df1 ("ARM: add Highbank core
platform support")

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Arnd, Olof, can you please take this through the soc tree as a fix,
whenever you find time?

Thanks!
Andre

> ---
>  arch/arm/mach-highbank/highbank.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index db607955a7e4..fe82c3d16ffd 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -141,6 +141,7 @@ static void __init highbank_init(void)
>  	/* Map system registers */
>  	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
>  	sregs_base = of_iomap(np, 0);
> +	of_node_put(np);
>  	WARN_ON(!sregs_base);
>  
>  	pm_power_off = highbank_power_off;

