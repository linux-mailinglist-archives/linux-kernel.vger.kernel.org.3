Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D5530BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiEWI6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiEWI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:58:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B613E0D3;
        Mon, 23 May 2022 01:58:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 450081F42575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653296330;
        bh=7UgM4ruQTstnqIM046Xou/g3stt98V447+t6kKN3sCU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N9rC/Ny9ej6qs7tbI98vVloYt0/LslMcDJWyfytwwtWbuJaejzOu6yd3Gt1b6ALRm
         QFS6d4Jbz3rk5xnH5/NqW/IyuFCota2t7OOysSaNShon1S5NyjSCD5AqE2Nm9Y++Ek
         vQBno/8lebbuo7ueDf8lq4Vy9XZ1KC9tBSazzSMqikgpS6mgRArJXFBL+Z3kJbzz79
         L+lfQtQVL8gKCzTvNPKR7fhiO4tTAt7zPGPWlgpuYmf2F6f0/z/2sMAm5WMFZps3GF
         +4tHF2/D5RHtc/3kAQ09K/zT8pb2C/32Au6Gf/4JzYh92mSr1Md4me9tMl8X6FHYb8
         7LGpECA+lXTiA==
Message-ID: <926ce818-4f42-898d-aca8-185b5c7434ba@collabora.com>
Date:   Mon, 23 May 2022 10:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] Input: mtk-pmic-keys - Use regmap_{set,clear}_bits
 where possible
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-3-angelogioacchino.delregno@collabora.com>
 <YosS0ZvAovyl8cF5@google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YosS0ZvAovyl8cF5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 06:51, Dmitry Torokhov ha scritto:
> On Fri, May 20, 2022 at 02:51:29PM +0200, AngeloGioacchino Del Regno wrote:
>> Instead of always using regmap_update_bits(), let's go for the shorter
>> regmap_set_bits() and regmap_clear_bits() where possible.
>>
>> No functional change.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/input/keyboard/mtk-pmic-keys.c | 24 ++++++------------------
>>   1 file changed, 6 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
>> index 8e4fa7cd16e6..83d0b90cc8cb 100644
>> --- a/drivers/input/keyboard/mtk-pmic-keys.c
>> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
>> @@ -157,28 +157,16 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
>>   
>>   	switch (long_press_mode) {
>>   	case LP_ONEKEY:
>> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
>> -				   MTK_PMIC_PWRKEY_RST,
>> -				   MTK_PMIC_PWRKEY_RST);
>> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
>> -				   MTK_PMIC_HOMEKEY_RST,
>> -				   0);
>> +		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
>> +		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
> 
> Why not combine this into a single update instead? I.e. assuming
> 

All downstream kernels (at least, I checked 4 different kernel versions for 4
different SoCs) are doing these updates one-at-a-time, never combining them.

Even though I agree with you about one single update being simply more logical,
I am afraid that (on some SoCs) the IP will not like that so - since I don't have
any *clear* documentation saying that this is possible, or that this is not, I
would leave it like that.


> #define MTK_PMIC_KEY_RST_MASK GENMASK(6, 5)
> 
> 		regmap_update_bits(keys->regmap, pmic_rst_reg,
> 				   MTK_PMIC_KEY_RST_MASK,
> 				   MTK_PMIC_PWRKEY_RST);
> 
>>   		break;
>>   	case LP_TWOKEY:
>> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
>> -				   MTK_PMIC_PWRKEY_RST,
>> -				   MTK_PMIC_PWRKEY_RST);
>> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
>> -				   MTK_PMIC_HOMEKEY_RST,
>> -				   MTK_PMIC_HOMEKEY_RST);
>> +		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
>> +		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
> 
> 		regmap_update_bits(keys->regmap, pmic_rst_reg,
> 				   MTK_PMIC_KEY_RST_MASK,
> 				   MTK_PMIC_PWRKEY_RST | MTK_PMIC_HOMEKEY_RST);
> 
>>   		break;
>>   	case LP_DISABLE:
>> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
>> -				   MTK_PMIC_PWRKEY_RST,
>> -				   0);
>> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
>> -				   MTK_PMIC_HOMEKEY_RST,
>> -				   0);
>> +		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
>> +		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
> 
> 		regmap_update_bits(keys->regmap, pmic_rst_reg,
> 				   MTK_PMIC_KEY_RST_MASKi, 0);
> 
>>   		break;
>>   	default:
>>   		break;
>> -- 
>> 2.35.1
>>
> 
> Thanks.
> 



