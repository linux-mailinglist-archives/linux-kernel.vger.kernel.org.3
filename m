Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66F6574B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbiGNLFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbiGNLE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:04:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB1E300;
        Thu, 14 Jul 2022 04:04:54 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D93C6601A3B;
        Thu, 14 Jul 2022 12:04:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657796692;
        bh=fDnSmz7ATZ9eZAfZWM2eRcCrYCUPAHzXG+z/TTvHfdk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JupW8+3MR/peFQltkKEv/eaiFhUg++x7z/GRiSkA6bN6G06//wWu4+anYAjSj3FfK
         DnOMPAQUJdsafhg5T6Rrg1hp29Qj7KJah2afy+f+6SLZJTFoVLbm9RhU56kuT9e2A1
         PqQ7a3btUVMrBh65uzAHyaVesRyODQpNFE+zIi96DfXpLmsPQlojtJJsINz7v5ofOI
         qpaave4tETAmUqijtoVfGyx3LsvIbnuWUDurTMn7dgGVFtCagnYcgcwkyVLLarIEt6
         X5BTpXOax0kslLIib6SLdtKvYIqPMlKb30Gle7tj/NSGIVITrog/tHnAvX2R85X7Uv
         mRchlu8wOAhog==
Message-ID: <a1d36cba-a58a-326a-70dc-3578f183a249@collabora.com>
Date:   Thu, 14 Jul 2022 13:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 2/2] clk: mediatek: Add frequency hopping support
Content-Language: en-US
To:     Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?UTF-8?B?WXUtQ2hhbmcgV2FuZyAo546L54Wc5qifKQ==?= 
        <Yu-Chang.Wang@mediatek.com>,
        =?UTF-8?B?S3Vhbi1Ic2luIExlZSAo5p2O5Yag5pawKQ==?= 
        <Kuan-Hsin.Lee@mediatek.com>
References: <20220612135414.3003-1-johnson.wang@mediatek.com>
 <20220612135414.3003-3-johnson.wang@mediatek.com>
 <ca4b9a0e-b1ca-6861-e4c0-30a8c8a5c99c@collabora.com>
 <9addc9fb0c949e921f915fcf128783393214bfde.camel@mediatek.com>
 <30e07350-ff56-a361-121e-3cb3a27643a1@collabora.com>
 <CAGXv+5F3YK51eL60-SD6pfW90xSZYoVvLXvbQ1oq+8zQmfkKwA@mail.gmail.com>
 <946e6d8fd14151277f00521e1373057a403021b0.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <946e6d8fd14151277f00521e1373057a403021b0.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/22 15:07, Edward-JW Yang ha scritto:
> On Wed, 2022-06-29 at 16:54 +0800, Chen-Yu Tsai wrote:
>> On Tue, Jun 28, 2022 at 6:09 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Il 24/06/22 09:12, Edward-JW Yang ha scritto:
>>>> Hi AngeloGioacchino,
>>>>
>>>> Thanks for all the advices.
>>>>
>>>> On Mon, 2022-06-13 at 17:43 +0800, AngeloGioacchino Del Regno wrote:
>>>>> Il 12/06/22 15:54, Johnson Wang ha scritto:
>>>>>> Add frequency hopping support and spread spectrum clocking
>>>>>> control for MT8186.
>>>>>>
>>>>>> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
>>>>>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>>>>>
>>>>> Before going on with the review, there's one important consideration:
>>>>> the Frequency Hopping control is related to PLLs only (so, no other clock
>>>>> types get in the mix).
>>>>>
>>>>> Checking the code, the *main* thing that we do here is initializing the
>>>>> FHCTL by setting some registers, and we're performing the actual frequency
>>>>> hopping operation in clk-pll, which is right but, at this point, I think
>>>>> that the best way to proceed is to add the "FHCTL superpowers" to clk-pll
>>>>> itself, instead of adding multiple new files and devicetree bindings that
>>>>> are specific to the FHCTL itself.
>>>>>
>>>>> This would mean that the `fh-id` and `perms` params that you're setting in
>>>>> the devicetree get transferred to clk-mt8186 (and hardcoded there), as to
>>>>> extend the PLL declarations to include these two: that will also simplify
>>>>> the driver so that you won't have to match names here and there.
>>>>>
>>>>> Just an example:
>>>>>
>>>>>       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0224, 0x0230, 0,
>>>>>
>>>>>           PLL_AO, 0, 22, 0x0228, 24, 0, 0, 0, 0x0228, 2, FHCTL_PERM_DBG_DUMP),
>>>>>
>>>>> Besides, there are another couple of reasons why you should do that instead,
>>>>> of which:
>>>>>     - The devicetree should be "generic enough", we shall not see the direct value
>>>>>       to write to the registers in there (yet, perms assigns exactly that)
>>>>>     - These values won't change on a per-device basis, I believe? They're SoC-related,
>>>>>       not board-related, right?
>>>>>
>>>>> In case they're board related (and/or related to TZ permissions), we can always add
>>>>> a bool property to the apmixedsys to advertise that board X needs to use an
>>>>> alternative permission (ex.: `mediatek,secure-fhctl`).
>>>>
>>>> I think we should remain clk-fhctl files because FHCTL is a independent HW and is
>>>> not a necessary component of clk-pll.
>>>
>>> I know what FHCTL is, but thank you anyway for the explanation, that's appreciated.
>>> In any case, this not being a *mandatory* component doesn't mean that when it is
>>> enabled it's not changing the way we manage the PLLs..........
>>>
>>>> Frequency hopping function from FHCTL is not used to replace original flow of
>>>> set_rate in clk-pll. They are two different ways to change PLL's frequency. The
>>>
>>> I disagree: when we want to use FHCTL, we effectively hand-over PLL control from
>>> APMIXEDSYS to the Frequency Hopping controller - and we're effectively replacing
>>> the set_rate() logic of clk-pll.
> 
> Do you mean we need to drop the current set_rate() logic (direct register write) and
> use Frequency Hopping Controller instead?
> 

