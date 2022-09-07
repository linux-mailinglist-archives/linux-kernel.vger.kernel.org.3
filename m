Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13AD5B0A28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIGQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiIGQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BBF86705;
        Wed,  7 Sep 2022 09:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 060A6619CC;
        Wed,  7 Sep 2022 16:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D45CC4314B;
        Wed,  7 Sep 2022 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662568341;
        bh=5WbcCfZRJu9cYVet1elgBrqqShd4l0yonhdRZ64vnO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H97fhlhXq6e2nrOKRg9PF7TC1Q6l9sn2MBz27zi+IUf0q5wsBQEAqgiAXtUS6HbgT
         UKy2oFx5RZ7KwFove4MSV+XQEWkp8nY5G4T3fZsXvB/8k4ZqUAuRn8WDqasb5DpiCY
         6IahxcrMoYmKDMEaP/Pe4/6uPG5O4443p4Q8Z7fxp8R118A6XWExvvqrYGheNlunRj
         Z9Zr8/rappROaHXCKGd2sjdQTNm4Bz89PWfOYn8zqh40K1Cdp31LDrSvXSaVb4fi2S
         uGA8fu1O8WAPA20vlF1RmIVqxgEQ/U0mJo2+HbleVIV1iJ1aCLnU72nKwz1G350JOe
         vUDDH81FXnCUA==
Received: by pali.im (Postfix)
        id 3D8687F0; Wed,  7 Sep 2022 18:32:18 +0200 (CEST)
Date:   Wed, 7 Sep 2022 18:32:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: reset: restart-handler: add common
 schema
Message-ID: <20220907163218.aja4pazw3sbxnoop@pali>
References: <20220907123630.57383-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907123630.57383-1-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 September 2022 14:36:30 Krzysztof Kozlowski wrote:
> Add common schema for restart and shutdown handlers, so they all use
> same meaning of "priority" field.  The Linux drivers already have this
> property and some systems want to customize it per-board in DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> See also:
> https://lore.kernel.org/all/8fe93da3-f768-16ae-7025-1cfa97a42b27@linaro.org/
> https://lore.kernel.org/all/20220831081715.14673-1-pali@kernel.org/
> ---
>  .../bindings/power/reset/gpio-restart.yaml    | 13 ++------
>  .../bindings/power/reset/restart-handler.yaml | 30 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> index a72d5c721516..d3d18e0f5db3 100644
> --- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> @@ -25,6 +25,9 @@ description: >
>    inactive-delay, the GPIO is driven active again.  After a delay specified by wait-delay, the
>    restart handler completes allowing other restart handlers to be attempted.
>  
> +allOf:
> +  - $ref: restart-handler.yaml#
> +
>  properties:
>    compatible:
>      const: gpio-restart
> @@ -41,16 +44,6 @@ properties:
>        in its inactive state.
>  
>    priority:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description: |
> -      A priority ranging from 0 to 255 (default 129) according to the following guidelines:
> -
> -        0:   Restart handler of last resort, with limited restart capabilities.
> -        128: Default restart handler; use if no other restart handler is expected to be available,
> -             and/or if restart functionality is sufficient to restart the entire system.
> -        255: Highest priority restart handler, will preempt all other restart handlers.
> -    minimum: 0
> -    maximum: 255
>      default: 129
>  
>    active-delay:
> diff --git a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> new file mode 100644
> index 000000000000..f5d22ca0cd45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/restart-handler.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Restart and shutdown handler generic binding
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description:
> +  Restart and shutdown handler device is responsible for powering off the
> +  system, e.g. my cutting off the power.  System might have several restart
> +  handlers, which usually are tried from most precise to last resort.
> +
> +properties:
> +  priority:
> +    $ref: /schemas/types.yaml#/definitions/uint32

IIRC priority is signed integer number, not unsigned.

> +    description: |
> +      A priority ranging from 0 to 255 according to the following guidelines::
> +        0:   Restart handler of last resort, with limited restart capabilities.
> +        128: Typical, default restart handler; use if no other restart handler
> +             is expected to be available, and/or if restart functionality is
> +             sufficient to restart the entire system.
> +        255: Highest priority restart handler, will preempt all other restart handlers.
> +    minimum: 0
> +    maximum: 255

And IIRC also other values (above 255 or below 0) are allowed for tuning
two "highest" or two "last resort" handlers.

This needs to be checked / tested to ensure that new schema is not incorrect.

> +
> +additionalProperties: true
> -- 
> 2.34.1
> 
