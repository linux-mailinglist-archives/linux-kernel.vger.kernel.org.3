Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FF047191B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhLLH1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLLH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:26:55 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C791AC061714;
        Sat, 11 Dec 2021 23:26:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2209C424CD;
        Sun, 12 Dec 2021 07:26:49 +0000 (UTC)
Subject: Re: [PATCH v2 2/8] dt-bindings: apple,aic: Add CPU PMU per-cpu
 pseudo-interrupts
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com,
        Rob Herring <robh@kernel.org>
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-3-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <6409face-ad91-1d5b-0eb5-773bd6de7cd3@marcan.st>
Date:   Sun, 12 Dec 2021 16:26:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201134909.390490-3-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 22.49, Marc Zyngier wrote:
> Advertise the two pseudo-interrupts that tied to the two PMU
> flavours present in the Apple M1 SoC.
> 
> We choose the expose two different pseudo-interrupts to the OS
> as the e-core PMU is obviously different from the p-core one,
> effectively presenting two different devices.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   .../devicetree/bindings/interrupt-controller/apple,aic.yaml     | 2 ++
>   include/dt-bindings/interrupt-controller/apple-aic.h            | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> index cf6c091a07b1..b95e41816953 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> @@ -56,6 +56,8 @@ properties:
>             - 1: virtual HV timer
>             - 2: physical guest timer
>             - 3: virtual guest timer
> +          - 4: 'efficient' CPU PMU
> +          - 5: 'performance' CPU PMU
>   
>         The 3rd cell contains the interrupt flags. This is normally
>         IRQ_TYPE_LEVEL_HIGH (4).
> diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/dt-bindings/interrupt-controller/apple-aic.h
> index 604f2bb30ac0..bf3aac0e5491 100644
> --- a/include/dt-bindings/interrupt-controller/apple-aic.h
> +++ b/include/dt-bindings/interrupt-controller/apple-aic.h
> @@ -11,5 +11,7 @@
>   #define AIC_TMR_HV_VIRT		1
>   #define AIC_TMR_GUEST_PHYS	2
>   #define AIC_TMR_GUEST_VIRT	3
> +#define AIC_CPU_PMU_E		4
> +#define AIC_CPU_PMU_P		5
>   
>   #endif
> 

Reviewed-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
