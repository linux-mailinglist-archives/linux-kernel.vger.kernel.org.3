Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A58C50EC07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiDYWZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343643AbiDYWBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:01:48 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64C3298E;
        Mon, 25 Apr 2022 14:58:42 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 59D0A22246;
        Mon, 25 Apr 2022 23:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650923920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCsEa7zKkDqLZy+dB+iRWtTIDIbRaSE/8JLGg5kT/lA=;
        b=B/vwdgRY9J8Xn903h4fqbxkT2zuHxf9NoV56Bh8CqE8Dl1vwTDZAOU1KeUM8lrBWj3aI4f
        erzbaLdSRTNVVYNve2Netuuwp5dhYr5GymSXePHQ2Rp9z9X7vgzQhcxDny0aYJ1hqFbKSq
        prT3Gz1uWzqH7Qd2crngmBYYeblCQ9Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Apr 2022 23:58:39 +0200
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: fsl,ls-extirq:
 convert to YAML
In-Reply-To: <658851ed-33fd-8e2b-7db7-ef1ca9e31c33@linaro.org>
References: <20220425140214.32448-1-michael@walle.cc>
 <658851ed-33fd-8e2b-7db7-ef1ca9e31c33@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <83b596d0570c779c61c3c37c6f512679@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-25 20:36, schrieb Krzysztof Kozlowski:
> On 25/04/2022 16:02, Michael Walle wrote:
>> Convert the fsl,ls-extirq binding to the new YAML format.
>> 
> 
> (...)
> 
>> diff --git 
>> a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml 
>> b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
>> new file mode 100644
>> index 000000000000..39d120ad7549
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
>> @@ -0,0 +1,88 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: 
>> http://devicetree.org/schemas/interrupt-controller/fsl,ls-extirq.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Freescale Layerscape External Interrupt Controller
>> +
>> +maintainers:
>> +  - Shawn Guo <shawnguo@kernel.org>
>> +  - Li Yang <leoyang.li@nxp.com>
>> +
>> +description: |
>> +  Some Layerscape SOCs (LS1021A, LS1043A, LS1046A LS1088A, LS208xA,
>> +  LX216xA) support inverting the polarity of certain external 
>> interrupt
>> +  lines.
>> +
>> +allOf:
>> +  - $ref: /schemas/interrupt-controller.yaml#
> 
> I have doubts whether this is here applicable. See also Rob's comment:
> https://lore.kernel.org/all/YjjJpxLWJ%2FYOe0OX@robh.at.kernel.org/
> 
> This device does not have children, so the interrupt-controller schema
> should be probably skipped.

ok.

>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - fsl,ls1021a-extirq
>> +          - fsl,ls1043a-extirq
>> +          - fsl,ls1088a-extirq
>> +      - items:
>> +          - enum:
>> +              - fsl,ls1046a-extirq
>> +          - const: fsl,ls1043a-extirq
>> +      - items:
>> +          - enum:
>> +              - fsl,ls2080a-extirq
>> +              - fsl,lx2160a-extirq
>> +          - const: fsl,ls1088a-extirq
>> +
>> +  '#interrupt-cells':
>> +    const: 2
>> +
>> +  '#address-cells':
>> +    const: 0
>> +
>> +  interrupt-controller: true
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description:
>> +      Specifies the Interrupt Polarity Control Register (INTPCR) in 
>> the
>> +      SCFG or the External Interrupt Control Register (IRQCR) in the 
>> ISC.
>> +
>> +  interrupt-map:

btw.

minItems: 12
maxItems: 12

Isn't working here, is that expected? The validator seem to get the 
count
of the elements of one tuple wrong.

I.e.
arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: 
interrupt-controller@14: interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 
0, 1, 4, 2, 0, 1, 0], [2, 4, 3, 0, 1, 0, 3, 4], [4, 0, 1, 0, 4, 4, 5, 
0], [1, 0, 5, 4, 6, 0, 1, 0], [6, 4, 7, 0, 1, 0, 7, 4], [8, 0, 1, 0, 8, 
4, 9, 0], [1, 0, 9, 4, 10, 0, 1, 0], [10, 4, 11, 0, 1, 0, 11, 4]] is too 
short

>> +    description: Specifies the mapping from external interrupts to 
>> GIC interrupts.
>> +
>> +  interrupt-map-mask:
>> +    items:
>> +      - const: 0xffffffff
> 
> This looks highly permissive mask and should be instead defined per
> variant, for example (quickly looking at DTS):
> 0x7 for ls1021
> 0xf for ls1043a and ls1088a

Just that I understand it correctly, the result of the AND with that
mask is then looked up in the interrupt-map (the first entry there)?

> You might need to correct the DTS. Some confirmation from someone with
> datasheet would be good.

According to their datasheets they have the following number of external
IRQs:
- ls1021a has 6,
- ls1043a has 12,
- ls1046a has 12,
- ls1088a has 12,
- ls2080a has 12,
- lx2160a has 12.

That is what I need to confirm, right?

Is there a better way than the following snippet:

properties:
   interrupt-map-mask: true

allOf:
   - if:
       properties:
         compatible:
           contains:
             enum:
               - fsl,ls1021a-extirq
     then:
       properties:
         interrupt-map-mask:
           items:
             - const: 0x7
             - const: 0
   - if:
       properties:
         compatible:
           contains:
             enum:
               - fsl,ls1043a-extirq
               - fsl,ls1046a-extirq
               - fsl,ls1088a-extirq
               - fsl,ls2080a-extirq
               - fsl,lx2160a-extirq
     then:
       properties:
         interrupt-map-mask:
           items:
             - const: 0xf
             - const: 0

-michael
