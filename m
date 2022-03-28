Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAFF4E9302
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbiC1LLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiC1LLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:11:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A713E43EC3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:09:37 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nYnFX-0000jR-1o; Mon, 28 Mar 2022 13:09:27 +0200
Message-ID: <74e74ea8-1554-bf08-b0ea-36e77259cb18@pengutronix.de>
Date:   Mon, 28 Mar 2022 13:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp: Enable HS400-ES
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
References: <20220327123835.28329-1-aford173@gmail.com>
 <20220327123835.28329-3-aford173@gmail.com>
 <c964bf2c-f7bf-451c-1691-02903f20c634@pengutronix.de>
 <CAHCN7xL05pBK0uK7zuE7Uq4P9Rzo6bHbJdbOt5XnQRB7Sh3msw@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAHCN7xL05pBK0uK7zuE7Uq4P9Rzo6bHbJdbOt5XnQRB7Sh3msw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adam,

On 28.03.22 12:47, Adam Ford wrote:
> On Mon, Mar 28, 2022 at 2:20 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> Hello Adam,
>>
>> On 27.03.22 14:38, Adam Ford wrote:
>>> The SDHC controller in the imx8mp has the same controller
>>> as the imx8mm which supports HS400-ES. Change the compatible
>>> fallback to imx8mm to enable it.
>>
>> I believe that's a shortcoming of the Linux driver, which should explicitly list
>> fsl,imx8mp-usdhc in its compatibles and enable HS400-ES for it.
>>
>> I find dropping compatibles problematic, because like Linux matching
>> fsl,imx8mm-usdhc, but not fsl,imx8mp-usdhc, other software may match
>> fsl,imx7d-usdhc, but not fsl,imx8[mp]-usdhc.
>>
>> I'd prefer that either the kernel driver gains extra compatibles or that
>> the DTS lists extra compatibles and we refrain from dropping existing
>> (correct) ones.
>>
> 
> I would argue that imx7d is not correct since the IP blocks between
> imx7d and imx8mm have different flags/quirks.  One of which includes
> HS400-ES, but there are other differences as well.

The DTS currently says that an fsl,imx7d-usdhc is a subset of an
fsl,imx8mm-usdhc. So a driver could treat both HW the exact same
by focusing on the i.MX7D parts. Linux apparently did exactly
that so far. Is this not accurate?


>> What do you think?
> 
> From my understanding of the fallback compatibility strings is to
> avoid having to add more and more compatible strings to the drivers
> when they do not serve a functional purpose. Based On a conversation
> with Krzysztof [1], he suggested we update the YAML file based on the
> fallback, but he wanted NXP to give their feedback as to what the
> right fallback strings should be.  Haibo from NXP sent me a hierarchy
> [1] which is what I used to update the YAML file.  Based on the YAML
> file, the fallback in each DTSI file was updated to ensure the use of
> the proper IP block.

Myself I am in favor of moving to three compatibles instead of dropping one.
For some theoretical fsl,imx8mf-usdhc that's supposed to be exactly the same
as a fsl,imx8mm-usdhc, I don't mind omitting the fsl,imx7d-usdhc compatible,
but for existing device trees, this may introduce needless potential breakage
for other software that also uses Linux device trees.

Cheers,
Ahmad

> 
> adam
> 
> [1] - https://lore.kernel.org/linux-arm-kernel/CAHCN7xLWoUGi-jfxR2a0gvEFkPT3USUEb+8U3CCqCb5wWEJ8xw@mail.gmail.com/T/
> 
>>
>> Cheers,
>> Ahmad
>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> index 794d75173cf5..d5ee1520f1fe 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> @@ -769,7 +769,7 @@ i2c6: i2c@30ae0000 {
>>>                       };
>>>
>>>                       usdhc1: mmc@30b40000 {
>>> -                             compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
>>> +                             compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
>>>                               reg = <0x30b40000 0x10000>;
>>>                               interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
>>>                               clocks = <&clk IMX8MP_CLK_DUMMY>,
>>> @@ -783,7 +783,7 @@ usdhc1: mmc@30b40000 {
>>>                       };
>>>
>>>                       usdhc2: mmc@30b50000 {
>>> -                             compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
>>> +                             compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
>>>                               reg = <0x30b50000 0x10000>;
>>>                               interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>>>                               clocks = <&clk IMX8MP_CLK_DUMMY>,
>>> @@ -797,7 +797,7 @@ usdhc2: mmc@30b50000 {
>>>                       };
>>>
>>>                       usdhc3: mmc@30b60000 {
>>> -                             compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
>>> +                             compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
>>>                               reg = <0x30b60000 0x10000>;
>>>                               interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>>>                               clocks = <&clk IMX8MP_CLK_DUMMY>,
>>
>>
>> --
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
