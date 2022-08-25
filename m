Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D35A16BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbiHYQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiHYQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:32:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F536B81F3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:32:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id jm11so18952997plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=sPnypK+omnN4NaKyZT/jJYzqdJLQrrS9NmH3ZYgM+1c=;
        b=Sd1KVFPrdCZf7Afab7qAt7rAKxXkdSaydhBN2TY7lxwcH7lh11Bb5qE6LQFvcq6y/w
         u37tdcyA/7+vo5Vjrn/eHyXPULWhbKrRd+PctBVJC7ZnTGGhvBeJE6bOvpFFoNY2Cvdn
         LXIpnQ69V4lR4u69xO9vty38GUHaJOXxIqp4p7l+E6W8qnlZofexhXDG1AgZQ3mr4C/m
         MURrPCnnyE7iGf/gb9XMT3RelVphZ32/cB07R/S4Z65Vggk/4KrQ7b+HzDvAMS9SO/kH
         samVKKG/Mlm6NPLdH8jiIBp/5f9JVx6Dpj5i2EJg3if/IfiRo0ymVvipR1LHbXK8p49m
         mI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=sPnypK+omnN4NaKyZT/jJYzqdJLQrrS9NmH3ZYgM+1c=;
        b=Rdw5qVfyJ+NMRlsJBhtSXK1sNz4RslGHp8BZXPYVB4zXz4iRsCsMcnlrnbH7v79Bzp
         uu0yFdithM2OMCrnKhZHLCgNx8FyOSDIE+xaEHBNOHgXBVp5yLttrFkYs9kv81ILIxHY
         FbgIWgwJ3FpVOcb9k6NU+SyUgEqJs7TAISIKeTw/d/ek2/hqNUfOyseBNhFXBrAWjsOe
         ZTQBMI3EZemGuXCPY5REw6tqEd/Ymge8F2O9SSMJkdrGkVYyayu3yPbwaagZe2iSsoc3
         OqoSJ/TvsXx6rP1Rz7OO3UJSuRO7UQfWXW0bPltR3KVHi/XXqQBNBVyQyEdQ724b9kTq
         kp4Q==
X-Gm-Message-State: ACgBeo1FAPKx+sMV8OW/kCKLRoPZ0bRPOwvqyUkjJrHB+myYd5pWDL91
        CMnOwRo3EMd7PoBBikLtuDyrFA==
X-Google-Smtp-Source: AA6agR7mz8cQUwkxL9Bv/hIpB+gTpvIF8B7Hkh4amGYsubylHmdqLgf+o9KxCVhz7JzWeXfZ52Z5nw==
X-Received: by 2002:a17:90b:4b47:b0:1f7:2e06:5752 with SMTP id mi7-20020a17090b4b4700b001f72e065752mr5520149pjb.187.1661445136082;
        Thu, 25 Aug 2022 09:32:16 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b001728eb339e2sm14983625plh.286.2022.08.25.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:32:15 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:32:12 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: coresight: Add 'power-domains'
 property
Message-ID: <20220825163212.GA1909152@p14s>
References: <20220721212718.1980905-1-robh@kernel.org>
 <CAL_JsqJCGPSxYb5CqiEM9YAmJjQE4wp_0HCWgBSqPDBBAJRMBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJCGPSxYb5CqiEM9YAmJjQE4wp_0HCWgBSqPDBBAJRMBA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 02:04:31PM -0500, Rob Herring wrote:
> On Thu, Jul 21, 2022 at 4:27 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Coresight components may be in a power domain which is the case for the Arm
> > Juno board. Allow a single 'power-domains' entry for Coresight components.
> 
> Ping.

Somehow this fell through the cracks.  I've applied both patches.

Thanks,
Mathieu

> 
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml  | 3 +++
> >  Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml   | 3 +++
> >  .../devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml  | 3 +++
> >  .../bindings/arm/arm,coresight-dynamic-replicator.yaml         | 3 +++
> >  Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml | 3 +++
> >  Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml   | 3 +++
> >  .../devicetree/bindings/arm/arm,coresight-static-funnel.yaml   | 3 +++
> >  .../bindings/arm/arm,coresight-static-replicator.yaml          | 3 +++
> >  Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml   | 3 +++
> >  Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml   | 3 +++
> >  Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml  | 3 +++
> >  .../devicetree/bindings/arm/arm,embedded-trace-extension.yaml  | 3 +++
> >  12 files changed, 36 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> > index d783d9276124..2bae06eed693 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> > @@ -61,6 +61,9 @@ properties:
> >      maxItems: 1
> >      description: Address translation error interrupt
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    in-ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >      additionalProperties: false
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> > index 72ffe4d1e948..0c5b875cb654 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> > @@ -98,6 +98,9 @@ properties:
> >        base cti node if compatible string arm,coresight-cti-v8-arch is used,
> >        or may appear in a trig-conns child node when appropriate.
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    arm,cti-ctm-id:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description:
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> > index 1eeedc22857c..44a1041cb0fc 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> > @@ -54,6 +54,9 @@ properties:
> >        - const: apb_pclk
> >        - const: atclk
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    in-ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
> > index a26ed9214e00..03792e9bd97a 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
> > @@ -54,6 +54,9 @@ properties:
> >        - const: apb_pclk
> >        - const: atclk
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    qcom,replicator-loses-context:
> >      type: boolean
> >      description:
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
> > index fd06ede26ceb..90679788e0bf 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
> > @@ -54,6 +54,9 @@ properties:
> >        - const: apb_pclk
> >        - const: atclk
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    in-ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >      additionalProperties: false
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
> > index e0377ce48537..01200f67504a 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
> > @@ -73,6 +73,9 @@ properties:
> >        - const: apb_pclk
> >        - const: atclk
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    arm,coresight-loses-context-with-cpu:
> >      type: boolean
> >      description:
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
> > index b9da30ab9ccd..06a1d346982c 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
> > @@ -27,6 +27,9 @@ properties:
> >    compatible:
> >      const: arm,coresight-static-funnel
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    in-ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
> > index 66ee97370fb2..5178e7fdff0b 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
> > @@ -27,6 +27,9 @@ properties:
> >    compatible:
> >      const: arm,coresight-static-replicator
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    in-ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >      additionalProperties: false
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
> > index 905008faa012..378380c3f5aa 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
> > @@ -61,6 +61,9 @@ properties:
> >        - const: apb_pclk
> >        - const: atclk
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    out-ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >      additionalProperties: false
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> > index 3463b6e53aef..e0b88a71356a 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> > @@ -55,6 +55,9 @@ properties:
> >        - const: apb_pclk
> >        - const: atclk
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    arm,buffer-size:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      deprecated: true
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
> > index e80d48200c37..61a0cdc27745 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
> > @@ -54,6 +54,9 @@ properties:
> >        - const: apb_pclk
> >        - const: atclk
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    in-ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >      additionalProperties: false
> > diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> > index 5f07fb166c56..108460627d9a 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> > @@ -33,6 +33,9 @@ properties:
> >        Handle to the cpu this ETE is bound to.
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    out-ports:
> >      description: |
> >        Output connections from the ETE to legacy CoreSight trace bus.
> > --
> > 2.34.1
> >
