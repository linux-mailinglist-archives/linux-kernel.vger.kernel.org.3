Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC6F5738F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiGMOeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiGMOeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:34:01 -0400
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC213FAF;
        Wed, 13 Jul 2022 07:33:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07781884|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00565203-0.000234054-0.994114;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=zhouyu@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.ORke3Uw_1657722824;
Received: from 192.168.10.152(mailfrom:zhouyu@wanyeetech.com fp:SMTPD_---.ORke3Uw_1657722824)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 22:33:45 +0800
Subject: Re: [PATCH v4 07/11] ASoC: jz4740-i2s: Make the PLL clock name
 SoC-specific
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-8-aidanmacdonald.0x0@gmail.com>
From:   Zhou Yanjie <zhouyu@wanyeetech.com>
Message-ID: <0269b850-f33a-7aa9-a3eb-83655bd4e19a@wanyeetech.com>
Date:   Wed, 13 Jul 2022 22:33:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20220708160244.21933-8-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

On 2022/7/9 上午12:02, Aidan MacDonald wrote:
> On some Ingenic SoCs, such as the X1000, there is a programmable
> divider used to generate the I2S system clock from a PLL, rather
> than a fixed PLL/2 clock. It doesn't make much sense to call the
> clock "pll half" on those SoCs, so the clock name should really be
> a SoC-dependent value.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>   sound/soc/jz4740/jz4740-i2s.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
> index 0dcc658b3784..a41398c24d0e 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -75,6 +75,8 @@ struct i2s_soc_info {
>   	struct reg_field field_i2sdiv_capture;
>   	struct reg_field field_i2sdiv_playback;
>   
> +	const char *pll_clk_name;
> +
>   	bool shared_fifo_flush;
>   };
>   
> @@ -281,7 +283,7 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>   		clk_set_parent(i2s->clk_i2s, parent);
>   		break;
>   	case JZ4740_I2S_CLKSRC_PLL:
> -		parent = clk_get(NULL, "pll half");
> +		parent = clk_get(NULL, i2s->soc_info->pll_clk_name);
>   		if (IS_ERR(parent))
>   			return PTR_ERR(parent);
>   		clk_set_parent(i2s->clk_i2s, parent);
> @@ -400,6 +402,7 @@ static const struct i2s_soc_info jz4740_i2s_soc_info = {
>   	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
>   	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>   	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.pll_clk_name		= "pll half",
>   	.shared_fifo_flush	= true,
>   };
>   
> @@ -409,6 +412,7 @@ static const struct i2s_soc_info jz4760_i2s_soc_info = {
>   	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>   	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>   	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.pll_clk_name		= "pll half",
>   };


Since JZ4760, according to the description of the I2SCDR register,
Ingenic SoCs no longer use PLL/2 clock, but directly use PLL clock,
so it seems also inappropriate to use "pll half" for these SoCs.


>   
>   static struct snd_soc_dai_driver jz4770_i2s_dai = {
> @@ -435,6 +439,7 @@ static const struct i2s_soc_info jz4770_i2s_soc_info = {
>   	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>   	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>   	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.pll_clk_name		= "pll half",
>   };


Same here.


>   
>   static const struct i2s_soc_info jz4780_i2s_soc_info = {
> @@ -443,6 +448,7 @@ static const struct i2s_soc_info jz4780_i2s_soc_info = {
>   	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>   	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>   	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.pll_clk_name		= "pll half",
>   };
>   


Same here.


Thanks and best regards!


>   static const struct snd_soc_component_driver jz4740_i2s_component = {
