Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2D4DB67F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357548AbiCPQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357506AbiCPQpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:45:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972B2BB16;
        Wed, 16 Mar 2022 09:44:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4CC0D1F444AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647449047;
        bh=h2AMhi8TqdtC1FrQCtRKbyqJVBkVCHEl4n1QG40E9ak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JoaAkE34OfU2o7jvHNCZUjFX1D7VhXDoe4/tSS9ukEzMHKNhcPOVyneAtQggkKWS6
         9ECpaf0M8ChJQQGtcwqv9evt9VGGycdNS1DvPgQTgnvQDGRv1MOgdaHOo/PB/Fv7wy
         odYfUQ5kSkxTTyNGAYw/P6rGEX+7KuN1SFJtWSzDbTgxa8QtExSv22fy/H8a618qXL
         b2hDtG1oy7duRzjJEgFZ0L4cWEfcHSQqos+1PpaweZTYK354PzRYFTkH5AHNE+KKgH
         l7GZ6/8se7+1TFCVueKXocYDrVy6dPr8Jp4/F4vPz04mGgcSwX+yyr7BheuxQDPsJr
         doNMx9ZS7JQ2g==
Message-ID: <8a7be596-531a-52f4-c1b0-ed1d23cfa1bb@collabora.com>
Date:   Wed, 16 Mar 2022 17:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4] remoteproc: mediatek: Fix side effect of mt8195 sram
 power on
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220316031117.7311-1-tinghan.shen@mediatek.com>
 <20220316163451.GA2546942@p14s>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220316163451.GA2546942@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/03/22 17:34, Mathieu Poirier ha scritto:
> Good morning,
> 
> On Wed, Mar 16, 2022 at 11:11:17AM +0800, Tinghan Shen wrote:
>> The definition of L1TCM_SRAM_PDN bits on mt8195 is different to mt8192.
>>
>> L1TCM_SRAM_PDN bits[3:0] control the power of mt8195 L1TCM SRAM.
>>
>> L1TCM_SRAM_PDN bits[7:4] control the access path to EMI for SCP.
>> These bits have to be powered on to allow EMI access for SCP.
>>
>> Bits[7:4] also affect audio DSP because audio DSP and SCP are
>> placed on the same hardware bus. If SCP cannot access EMI, audio DSP is
>> blocked too.
>>
>> L1TCM_SRAM_PDN bits[31:8] are not used.
>>
>> This fix removes modification of bits[7:4] when power on/off mt8195 SCP
>> L1TCM. It's because the modification introduces a short period of time
>> blocking audio DSP to access EMI. This was not a problem until we have
>> to load both SCP module and audio DSP module. audio DSP needs to access
>> EMI because it has source/data on DRAM. Audio DSP will have unexpected
>> behavior when it accesses EMI and the SCP driver blocks the EMI path at
>> the same time.
>>
>> Fixes: 79111df414fc ("remoteproc: mediatek: Support mt8195 scp")
>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>> v4: add Fixes and Reviewed-by tags
>> v3: fix build error
>> v2: apply comments about macro definition and function calls
>> ---
>>   drivers/remoteproc/mtk_common.h |  2 ++
>>   drivers/remoteproc/mtk_scp.c    | 67 +++++++++++++++++++++++++++++++----------
>>   2 files changed, 53 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
>> index 5ff3867c72f3..ff954a06637c 100644
>> --- a/drivers/remoteproc/mtk_common.h
>> +++ b/drivers/remoteproc/mtk_common.h
>> @@ -51,6 +51,8 @@
>>   #define MT8192_CORE0_WDT_IRQ		0x10030
>>   #define MT8192_CORE0_WDT_CFG		0x10034
>>   
>> +#define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
>> +
>>   #define SCP_FW_VER_LEN			32
>>   #define SCP_SHARE_BUFFER_SIZE		288
>>   
>> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
>> index 36e48cf58ed6..5f686fe09203 100644
>> --- a/drivers/remoteproc/mtk_scp.c
>> +++ b/drivers/remoteproc/mtk_scp.c
>> @@ -365,22 +365,22 @@ static int mt8183_scp_before_load(struct mtk_scp *scp)
>>   	return 0;
>>   }
>>   
>> -static void mt8192_power_on_sram(void __iomem *addr)
>> +static void scp_sram_power_on(void __iomem *addr, u32 reserved_mask)
> 
> Why is @reserved_mask needed?  It is not described in the changelong and as far
> as I can see in this patchset the parameter is always set to '0', which has no
> effect on the mask that gets generated.
> 

Hello Mathieu,
the @reserved_mask is explained in perhaps not very very clear terms, meaning
that he's not explicitly saying the name of the new param, but that's it:

"This fix removes modification of bits[7:4] when power on/off mt8195 SCP
L1TCM."

....and it's actually being used, check below....

> Thanks,
> Mathieu
> 
>>   {
>>   	int i;
>>   
>>   	for (i = 31; i >= 0; i--)
>> -		writel(GENMASK(i, 0), addr);
>> +		writel(GENMASK(i, 0) & ~reserved_mask, addr);
>>   	writel(0, addr);
>>   }
>>   
>> -static void mt8192_power_off_sram(void __iomem *addr)
>> +static void scp_sram_power_off(void __iomem *addr, u32 reserved_mask)

...snip...

>> +static int mt8195_scp_before_load(struct mtk_scp *scp)
>> +{
>> +	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
>> +	writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
>> +
>> +	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
>> +
>> +	/* enable SRAM clock */
>> +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
>> +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
>> +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);


>> +	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
>> +			  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);

here				^^^^^^^^^^^^

>> +	scp_sram_power_on(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
>>   
>>   	/* enable MPU for all memory regions */
>>   	writel(0xff, scp->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);

...snip...

>> +
>> +static void mt8195_scp_stop(struct mtk_scp *scp)
>> +{
>> +	/* Disable SRAM clock */
>> +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
>> +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
>> +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
>> +	scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
>> +			   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);

and here 			^^^^^^^^

>> +	scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
>>   

Cheers,
Angelo
