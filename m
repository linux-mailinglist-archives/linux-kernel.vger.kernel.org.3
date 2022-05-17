Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253F529F71
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiEQKaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344356AbiEQKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:30:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF6B655E;
        Tue, 17 May 2022 03:30:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 56B961F444B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652783403;
        bh=6tf+IhI1uhRk5WMTxebI9p1VB8UGJDHOEKu225QRcYc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hBiIr+B+NnNbKefUddBoyyLBdBdi6BoQ4KEDlkdSyWGaH7Q8dcEVKiHPRzsrDoq8i
         jDP7T3pDLXZKxsYmNxOkdxXCSyxFKMdJYGgE5jWLMQKw9Wk6KzET6ijKuDHxJ3hDVr
         yseRC31x2HDh2EclsIbTxhG1waG9kfrj7rR6mTxzQcBxr4YWJDnn2wdVTV2AhjWXaA
         QWHX0DFKHlm5hiFNPDnU12Pjp57vH3X5OnKOLuE2xNIylCtI3SWZXHTB3tq85qfoNu
         eyswMgj1MJ8kCVaNVWItr1M6nkqhIWveTGyvhp6sVnayI4BswYwsmjhx8kMF4n2mFP
         1finYBnXi7TAw==
Message-ID: <f2564c4e-20f8-e373-8793-c0acaeefc992@collabora.com>
Date:   Tue, 17 May 2022 12:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] memory: mtk-smi: Add support for MT6795 Helio X10
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org, kernel@collabora.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com,
        wendy-st.lin@mediatek.com
References: <20220513150633.387200-1-angelogioacchino.delregno@collabora.com>
 <20220513150633.387200-3-angelogioacchino.delregno@collabora.com>
 <cf2442b9c7124ebf1ce62ae5df597f003fa447d7.camel@mediatek.com>
 <f222e1c5-4ce1-a42d-ceef-a292136d8b61@collabora.com>
 <9f290b2bbdfd4b9d46b81d3ab02c2f50999e95e5.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <9f290b2bbdfd4b9d46b81d3ab02c2f50999e95e5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/22 11:44, Yong Wu ha scritto:
