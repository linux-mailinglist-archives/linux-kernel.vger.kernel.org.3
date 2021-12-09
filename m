Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805F946E9BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbhLIOTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:19:55 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:59245 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhLIOTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:19:54 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 95a57f88;
        Thu, 9 Dec 2021 15:16:17 +0100 (CET)
Date:   Thu, 9 Dec 2021 15:16:17 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     sven@svenpeter.dev, jassisinghbrar@gmail.com, robh+dt@kernel.org,
        marcan@marcan.st, alyssa@rosenzweig.io, kettenis@openbsd.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20211209055049.99205-2-marcan@marcan.st> (message from Hector
        Martin on Thu, 9 Dec 2021 14:50:48 +0900)
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: apple,
 mailbox: Add generic and t6000 compatibles
References: <20211209055049.99205-1-marcan@marcan.st> <20211209055049.99205-2-marcan@marcan.st>
Message-ID: <d3cb3991a2be5ea4@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Thu,  9 Dec 2021 14:50:48 +0900
> 
> Much as we've done with other blocks, let's introduce generic
> compatibles so drivers can bind to those and still work with future
> SoCs, as long as the hardware remains the same. Also go ahead and add
> compatibles for the new t600x SoCs (we group those as t6000).
> 
> Note that no DTs instantiate devices with this binding yet.

I think this makes sense.  There is no OpenBSD driver for this yet and
my U-Boot driver has not been submitted upstream yet.  So I think
there are no real backwards compatibility issues.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/mailbox/apple,mailbox.yaml   | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
> index 2c1704b34e7a..58007c789671 100644
> --- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
> @@ -27,14 +27,20 @@ properties:
>            for example for the display controller, the system management
>            controller and the NVMe coprocessor.
>          items:
> -          - const: apple,t8103-asc-mailbox
> +          - enum:
> +              - apple,t8103-asc-mailbox
> +              - apple,t6000-asc-mailbox
> +          - const: apple,asc-mailbox
>  
>        - description:
>            M3 mailboxes are an older variant with a slightly different MMIO
>            interface still found on the M1. It is used for the Thunderbolt
>            co-processors.
>          items:
> -          - const: apple,t8103-m3-mailbox
> +          - enum:
> +              - apple,t8103-m3-mailbox
> +              - apple,t6000-m3-mailbox
> +          - const: apple,m3-mailbox
>  
>    reg:
>      maxItems: 1
> @@ -68,7 +74,7 @@ additionalProperties: false
>  examples:
>    - |
>          mailbox@77408000 {
> -                compatible = "apple,t8103-asc-mailbox";
> +                compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox";
>                  reg = <0x77408000 0x4000>;
>                  interrupts = <1 583 4>, <1 584 4>, <1 585 4>, <1 586 4>;
>                  interrupt-names = "send-empty", "send-not-empty",
> -- 
> 2.33.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
