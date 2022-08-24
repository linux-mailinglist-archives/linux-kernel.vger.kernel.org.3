Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8AE59F0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiHXBax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiHXBar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:30:47 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 18:30:44 PDT
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net (p3plsmtpa06-01.prod.phx3.secureserver.net [173.201.192.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E51B7A4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:30:44 -0700 (PDT)
Received: from black ([121.35.128.89])
        by :SMTPAUTH: with ESMTPSA
        id QfBxo3UvK8KflQfBzoFS6c; Tue, 23 Aug 2022 18:28:29 -0700
X-CMAE-Analysis: v=2.4 cv=WdvJ12tX c=1 sm=1 tr=0 ts=63057ebd
 a=Ts6IU5S7MsxbcnDc+OdCiQ==:117 a=Ts6IU5S7MsxbcnDc+OdCiQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=_twTT5zqAAAA:8
 a=pGLkceISAAAA:8 a=ATfU8fHJlrvmeOZnxusA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=ILoXdGDbYT3DTB7Z0gVI:22
X-SECURESERVER-ACCT: dhu@hodcarrier.org
Date:   Wed, 24 Aug 2022 09:28:25 +0800
From:   Du Huanpeng <dhu@hodcarrier.org>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        Yang Ling <gnaygnil@gmail.com>, linux-kernel@vger.kernel.org,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RESEND PATCH] clk: ls1c: Fix PLL rate calculation
Message-ID: <20220824012825.GA2956@black>
References: <20220823033414.198525-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823033414.198525-1-seanga2@gmail.com>
X-CMAE-Envelope: MS4xfB7Qh1/JJak2gztQXiYgXTUVMZsO1KSPSanPLPhuJCyRNNIvHZpItw6k8A1HpaGJ2vq9orllLlr7Kh7lh85IQK47meW/+e3/Do+4DgYrkECkZeFgsSD1
 n5SGWQdhCBGejZWA2Uab7HIcjO6kgYAufbUq+JtB95WoogF8GYjxYiRt0TJDV8VS41n12PtIe/QTVoi9nB+vuiG81U4moMcnh/q0AvPuKaxaXg+MKqAqnFPR
 JloMvp8VsjCXD6+9WO0BFKRxOiwqVZfpKjOSYLSMaQxZVTvn6WOC5vZZ10illBB8eeBd99M25IKEqJz7k1qAnHpzy7iDdHsogxEQmCSUNKhmEbgJB/R54ar+
 ABfLLY0/J+neyz1N2ulop7IPzuFk25+EDqLwDBxh3HVcSpPfJj8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 11:34:14PM -0400, Sean Anderson wrote:
Dear Sean,
> While reviewing Dhu's patch adding ls1c300 clock support to U-Boot [1], I
> noticed the following calculation, which is copied from
I didn't copy it from this driver, I read the document and ``try'' to
understand it.
I also write a excel [1] file to calculate values for clock nodes.

[1] https://github.com/hodcarrier/ls1c300_bsp
> drivers/clk/loongson1/clk-loongson1c.c:
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
> 	rate = parent * (256 * M_PLL + FRAC_N) / 256 / 4
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
> index 1ebf740380ef..2aa839b05d6b 100644
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
> 2.37.1
> 