> On Tue, 2022-05-17 at 10:27 +0200, AngeloGioacchino Del Regno wrote:
>> Il 17/05/22 08:37, Yong Wu ha scritto:
>>> On Fri, 2022-05-13 at 17:06 +0200, AngeloGioacchino Del Regno
>>> wrote:
>>>> The MediaTek Helio X10 (MT6795) SoC has 5 LARBs and one common
>>>> SMI
>>>> instance without any sub-common and without GALS.
>>>>
>>>> While the smi-common configuration is specific to this SoC, on
>>>> the
>>>> LARB side, this is similar to MT8173, in the sense that it
>>>> doesn't
>>>> need the port in LARB, and the register layout is also compatible
>>>> with that one, which makes us able to fully reuse the smi-larb
>>>> platform data struct that was introduced for MT8173.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <
>>>> angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    drivers/memory/mtk-smi.c | 17 +++++++++++++++++
>>>>    1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>>>> index 86a3d34f418e..7e7c3ede19e4 100644
>>>> --- a/drivers/memory/mtk-smi.c
>>>> +++ b/drivers/memory/mtk-smi.c
>>>> @@ -21,11 +21,13 @@
>>>>    /* SMI COMMON */
>>>>    #define SMI_L1LEN			0x100
>>>>    
>>>> +#define SMI_L1_ARB			0x200
>>>>    #define SMI_BUS_SEL			0x220
>>>>    #define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
>>>>    /* All are MMU0 defaultly. Only specialize mmu1 here. */
>>>>    #define F_MMU1_LARB(larbid)		(0x1 <<
>>>> SMI_BUS_LARB_SHIFT(larbid))
>>>>    
>>>> +#define SMI_FIFO_TH0			0x230
>>>
>>> Does the name come from the coda you got?
>>> It is called SMI_READ_FIFO_TH in my coda.
>>>
>>
>> Documentation for this SoC is not public and I have no access to it,
>> so
>> everything that you see here comes from reading downstream kernel
>> code :-(
>>
>> I'll change the name to SMI_READ_FIFO_TH as suggested, thanks!
>>
>>>>    #define SMI_M4U_TH			0x234
>>>>    #define SMI_FIFO_TH1			0x238
>>>>    #define SMI_FIFO_TH2			0x23c
>>>> @@ -360,6 +362,7 @@ static const struct of_device_id
>>>> mtk_smi_larb_of_ids[] = {
>>>>    	{.compatible = "mediatek,mt2701-smi-larb", .data =
>>>> &mtk_smi_larb_mt2701},
>>>>    	{.compatible = "mediatek,mt2712-smi-larb", .data =
>>>> &mtk_smi_larb_mt2712},
>>>>    	{.compatible = "mediatek,mt6779-smi-larb", .data =
>>>> &mtk_smi_larb_mt6779},
>>>> +	{.compatible = "mediatek,mt6795-smi-larb", .data =
>>>> &mtk_smi_larb_mt8173},
>>>>    	{.compatible = "mediatek,mt8167-smi-larb", .data =
>>>> &mtk_smi_larb_mt8167},
>>>>    	{.compatible = "mediatek,mt8173-smi-larb", .data =
>>>> &mtk_smi_larb_mt8173},
>>>>    	{.compatible = "mediatek,mt8183-smi-larb", .data =
>>>> &mtk_smi_larb_mt8183},
>>>> @@ -541,6 +544,13 @@ static struct platform_driver
>>>> mtk_smi_larb_driver = {
>>>>    	}
>>>>    };
>>>>    
>>>> +static const struct mtk_smi_reg_pair
>>>> mtk_smi_common_mt6795_init[SMI_COMMON_INIT_REGS_NR] = {
>>>> +	{SMI_L1_ARB, 0x1b},
>>>> +	{SMI_M4U_TH, 0xce810c85},
>>>> +	{SMI_FIFO_TH1, 0x43214c8},
>>>> +	{SMI_FIFO_TH0, 0x191f},
>>>> +};
>>>> +
>>>>    static const struct mtk_smi_reg_pair
>>>> mtk_smi_common_mt8195_init[SMI_COMMON_INIT_REGS_NR] = {
>>>>    	{SMI_L1LEN, 0xb},
>>>>    	{SMI_M4U_TH, 0xe100e10},
>>>> @@ -565,6 +575,12 @@ static const struct mtk_smi_common_plat
>>>> mtk_smi_common_mt6779 = {
>>>>    		    F_MMU1_LARB(5) | F_MMU1_LARB(6) |
>>>> F_MMU1_LARB(7),
>>>>    };
>>>>    
>>>> +static const struct mtk_smi_common_plat mtk_smi_common_mt6795 =
>>>> {
>>>> +	.type	  = MTK_SMI_GEN2,
>>>> +	.bus_sel  = BIT(0),
>>>
>>> Like the other larbs, use F_MMU1_LARB(0) here?
>>>
>>
>> I agree that F_MMU1_LARB(0) == (1 << (0 << 1)) == BIT(0), but that
>> would
>> not be correct and induce other people to mistake, I think?
> 
> F_MMU1_LARB(x) means larbx enter MMU1. this is correct for me.
> 
> OK. Maybe the macro name is not good. About the macro background,
> please see:
> 567e58cf96dd (memory: mtk-smi: Add bus_sel for mt8183)
> 
> If you have better name for this, please tell me:)
> 

I checked that commit. It's not about the macro name... this confusion
would've been avoided if there was a better comment in the code that
explained what was actually going on with that bus selection mechanism.

No worries though, I'll take care of that and will try to write a good
and short explanation for that macro in the code, so that the next
developer trying to do the same will not be induced into such big
misunderstanding of what's going on here.

By the way - now that I know - that bus switching is pretty smart, I
wonder if there's any way to dynamically switch them to eventually save
power by entering some sort of power saving on MMU1 when unused, and/or
achieve better performance in heavy workloads... but I will leave that
improvement idea to you :-)

>> Downstream doesn't do MMU1 bits, but MMU0 in this case... but if you
>> can
>> check on internal documentation and confirm that the downstream
>> kernel's
>> logic is wrong on that - and that you've verified that this should
> 
> I don't know the detailed downstream code, But I find a internal branch
> about this SoC. I see the bus_sel did set to 0x1 as you did here. thus
> I don't think the downstream kernel is wrong. 0x1 means larb0 enter
> MMU1 while the others still enter MMU0. we could use F_MMU1_LARB(0)
> here.
> 

I promised a bigger thank you, so there you go: THANK YOU! :-)

At this point, I definitely agree about using F_MMU1_LARB(0) for MT6795.

Cheers,
Angelo


