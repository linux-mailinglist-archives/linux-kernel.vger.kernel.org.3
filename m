Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162E65086FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378096AbiDTLaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378093AbiDTL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:29:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C241608;
        Wed, 20 Apr 2022 04:27:08 -0700 (PDT)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6516D22249;
        Wed, 20 Apr 2022 13:27:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650454027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ik2ns8BjGvma+kcnUHSgUe92puZeAqjO0QIBOmC2o1I=;
        b=JCjHUsJYvhVJULzvaBiJZJyXoGDj6pmDMhaITAgSaK7cz6YysOANvIYZClBHrvhRV0MO+x
        n9hCW0twa3x8Jj/T5aNyNYx1l/x/mvl6iApipodidO54WnaCmC/b841gYnVIbSVPh++7W/
        cJ17fjRnzA1ZlH+sBp44gkIPPP4wav8=
From:   Michael Walle <michael@walle.cc>
To:     jerry.huang@nxp.com
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 1/2 v3] dt-bindings: dspi: added for semtech sx1301
Date:   Wed, 20 Apr 2022 13:26:57 +0200
Message-Id: <20220420112657.270293-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420035045.33940-1-jerry.huang@nxp.com>
References: <20220420035045.33940-1-jerry.huang@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add DT Binding doc for semtech sx1301

Please be a bit more elaborate. The sx1301 seems to be an
SPI device, some kind of WAN device.

> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
> changes in v3:
>   - add the dt-bindings
> 
>  .../bindings/spi/semtech,sx1301.yaml          | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> new file mode 100644
> index 000000000000..f65fb5809218
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/semtech,sx1301.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech sx1301 devicetree bindings
> +
> +allOf:
> +  - $ref: "spi-controller.yaml"

.. then why does it inherit the spi controllers properties?

Also *some* kind of information what the sx1301 is would be nice.

Anyway, I was about to comment on your patch 2. But maybe I'll
just leave it here. On the RDB there is a mikrobus connector, with
this, you are going to say "hey there is always a sx1301" module
there. What happens if it not there? What if you put another module
in that socket?

Maybe Krzystof knows better. But it really looks like you want to
have device tree overlays here instead of hardcoding exactly one
use case.

-michael

> +
> +maintainers:
> +  - Changming Huang <jerry.huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: semtech,sx1301
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  fsl,spi-cs-sck-delay: true
> +
> +  fsl,spi-sck-cs-delay: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mikrobus@0 {
> +      compatible = "semtech,sx1301";
> +      reg = <0>;
> +      spi-max-frequency = <2000000>;
> +      fsl,spi-cs-sck-delay = <1000000>;
> +      fsl,spi-sck-cs-delay = <50>;
> +    };
> +
> +...
> -- 
> 2.25.1
> 
> 
