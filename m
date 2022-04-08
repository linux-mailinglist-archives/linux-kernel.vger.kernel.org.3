Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773AC4F934D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiDHKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiDHKtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:49:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8D12F8FEE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8EE161F09
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31603C385A1;
        Fri,  8 Apr 2022 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649414866;
        bh=vBQnm40TlruffgZ0FkFkFQiFjmj1QTzKebBa5p5lGDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBc7cW1mDB2GSilE/AeCOrQkDD8LOEXSayvXjKPv+3hTg5sPJTRn77tt7+m9wV3o/
         6OVt79xXXGKq5fJhdZoTevyrp7dQE7/He6Jc3urZQGYLMogfg6Sw8Yn8yajidngRtD
         ELtQUouJtKpukFr9qXO/bMdjAe5PXrkXMIFqiOUfV/u8c5JpSllPIfCoiMJiC2gs7w
         K2002zVNHJi8nv03CrgbZSgUYyI4Y9+Xh+uNUNhAXMk7Sp0RFBbab2ySOTfFccbLvl
         6I7BekEmk5Fr+BHguldC2lKTtjar00+CfFhIHh5LRzMIQ3atDFCH235nidP94IQ3CO
         YsRLjFiok52Cw==
Date:   Fri, 8 Apr 2022 11:47:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Frank Li <Frank.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/11] perf/imx_ddr: Fix undefined behavior due to shift
 overflowing the constant
Message-ID: <20220408104739.GA27564@willie-the-truck>
References: <20220405151517.29753-1-bp@alien8.de>
 <20220405151517.29753-10-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405151517.29753-10-bp@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 05:15:15PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Fix:
> 
>   In file included from <command-line>:0:0:
>   In function ‘ddr_perf_counter_enable’,
>       inlined from ‘ddr_perf_irq_handler’ at drivers/perf/fsl_imx8_ddr_perf.c:651:2:
>   ././include/linux/compiler_types.h:352:38: error: call to ‘__compiletime_assert_729’ \
> 	declared with attribute error: FIELD_PREP: mask is not constant
>     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> ...
> 
> See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
> details as to why it triggers with older gccs only.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Frank Li <Frank.li@nxp.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/perf/fsl_imx8_ddr_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> index 94ebc1ecace7..b1b2a55de77f 100644
> --- a/drivers/perf/fsl_imx8_ddr_perf.c
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -29,7 +29,7 @@
>  #define CNTL_OVER_MASK		0xFFFFFFFE
>  
>  #define CNTL_CSV_SHIFT		24
> -#define CNTL_CSV_MASK		(0xFF << CNTL_CSV_SHIFT)
> +#define CNTL_CSV_MASK		(0xFFU << CNTL_CSV_SHIFT)

Acked-by: Will Deacon <will@kernel.org>

(let me know if you'd prefer for me to queue this directly)

Will
