Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB15093A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380312AbiDTXfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiDTXfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:35:42 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 16:32:54 PDT
Received: from p3plsmtpa11-10.prod.phx3.secureserver.net (p3plsmtpa11-10.prod.phx3.secureserver.net [68.178.252.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B35B2FFEC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:32:54 -0700 (PDT)
Received: from black ([209.234.248.132])
        by :SMTPAUTH: with ESMTPSA
        id hJmNn85L8pmFVhJmPn5OZs; Wed, 20 Apr 2022 16:30:39 -0700
X-CMAE-Analysis: v=2.4 cv=f82NuM+M c=1 sm=1 tr=0 ts=6260979f
 a=QYjdx1n8fnJJ/8JFsBbjTg==:117 a=QYjdx1n8fnJJ/8JFsBbjTg==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=_twTT5zqAAAA:8
 a=pGLkceISAAAA:8 a=VrlHBnlMTWxngOB4VMsA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=ILoXdGDbYT3DTB7Z0gVI:22
X-SECURESERVER-ACCT: dhu@hodcarrier.org
Date:   Thu, 21 Apr 2022 07:30:34 +0800
From:   Du Huanpeng <dhu@hodcarrier.org>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yang Ling <gnaygnil@gmail.com>
Subject: Re: [RFT PATCH] clk: ls1c: Fix PLL rate calculation
Message-ID: <20220420233034.GA5694@black>
References: <20220419051114.1569291-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220419051114.1569291-1-seanga2@gmail.com>
X-CMAE-Envelope: MS4xfPEYo7+TzSzfoE9wr4Xt4tpOgDEJytkfrpg2EqyGeYHbHaYWP6bKmr5LO4CKiw1emz9MS9a9tONXOH3zWVOOolpKx9DPH65StwNnh8Rboe7/Jnfq0SSO
 2SobRlNcKtY82aUuVQD41sNEEIATrrPb1Xk17EJfGQzc++4JjxLGe9009S0nXdWcsDB+23TZJwf43bA2zglMg9irWhYhiuZXQHerNQ9yf+c7oVPob8sIUnZ4
 bEILzOcC1rLn1hbO8mt5sV/dKh8E1wjOm8UgWsyNiMf6/SGPAT7C9x9xmq4ombpsd8kJ6Y0lKnU2id+n9dTkifRR/coD1neFSW1LttSoO9cwZW1zsMx9QNbE
 XwqyhtPJBHnB6vlDaxZElhYb7t8Y3VL1sJjKm9NdAcSWJOjEQuM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 01:11:14AM -0400, Sean Anderson wrote:
> While reviewing Dhu's patch adding ls1c300 clock support to U-Boot [1], I
> noticed the following calculation, which is copied from
> drivers/clk/loongson1/clk-loongson1c.c:
Hi, the calculate method is based on Loongson's manual(龙芯 1C300
处理器用户手册 1.4)in page 35.
| 注： PLL 的分频系数 N 固定为 4， PLL 的频率计算公式如下：
| Freq_PLL = XIN *(M_PLL + FRAC_N)/4

I aslo made a tool to set pll rate and generate asm code at the same
time, I also put the formulae from the manual in code:

the tool:
[1]. https://github.com/hodcarrier/ls1c300_bsp/blob/master/clk-ls1c300.xlsx

lowlevel_init.S:
[2]. https://github.com/hodcarrier/u-boot/blob/lsmips/ls1c300b/arch/mips/mach-lsmips/ls1c300/lowlevel_init.S#L48
|/* Document:
| * Freq_PLL = XIN *(M_PLL + FRAC_N)/4
| */

The my v1 patch was using magic number for initialize pll, because I
use this tool to generate the code.

Set FRAC_N to 0, the pll can be adjust by step 6MHz. I noticed this
issues, you can see I always set the FRAC_N to 0 in the tool[1].
this will lost some pricise, but avoid to do the adventure...

> 
> ulong ls1c300_pll_get_rate(struct clk *clk)
> {
> 	unsigned int mult;
> 	long long parent_rate;
> 	void *base;
> 	unsigned int val;
> 
> 	parent_rate = clk_get_parent_rate(clk);
> 	base = (void *)clk->data;
> 
> 	val = readl(base + START_FREQ);
> 	mult = FIELD_GET(FRAC_N, val) + FIELD_GET(M_PLL, val);
> 	return (mult * parent_rate) / 4;
> }
> 
> I would like to examine the use of M_PLL and FRAC_N to calculate the multiplier
> for the PLL. The datasheet has the following to say:
> 
> START_FREQ 位    缺省值      描述
> ========== ===== =========== ====================================
> FRAC_N     23:16 0           PLL 倍频系数的小数部分
> 
>                  由          PLL 倍频系数的整数部分
> M_PLL      15:8  NAND_D[3:0] (理论可以达到 255，建议不要超过 100)
>                  配置
> 
> which according to google translate means
> 
> START_FREQ Bits  Default       Description
> ========== ===== ============= ================================================
> FRAC_N     23:16 0             Fractional part of the PLL multiplication factor
> 
>                  Depends on    Integer part of PLL multiplication factor
> M_PLL      15:8  NAND_D[3:0]   (Theoretically it can reach 255, [but] it is
>                  configuration  recommended not to exceed 100)
> 
> So just based on this description, I would expect that the formula to be
> something like
> 
> 	rate = parent * (255 * M_PLL + FRAC_N) / 255 / 4
> 
> However, the datasheet also gives the following formula:
> 
> 	rate = parent * (M_PLL + FRAC_N) / 4
> 
> which is what the Linux driver has implemented. I find this very unusual.
> First, the datasheet specifically says that these fields are the integer and
> fractional parts of the multiplier. Second, I think such a construct does not
> easily map to traditional PLL building blocks. Implementing this formula in
> hardware would likely require an adder, just to then set the threshold of a
> clock divider.
> 
> I think it is much more likely that the first formula is correct. The author of
> the datasheet may think of a multiplier of (say) 3.14 as
> 
> 	M_PLL = 3
> 	FRAC_N = 0.14
> 
> which together sum to the correct multiplier, even though the actual value
> stored in FRAC_N would be 36.
> 
> I suspect that this has slipped by unnoticed because when FRAC_N is 0, there is
> no difference in the formulae. The following patch is untested, but I suspect
> it will fix this issue. I would appreciate if anyone with access to the
> hardware could measure the output of the PLL (or one of its derived clocks) and
> determine the correct formula.
> 
> [1] https://lore.kernel.org/u-boot/20220418204519.19991-1-dhu@hodcarrier.org/T/#u
> 
> Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
>  drivers/clk/loongson1/clk-loongson1c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
> index 703f87622cf5..2b98a116c1ea 100644
> --- a/drivers/clk/loongson1/clk-loongson1c.c
> +++ b/drivers/clk/loongson1/clk-loongson1c.c
> @@ -21,9 +21,9 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
>  	u32 pll, rate;
>  
>  	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
> -	rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
> +	rate = (pll & 0xff00) + ((pll >> 16) & 0xff);
>  	rate *= OSC;
> -	rate >>= 2;
> +	rate >>= 10;
>  
>  	return rate;
>  }
> -- 
> 2.35.1
> 
