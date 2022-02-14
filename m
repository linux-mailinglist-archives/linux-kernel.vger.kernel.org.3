Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168114B4F68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346842AbiBNLwa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:52:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiBNLwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:52:25 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD44C34;
        Mon, 14 Feb 2022 03:52:17 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:52:07 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000
 SoC
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <VAMA7R.PG2P5IFR07772@crapouillou.net>
In-Reply-To: <20220212150927.39513-2-aidanmacdonald.0x0@gmail.com>
References: <20220212150927.39513-1-aidanmacdonald.0x0@gmail.com>
        <20220212150927.39513-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le sam., févr. 12 2022 at 15:09:28 +0000, Aidan MacDonald 
<aidanmacdonald.0x0@gmail.com> a écrit :
> The X1000 does have a TCU clock gate, so pass it to the driver.
> Without this the TCU can be gated automatically, which prevents
> timers from running.
> 
> Fixes: dc6a81c3382f74fe ("clk: Ingenic: Add support for TCU of 
> X1000.")
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> I've just realized, maybe this is an ABI break. Now that the TCU 
> clock is
> required, the driver probe will fail if given an old device tree 
> which is
> missing that clock. Is it necessary to add a hack of some sort to 
> support
> the old device tree?

Yes, that's a valid concern. The driver should then support the TCU 
clock being missing (but only for the x1000), with a comment that 
explain why the workaround exists.

You can use of_clk_get_by_name(), and if you get -EINVAL and the 
workaround flag is set, allow the driver to continue. Also change the 
checks for (tcu->soc_info->has_tcu_clk) in the function's cleanup to 
checks for (tcu->clk) so that the clk_disable_unprepare/clk_put are 
only done on a valid pointer.

Note that the x1830 also has a TCU clock that's not specified in the 
device tree; so you could add a patch similar to your current [1/2] 
that adds it to x1830.dtsi as well. It uses the "ingenic,x1000-tcu" 
string as fallback, so the driver wouldn't have to be modified further.

Cheers,
-Paul

> 
>  drivers/clk/ingenic/tcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
> index 77acfbeb4830..9c86043f673a 100644
> --- a/drivers/clk/ingenic/tcu.c
> +++ b/drivers/clk/ingenic/tcu.c
> @@ -320,7 +320,7 @@ static const struct ingenic_soc_info 
> jz4770_soc_info = {
>  static const struct ingenic_soc_info x1000_soc_info = {
>  	.num_channels = 8,
>  	.has_ost = false, /* X1000 has OST, but it not belong TCU */
> -	.has_tcu_clk = false,
> +	.has_tcu_clk = true,
>  };
> 
>  static const struct of_device_id __maybe_unused 
> ingenic_tcu_of_match[] __initconst = {
> --
> 2.34.1
> 


