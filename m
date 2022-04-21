Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC350ABC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392462AbiDUXGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiDUXF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:05:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD0D4839F;
        Thu, 21 Apr 2022 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=vL/W45Gfjw/HwQhtvjL88yNghuAlDto3M3aCv6IU0jU=; b=sDu4foEfZtxvuMNTu1o48+078H
        MzUI2mLzlyLnOxDjWVMcCz5jo5w6ilUE5KOUrdmndCsPEBHMfBrjaGw7fnaXvOJqDZNVJ/1n3JNSR
        EbyqUlj7NZHVjwX/qrCRALCeDP0C0gJsjbFn/vKybeiKnw9ydw3uhD0LKTkh5Iz+zGd0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nhfpB-00GsVH-SL; Fri, 22 Apr 2022 01:02:57 +0200
Date:   Fri, 22 Apr 2022 01:02:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/8] dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
Message-ID: <YmHiofjPdWux1BJ6@lunn.ch>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
 <20220421175657.1259024-4-sean.anderson@seco.com>
 <YmHTwPsZ2QNoFmAF@lunn.ch>
 <535b1363-1d74-1068-7270-16a5e582b403@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <535b1363-1d74-1068-7270-16a5e582b403@seco.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 06:06:39PM -0400, Sean Anderson wrote:
> Hi Andrew,
> 
> On 4/21/22 5:59 PM, Andrew Lunn wrote:
> > On Thu, Apr 21, 2022 at 01:56:52PM -0400, Sean Anderson wrote:
> >> The TA_PROG_SFP supply must be enabled to program the fuses, and
> >> disabled to read the fuses (such as at power-on-reset). On many boards,
> >> this supply is controlled by a jumper. The user must manually insert or
> >> remove it at the appropriate time in the programming process. However,
> >> on other boards this supply is controlled by and FPGA or a GPIO. In
> >> these cases, the driver can automatically enabled and disable it as
> >> necessary.
> >> 
> >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> >> ---
> >> 
> >>  .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml        | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> >> index 54086f50157d..e7d1232fcd41 100644
> >> --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> >> +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> >> @@ -32,6 +32,11 @@ properties:
> >>    clock-names:
> >>      const: sfp
> >>  
> >> +  ta-prog-sfp-supply:
> >> +    description:
> >> +      The TA_PROG_SFP supply. It will be enabled for programming and disabled
> >> +      for reading.
> >> +
> > 
> > Doesn't there need to be some indication what this is? Is it a GPIO,
> > or maybe a regulator?
> 
> There is a pin on these processors named "TA_PROG_SFP". The supply here should
> be for whatever regulator supplies that pin. So it could be a fixed-regulator
> or perhaps a sub-node of the board's FPGA (no such node exists yet, but it
> certainly could). There's a pattern property under
> Documentation/devicetree/bindings/regulator/regulator.yaml for these sorts
> of nodes.

Ah, so -supply means regulator. I would spell it out for dumb people
like my:

  ta-prog-sfp-supply:
    description:
      The regulator supplying TA_PROG_SFP. It will be enabled for programming and disabled
      for reading.

      Andrew
