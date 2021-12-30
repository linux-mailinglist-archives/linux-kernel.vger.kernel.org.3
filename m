Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2987481F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbhL3SKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:10:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58722 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhL3SKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:10:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8739661705;
        Thu, 30 Dec 2021 18:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04439C36AE9;
        Thu, 30 Dec 2021 18:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640887842;
        bh=wl13idcBH22Q98gEtmxIacxmyis+T8ZRvfxttNaeonI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qm0aWo61gjrsc6uZGJHbroRrWXDZG2l+ccokx6g7SL/wTs5B6cBWKsbKI+xFxjmnJ
         F6lBANDMVUaLvBjCSlW5ORtXSYuPXNvj9oLMr2DX/w2OwCFR91mg0xnlXisD/p2Atp
         /kKgschEwantvmMUyPNvDhZ04RR2f4v41Ymp4I4MA9KWx2P6oX0nREMeRv3GbxTk+8
         rjeEeH+RtY6qrU7HrGpL79CFHQ1ivZsjtsByWT7g2VjiwqBzyMIptD8HlLTNUSJCdB
         8j/EA+2YFmgjsULkgR++mtGYnniek6k7to7UMc3CY2kvNNM6qkP6Ni0oV2JqKTAOlB
         7BzUFKIrGhbwA==
Subject: Re: [PATCH] clk: socfpga: remove redundant assignment after a mask
 operation
To:     Colin Ian King <colin.i.king@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20211230150321.167576-1-colin.i.king@gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <7f5f8143-3eae-424f-b857-b57f66c96f65@kernel.org>
Date:   Thu, 30 Dec 2021 12:10:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211230150321.167576-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/21 9:03 AM, Colin Ian King wrote:
> The assignment operation after a & mask operation is redundant, the
> variables being assigned are not used afterwards. Replace the &=
> operator with just & operator.
> 
> Cleans up two clang-scan warnings:
> drivers/clk/socfpga/clk-gate.c:37:10: warning: Although the value stored
> to 'l4_src' is used in the enclosing expression, the value is never
> actually read from 'l4_src' [deadcode.DeadStores]
>                  return l4_src &= 0x1;
>                         ^         ~~~
> drivers/clk/socfpga/clk-gate.c:46:10: warning: Although the value stored
> to 'perpll_src' is used in the enclosing expression, the value is never
> actually read from 'perpll_src' [deadcode.DeadStores]
>                  return perpll_src &= 0x3;
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/clk/socfpga/clk-gate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
> index 1ec9678d8cd3..53d6e3ec4309 100644
> --- a/drivers/clk/socfpga/clk-gate.c
> +++ b/drivers/clk/socfpga/clk-gate.c
> @@ -34,7 +34,7 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
>   
>   	if (streq(name, SOCFPGA_L4_MP_CLK)) {
>   		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
> -		return l4_src &= 0x1;
> +		return l4_src & 0x1;
>   	}
>   	if (streq(name, SOCFPGA_L4_SP_CLK)) {
>   		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
> @@ -43,7 +43,7 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
>   
>   	perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
>   	if (streq(name, SOCFPGA_MMC_CLK))
> -		return perpll_src &= 0x3;
> +		return perpll_src & 0x3;
>   	if (streq(name, SOCFPGA_NAND_CLK) ||
>   	    streq(name, SOCFPGA_NAND_X_CLK))
>   		return (perpll_src >> 2) & 3;
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
