Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D6256895C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiGFN07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiGFN05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:26:57 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD61CB10;
        Wed,  6 Jul 2022 06:26:56 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 33D5C3F767;
        Wed,  6 Jul 2022 15:26:54 +0200 (CEST)
Message-ID: <92d41b82-97ab-723d-4191-1fcaca17fb76@somainline.org>
Date:   Wed, 6 Jul 2022 15:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/5] clk: qcom: clk-rpm: convert to parent_data API
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-4-ansuelsmth@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220705202837.667-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 22:28, Christian Marangi wrote:
> Convert clk-rpm driver to parent_data API and change parent names to cxo
> and pxo instead of the board variant as pxo_board is an ancient name and
> pxo should be used instead.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/clk-rpm.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
> index a18811c38018..d45a8b0fc97c 100644
> --- a/drivers/clk/qcom/clk-rpm.c
> +++ b/drivers/clk/qcom/clk-rpm.c
> @@ -23,6 +23,14 @@
>  #define QCOM_RPM_SCALING_ENABLE_ID			0x2
>  #define QCOM_RPM_XO_MODE_ON				0x2
>  
> +static const struct clk_parent_data gcc_pxo[] = {
> +	{ .fw_name = "pxo", .name = "pxo" },
The .name lookup should include _board, as the old DTs expect that.
If I understand correctly though, you need to preserve both pxo and
pxo_board, as they were separate, not sure though..

Konrad
> +};
> +
> +static const struct clk_parent_data gcc_cxo[] = {
> +	{ .fw_name = "cxo", .name = "cxo" },
> +};
> +
>  #define DEFINE_CLK_RPM(_platform, _name, _active, r_id)			      \
>  	static struct clk_rpm _platform##_##_active;			      \
>  	static struct clk_rpm _platform##_##_name = {			      \
> @@ -32,8 +40,8 @@
>  		.hw.init = &(struct clk_init_data){			      \
>  			.ops = &clk_rpm_ops,				      \
>  			.name = #_name,					      \
> -			.parent_names = (const char *[]){ "pxo_board" },      \
> -			.num_parents = 1,				      \
> +			.parent_data = gcc_pxo,				      \
> +			.num_parents = ARRAY_SIZE(gcc_pxo),		      \
>  		},							      \
>  	};								      \
>  	static struct clk_rpm _platform##_##_active = {			      \
> @@ -44,8 +52,8 @@
>  		.hw.init = &(struct clk_init_data){			      \
>  			.ops = &clk_rpm_ops,				      \
>  			.name = #_active,				      \
> -			.parent_names = (const char *[]){ "pxo_board" },      \
> -			.num_parents = 1,				      \
> +			.parent_data = gcc_pxo,				      \
> +			.num_parents = ARRAY_SIZE(gcc_pxo),		      \
>  		},							      \
>  	}
>  
> @@ -56,8 +64,8 @@
>  		.hw.init = &(struct clk_init_data){			      \
>  			.ops = &clk_rpm_xo_ops,			      \
>  			.name = #_name,					      \
> -			.parent_names = (const char *[]){ "cxo_board" },      \
> -			.num_parents = 1,				      \
> +			.parent_data = gcc_cxo,				      \
> +			.num_parents = ARRAY_SIZE(gcc_cxo),		      \
>  		},							      \
>  	}
>  
> @@ -68,8 +76,8 @@
>  		.hw.init = &(struct clk_init_data){			      \
>  			.ops = &clk_rpm_fixed_ops,			      \
>  			.name = #_name,					      \
> -			.parent_names = (const char *[]){ "pxo" },	      \
> -			.num_parents = 1,				      \
> +			.parent_data = gcc_pxo,				      \
> +			.num_parents = ARRAY_SIZE(gcc_pxo),		      \
>  		},							      \
>  	}
>  
