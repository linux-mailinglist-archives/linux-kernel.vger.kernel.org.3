Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B8570CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiGKVkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiGKVkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:40:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F954820CC;
        Mon, 11 Jul 2022 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=MxZLNsEYWmGS2U8Tp+3WU74u0FPSEgIOYWsVk2AnpjQ=; b=GRVeA5E2i4QwxmtSq9juLDjKkV
        di5hUGbDJLbBDHegFiKEPn3+CS+XYLU0SNwrQ86TpCyXRox+wlsVaBL3ONFk3S4yEFmF0an34vFWv
        wYYxHDowijTdLyLgJYZpOdeNPxUxj2npRYwXMjThpznC+mbHMkEb1VslIejlb0H/rqbmAlv3tBDhd
        0gep0ku7RUq/3GsLhFkCFuPggTuHdE0aNG1XoXOwGL0Lc3npYB1sIFUIJZnHUkmRRh3OYoiwB+325
        tXbC7dGIz6CgyHNTveatDi3IxYaSS+rIDCjoDbz9Zajs2iDtPaB+g664Cky4MN1fzuwwwstVD87sQ
        Uryyf5LQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB18C-0050Cq-Nt; Mon, 11 Jul 2022 21:39:52 +0000
Message-ID: <af5f882f-e7f8-ca49-020d-0dab3f2cc145@infradead.org>
Date:   Mon, 11 Jul 2022 14:39:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 5/7] clk: baikal-t1: Move reset-controls code into a
 dedicated module
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220711154433.15415-1-Sergey.Semin@baikalelectronics.ru>
 <20220711154433.15415-6-Sergey.Semin@baikalelectronics.ru>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220711154433.15415-6-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/22 08:44, Serge Semin wrote:
> diff --git a/drivers/clk/baikal-t1/Kconfig b/drivers/clk/baikal-t1/Kconfig
> index 03102f1094bc..56a4ff1d8bf0 100644
> --- a/drivers/clk/baikal-t1/Kconfig
> +++ b/drivers/clk/baikal-t1/Kconfig
> @@ -29,7 +29,6 @@ config CLK_BT1_CCU_PLL
>  
>  config CLK_BT1_CCU_DIV
>  	bool "Baikal-T1 CCU Dividers support"
> -	select RESET_CONTROLLER
>  	select MFD_SYSCON
>  	default MIPS_BAIKAL_T1
>  	help
> @@ -39,4 +38,15 @@ config CLK_BT1_CCU_DIV
>  	  either gateable or ungateable. Some of the CCU dividers can be as well
>  	  used to reset the domains they're supplying clock to.
>  
> +config CLK_BT1_CCU_RST
> +	bool "Baikal-T1 CCU Resets support"
> +	select RESET_CONTROLLER
> +	select MFD_SYSCON
> +	default MIPS_BAIKAL_T1
> +	help
> +	  Enable this to support the CCU reset blocks responsible for the
> +	  AXI-bus and some subsystems reset. These are mainly the
> +	  sef-deasserted reset controls but there are several lines which

	  self-deasserted
?

> +	  can be directly asserted/de-asserted (PCIe and DDR sub-domains).

-- 
~Randy
