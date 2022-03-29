Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E804EABBF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiC2K62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiC2K6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:58:24 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E9051DA7C;
        Tue, 29 Mar 2022 03:56:39 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Mar 2022 19:56:38 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 9A3C42058B50;
        Tue, 29 Mar 2022 19:56:38 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 29 Mar 2022 19:56:38 +0900
Received: from [10.212.183.172] (unknown [10.212.183.172])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 90509B62B7;
        Tue, 29 Mar 2022 19:56:37 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: gpio: uniphier: Add hogs parsing
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1648430916-21988-1-git-send-email-hayashi.kunihiko@socionext.com>
 <9f7355de-8154-7ff2-ce29-c89ccfb89cab@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <81864a56-f48b-a41a-614b-16128f3850a9@socionext.com>
Date:   Tue, 29 Mar 2022 19:56:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9f7355de-8154-7ff2-ce29-c89ccfb89cab@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/03/29 4:04, Krzysztof Kozlowski wrote:
> On 28/03/2022 03:28, Kunihiko Hayashi wrote:
>> Allow parsing GPIO controller children nodes with GPIO hogs to fix the
>> following warning:
>>
>>    uniphier-ld11-ref.dtb: gpio@55000000: 'xirq0-hog' does not match any of
>> the regexes: 'pinctrl-[0-9]+'
>>        From schema:
>> Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../devicetree/bindings/gpio/socionext,uniphier-gpio.yaml  | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
>> b/Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
>> index bcafa494ed7a..b6f5963a2ae6 100644
>> --- a/Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
>> +++ b/Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
>> @@ -52,6 +52,13 @@ properties:
>>         <child-interrupt-base parent-interrupt-base length> triplets.
>>       $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>
>> +patternProperties:
>> +  "^(.+-hog(-[0-9]+)?)$":
> 
> The outer () are not needed.

Surely, the "()" can be removed.

>> +    type: object
> 
> You need also properties. See for example:
> Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml

I see. I should list the valid properties in patternProperties.
I'll add it.

Thank you,

---
Best Regards
Kunihiko Hayashi
