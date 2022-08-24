Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786F5A00FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbiHXSCU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Aug 2022 14:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiHXSBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:01:51 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD7D4DF22;
        Wed, 24 Aug 2022 11:00:39 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oQug4-0004qH-Mb; Wed, 24 Aug 2022 20:00:32 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, Conor.Dooley@microchip.com
Cc:     daniel.lezcano@linaro.org, anup@brainfault.org,
        Conor.Dooley@microchip.com, guoren@kernel.org,
        sagar.kadam@sifive.com, jrtc27@jrtc27.com, ajones@ventanamicro.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        qemu-riscv@nongnu.org, robh@kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: interrupt-controller: sifive,plic: add legacy riscv compatible
Date:   Wed, 24 Aug 2022 20:00:31 +0200
Message-ID: <7260367.4vTCxPXJkl@diego>
In-Reply-To: <95fe8df7-581e-f7ec-be1f-1c6e06cb30a4@microchip.com>
References: <20220823183319.3314940-1-mail@conchuod.ie> <3948407.AJdgDx1Vlc@diego> <95fe8df7-581e-f7ec-be1f-1c6e06cb30a4@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 24. August 2022, 19:55:17 CEST schrieb Conor.Dooley@microchip.com:
> On 24/08/2022 18:44, Heiko Stübner wrote:
> > Am Dienstag, 23. August 2022, 20:33:18 CEST schrieb Conor Dooley:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> While "real" hardware might not use the compatible string "riscv,plic0"
> >> it is present in the driver & QEMU uses it for automatically generated
> >> virt machine dtbs. To avoid dt-validate problems with QEMU produced
> >> dtbs, such as the following, add it to the binding.
> >>
> >> riscv-virt.dtb: plic@c000000: compatible: 'oneOf' conditional failed, one must be fixed:
> >>         'sifive,plic-1.0.0' is not one of ['sifive,fu540-c000-plic', 'starfive,jh7100-plic', 'canaan,k210-plic']
> >>         'sifive,plic-1.0.0' is not one of ['allwinner,sun20i-d1-plic']
> >>         'sifive,plic-1.0.0' was expected
> >>         'thead,c900-plic' was expected
> >> riscv-virt.dtb: plic@c000000: '#address-cells' is a required property
> >>
> >> Reported-by: Rob Herring <robh@kernel.org>
> >> Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml     | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> >> index 92e0f8c3eff2..99e01f4d0a69 100644
> >> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> >> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> >> @@ -66,6 +66,11 @@ properties:
> >>            - enum:
> >>                - allwinner,sun20i-d1-plic
> >>            - const: thead,c900-plic
> >> +      - items:
> >> +          - const: sifive,plic-1.0.0
> >> +          - const: riscv,plic0
> >> +        deprecated: true
> > 
> > hmm, when setting this to deprecated, does this mean qemu was changed
> > to not use that compatible anymore?
> > 
> > I.e. reading deprecated I'd assume that this is kept around for old qemu builds?
> 
> I did not make that change to QEMU. From v1 [0]:
> 
> Rob:
> > Conor:
> >> In arm's virt.c they use the generic gic compatible & I don't see any
> >> evidence of other archs using "qemu,foo" bindings. I suppose there's
> >> always the option of just removing the "riscv,plic0" from the riscv's
> >> virt.c
> >
> > I think we're pretty much stuck with what's in use already.
> 
> > I'm on the fence whether to mark it deprecated though if there is no 
> > plan to 'fix' it. Doesn't really matter until the tools can selectively 
> > remove deprecated properties from validation.
> 
> My interpretation was "do not use this compatible in any new devicetrees".
> 
> I don't really have any strong feelings here. Maybe the description is
> sufficient?

that makes sense then. Existing users can keep using it, but no-one should
create new usages of it, so this looks good then

Heiko


