Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE5B477D33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbhLPUPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:15:17 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37848 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhLPUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:15:16 -0500
Received: by mail-ot1-f45.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so288231otg.4;
        Thu, 16 Dec 2021 12:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYmeLfLobnbzpDW1UJt55IT1E6sxaX+gTnLSdXFJ+9k=;
        b=M7uF+IKV+QvD0P2DRgR+ajQ74C1GjuYozNUsW64+akxeg3SBIk1W7T3JlmEIEFFu46
         eJgDVlvA1K/EzP3oizkAxlmPV9/GfGWYZsmKER0T48qatYeTPXYSQBELgvvuDBxmzvfa
         /HUuAVqGujyr+zYv/tKi8Sm+klyKwOlDiGHWQVRPJ7ypTaEcHk2MQrIURjD3HH0btHxl
         ZmVs0e9qXMpiE+i9Yo1ioY6q8CnVZ13Ee5WEn6lu9AZz8k/FiE4kJMVooC0Nqfd5Yvnu
         Gx6QarqGb+jahdkARg6fXHOrYTLsHmCt0pnCC3+cAlWGCeg1L/7qJ7nMjeyA3eoDJwJ2
         OBEw==
X-Gm-Message-State: AOAM532Mb7L2PfueM1FLUMYTsNf2+K4mHBTBfYP7A+98EOxgvJCxe2hU
        UHtqRsleKVCE9AtVUpjf5g==
X-Google-Smtp-Source: ABdhPJyvLCwGruPUfdr2lc9ZUCfmx7PigNZabGaqqj/UuuptIxAPkDUDcmqq8jNjbMJqpha7OmVvgQ==
X-Received: by 2002:a05:6830:44a1:: with SMTP id r33mr14012682otv.162.1639685715882;
        Thu, 16 Dec 2021 12:15:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e21sm1212688ote.72.2021.12.16.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:15:15 -0800 (PST)
Received: (nullmailer pid 681236 invoked by uid 1000);
        Thu, 16 Dec 2021 20:15:14 -0000
Date:   Thu, 16 Dec 2021 14:15:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: interrupt-controller: Update STM32
 EXTI interrupt controller
Message-ID: <YbueUmqyzwS9rOu5@robh.at.kernel.org>
References: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
 <20211215105847.2328-2-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215105847.2328-2-alexandre.torgue@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:58:43AM +0100, Alexandre Torgue wrote:
> Document new entry "st,exti-mapping" which links EXTI lines with GIC
> interrupt lines and add an include file to define EXTI interrupt type.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
> index d19c881b4abc..e08bb51e97a8 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
> @@ -41,6 +41,17 @@ properties:
>      description:
>        Interrupts references to primary interrupt controller
>  
> +  st,exti-mapping:
> +    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
> +    description: |
> +            Define mapping between EXTI lines and GIC irq lines. Should be:
> +            st,exti-mapping = <EXTI_LINE GIC_IRQ EXTI_TYPE>, ...;
> +            With:
> +            - EXTI_LINE: EXTI line number.
> +            - GIC_IRQ: GIC IRQ associated to the EXTI line.
> +            - EXTI_TYPE: STM32_EXTI_TYPE_CONFIGURABLE or STM32_EXTI_TYPE_DIRECT.
> +              Defined in include/dt-bindings/interrupt-controller/stm32-exti.h

No custom properties for this. See[1][2][3].

Rob


[1] https://lore.kernel.org/all/20211122103032.517923-1-maz@kernel.org/
[2] https://lore.kernel.org/all/87k0g8jlmg.wl-maz@kernel.org/
[3] https://lore.kernel.org/all/CAL_JsqK2Shj6smam7HgNAmy3UG+vVQPkU3Q0OjyEHOEJB45n0A@mail.gmail.com/