On PLLs that are supported by the Frequency Hopping controller, yes: we should
simply use a different .set_rate() callback in clk-pll.c, and we should return
a failure if the FHCTL fails to set the rate - so we should *not* fall back to
direct register writes, as on some platforms and in some conditions, using
direct register writes (which means that we skip FHCTL), may lead to unstable
system.

This means that we need logic such that, in mtk_clk_register_pll(), we end up
having something like that:

if (fhctl_is_enabled(pll))
	init.ops = &mtk_pll_fhctl_ops;
else
	init.ops = &mtk_pll_ops;

> I need to mention that not all PLL support FHCTL, only those PLLs with FHCTL HW can
> choose to use FHCTL. Take 8186 for example, there are three PLLs don't support FHCTL
> HW.

Where we declare the PLLs, for example, in clk-mt8186-apmixedsys.c, we can declare
that such PLL can be managed by FHCTL, for example:

	PLL(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0204, 0x0210, 0,

	    PLL_AO, 0, 22, 0x0208, 24, 0, 0, 0, 0x0208),

becomes

	PLL(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0204, 0x0210, 0,

	    PLL_AO, 0, 22, 0x0208, 24, 0, 0, 0, 0x0208, true);

where 'true' means "FHCTL is supported".

Then, we register the PLLs with something like:

mtk_clk_register_plls(node, plls, num_plls, clk_data, fhctl_register_version);

...where fhctl_register_version is used to assign the right fhctl register offsets.
Also, it's not needed to assign all of the register offsets statically, because
they can be easily calculated based on the number of supported PLLs, since the
registers are structured like

[FHCTL GLOBAL REGISTERS] <--- hp_en...slope1
[FHCTL SSC GLOBAL REGISTERS] <--- DSSC_CFG, DSSC0...x_CON

[FHCTL PER-PLL REGISTERS] <--- CFG...MON
^^^ where this is repeated X times for X PLLs.

so, keeping the example of MT8186, we can get the per-pll register like:

#define FHCTL_PLL_OFFSET	0x3c
#define FHCTL_PLL_LEN		0x14

#define FHCTLx_CFG(pll_id)	(FHCTL_PLL_OFFSET + (pll_id * FHCTL_PLL_LEN))
#define FHCTLx_UPDNLMT(pll_id)	(FHCTL_PLL_OFFSET + (pll_id * FHCTL_PLL_LEN) + 0x4)
#define FHCTLx_DDS(pll_id)	(FHCTL_PLL_OFFSET + (pll_id * FHCTL_PLL_LEN) + 0x8)

we don't need to put all of them in a structure and for each PLL.

> So, we need both APMIXEDSYS and Frequency Hopping Controller in set_rate() logic to
> handle this two types of PLL.
> 

As already said, we preventively know which PLLs support FHCTL and which does not,
so we can use a different .set_rate() callback.

>>>
>>>> current set_rate method in clk-pll changes PLL register setting directly. Another
>>>> way uses FHCTL to change PLL rate.
>>>
>>> ...and of course, if we change that, we're effectively mutating the functionality
>>> of the MediaTek clk-pll driver and please understand that seeing a clear mutation
>>> in that driver is a bit more human-readable.
>>>
>>> Besides, this makes me think about one question: is there any instance in which,
>>> when FHCTL rate setting fails, we fall back to direct register writes?
>>>
>>> I don't think that this is feasible because we have a register in FHCTL that
>>> effectively hands over control to it, so direct register writes should not work
>>> when the PLL is not under APMIXEDSYS control, but I'm asking just to be extremely
>>> sure that my understanding is right.
> 
> It won't fall back to direct register writes when FHCTL rate setting fails. But, PLL
> control mode will switch back to APMIXEDSYS after frequency hopping completed.
> 
> There are two cases that we need to fall back to direct register writes:
>    1. PLL support FHCTL but it doesn't want to use FHCTL.
>    2. PLL doesn't support FHCTL HW.
> 

