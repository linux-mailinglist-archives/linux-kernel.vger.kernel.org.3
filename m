Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F71572159
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiGLQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiGLQtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:49:04 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123AF1B7;
        Tue, 12 Jul 2022 09:49:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u14so10565244ljh.2;
        Tue, 12 Jul 2022 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=jZlp/3l+ClSidDbuE2aiwRaFz4EhPjWqcH0ZCOW33tY=;
        b=Ql8GHV5qptFiQDmuuqTIhkG9ZbmZEI+cRVmmDzcq1zTyZeia/sePy7CDkp5EEU/nyb
         urN6qwz4w7ZLPZJs7qm0l532VbExbvJ/Hkh4X+BDvbC9ld4Mn8FkVTE1YIGl+LNw2i/f
         vQHv5t/9ojj/325Bek7FBwIR3X7wXUpjoEZpUGaBzg73L5unJaefPC4QZrkFGUnmztiE
         izRJAdktU9cuiYSBStyqhVroaK9HEIdteb6F9MWO/9Eg/HoAb/QGaR2LW1zjgXgbniTS
         L0UhgPOagfE4fVjwxN8sp1pVO7RuMuqEcLmgxCT8Ok60XNA+IVQf3ox8qvlqkCGPNgNC
         qfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=jZlp/3l+ClSidDbuE2aiwRaFz4EhPjWqcH0ZCOW33tY=;
        b=zXDchwZ1UJ2vkdiDR9t7L70M4y6z7kOCjSRJ8zAGZ/uhjJ4zp+m7pd/m+R/ZejI+Jf
         uR5mpQ/P1jNje5NUK0UXhFm5fxBxH0gyaUCYdpRGTD0VHZPsu6T6UoKQXmbDyDrO77Uo
         OjkGwDaajpqHNGcSE0I42EmpzyVEHvpPd+LhLSb9oLgoB5qhBpNNfU6ljxK0FeeTfi5O
         hJONOGOFu++ANZ0Kq+bGpnN4C6kDTmstxx6B30+s0Yk9B/R/yddSFbxpVFZZY/j06wU+
         M5gxDL5pREmsLkpuCz5LV5jpgIg0CEStYG2bmDVl9xlVbKndqeDY+Vkds8KyyOlwV5gy
         bWKQ==
X-Gm-Message-State: AJIora84s9fWs/yhbbNWes26PgxmKVR79RwF/FIEEvlNcBuPYSgGTvrw
        VmURZYZppsRY5aZjt34SKf6ghuJVPf0KSJsA
X-Google-Smtp-Source: AGRyM1t/eAVsmwXrlU9D0jDmyjH9uPoyXGxynUs2xkhaN9zMxD7t9hVdEMrpAeauaYZ4tRD9DVNJrw==
X-Received: by 2002:a2e:2419:0:b0:25d:794f:3fa3 with SMTP id k25-20020a2e2419000000b0025d794f3fa3mr2662845ljk.233.1657644538971;
        Tue, 12 Jul 2022 09:48:58 -0700 (PDT)
Received: from razdolb (95-31-189-152.broadband.corbina.ru. [95.31.189.152])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25628000000b0048329aa6c92sm2266064lff.139.2022.07.12.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:48:58 -0700 (PDT)
References: <20220712141925.678595-1-mike.rudenko@gmail.com>
 <20220712141925.678595-2-mike.rudenko@gmail.com>
 <82d4507a-d092-8cb0-2e88-4290661d114d@linaro.org>
User-agent: mu4e 1.7.27; emacs 28.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dt-bindings: media: i2c: document OV4689 DT
 bindings
Date:   Tue, 12 Jul 2022 19:40:17 +0300
In-reply-to: <82d4507a-d092-8cb0-2e88-4290661d114d@linaro.org>
Message-ID: <874jzmgtty.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Krzysztof,

On 2022-07-12 at 17:12 +02, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 12/07/2022 16:19, Mikhail Rudenko wrote:
>> Add device-tree binding documentation for OV4689 image sensor driver,
>> and the relevant MAINTAINERS entries.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  .../bindings/media/i2c/ovti,ov4689.yaml       | 122 ++++++++++++++++++
>>  MAINTAINERS                                   |   7 +
>>  2 files changed, 129 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> new file mode 100644
>> index 000000000000..6bdebe5862b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> @@ -0,0 +1,122 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Omnivision OV4689 CMOS Sensor Device Tree Bindings
>
> s/Device Tree Bindings//

Ack, will fix in v2.

>> +
>> +maintainers:
>> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
>> +
>> +description: |-
>
> No need for -
>

Ack

>> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
>> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
>> +  at 2688x1520 resolution. It is programmable through an I2C
>> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
>> +  connection.
>> +
>> +allOf:
>> +  - $ref: /schemas/media/video-interface-devices.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: ovti,ov4689
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    description:
>> +      External clock for the sensor.
>
> This goes to clocks instead.
>

Ack

>> +    items:
>> +      - const: xclk
>
> No need for clock-names for such case.
>

Ack

>> +
>> +  dovdd-supply:
>> +    description:
>> +      Definition of the regulator used as Digital I/O voltage supply.
>
> s/Definition of the regulator used as //
>
> It's redundant...
>

Ack

>> +
>> +  avdd-supply:
>> +    description:
>> +      Definition of the regulator used as Analog voltage supply.
>
> Ditto
>

Ack

>> +
>> +  dvdd-supply:
>> +    description:
>> +      Definition of the regulator used as Digital core voltage supply.
>
> Ditto
>

Ack

>> +
>> +  powerdown-gpios:
>> +    maxItems: 1
>> +    description:
>> +      Reference to the GPIO connected to the powerdown pin (active low).
>
> s/Reference to the//
>

Ack

>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      Reference to the GPIO connected to the reset pin (active low).
>
> The same.
>

Ack

>> +
>> +  orientation: true
>> +
>> +  rotation: true
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/$defs/port-base
>> +    additionalProperties: false
>> +    description:
>> +      Output port node, single endpoint describing the CSI-2 transmitter.
>> +
>> +    properties:
>> +      endpoint:
>> +        $ref: /schemas/media/video-interfaces.yaml#
>> +        unevaluatedProperties: false
>> +
>
> Best regards,
> Krzysztof

Thanks for review! By the way, I used an existing schema for a similar
sensor ("ovti,ov02a10.yaml", specifically) as an example, and your notes
apply to it too. Looks like it should also be fixed...


--
Best regards,
Mikhail Rudenko
