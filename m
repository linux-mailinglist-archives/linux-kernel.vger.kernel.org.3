Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649D052E9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiETK0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiETK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:26:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D759B89;
        Fri, 20 May 2022 03:26:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 321991F46241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653042389;
        bh=HDf0MWYOCR8r+DZXQalTBiAOnmPm5YoK5f5O0omhcKw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mdAaBJ/ldoxoFkOrLMDVKqWZzcLoxCeB7GE3uaRVXxTozO8Y5+Hp6X5lUigIWNr7J
         Ktc7zWDmESvVXtv2Iad6ze8Kgxdg2WAsPRxKwZN+IPNJjbKZInkZDd2mV5ih49Z67M
         XGN+NHSZr59Q4aDq3Zytr23c5wpGqtrewmWFxkoqJ2UkmvdNHFw7qnVk9yUd+BKAHc
         /oT1lON2DU9i2X04vG27EVMGu2kvfSCyrhA2Eo/Ij66jU4RO4TRI1h3sFvHlRB1j6A
         33qLkIzS/BpuXD0hf1mRa5PSa1hrhF4FCjI51q6AQKa9lzIUyAHlQSyQ8xjT2cT/uG
         sv+GathARu3Mw==
Message-ID: <c7b98ee4-cd4f-d7b7-726d-1acd4fafd50a@collabora.com>
Date:   Fri, 20 May 2022 12:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/4] clk: mediatek: Add drivers for MediaTek MT6735
 main clock drivers
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>, yassine.oudjana@gmail.com
Cc:     bgolaszewski@baylibre.com, chun-jie.chen@mediatek.com,
        devicetree@vger.kernel.org, ikjn@chromium.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sam.shih@mediatek.com,
        sboyd@kernel.org, tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        wenst@chromium.org, y.oudjana@protonmail.com,
        ~postmarketos/upstreaming@lists.sr.ht
References: <NJC6CR.M4CF312LSXXV1@gmail.com>
 <20220520093501.28758-1-miles.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220520093501.28758-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/05/22 11:35, Miles Chen ha scritto:
> 
>>>
>>> Thanks for submitting this patch.
>>>
>>> I compare this with drivers/clk/mediatek/clk-mt7986-apmixed.c,
>>> and other clk files are using macros to make the mtk_pll_data array
>>> more readable.
>>
>> I'd actually argue that macros make it less readable. While reading
>> other drivers I had a lot of trouble figuring out which argument
>> is which field of the struct, and had to constantly go back to the
>> macro definitions and count arguments to find it. Having it this
>> way, each value is labeled clearly with the field it's in. I think
>> the tradeoff between line count and readability here is worth it.
> 
> It is easier for multiple developers to work together if we have a common style.
> 
> How do you think?
> 

In my opinion, Yassine is definitely right about this one: unrolling these macros
will make the code more readable, even though this has the side effect of making
it bigger in the source code form (obviously, when compiled, it's going to be the
exact same size).

I wouldn't mind getting this clock driver in without the usage of macros, as much
as I wouldn't mind converting all of the existing drivers to open-code everything
instead of using macros that you have to find in various headers... this practice
was done in multiple drivers (clock or elsewhere), so I don't think that it would
actually be a bad idea to do it here on MediaTek too, even though I'm not aware of
any *rule* that may want us to do that: if you check across drivers/clk/*, there's
a big split in how drivers are made, where some are using macros (davinci, renesas,
samsung, sprd, etc), and some are not (bcm, sunxi-ng, qcom, tegra, versatile, etc),
so it's really "do it as you wish"...

... *but:*

Apart from that, I also don't think that it is a good idea to convert the other
MTK clock drivers right now, as this would make the upstreaming of MediaTek clock
drivers harder for some of the community in this moment... especially when we look
at how many MTK SoCs are out there in the wild, and how many we have upstream:
something like 10% of them, or less.

I see the huge benefit of having a bigger community around MediaTek platforms as
that's beneficial to get a way better support and solidity for all SoCs as they
are sharing the same drivers and same framework, and expanding the support to more
of them will only make it better with highly valuable community contributions.


That said, Yassine, you should've understood that you have my full support on
unrolling these macros - but it's not time to do that yet: you definitely know
that MediaTek clock drivers are going through a big cleanup phase which is, at
this point, unavoidable... if we are able to get the aid of scripts (cocci and
others), that will make our life easier in this cleanup, and will also make us
able to perform the entire cleanup with less effort and in less overall time.

With that, I'm sad but I have to support Miles' decision on this one, and I also
have to ask you to use macros in this driver.


I am sure - and it is my wish - to see MediaTek clock drivers open-coding stuff
instead of using macros, but that's something for the future - which will happen
after the more important cleanups.

After all, it will be just about running "gcc -E xxxx.c" and copy-pasting the
unrolled macros to the clock drivers, which will be pretty fast and straightforward.

Sorry for the wall of text, by the way.

Cheers,
Angelo
