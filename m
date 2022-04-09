Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF934FA7B5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbiDIMja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbiDIMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:39:27 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE5624975;
        Sat,  9 Apr 2022 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649507836; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifBE7hLzyPPy+KwIFI4YoPCOsdLAAVtL/pcRZoRx3eg=;
        b=16eZFc8L+FfE+kmG9/d4QnEQoQUIuSB4Faqr2VU1OPxy5YvezIax7MxnUW7oDWmardXhCL
        aeAzlUu8eB5a47P9ZRSc7sujkU6F+FXUtR5FuSB71VVgL4uR/erNfX94MoSCWhrt5cnkvb
        sHwjLE24d0lyi7DhXA5hcvei+gqTy0A=
Date:   Sat, 09 Apr 2022 13:37:07 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 13/18] dt-bindings: fix jz4780-nemc issue as reported by
 dtbscheck
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Message-Id: <VDO2AR.XO9112UD3KYT3@crapouillou.net>
In-Reply-To: <036b66b2-c221-6e9e-6a56-510e7a0d20d3@linaro.org>
References: <cover.1649443080.git.hns@goldelico.com>
        <84adfe6237cd4cfd52cb9723416f69926e556e55.1649443080.git.hns@goldelico.com>
        <036b66b2-c221-6e9e-6a56-510e7a0d20d3@linaro.org>
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

Le sam., avril 9 2022 at 13:26:25 +0200, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>  jz4780-nemc needs to be compatible to simple-mfd as well or we get
>>=20
>>  arch/mips/boot/dts/ingenic/ci20.dtb: memory-controller@13410000:=20
>> compatible: 'oneOf' conditional failed, one must be fixed:
>>  	['ingenic,jz4780-nemc', 'simple-mfd'] is too long
>>  	'ingenic,jz4725b-nemc' was expected
>>  	'ingenic,jz4740-nemc' was expected
>>  	From schema:=20
>> Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>>=20
>>  Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>  ---
>>   .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml    |=20
>> 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml=
=20
>> b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>>  index 24f9e19820282..3b1116588de3d 100644
>>  ---=20
>> a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>>  +++=20
>> b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>>  @@ -17,7 +17,7 @@ properties:
>>       oneOf:
>>         - enum:
>>             - ingenic,jz4740-nemc
>>  -          - ingenic,jz4780-nemc
>>  +          - [ ingenic,jz4780-nemc, simple-mfd ]
>=20
> This is not correct representation. If you really need simple-mfd,=20
> then
> this should be a separate item below oneOf.

Correct.

> The true question is whether you need simple-mfd. Isn't the binding=20
> (and
> the driver) expected to instantiate its children?

I can explain that one. There is the EFUSE controller located inside=20
the nemc's memory area, and the two are pretty much unrelated, hence=20
the "simple-mfd" compatible string.

Cheers,
-Paul


