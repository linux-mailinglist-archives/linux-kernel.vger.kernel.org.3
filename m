Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6656891F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiGFNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiGFNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:14:41 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B21393;
        Wed,  6 Jul 2022 06:14:40 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C9B503EEC4;
        Wed,  6 Jul 2022 15:14:38 +0200 (CEST)
Message-ID: <fa748405-ca38-8ec8-0e8d-83a99a0c9c57@somainline.org>
Date:   Wed, 6 Jul 2022 15:14:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/3] clk: qcom: clk-alpha-pll: add support for APSS PLL
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220705191017.1683716-1-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220705191017.1683716-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 21:10, Robert Marko wrote:
> APSS PLL type will be used by the IPQ8074 APSS driver for providing the
> CPU core clocks and enabling CPU Frequency scaling.
> 
> This is ported from the downstream 5.4 kernel.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 12 ++++++++++++
>  drivers/clk/qcom/clk-alpha-pll.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index 4406cf609aae..8270363ff98e 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -154,6 +154,18 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>  		[PLL_OFF_TEST_CTL_U] = 0x30,
>  		[PLL_OFF_TEST_CTL_U1] = 0x34,
>  	},
> +	[CLK_ALPHA_PLL_TYPE_APSS] = {
The name is surely not correct, can somebody from qcom chime in
and suggest what it should be?

Konrad
> +		[PLL_OFF_L_VAL] = 0x08,
> +		[PLL_OFF_ALPHA_VAL] = 0x10,
> +		[PLL_OFF_ALPHA_VAL_U] = 0xff,
> +		[PLL_OFF_USER_CTL] = 0x18,
> +		[PLL_OFF_USER_CTL_U] = 0xff,
> +		[PLL_OFF_CONFIG_CTL] = 0x20,
> +		[PLL_OFF_CONFIG_CTL_U] = 0x24,
> +		[PLL_OFF_TEST_CTL] = 0x30,
> +		[PLL_OFF_TEST_CTL_U] = 0x34,
> +		[PLL_OFF_STATUS] = 0x28,
> +	},
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>  
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index 6e9907deaf30..626fdf80336d 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -18,6 +18,7 @@ enum {
>  	CLK_ALPHA_PLL_TYPE_AGERA,
>  	CLK_ALPHA_PLL_TYPE_ZONDA,
>  	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
> +	CLK_ALPHA_PLL_TYPE_APSS,
>  	CLK_ALPHA_PLL_TYPE_MAX,
>  };
>  
