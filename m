Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC8573A25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiGMP31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiGMP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:29:26 -0400
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3653A24948;
        Wed, 13 Jul 2022 08:29:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07444607|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00859718-0.000281683-0.991121;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=zhouyu@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.ORmM25F_1657726140;
Received: from 192.168.10.152(mailfrom:zhouyu@wanyeetech.com fp:SMTPD_---.ORmM25F_1657726140)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 23:29:01 +0800
Subject: Re: [PATCH v4 07/11] ASoC: jz4740-i2s: Make the PLL clock name
 SoC-specific
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-8-aidanmacdonald.0x0@gmail.com>
 <0269b850-f33a-7aa9-a3eb-83655bd4e19a@wanyeetech.com>
 <ROSYER.QTJF8J14H2YX1@crapouillou.net>
From:   Zhou Yanjie <zhouyu@wanyeetech.com>
Message-ID: <6f2c7a0b-b68b-fc42-1a82-2b69c114823f@wanyeetech.com>
Date:   Wed, 13 Jul 2022 23:29:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ROSYER.QTJF8J14H2YX1@crapouillou.net>
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

Hi Paul,

On 2022/7/13 下午11:07, Paul Cercueil wrote:
> Hi Zhou,
>
> Le mer., juil. 13 2022 at 22:33:44 +0800, Zhou Yanjie 
> <zhouyu@wanyeetech.com> a écrit :
>> Hi Aidan,
>>
>> On 2022/7/9 上午12:02, Aidan MacDonald wrote:
>>> On some Ingenic SoCs, such as the X1000, there is a programmable
>>> divider used to generate the I2S system clock from a PLL, rather
>>> than a fixed PLL/2 clock. It doesn't make much sense to call the
>>> clock "pll half" on those SoCs, so the clock name should really be
>>> a SoC-dependent value.
>>>
>>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>> ---
>>>   sound/soc/jz4740/jz4740-i2s.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/jz4740/jz4740-i2s.c 
>>> b/sound/soc/jz4740/jz4740-i2s.c
>>> index 0dcc658b3784..a41398c24d0e 100644
>>> --- a/sound/soc/jz4740/jz4740-i2s.c
>>> +++ b/sound/soc/jz4740/jz4740-i2s.c
>>> @@ -75,6 +75,8 @@ struct i2s_soc_info {
>>>       struct reg_field field_i2sdiv_capture;
>>>       struct reg_field field_i2sdiv_playback;
>>>   +    const char *pll_clk_name;
>>> +
>>>       bool shared_fifo_flush;
>>>   };
>>>   @@ -281,7 +283,7 @@ static int jz4740_i2s_set_sysclk(struct 
>>> snd_soc_dai *dai, int clk_id,
>>>           clk_set_parent(i2s->clk_i2s, parent);
>>>           break;
>>>       case JZ4740_I2S_CLKSRC_PLL:
>>> -        parent = clk_get(NULL, "pll half");
>>> +        parent = clk_get(NULL, i2s->soc_info->pll_clk_name);
>>>           if (IS_ERR(parent))
>>>               return PTR_ERR(parent);
>>>           clk_set_parent(i2s->clk_i2s, parent);
>>> @@ -400,6 +402,7 @@ static const struct i2s_soc_info 
>>> jz4740_i2s_soc_info = {
>>>       .field_tx_fifo_thresh    = REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
>>>       .field_i2sdiv_capture    = REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>>       .field_i2sdiv_playback    = REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>> +    .pll_clk_name        = "pll half",
>>>       .shared_fifo_flush    = true,
>>>   };
>>>   @@ -409,6 +412,7 @@ static const struct i2s_soc_info 
>>> jz4760_i2s_soc_info = {
>>>       .field_tx_fifo_thresh    = REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>>>       .field_i2sdiv_capture    = REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>>       .field_i2sdiv_playback    = REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>> +    .pll_clk_name        = "pll half",
>>>   };
>>
>>
>> Since JZ4760, according to the description of the I2SCDR register,
>> Ingenic SoCs no longer use PLL/2 clock, but directly use PLL clock,
>> so it seems also inappropriate to use "pll half" for these SoCs.
>
> The device tree passes the clock as "pll half". So the driver should 
> use this name as well...


I see...

It seems that the device tree of JZ4770 has used "pll half" already,
but there is no "pll half" used anywhere in the device tree of JZ4780,
maybe we can keep the pll_clk_name of JZ4770 as "pll half", and change
the pll_clk_name of JZ4780 to a more reasonable name.


Thanks and best regards!


>
> Cheers,
> -Paul
>
>>>     static struct snd_soc_dai_driver jz4770_i2s_dai = {
>>> @@ -435,6 +439,7 @@ static const struct i2s_soc_info 
>>> jz4770_i2s_soc_info = {
>>>       .field_tx_fifo_thresh    = REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>>>       .field_i2sdiv_capture    = REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>>>       .field_i2sdiv_playback    = REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>> +    .pll_clk_name        = "pll half",
>>>   };
>>
>>
>> Same here.
>>
>>
>>>     static const struct i2s_soc_info jz4780_i2s_soc_info = {
>>> @@ -443,6 +448,7 @@ static const struct i2s_soc_info 
>>> jz4780_i2s_soc_info = {
>>>       .field_tx_fifo_thresh    = REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>>>       .field_i2sdiv_capture    = REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>>>       .field_i2sdiv_playback    = REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>> +    .pll_clk_name        = "pll half",
>>>   };
>>>
>>
>> Same here.
>>
>>
>> Thanks and best regards!
>>
>>
>>>   static const struct snd_soc_component_driver jz4740_i2s_component = {
>
