Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540515667B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiGEKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGEKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:20:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121C6140A9;
        Tue,  5 Jul 2022 03:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F75EB81737;
        Tue,  5 Jul 2022 10:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5629FC341C7;
        Tue,  5 Jul 2022 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657016447;
        bh=RAkY+wvaF4GTKl/ePFJozpLmUoWkpkz/u3e8jPZsNlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R00oG4MoK+jENJsN8NWEwyAabitOydRAZY5pVC5z1n47uXmbFpC97MmjcrYTNwocE
         C0cHwv2nwRjBd9vQfF4PKuExDVcufw+rkkerk5ngbDT6ipv52cCTTD216KYP5n3KVd
         Zq57LM46H3/Zv7UjtguPm42sQqeq/rpZlgJ7wR9UwRZutHARmyPoIpfj/VhCzEAoE6
         TTG9izVBhvnvqyCbLpBndoRcTSwqLRWxiBeJGuxMM+/d7T4s6siDEmdGXBvrJT+fy7
         CRjw43Pe7k8IMyZW9W6Ap2GVlqqiS+q0hfD8tCXCi94lzKGes3EzUN66FMQe1wv7sZ
         owZZ+7QA8t+dw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8ffj-00055H-SU; Tue, 05 Jul 2022 12:20:47 +0200
Date:   Tue, 5 Jul 2022 12:20:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/43] dt-bindings: phy: qcom,qmp: split out
 msm8996-qmp-pcie-phy
Message-ID: <YsQQfwqmiQ7O3FdY@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-7-johan+linaro@kernel.org>
 <46b0cdab-aa94-7f55-5d9f-f79a644f0fec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46b0cdab-aa94-7f55-5d9f-f79a644f0fec@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:08:36PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 11:42, Johan Hovold wrote:
> > The QMP PHY DT schema is getting unwieldy. Break out the odd-bird
> > msm8996-qmp-pcie-phy which is the only QMP PHY that uses separate
> > "per-lane" nodes.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 114 ++++++++++++++++++
> >  .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  32 -----
> >  2 files changed, 114 insertions(+), 32 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> > new file mode 100644
> > index 000000000000..14fd86fd91ec
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> > @@ -0,0 +1,114 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +
> 
> No line break
> 
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/phy/qcom,msm8996-qmp-pcie-phy.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> Drop the quotes from two above.

This comes from the current binding. I can clean that one up first.

> > +
> > +title: Qualcomm QMP PHY controller (MSM8996 PCIe)
> > +
> > +maintainers:
> > +  - Vinod Koul <vkoul@kernel.org>
> > +
> > +description:
> > +  QMP PHY controller supports physical layer functionality for a number of
> > +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,msm8996-qmp-pcie-phy
> > +
> > +  reg:
> > +    minItems: 1
> > +    items:
> > +      - description: Address and length of PHY's common serdes block.
> > +      - description: Address and length of PHY's DP_COM control block.
> 
> Are two reg items applicable here?

No, but see below.

> > +
> > +  "#address-cells":
> > +    enum: [ 1, 2 ]
> > +
> > +  "#size-cells":
> > +    enum: [ 1, 2 ]
> > +
> > +  ranges: true
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 4
> 
> Define clocks here, not in allOf:if:then.

To remain sane, and to help reviewers, I decided not to do changes to
the binding while splitting it up which would only make them harder
to review.

Hence the split followed by cleanup/tightening of constraints.

> How about an example?

That's also a new addition to the binding and goes in a later separate
patch.

Johan
