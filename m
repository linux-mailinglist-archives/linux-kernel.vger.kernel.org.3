Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675A55A4619
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiH2Jb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiH2JbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:31:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E6425C66;
        Mon, 29 Aug 2022 02:31:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 186426601DB2;
        Mon, 29 Aug 2022 10:31:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661765482;
        bh=vj0TZu2ctXuLgzUFUUVacwwsrQ4oDpOKmllM1Y9zDdk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hgwIRCJXGnE9dl7xULH91Ei9q6Ctojg6u8vx4hspoFV6G0rm+fHoPjMzCNYlPVshN
         nneu/iBSUYJu+jugutZply26bKo0b4RIZmACogZIKqWB0C3uATjLajmAZhdhv696VJ
         MkbtFRrvbJNtzoE5SBJWoEpYE89khHwKnVef3QF1aHoLb0Dd6KGLlYQY2CgdtWCCAb
         KdgsY1Iz3V+cDFVYeiCxO2LGN0hrZ4uBcdfdJPmodmSnvdMRFU2JPO2AmQzEj8CJoj
         0DSx1IlAigoyWUvXegEnM7TgJgKKRy21yKD1GsGV3VKU1OYushCtuAH45XMbKPRH4+
         OJBp/UdhT/8Zw==
Message-ID: <5350956c-fbab-6eee-071a-8b24b74e741c@collabora.com>
Date:   Mon, 29 Aug 2022 11:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] clk: mediatek: Add drivers for MediaTek MT6735
 main clock drivers
Content-Language: en-US
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Miles Chen <miles.chen@mediatek.com>, yassine.oudjana@gmail.com,
        bgolaszewski@baylibre.com, chun-jie.chen@mediatek.com,
        devicetree@vger.kernel.org, ikjn@chromium.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sam.shih@mediatek.com,
        sboyd@kernel.org, tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        wenst@chromium.org, ~postmarketos/upstreaming@lists.sr.ht
References: <NJC6CR.M4CF312LSXXV1@gmail.com>
 <20220520093501.28758-1-miles.chen@mediatek.com>
 <c7b98ee4-cd4f-d7b7-726d-1acd4fafd50a@collabora.com>
 <lAB8fLfWTwUu6FUqPZWoKNEC0ZPYHnvo05u6BGriYQVjanlTzorHaZAflEbzoml-0UVZe-02r6CfzKwGdBCp7E0YeT_hF86P26r-Zeivda4=@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <lAB8fLfWTwUu6FUqPZWoKNEC0ZPYHnvo05u6BGriYQVjanlTzorHaZAflEbzoml-0UVZe-02r6CfzKwGdBCp7E0YeT_hF86P26r-Zeivda4=@protonmail.com>
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

Il 13/08/22 12:44, Yassine Oudjana ha scritto:
> On Friday, May 20th, 2022 at 11:26 AM, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
>> Il 20/05/22 11:35, Miles Chen ha scritto:
>>
>>>>> Thanks for submitting this patch.
>>>>>
>>>>> I compare this with drivers/clk/mediatek/clk-mt7986-apmixed.c,
>>>>> and other clk files are using macros to make the mtk_pll_data array
>>>>> more readable.
>>>>
>>>> I'd actually argue that macros make it less readable. While reading
>>>> other drivers I had a lot of trouble figuring out which argument
>>>> is which field of the struct, and had to constantly go back to the
>>>> macro definitions and count arguments to find it. Having it this
>>>> way, each value is labeled clearly with the field it's in. I think
>>>> the tradeoff between line count and readability here is worth it.
>>>
>>> It is easier for multiple developers to work together if we have a common style.
>>>
>>> How do you think?
>>
>>
>> In my opinion, Yassine is definitely right about this one: unrolling these macros
>> will make the code more readable, even though this has the side effect of making
>> it bigger in the source code form (obviously, when compiled, it's going to be the
>> exact same size).
>>
>> I wouldn't mind getting this clock driver in without the usage of macros, as much
>> as I wouldn't mind converting all of the existing drivers to open-code everything
>> instead of using macros that you have to find in various headers... this practice
>> was done in multiple drivers (clock or elsewhere), so I don't think that it would
>> actually be a bad idea to do it here on MediaTek too, even though I'm not aware of
>> any rule that may want us to do that: if you check across drivers/clk/*, there's
>> a big split in how drivers are made, where some are using macros (davinci, renesas,
>> samsung, sprd, etc), and some are not (bcm, sunxi-ng, qcom, tegra, versatile, etc),
>> so it's really "do it as you wish"...
>>
>> ... but:
>>
>> Apart from that, I also don't think that it is a good idea to convert the other
>> MTK clock drivers right now, as this would make the upstreaming of MediaTek clock
>> drivers harder for some of the community in this moment... especially when we look
>> at how many MTK SoCs are out there in the wild, and how many we have upstream:
>> something like 10% of them, or less.
>>
>> I see the huge benefit of having a bigger community around MediaTek platforms as
>> that's beneficial to get a way better support and solidity for all SoCs as they
>> are sharing the same drivers and same framework, and expanding the support to more
>> of them will only make it better with highly valuable community contributions.
>>
>>
>> That said, Yassine, you should've understood that you have my full support on
>> unrolling these macros - but it's not time to do that yet: you definitely know
>> that MediaTek clock drivers are going through a big cleanup phase which is, at
>> this point, unavoidable... if we are able to get the aid of scripts (cocci and
>> others), that will make our life easier in this cleanup, and will also make us
>> able to perform the entire cleanup with less effort and in less overall time.
>>
>> With that, I'm sad but I have to support Miles' decision on this one, and I also
>> have to ask you to use macros in this driver.
> 
> I'm picking up this series again now after taking a long break to allow for
> ongoing cleanup and refactoring work to settle down. I was going to make this
> change but then I couldn't find the PLL macro defined in any common header.
> It seems that it is defined in every driver that uses it, with slight variations
> in some of them. Should I just do the same, or would it be better to define it
> in clk-pll.h? Also, would now be a good time to unroll the macros in all drivers,
> or is it still too soon?

Hello Yassine,
I'm sorry for the very late reply to this topic, but I just got back from vacation.

Please follow the current way of defining the PLL macro into the SoC-specific
driver: MediaTek folks are in the process of implementing Frequency Hopping (FHCTL)
on supported PLLs so "some things may change"... maybe in your driver too... I'm
not sure, though, whether MT6735 does support FHCTL and anyway, even if it does,
I would recommend to just go without it as a first step, as adding FHCTL capability
will be done on all(?) of the supported SoC clock drivers as soon as it lands.

> 
> Another thing: Since I've been out of touch with the cleanup work for a while,
> it would be great if someone makes me aware of any pending cleanup patches that
> I should know of so that I base my patches on them and avoid duplicating work.
> 

Simply check linux-mediatek, but I don't think that there's anything in the
pipeline that would be blocking your MT6735 drivers.

Cheers,
Angelo
