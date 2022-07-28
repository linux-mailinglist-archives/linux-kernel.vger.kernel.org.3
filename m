Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61677583AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiG1JFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiG1JFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:05:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0320A4F6AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:05:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso2900971wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:subject:date:in-reply-to:message-id
         :mime-version:content-transfer-encoding;
        bh=+OcFPLQx6Ft687/V7wURN2VQWAIUGdH0K7LY/fhlaDo=;
        b=YPaUlAEQdlx+kmxBPZ+Nh79C/fBgQ+GJSZbX5sGR5UeAsooqhdnkgJE1nos0wwFkey
         g9PoE5y0wGPR98y7OvhuiVdg0RZKcr58XveY7cWN93fwYIcXL1thMwn629mb12kakRMf
         WpU85G+NJa+8UOuIwtQ/psMhwNuTMdpQZdyOpOrQL3z+QjfVuOKHB6F8KS/0B1+cfRzU
         Q1FJ/bVoMQONqRBYpCjUxJ6s+ccWVpfQ1g0QHF8zYB8cH/DpcijrlYfV+lWqfzGrZslK
         KT+TpwIuvfA6Kjywvu0CAt+ofsXTNFm9dTHEfMd3+ldst4onF/tasVuSrgXDQYAXCDt5
         /i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+OcFPLQx6Ft687/V7wURN2VQWAIUGdH0K7LY/fhlaDo=;
        b=Hp2MrB646TAwX1V91yhCg0VcfEukWzIpYFxJ2V76I8wxMmjiUQuJu+UURbpG6fTYUE
         +CICWCw25plH/wMGCsVj6UydLjofbKj1vC8JqRczp+cEXsS/ITvpa/46CfLKmLwxoc+H
         EqIW3mG5zh5QOeMiWfmJAf+79SEkSekU4phIHgpnt5Og/9dEzXzEUopo2iDPuapYo5HP
         +Mvju2SCmcj1CBVCfVu2phQ1u/R379Hf6HJ2uPZhf5svSOoXF9ZNPIRFJa9IRKXb3eYH
         ++q3zeUSk/NolfC7H7CBzxg1YzsXTRIhslpPChXwqueMAT2VFm+wpt5r2QdvNXyslus/
         sKIw==
X-Gm-Message-State: AJIora/iDBdkG2zJlCdh34huDMcu/kwqfIArrPNSNOHhCFkBC/VwMp6C
        D6l2QyOWEVLBpEWQkVb1wZ3TAw==
X-Google-Smtp-Source: AGRyM1sVNiJX8YKWerXapN2Ixv89nJZDNv/1hf5hRxoFAVrVo4zBDMO23Ru7zb0iN/K21CTzXnBD8g==
X-Received: by 2002:a05:600c:3582:b0:3a3:3b00:cb25 with SMTP id p2-20020a05600c358200b003a33b00cb25mr5762604wmq.170.1658999141375;
        Thu, 28 Jul 2022 02:05:41 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a31d200a7dsm664591wmq.9.2022.07.28.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 02:05:40 -0700 (PDT)
References: <20220728054202.6981-1-yu.tu@amlogic.com>
 <1j8rodhfn9.fsf@starbuckisacylon.baylibre.com>
 <032b3c3f-f899-bf53-ecbb-35191d39392b@amlogic.com>
 <1j4jz1hbr5.fsf@starbuckisacylon.baylibre.com>
 <965f83cf-4695-f89c-5ede-2f6b2524f392@amlogic.com>
