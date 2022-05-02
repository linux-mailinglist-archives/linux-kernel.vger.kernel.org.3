Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6381C516CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383970AbiEBI6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383958AbiEBI6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:58:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0429426132;
        Mon,  2 May 2022 01:55:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8D15D1F4305D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651481701;
        bh=3BW+nxuTRA49LbcdXaeq9ZCmg12LIlVHpHv79umm3nU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jDPcTXu8R4vBjXC9eYZzcXigt/dEgh9fzk8DyL5ipvwVNXD+kb9RvR+nBzl0A1x+1
         n8waVx/o+73r2krzd2TsWxU/5vPWvSFWAGsfOUPeXPuvbBgsJ7CU2hDZDu+E5yMeSF
         ZUKxBlCmoYazE+C9EJWr45b9h7vTlyTO1TkD9zuE93hQWuaCByEnWCExEZ3wS07Sxf
         FejKSb9B1B3bEwUUOijFwtLJ2iMe2xxHSGAkjn/zsemHMihFSA0aYne+VdDuMS2NIe
         v3IzKoMOS6UjYgmLQwJ+N8BA4oh1lf2KYilAKr2usTB4Q9LoAWmrD2O8bVmfvnWyFr
         QdAMettwC+Pig==
Message-ID: <c56464d3-d33d-1797-2c98-67bec34df756@collabora.com>
Date:   Mon, 2 May 2022 10:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 12/16] dt-bindings: reset: mediatek: Add infra_ao reset
 bit for MT8195
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
 <20220428115620.13512-13-rex-bc.chen@mediatek.com>
 <839978c5-c337-7784-a04f-26b9883c703b@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <839978c5-c337-7784-a04f-26b9883c703b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/04/22 23:13, Krzysztof Kozlowski ha scritto:
> On 28/04/2022 13:56, Rex-BC Chen wrote:
>> To support reset of infra_ao, add the bit definitions for MT8195.
>> The infra_ao reset includes 5 banks and 32 bits for each bank.
>>
>> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>> ---
>>   include/dt-bindings/reset/mt8195-resets.h | 170 ++++++++++++++++++++++
>>   1 file changed, 170 insertions(+)
>>
>> diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
>> index a26bccc8b957..463114014483 100644
>> --- a/include/dt-bindings/reset/mt8195-resets.h
>> +++ b/include/dt-bindings/reset/mt8195-resets.h
>> @@ -7,6 +7,7 @@
>>   #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8195
>>   #define _DT_BINDINGS_RESET_CONTROLLER_MT8195
>>   
>> +/* TOPRGU resets */
>>   #define MT8195_TOPRGU_CONN_MCU_SW_RST          0
>>   #define MT8195_TOPRGU_INFRA_GRST_SW_RST        1
>>   #define MT8195_TOPRGU_APU_SW_RST               2
>> @@ -26,4 +27,173 @@
>>   
>>   #define MT8195_TOPRGU_SW_RST_NUM               16
>>   
>> +/* INFRA RST0 */
>> +#define MT8195_INFRA_RST0_THERM_CTRL_SWRST	0
>> +#define MT8195_INFRA_RST0_RSV0			1
>> +#define MT8195_INFRA_RST0_DISP_PWM1_SWRST	2
>> +#define MT8195_INFRA_RST0_RSV1			3
>> +#define MT8195_INFRA_RST0_MSDC3_SWRST		4
>> +#define MT8195_INFRA_RST0_MSDC2_SWRST		5
>> +#define MT8195_INFRA_RST0_MSDC1_SWRST		6
>> +#define MT8195_INFRA_RST0_MSDC0_SWRST		7
>> +#define MT8195_INFRA_RST0_RSV2			8
>> +#define MT8195_INFRA_RST0_AP_DMA_SWRST		9
>> +#define MT8195_INFRA_RST0_MIPI_D_SWRST		10
>> +#define MT8195_INFRA_RST0_RSV3			11
>> +#define MT8195_INFRA_RST0_RSV4			12
>> +#define MT8195_INFRA_RST0_SSUSB_TOP_SWRST	13
>> +#define MT8195_INFRA_RST0_DISP_PWM_SWRST	14
>> +#define MT8195_INFRA_RST0_AUXADC_SWRST		15
>> +#define MT8195_INFRA_RST0_RSV5			16
>> +#define MT8195_INFRA_RST0_RSV6			17
>> +#define MT8195_INFRA_RST0_RSV7			18
>> +#define MT8195_INFRA_RST0_RSV8			19
>> +#define MT8195_INFRA_RST0_RSV9			20
>> +#define MT8195_INFRA_RST0_RSV10			21
>> +#define MT8195_INFRA_RST0_RSV11			22
>> +#define MT8195_INFRA_RST0_RSV12			23
>> +#define MT8195_INFRA_RST0_RSV13			24
>> +#define MT8195_INFRA_RST0_RSV14			25
>> +#define MT8195_INFRA_RST0_RSV15			26
>> +#define MT8195_INFRA_RST0_RSV16			27
>> +#define MT8195_INFRA_RST0_RSV17			28
>> +#define MT8195_INFRA_RST0_RSV18			29
>> +#define MT8195_INFRA_RST0_RSV19			30
>> +#define MT8195_INFRA_RST0_RSV20			31
> 
> These are not proper IDs... don't work-around usage of bits with fake
> reserved IDs...

Hello Krzysztof,

Actually, I get that it may seem that Rex is trying to cheat with fake
reserved numbers... but it's really how the registers are laid out: there
really are reserved bits in between used reset bits.

I don't think that the reserved bits are doing anything though, so the
best way to proceed is to just remove them and map the dt-bindings IDs to
the HW register's bits in the driver instead.
Even though the current approach is very simplistic, I agree that this is
not how it's supposed to be done (and I'm sort-of sad about that).

Rex, please map these values in the reset driver so that, in this header,
you'll get something like:

#define MT8195_INFRA_RST0_THERM_CTRL_SWRST	0
#define MT8195_INFRA_RST0_DISP_PWM1_SWRST	1
#define MT8195_INFRA_RST0_MSDC3_SWRST		2
#define .... (etc)

Cheers,
Angelo

> 
> Best regards,
> Krzysztof

