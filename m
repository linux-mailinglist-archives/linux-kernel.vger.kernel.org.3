Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0860049CAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiAZNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:24:24 -0500
Received: from box.trvn.ru ([194.87.146.52]:45461 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239136AbiAZNYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:24:21 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C6AC7400A0;
        Wed, 26 Jan 2022 18:24:17 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1643203458; bh=TIAqSWeDfTOLeUG3TlRCM5ui07kZfc3DdPbP89AONOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=18RXvb27zDUIDkTT35TH84VfaQApu747yNNDxRyp3+VS2UObNXClzo2f08eE0N0ZY
         vj2bz7JYj+DxEl8i3kQzxjVaXVJjd5oJHNzvzSK5prUIoSOQBzBAjdJ+VTRf3Hw+Fx
         cgjWoOFuRVLMRgxUE6RQteCwxhoQpw5ivbJ7101Dqt14MxeDeuhPzsK/SrT4AQJeQb
         P0x+sR8e4XKgxO1tkgEz9Wf/JohOnoyQ+eD7UqcxUi0FIqt7jFEEyEUex6DTWqy4Dq
         jHAifDlnCa0+K3DSJxSfQNxQw1pw9/KdUkfIDwBWHg7ExGxswOTlJ8Swh8kdxwSbyj
         34HhCPakqoZTg==
MIME-Version: 1.0
Date:   Wed, 26 Jan 2022 18:24:17 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        sean.anderson@seco.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: Document clk based PWM
 controller
In-Reply-To: <48350476-605c-0775-7d18-2601d3360241@kernel.org>
References: <20220126125849.75572-1-nikita@trvn.ru>
 <20220126125849.75572-2-nikita@trvn.ru>
 <48350476-605c-0775-7d18-2601d3360241@kernel.org>
Message-ID: <c7ad0c6b133186341d0377ac67538fd5@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 26.01.2022 18:14:
> On 26/01/2022 13:58, Nikita Travkin wrote:
>> Add YAML devicetree binding for clk based PWM controller
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> --
>> Changes in v2:
>>  - fix the file name.
>> Changes in v4:
>>  - Use generic node name in the dt bindings example.
>> ---
>>  .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>> new file mode 100644
>> index 000000000000..d3416ba549b5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/clk-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Clock based PWM controller
>> +
>> +maintainers:
>> +  - Nikita Travkin <nikita@trvn.ru>
>> +
>> +description: |
>> +  Some systems have clocks that can be exposed to external devices.
>> +  (e.g. by muxing them to GPIO pins)
>> +  It's often possible to control duty-cycle of such clocks which makes them
>> +  suitable for generating PWM signal.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: clk-pwm
>> +
>> +  clocks:
>> +    description: Clock used to generate the signal.
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 2
>> +
>> +unevaluatedProperties: false
>> +
>> +required:
> 
> You need a compatible. pwm-cells can be skipped as pwm.yaml will require
> them.
> 

Oops, thanks for noticing that, will add. (Though I'd assume compatible
to be implicitly required as the schema wouldn't even match otherwise...)

Nikita

>> +  - clocks
>> +
>> +examples:
>> +  - |
>> +    pwm {
>> +      compatible = "clk-pwm";
>> +      #pwm-cells = <2>;
>> +      clocks = <&gcc 0>;
>> +      pinctrl-names = "default";
>> +      pinctrl-0 = <&pwm_clk_flash_default>;
>> +    };
> 
> 
> Best regards,
> Krzysztof
