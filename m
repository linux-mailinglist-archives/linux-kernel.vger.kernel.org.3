Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299CA557A52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiFWM2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiFWM2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:28:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54520F65;
        Thu, 23 Jun 2022 05:28:04 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFF836601796;
        Thu, 23 Jun 2022 13:28:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655987283;
        bh=IwL6iPRd+xbXzEa1NNLhk/737SOyuXYMWwedlhFBIcQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TgAlMRXbzSxcaX2zPy20reDYxQQsk+xodm14NOXdG7rKGc0+NIDiA4PoaCy2QGIw0
         mXfiMuZEG8rk6n6M53Vy1fomVFj6tdM9IT9UNJn6Hc0Iumqi4QnISWeMG99gFAJJry
         gQflStppiv0dHF8bItCTYposeZtXD6tOatNm/GBc3P2hZSOFneluxYoo256oVueKek
         auzmyppiGXke/xmb8Oe8tkEnj4grw7Cw5iSZgRFM0vp20zB1GAH3NGmIWmVCk8Ch0y
         Z0KIXlk52dXXI44xbcz5LmBgnjNz/SuTXOszhRBjVhs4qqFNLj1MOHJMgCIxFcCsTC
         oiYArA24BvqhA==
Message-ID: <24bd8e36-d836-74f0-2006-781d6458b7da@collabora.com>
Date:   Thu, 23 Jun 2022 14:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/5] Allow getting regulator on MFG for multiple SoCs
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
References: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
 <11da278b-f7ce-d668-2c8a-46d7a9c71eb9@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <11da278b-f7ce-d668-2c8a-46d7a9c71eb9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/06/22 13:40, Matthias Brugger ha scritto:
> 
> 
> On 23/06/2022 12:09, AngeloGioacchino Del Regno wrote:
>> This is one of the steps to enable DVFS with the Panfrost driver:
>> since Panfrost is already enabling the (required) MFG power domains
>> and since the mtk-pm-domains driver is already responsible for
>> actually enabling the SRAM PDN, it makes sense to make sure that
>> the VSRAM supply is ON when trying to reset/enable the SRAM.
>>
>> For this reason, the MTK_SCPD_DOMAIN_SUPPLY flag was added to one
>> more MFG domain, ensuring that the SRAM is actually powered and
>> also not relying on the bootloader leaving this supply on; on the
>> other hand, this is also making possible to avoid setting a
>> sram-supply on the GPU node, making devfreq happy about having
>> only one supply and finally allowing DVFS to happen.
>>
>> If no domain-supply is declared in devicetree, mtk-pm-domains driver
>> probe will anyway keep going, so this is not breaking old devicetrees.
>>
>> No side effects either when this supply is declared for both a MFG
>> domain and Panfrost together.
>>
>> This series has no dependencies.
>>
>> AngeloGioacchino Del Regno (5):
>>    soc: mediatek: mt8192-pm-domains: Allow probing vreg supply on MFG0/1
>>    soc: mediatek: mt8183-pm-domains: Allow probing vreg supply on
>>      MFG_ASYNC
>>    soc: mediatek: mt8195-pm-domains: Allow probing vreg supply on MFG1
>>    soc: mediatek: mt8186-pm-domains: Allow probing vreg supply on MFG1
> 
> I think we can squash the 4 patches into one. Other then that series looks good.
> 

I was wondering the same... the reason why I haven't squashed the patches is
that I'm not sure if MT8173 also needs that or not - and this makes really
clear to whoever reads the git log that MT8173 was omitted.
Looking back at that though, be it one and squashed, or be it four, shouldn't
change much for that kind of intention, what do you say?

Eh, for clarity - I didn't even check/touch MT8173 because that's PowerVR... and
currently there's no driver that's currently upstream.

Anyway, if you think that squashing is the right way to go, I can do that in
practically no time and send a v2.

Cheers,
Angelo

> Matthias
> 
>>    arm64: dts: mediatek: mt8183-kukui: Assign sram supply to mfg_async pd
>>
>>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 2 +-
>>   drivers/soc/mediatek/mt8183-pm-domains.h       | 1 +
>>   drivers/soc/mediatek/mt8186-pm-domains.h       | 2 +-
>>   drivers/soc/mediatek/mt8192-pm-domains.h       | 2 ++
>>   drivers/soc/mediatek/mt8195-pm-domains.h       | 2 +-
>>   6 files changed, 10 insertions(+), 3 deletions(-)
>>