For case N.1, if this is board-specific, we have to resort to devicetree properties
that will enable/disable FHCTL on specific PLLs.

mediatek,fhctl-disable = <CLK_APMIXED_MSDCPLL>, <CLK_APMIXED_NNAPLL>;

mediatek,ssc-enable = <CLK_APMIXED_MFGPLL>, <CLK_APMIXED_TVDPLL>;

These are just examples - I don't currently know if it's a better idea to have an
allowlist or a blocklist as devicetree properties, as that depends on the expected
number of PLLs for which we en/dis fhctl or just ssc (if we generally want fhctl
enabled on all but one PLLs, we should use fhctl-disable, otherwise, fhctl-enable).

>>>
>>>> We will set some PLL's frequency be controlled
>>>> by clk-pll and some are controlled by FHCTL.
>>>
>>> Another question: is this also changing on a per-board basis?
>>>
>>> (note: the pll names in the example are random and not specific to anything)
>>>
>>> Example: board A wants FHCTL on MMPLL, TVDPLL, MPLL, but *shall not* hand over
>>>                    NNAPLL, MFGPLL
>>>            board B wants FHCTL on NNAPLL, TVDPLL but *shall not* hand over MMPLL
>>>
>>> Granted that the two A, B boards are using the same SoC, can that ever happen?
> 
> This could happen if A, B boards have different desense issue.
> 

Ok, so it's definitely board specific. Devicetree is the way to go for this.

>>>
>>>> And use `perms` param to decide
>>>> whether a PLL is using FHCTL to change its frequency.
>>>
>>> The perms param seems to be about:
>>>    * Enabling debug (but you're not providing any way to actually use debugging
>>>      features, so what's the point?)
> 
> Debugging feature is not used yet, we can removed it.
> 

If the debugging features of the FHCTL driver will be like what I can see on
the downstream MT6893 5.10 kernel, that's not really applicable to upstream.

In that case, please remove the debug.

>>>    * Handing over PLL control to FHCTL for hopping (can be as well done with
>>>      simply using a different .set_rate() callback instead of a flag)
> 
> There has some PLL that have FHCTL but don't want to use FHCTL. The flag is used in
> this case.
> 

Use the flag to set the right .set_rate() callback, set at probe time, instead of
checking that flag at every set_rate() call.

>>>    * Enabling/disabling Spread Spectrum Clocking (and I think that this is a
>>>      legit use for flags, but if it's just one flag, you can as well use a
>>>      bool and manage this with a devicetree param like "enable-ssc")
>>>
>>> That said, I think that the current way of enabling the FHCTL is more complicated
>>> than how it should really be.
> 
> Here needs an option to decide whether to enable FHCTL-hopping or FHCTL-ssc since
> these two are per-board basis.
> 
> We cannot force all PLL hand over to FHCTL for hopping casue not all PLLs support
> FHCTL and not all PLLs have need of using FHCTL-hopping.
> 

Board specific -> devicetree

SoC specific -> hardcode, no devicetree.

>>>
>>>>
>>>> FHCTL has another function called SSC(spread spectrum clocking) which is used to
>>>> solve PLL de-sense problem. De-sense problem is board-related so we introduce a
>>>> `ssc-rate` param in the devicetree to decide whether SSC is enabled and how many
>>>> rate should be set. Mixing SSC function into clk-pll may cause clk-pll more
>>>> complex.
>>>>
>>>
>>> Thing is, I don't get why you think that adding SSC to clk-pll would complicate it
>>> so much... it's really just a few register writes and nothing else, so I really
>>> don't see where the problem is, here.
>>>
>>> Another issue is that this driver may be largely incomplete, so perhaps I can't
>>> really see the complications you're talking about? Is this the case?
>>>
>>> Regarding keeping the FHCTL code in separated files, that's fine, but I would still
>>> integrate it tightly in clk-pll and its registration flow, because - yes, this is
>>> for sure not mandatory, but the main parameters are constant, they never change for
>>> a specific PLL, as they're register offsets, bits and masks (which, again, will
>>> never change as long as we're using the same SoC).
> 
> The driver may need to supoport microP by future HW design, standalone file clk-
> fhctl.c helps to trigger init flow of such as ap-init-flow, microP-init-flow .....,
> and those different init-flow also need to run some communication API with microP.
> Those communication APIs are not suitable to merge into clk-pll.
> 

Let's use clk-fhctl as an helper then, we can make sure to call the init flow for
the microP in the SoC-specific clock drivers, I think that's not a problem?

clk_mtfuturesoc_someip_probe()
{
	.... register clocks ....

	freqhopping_microp_init();

	return ret;
}

If there's hardware out there that supports such feature and a downstream kernel to
look at, please tell me which one, so that I will be able to check it out and
perhaps understand how this flow works.

P.S.: I guess it's not fhctl-sspm?

Regards,
Angelo
