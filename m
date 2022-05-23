Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67EB5311E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiEWNWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiEWNWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:22:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7904631234;
        Mon, 23 May 2022 06:22:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D4B671F4332B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653312162;
        bh=zJBx/meEVKgnjWI/EklM+94hyPmWSwELMNThgJm6lUg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BunFdwU73dubqPSW7rx74D895hMJcTYcd6qN8jpL/C2L2dkGSbvdf7x1JTB+M0ZKe
         0Wxhc3HjHNPcNjomBvWRqZ7e7teC1cQKdJgXMhRZ4N4+dW2dMmF2k/cYamAYO5joX6
         aTDmvnpDZoJGSyHPSbOYqJbDcFklr4mjrfsMzCjU2pauq31X6Fsp9NcI0oZm1k7C5U
         NlJjXVTJkRO2QDEn2rurR3ku95M4Tcuz1Adurp5tjqooSo9L4bFwvRd+zFEQbMSGgJ
         POT/pN634OKMiDfAnFoeuHMOo58bQ3Zh6JpNy5hpvkU0p/U2/XVVhK1ES06H3myDzO
         7coEpax5GyFfw==
Message-ID: <a6606891-d55f-dbce-7c5a-86390694e1c4@collabora.com>
Date:   Mon, 23 May 2022 15:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] regulator: Add driver for MT6331 PMIC regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220520133305.265310-1-angelogioacchino.delregno@collabora.com>
 <20220520133305.265310-3-angelogioacchino.delregno@collabora.com>
 <YoepiTUfdhkYByo7@sirena.org.uk>
 <6cc68be9-e509-eae4-801d-997fdc01dcf2@collabora.com>
 <YouFcSapkVC7ZfuP@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YouFcSapkVC7ZfuP@sirena.org.uk>
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

Il 23/05/22 15:00, Mark Brown ha scritto:
> On Mon, May 23, 2022 at 02:49:19PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 20/05/22 16:45, Mark Brown ha scritto:
>>> On Fri, May 20, 2022 at 03:33:03PM +0200, AngeloGioacchino Del Regno wrote:
> 
>>>> +static const unsigned int ldo_volt_table10[] = {
>>>> +	1200000, 1300000, 1500000, 1800000,
>>>> +	1200000, 1300000, 1500000, 1800000,
>>>> +	1200000, 1300000, 1500000, 1800000,
>>>> +	1200000, 1300000, 1500000, 1800000,
>>>> +};
> 
>>> So the top bits of the voltate selection field just get ignored?  Might
>>> be easier to just write the code to not include the top bits.
>>>
> 
>> No, they're all valid values for real... but I guess that I can simplify
>> this voltage table by simply modifying the bitmask that we use for the
>> regulators that are using this table....
> 
> Right, my point here is that it looks awfully like the documentation
> (this came from documentation I guess?) is including some extra bits
> that get ignored in the voltage selection field here.  That seems like a
> weird choice somewhere along the line.
> 

I wish I had a datasheet for these parts...

All of this comes from analyzing a running device on the downstream 3.4 kernel
and on understanding the (not really readable) downstream kernel code...
..but yes, I agree on the fact that this seems to be a weird choice.

Ah, besides, I hooked up an oscilloscope to the VCAM_IO and I can see that the
vreg really does react as expected upon setting the upper bits.. but since it
still works without, we can safely ignore them, which makes us able to simplify
the driver (as no custom code for that will be required) and, at the same time,
avoid seeing a table of values repeated 4 times in a row.

>>>> +	if (info->qi > 0) {
>>>> +		reg = info->desc.enable_reg;
>>>> +		en_mask = info->qi;
> 
>>> If the regulator doesn't have status readback it shouldn't provide a
>>> get_status() operation.
> 
>> What I've understood is that when there's no "QI" flag, the enable register
>> will provide the regulator status (EN/DIS) acting like QI, that's why I've
>> added that if branch...
> 
>> Anyway, I'll recheck this part before sending the next version!
> 
> That would be fairly unusual, often a regulator won't even detect when
> it's gone out of regulation.

Actually, there *is* support for this kind of detection... luckily the registers
and masks/bits are all dumped in a "upmu_hw.h" header downstream, regardless of
whether they're used or not in the code, so at least there's that reference to
look at... and I can see that there are bits to manage the overcurrent protection
(OVP) and configurable (OCPLVL) overcurrent protection (OCP_EN / OC_EN)...

...so, the regulator will indeed shut itself off and clear either/both the QI_EN
and/or its relative bit in the enable register... I've also just found hints of
the latter (enable register being set to 0) downstream, so I'm sure that this is
indeed right.

And finally... I would really like to test the OCP/OVP features to write some
code managing that, but I'm using a production smartphone (a Xperia M5, like
mentioned in the cover letter) for research and testing and you surely understand
that it's not time yet to take this risk... I will, later - but I have to finish
the upstreaming of this SoC and platform before chasing the green smoke... :-)


