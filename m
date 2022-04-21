Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F99C50A7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381275AbiDUSP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiDUSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:15:26 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F056431;
        Thu, 21 Apr 2022 11:12:36 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 59439221D4;
        Thu, 21 Apr 2022 20:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650564754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ts6rqzSFl+U/1vZW3tUs1vbFzVMiItVsA9fsXqIDkFI=;
        b=adtvdiWGqOSS3QqdMftPgNpszCPfNmrbDY3Opm67Pi5H8X3njSmCLVMGFCES+9pthJzGJU
        P1MAXSrWSSIDI4jxc4NyPEqFFI0EqC4Ve5SgyRDERhfIBD81y9/Pp/Ht/wY2PyduRozp+I
        9DV6ZXkkNxUz5zHWviW0gLeUxkEQb60=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Apr 2022 20:12:34 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/8] dt-bindings: nvmem: sfp: Add clock properties
In-Reply-To: <20220421175657.1259024-3-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
 <20220421175657.1259024-3-sean.anderson@seco.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4a45db184fbadc278624571dfbeb5004@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-21 19:56, schrieb Sean Anderson:
> To program fuses, it is necessary to set the fuse programming time. 
> This
> is determined based on the value of the platform clock. Add a clock
> property.

For some context: Sean was adding the SFP support in u-boot and
I referred him to this binding. I didn't need the clock to just
read the data. But Sean is right, we need the clock for the
programming. I was unaware of that. The binding is still yet to
be released with v5.18, thus I think it is still possible to make
the clock mandatory.

> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Fixes: 6f9817cdcc82 ("dt-bindings: nvmem: add fsl,layerscape-sfp 
binding")

-michael

> ---
> 
>  .../bindings/nvmem/fsl,layerscape-sfp.yaml         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> index b7798e903191..54086f50157d 100644
> --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> @@ -24,15 +24,29 @@ properties:
>    reg:
>      maxItems: 1
> 
> +  clocks:
> +    maxItems: 1
> +    description:
> +      The SFP clock. Typically, this is the platform clock divided by 
> 4.
> +
> +  clock-names:
> +    const: sfp
> +
>  required:
>    - compatible
>    - reg
> +  - clock-names
> +  - clocks
> 
>  unevaluatedProperties: false
> 
>  examples:
>    - |
> +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
>      efuse@1e80000 {
>          compatible = "fsl,ls1028a-sfp";
>          reg = <0x1e80000 0x8000>;
> +        clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                            QORIQ_CLK_PLL_DIV(4)>;
> +        clock-names = "sfp";
>      };
