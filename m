Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0B575725
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbiGNVoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiGNVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:44:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5B13F85;
        Thu, 14 Jul 2022 14:43:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o12so3697738ljc.3;
        Thu, 14 Jul 2022 14:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=UgtOla5iDdHvY794z5uOthpZLFwvuSdiV1bTDAW0mWg=;
        b=jQp3zOlZb8SydXE3IiTDbjwmoz94rlhSBjMCDYJaAhtQPaWOAELyzretwUzWmI/gyL
         wPQF9aDj79QJO4ClxYOZ2M0cb2cvRaX2yKJqZbA/yAfCwW7aQf3dxTncQnrAB1Sz9mjV
         NWMxeJjkhbYULjFwyDAGTi+1VfNwGvQtHyeTMV71LRqM1A97t5jo6xZ0fNA9MqBdxxY+
         +yswsroXaP8ssHRAsJeotqii/3xAMhFr0XZZ6Tk5pZPg079nAOqZjmccPqQC4bKJ+hNL
         cXzAuoJ4DOW4RXyMWtctXnysBPcWnEEMEeY5clmmGaUi8F97+5/2fTIqP3m1R7EGSdtK
         dFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=UgtOla5iDdHvY794z5uOthpZLFwvuSdiV1bTDAW0mWg=;
        b=b3l/yEt4LSvunF8huLo7jG6yAkxv/i5nK+Ci+4oDErIkfA0ctrl6WQ/+4bvCN/B/LN
         q7q/jcxkfwJnunQeOpsMYIlJS41X5HKVtt3MICnxSKF+5LFF59/l7Zo/FcBZcyJbRyX8
         8NMe5owtIjmm3dguV++1HLcAkNtqj9Gp3kHyNzZuG/OQoXoa8KhXbDnDB1ql6BljmBxP
         mVHytoqvX637sLhlgmrFWEpQh2a5VFp0/nFbx4cRXT4ytFx6vipLNhQYSd31a9qIz8Mh
         k0lxLwETo4SL/7YdOpKPza+wafuBzhOlPrJVPsNU/XAdJTDjwGP3qM6AZpL1g8zd3Be5
         gQYA==
X-Gm-Message-State: AJIora85nGSMmusASh8O2cF3lIJDyL8oh+Pj6GUCQ6AcZUQ6YOhUxcyL
        9/QQ4payXEb9dmg38q2IW68kiIrKwZli3g==
X-Google-Smtp-Source: AGRyM1seRrQY8GY3IH9uaKjaGGfCmlx4S3oZGra7nDuZclzlNcDZOSbq67LR4/xpHKsBD8ZsSUb6bA==
X-Received: by 2002:a2e:b0fc:0:b0:25d:a025:fd03 with SMTP id h28-20020a2eb0fc000000b0025da025fd03mr1055971ljl.87.1657835035779;
        Thu, 14 Jul 2022 14:43:55 -0700 (PDT)
Received: from razdolb (95-31-189-152.broadband.corbina.ru. [95.31.189.152])
        by smtp.gmail.com with ESMTPSA id 27-20020ac25f5b000000b0047255d210e4sm548496lfz.19.2022.07.14.14.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:43:55 -0700 (PDT)
References: <20220712141925.678595-1-mike.rudenko@gmail.com>
 <20220712141925.678595-2-mike.rudenko@gmail.com>
 <YtCGeBp5U18ljyuX@valkosipuli.retiisi.eu>
User-agent: mu4e 1.7.27; emacs 28.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dt-bindings: media: i2c: document OV4689 DT
 bindings
Date:   Fri, 15 Jul 2022 00:43:04 +0300
In-reply-to: <YtCGeBp5U18ljyuX@valkosipuli.retiisi.eu>
Message-ID: <87zghb8j51.fsf@gmail.com>
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


On 2022-07-15 at 00:11 +03, Sakari Ailus <sakari.ailus@iki.fi> wrote:

> Hi Mikhail,
>
> Thanks for the patch.
>
> On Tue, Jul 12, 2022 at 05:19:09PM +0300, Mikhail Rudenko wrote:
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
>> +
>> +maintainers:
>> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
>> +
>> +description: |-
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
>> +    items:
>> +      - const: xclk
>> +
>> +  dovdd-supply:
>> +    description:
>> +      Definition of the regulator used as Digital I/O voltage supply.
>> +
>> +  avdd-supply:
>> +    description:
>> +      Definition of the regulator used as Analog voltage supply.
>> +
>> +  dvdd-supply:
>> +    description:
>> +      Definition of the regulator used as Digital core voltage supply.
>> +
>> +  powerdown-gpios:
>> +    maxItems: 1
>> +    description:
>> +      Reference to the GPIO connected to the powerdown pin (active low).
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      Reference to the GPIO connected to the reset pin (active low).
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
>
> The number of lanes is needed, please require data-lanes property here (as
> well as add it to the example).

Thanks for review, will fix in v2

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - dovdd-supply
>> +  - avdd-supply
>> +  - dvdd-supply
>> +  - powerdown-gpios
>> +  - reset-gpios
>> +  - port
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        ov4689: camera@36 {
>> +            compatible = "ovti,ov4689";
>> +            reg = <0x36>;
>> +
>> +            clocks = <&ov4689_clk>;
>> +            clock-names = "xclk";
>> +
>> +            avdd-supply = <&ov4689_avdd>;
>> +            dovdd-supply = <&ov4689_dovdd>;
>> +            dvdd-supply = <&ov4689_dvdd>;
>> +
>> +            powerdown-gpios = <&pio 107 GPIO_ACTIVE_LOW>;
>> +            reset-gpios = <&pio 109 GPIO_ACTIVE_LOW>;
>> +
>> +            orientation = <2>;
>> +            rotation = <0>;
>> +
>> +            port {
>> +                wcam_out: endpoint {
>> +                    remote-endpoint = <&mipi_in_wcam>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f468864fd268..63c4844f26e6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14523,6 +14523,13 @@ S:	Maintained
>>  T:	git git://linuxtv.org/media_tree.git
>>  F:	drivers/media/i2c/ov2740.c
>>
>> +OMNIVISION OV4689 SENSOR DRIVER
>> +M:	Mikhail Rudenko <mike.rudenko@gmail.com>
>> +L:	linux-media@vger.kernel.org
>> +S:	Maintained
>> +T:	git git://linuxtv.org/media_tree.git
>> +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> +
>>  OMNIVISION OV5640 SENSOR DRIVER
>>  M:	Steve Longerbeam <slongerbeam@gmail.com>
>>  L:	linux-media@vger.kernel.org


--
Best regards,
Mikhail Rudenko