User-agent: mu4e 1.8.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V2 0/3] Add S4 SoC clock controller driver
Date:   Thu, 28 Jul 2022 11:03:18 +0200
In-reply-to: <965f83cf-4695-f89c-5ede-2f6b2524f392@amlogic.com>
Message-ID: <1jr125fvz0.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 28 Jul 2022 at 16:55, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Jerome,
> 	Thanks for your reply and explanation.
>
> On 2022/7/28 16:27, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>=20
>> On Thu 28 Jul 2022 at 16:06, Yu Tu <yu.tu@amlogic.com> wrote:
>>=20
>>> Hi JB=EF=BC=8C
>>>
>>> On 2022/7/28 15:08, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On Thu 28 Jul 2022 at 13:41, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>
>>>>> 1. Add clock controller driver for S4 SOC.
>>>>>
>>>>> Yu Tu (3):
>>>>>     dt-bindings: clk: meson: add S4 SoC clock controller bindings
>>>>>     arm64: dts: meson: add S4 Soc clock controller in DT
>>>>>     clk: meson: s4: add s4 SoC clock controller driver
>>>>>
>>>>> V1 -> V2: Change format as discussed in the email.
>>>>>
>>>>> Link:https://lore.kernel.org/linux-amlogic/20220708062757.3662-1-yu.t=
u@amlogic.com/
>>>>>
>>>>>    .../bindings/clock/amlogic,gxbb-clkc.txt      |    1 +
>>>>>    MAINTAINERS                                   |    1 +
>>>>>    arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   11 +
>>>>>    drivers/clk/meson/Kconfig                     |   15 +
>>>>>    drivers/clk/meson/Makefile                    |    1 +
>>>>>    drivers/clk/meson/s4.c                        | 4732 +++++++++++++=
++++
>>>>>    drivers/clk/meson/s4.h                        |  296 ++
>>>>>    include/dt-bindings/clock/s4-clkc.h           |  146 +
>>>>>    8 files changed, 5203 insertions(+)
>>>>>    create mode 100644 drivers/clk/meson/s4.c
>>>>>    create mode 100644 drivers/clk/meson/s4.h
>>>>>    create mode 100644 include/dt-bindings/clock/s4-clkc.h
>>>>>
>>>>>
>>>>> base-commit: b293bc9286ee21824e93f0fcfed3b78fdfee01e6
>>>> Please don't post until you have addressed *ALL* the comments from the
>>>> previous version.
>>> The last email asked you to adopt A1 method, but you did not reply?
>>>
>>>> At first glance, I can see that this is still a single driver for
>>>> what is obviously 2 controllers with 2 register spaces. Simple comments
>>>> like the "<< 2" in the register declaration have not been addressed ei=
ther.
>>> I understand that this should be a controller, just two address
>>> descriptions. One is the various PLL registers and one is the clock for
>>> the peripherals. And PLL is to provide a clock source for various
>>> peripheral clocks. So a clock controller is reasonable. I think you got
>>> it wrong.
>> I don't think I do. This looks exactly like the A1.
>> The post of that controller are still in the  archive and I am sure your
>> colleagues can give you the history.
>> You clearly have register regions providing clock, separated by
>> 0x8000. Claiming that as one big region is bad design.
>> There has been several remarks about using a big syscon on V1,
>> unaddressed too.
>> CCF has everything necessary in place to handle each register region
>> separately, properly and pass clock around.
>> You can handle it as a single controller, claiming the two regions
>> individually but:
>> # 1 - handling 2 different regmaps in the controller is going to be
>>        bigger mess than you think
>> # 2 - I am far from convinced there is any reason to do so
>>=20
> It makes sense, as you say, to separate the two controllers. But I think
> the only thing that was forced apart was that the digital designers=20
> didn't put these registers together when they were designing the chips.
>

One controller is providing all the base PLLs
The other is providing most (if not all) the devices clocks.
This does not look like coincidence or mistake to me.

> I'm going to separate the two controllers like you said.
>
>>=20
>>>
>>> Ok, if you insist on using two clock controllers,, please provide your =
the
>>> reason and example code?
>>>
>>>> Seeing that, I have not reviewed this version further.
>>>> I won't until all the comments from v1 are either addressed or answer
>>>> Regards
>>>> Jerome
>>>> .
>> .

