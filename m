Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5825075E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355642AbiDSRGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355714AbiDSRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:05:18 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06604667D;
        Tue, 19 Apr 2022 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650387354; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgJ9M4e77rm4vWgeDfc7h63C2dpPAutbcuRpKjGD9n4=;
        b=MmVauPxwx0Nc5F0BBmh8Ky18fFoRb3dvEkVCAGHNSiRWRImQwFNHbMGqb4r9bdw39GxCJ1
        fnzknse0G3i983UeNAOSfGnI5Vxp+M/C2ZeTJsExp2iufMyfMXnM+LK1eKsmsWJuKVlAyf
        desO9uA4S62Zkl7y1Bet11f2kYDyn/k=
Date:   Tue, 19 Apr 2022 17:55:44 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/5] dt-bindings: rtc: Rework compatible strings and add
 #clock-cells
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        list@opendingux.net, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Message-Id: <W0JLAR.RV6VQW59K8X3@crapouillou.net>
In-Reply-To: <1e9bf9d6-cd5a-6a47-f0d7-5a4bc6e6d2f0@linaro.org>
References: <20220418184933.13172-1-paul@crapouillou.net>
        <20220418184933.13172-2-paul@crapouillou.net>
        <1e9bf9d6-cd5a-6a47-f0d7-5a4bc6e6d2f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le mar., avril 19 2022 at 08:41:56 +0200, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> On 18/04/2022 20:49, Paul Cercueil wrote:
>>  The RTC in the JZ4770 is compatible with the JZ4760, but has an=20
>> extra
>>  register that permits to configure the behaviour of the CLK32K pin.=20
>> The
>>  same goes for the RTC in the JZ4780.
>>=20
>>  Therefore, the ingenic,jz4770-rtc and ingenic,jz4780-rtc strings do=20
>> not
>>  fall back anymore to ingenic,jz4760-rtc. The ingenic,jz4780-rtc=20
>> string
>>  now falls back to the ingenic,jz4770-rtc string.
>>=20
>>  Additionally, since the RTCs in the JZ4770 and JZ4780 support=20
>> outputting
>>  the input oscillator's clock to the CLK32K pin, the RTC node is now=20
>> also
>>  a clock provider on these SoCs, so a #clock-cells property is added.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Cc: Rob Herring <robh+dt@kernel.org>
>>  Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>>  ---
>>   Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>=20
>>  diff --git a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml=20
>> b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
>>  index b235b2441997..57393c3ac724 100644
>>  --- a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
>>  +++ b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
>>  @@ -18,14 +18,14 @@ properties:
>>         - enum:
>>             - ingenic,jz4740-rtc
>>             - ingenic,jz4760-rtc
>>  +          - ingenic,jz4770-rtc
>>         - items:
>>             - const: ingenic,jz4725b-rtc
>>             - const: ingenic,jz4740-rtc
>>         - items:
>>             - enum:
>>  -              - ingenic,jz4770-rtc
>>                 - ingenic,jz4780-rtc
>>  -          - const: ingenic,jz4760-rtc
>>  +          - const: ingenic,jz4770-rtc
>>=20
>>     reg:
>>       maxItems: 1
>>  @@ -39,6 +39,9 @@ properties:
>>     clock-names:
>>       const: rtc
>>=20
>>  +  "#clock-cells":
>>  +    const: 0
>>  +
>>     system-power-controller:
>>       description: |
>>         Indicates that the RTC is responsible for powering OFF
>=20
> Inside allOf:if:then:, please add a constraint which compatible cannot
> have clock-cells (or maybe better which can?).
>=20
> Some modification of:
> https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetre=
e/bindings/media/renesas,vsp1.yaml#L53

Sure.

Cheers,
-Paul


