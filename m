Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BF5599D81
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349227AbiHSOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348981AbiHSOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:24:57 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAC5A74CA;
        Fri, 19 Aug 2022 07:24:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1660919090; bh=rxMg2xPDnYTGDNHNhIT0kpgTm3BHNlqUVYjelU2Wnlk=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=cN0DLigKR5cWPoRIyNMmYIxY+4PU5IX1WPSOj5t6HYXP9NphxQ4Ug01xF13D3FM8e
         7pOlDXAfkK59n40RzEEfvTeJoeeNltYSLdgmYCvEqelHDU+5uQLbC2DYkQUmvstiVx
         cGR2z9rxCnlNZBBBk2C5zxRDD+hAqQUvNVjO5COg=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 2/4] arm64: dts: apple: t8103: Add MCA and its support
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <38094e2d-c75c-920b-4b4d-aa377971f615@linaro.org>
Date:   Fri, 19 Aug 2022 16:24:49 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9E366E2-EA4D-4F35-BE28-63745296D222@cutebit.org>
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-3-povik+lin@cutebit.org>
 <38094e2d-c75c-920b-4b4d-aa377971f615@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 19. 8. 2022, at 15:12, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 19/08/2022 15:54, Martin Povi=C5=A1er wrote:
>> Add the MCA I2S transceiver node and its supporting NCO, ADMAC nodes.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>> arch/arm64/boot/dts/apple/t8103.dtsi | 70 =
++++++++++++++++++++++++++++
>> 1 file changed, 70 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi =
b/arch/arm64/boot/dts/apple/t8103.dtsi
>> index 51a63b29d404..2dc3125aca5b 100644
>> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
>> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
>> @@ -532,6 +532,76 @@ port02: pci@2,0 {
>> 						<0 0 0 4 &port02 0 0 0 =
3>;
>> 			};
>> 		};
>> +
>> +		dart_sio: iommu@235004000 {
>> +			compatible =3D "apple,t8103-dart", "apple,dart";
>> +			reg =3D <0x2 0x35004000 0x0 0x4000>;
>> +			interrupt-parent =3D <&aic>;
>> +			interrupts =3D <AIC_IRQ 635 =
IRQ_TYPE_LEVEL_HIGH>;
>> +			#iommu-cells =3D <1>;
>> +			power-domains =3D <&ps_sio_cpu>;
>> +		};
>> +
>> +		nco_clkref: clock-ref {
>> +			compatible =3D "fixed-clock";
>> +			#clock-cells =3D <0>;
>> +			clock-frequency =3D <900000000>;
>> +			clock-output-names =3D "nco_ref";
>> +		};
>=20
> Reference clocks are usually physically outside of SoC (e.g. on the
> board), so:
> 1. Not part of "soc" node.
> 2. It should be defined by board. At least clock-frequency should be =
there.

Ah, right, this deserves commentary: Since this is a reverse-engineered
driver/platform support, we give up on knowing the clock tree exactly. =
Instead
we model the clock input to the Numerically Controlled Oscillator =
(=E2=80=98nco=E2=80=99 node
below) with this fabulated fixed clock reference.

I guess eventually the clock tree is rooted off the SoC, and there=E2=80=99=
s
nothing guaranteeing the same reference clock to the NCO across machines =
(being
function of the board wiring and the proprietary firmware). In the end I =
would
argue for keeping the =E2=80=98clock-ref=E2=80=99 here in =E2=80=99soc' =
but have the clock-frequency
defined by board.  Sounds reasonable?

>=20
>> +
>> +		nco: nco@23b044000 {
>> +			compatible =3D "apple,t8103-nco", "apple,nco";
>> +			reg =3D <0x2 0x3b044000 0x0 0x14000>;
>> +			clocks =3D <&nco_clkref>;
>> +			#clock-cells =3D <1>;
>> +		};
>> +
>> +		admac: dma-controller@238200000 {
>> +			compatible =3D "apple,t8103-admac", =
"apple,admac";
>> +			reg =3D <0x2 0x38200000 0x0 0x34000>;
>> +			dma-channels =3D <24>;
>> +			interrupts-extended =3D <0>,
>> +					 <&aic AIC_IRQ 626 =
IRQ_TYPE_LEVEL_HIGH>,
>> +					 <0>,
>> +					 <0>;
>> +			#dma-cells =3D <1>;
>> +			iommus =3D <&dart_sio 2>;
>> +			power-domains =3D <&ps_sio_adma>;
>> +		};
>> +
>> +		mca: mca@38400000 {
>=20
> Here node name is as well wrong.
>=20
> Node names should be generic.
> =
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicet=
ree-basics.html#generic-names-recommendation

OK

Best, Martin

>=20
> Best regards,
> Krzysztof

