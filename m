Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE99D46B1F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbhLGEjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:39:25 -0500
Received: from marcansoft.com ([212.63.210.85]:48140 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236121AbhLGEjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:39:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2442942181;
        Tue,  7 Dec 2021 04:35:44 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add Apple Watchdog
To:     Guenter Roeck <linux@roeck-us.net>, Sven Peter <sven@svenpeter.dev>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Janne Grunau <j@jannau.net>,
        Mark Kettenis <kettenis@openbsd.org>,
        Rob Herring <robh@kernel.org>
References: <20211130161809.64591-1-sven@svenpeter.dev>
 <20211202144301.GA829000@roeck-us.net>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <bd9a52eb-2aca-38a9-e183-2857960a4842@marcan.st>
Date:   Tue, 7 Dec 2021 13:35:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211202144301.GA829000@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2021 23.43, Guenter Roeck wrote:
> On Tue, Nov 30, 2021 at 05:18:08PM +0100, Sven Peter wrote:
>> Apple SoCs come with a simple embedded watchdog. This watchdog is also
>> required in order to reset the SoC.
>>
>> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
>> ---
>> v1 --> v2:
>>    - add Mark's and Rob's r-b tags
>>
>>   .../bindings/watchdog/apple,wdt.yaml          | 52 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>> new file mode 100644
>> index 000000000000..e58c56a6fdf6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/watchdog/apple,wdt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple SoC Watchdog
>> +
>> +allOf:
>> +  - $ref: "watchdog.yaml#"
>> +
>> +maintainers:
>> +  - Sven Peter <sven@svenpeter.dev>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - apple,t8103-wdt
>> +          - apple,t6000-wdt
>> +      - const: apple,wdt
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - interrupts
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    wdt: watchdog@50000000 {
>> +        compatible = "apple,t8103-wdt", "apple,wdt";
>> +        reg = <0x50000000 0x4000>;
>> +        clocks = <&clk>;
>> +        interrupts = <AIC_IRQ 123 IRQ_TYPE_LEVEL_HIGH>;
>> +    };
>> +
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 360e9aa0205d..859201bbd4e8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1750,6 +1750,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>>   F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>>   F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
>>   F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>> +F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>>   F:	arch/arm64/boot/dts/apple/
>>   F:	drivers/i2c/busses/i2c-pasemi-core.c
>>   F:	drivers/i2c/busses/i2c-pasemi-platform.c
>> -- 
>> 2.25.1
>>
> 

I've gone ahead and applied this patch to the asahi-soc/dt tree, so we 
can build off of that to add the DT nodes.

Sven, can you spin a v3 with the MAINTAINERS split and just the driver 
itself, without this patch? I imagine Guenter will want to take the 
driver itself through the linux-watchdog tree.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
