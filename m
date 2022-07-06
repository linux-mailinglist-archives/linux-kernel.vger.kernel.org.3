Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D37569228
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiGFSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiGFStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:49:53 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4552828E35
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:49:52 -0700 (PDT)
Date:   Wed, 06 Jul 2022 18:49:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1657133389; x=1657392589;
        bh=FQD+MMDt/Q8SRTTAfcqxo1U1VL4S1CdzwRULBkrzEs8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=SSodwAqUa6IEewyZfhwUlzSIwB7mAi7o0Tc/QGeKhXjB2Akhlw2pRuB12+A7pixy6
         xAsI5FDQK8WDXRaYkjfeSR3yyijiP9MY2yLgnEhiWWhoj9weJp+KZo9YZyShXlQPnC
         B5DsoTiTV825+tQlgOXwfaaM+pjvSniQUo6uyQZo=
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 1/2] arch: arm64: qcom: sdm845-shift-axolotl: fix Bluetooth firmware loading
Message-ID: <0488a37f-083c-6e8c-eff2-e204b242cbfb@connolly.tech>
In-Reply-To: <CAA8EJpqz32_LxmBVbcLt0sV=e1JzGtWEmMsKsQNoZzuGgLWbBQ@mail.gmail.com>
References: <20220609095412.211060-1-amartinz@shiftphones.com> <CAA8EJpqz32_LxmBVbcLt0sV=e1JzGtWEmMsKsQNoZzuGgLWbBQ@mail.gmail.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2022 13:47, Dmitry Baryshkov wrote:
> On Thu, 9 Jun 2022 at 12:54, Alexander Martinz <amartinz@shiftphones.com>=
 wrote:
>>
>> From: Dylan Van Assche <me@dylanvanassche.be>
>>
>> Add hsuart0 alias, firmware name and prevent garbage data on Bluetooth U=
ART lines
>
> hsuart aliases are not standard. Please use serialN alias instead.
>
>> on the SHIFT 6mq based on the Qualcomm SDM845 chip.
>> I discovered that these were missing by comparing the DTS with similar
>> devices such as the Oneplus 6/6T and Dragonboard 845c.
>>
>> Signed-of-by: Dylan Van Assche <me@dylanvanassche.be>
>> Tested-by: Alexander Martinz <amartinz@shiftphones.com>
>> ---
>>   .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 33 +++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/ar=
m64/boot/dts/qcom/sdm845-shift-axolotl.dts
>> index 103cc40816fd..fa72f23ef0c2 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
>> @@ -20,6 +20,7 @@ / {
>>
>>          aliases {
>>                  display0 =3D &framebuffer0;
>> +               hsuart0 =3D &uart6;
>>                  serial0 =3D &uart9;
>>          };
>>
>> @@ -529,6 +530,32 @@ volume_down_resin: resin {
>>          };
>>   };
>>
>> +/*
>> + * Prevent garbage data on bluetooth UART lines
>> + */
>> +&qup_uart6_default {
>> +        pinmux {
>> +                pins =3D "gpio45", "gpio46", "gpio47", "gpio48";
>> +                function =3D "qup6";
>> +        };
>
> This chunk should probably go into sdm845.dtsi. I'd suggest either
> adding a separate qup_uart6_4pin or just making qup_uart6_default the
> 4-pin UART.
This sounds good
>
>> +
>> +        cts {
>> +                pins =3D "gpio45";
>
> Then the label and 'pins' can go into the dtsi, while keeping just the
> bias and drive-strength in the platform dtsi.
>
>> +                bias-pull-down;
>> +        };
>> +
>> +        rts-tx {
>> +                pins =3D "gpio46", "gpio47";
>> +                drive-strength =3D <2>;
>> +                bias-disable;
>> +        };
>> +
>> +        rx {
>> +                pins =3D "gpio48";
>> +                bias-pull-up;
>> +        };
>> +};
>> +
>>   &qup_uart9_default {
>>          pinconf-rx {
>>                  pins =3D "gpio5";
>> @@ -667,6 +694,12 @@ &uart6 {
>>          bluetooth {
>>                  compatible =3D "qcom,wcn3990-bt";
>>
>> +               /*
>> +                * This path is relative to the qca/
>> +                * subdir under lib/firmware.
>> +                */
>> +               firmware-name =3D "axolotl/crnv21.bin";
>
> Do you know what is the difference between axolotl's bin and the regular =
one?
Just checked in a hex editor and there are some differences. This firmware =
is
signed on most devices but given the SHIFT6mq is secureboot off we could in
theory use upstream firmware here - if it works. This particular device has=
 some
very broken wifi firmware - we have to use the firmware from the OnePlus 6 =
to
get wifi to work at all...
>
>> +
>>                  vddio-supply =3D <&vreg_s4a_1p8>;
>>                  vddxo-supply =3D <&vreg_l7a_1p8>;
>>                  vddrf-supply =3D <&vreg_l17a_1p3>;
>
> --
> With best wishes
> Dmitry

--
Kind Regards,
Caleb

