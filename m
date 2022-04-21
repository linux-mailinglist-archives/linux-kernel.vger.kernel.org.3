Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12DC50A7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391197AbiDUSV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377142AbiDUSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:21:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04613EAA9;
        Thu, 21 Apr 2022 11:18:32 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 04C0A221D4;
        Thu, 21 Apr 2022 20:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650565111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8F6CN53BzDZd0GMZX26lmOXkDER5jODrK2Ga60c0CVk=;
        b=haspqQR+8nkQNrGwTx3EQqnDmd+2SRdz5JmOPZnrMg9CndqZ59zzbpPiNTZL6wjwAPniyT
        e1SvFJtellWwqCE4XhM2lYr9s4VvZeZpHqDyGIrU2VyDO80VX/rhp3qIJJL6GCCOzBCNHl
        fKTZk5iIPsrEIIWXD1+BjQAdNISJoro=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Apr 2022 20:18:30 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 4/8] dt-bindings: nvmem: sfp: Add compatible binding for
 TA 2.1 SFPs
In-Reply-To: <20220421175657.1259024-5-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
 <20220421175657.1259024-5-sean.anderson@seco.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <816dad4a1fd6869d89fc143030dd4ff9@walle.cc>
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
> Trust Architecture (TA) 2.1 devices include the LS1012A, LS1021A,
> LS1043A, and LS1046A. The SFP device on TA 2.1 devices is very similar
> to the SFP on TA 3.0 devices. The primary difference is a few fields in
> the control register. Add a compatible string.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml    | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> index e7d1232fcd41..aa277f1eee7e 100644
> --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> @@ -18,8 +18,13 @@ allOf:
> 
>  properties:
>    compatible:
> -    enum:
> -      - fsl,ls1028a-sfp
> +    oneOf:
> +      - description: Trust architecture 2.1 SFP
> +        items:
> +          - const: fsl,ls1021a-sfp
> +      - description: Trust architecture 3.0 SFP
> +        items:
> +          - const: fsl,ls1028a-sfp

I'm unsure about this one. Esp. if you reuse the fsl,ls1028a-sfp
compatible on other SoCs, there were some endianess issues with
other IP blocks on the ls1028a. So it might be that on the LS1028A
the IP has to accessed in little endian order and for other devices
in big endian. I think we should add one compatible per SoC unless
we know better.

-michael
