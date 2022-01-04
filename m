Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97663484970
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiADUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:49:12 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46048 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiADUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:49:11 -0500
Received: by mail-ot1-f49.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso48588676otf.12;
        Tue, 04 Jan 2022 12:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVzkHT/evz/UBD2bITCNNJEWZQF9qiy5Cy4cjCf+0oM=;
        b=kInAJ+gQ3TcjcE0gqJHBNAi1AEN5fQuxV6K10C2Nb40jOJ7MzM4+6FS7gxhY1T31dG
         w/HlRln+Mn9NkkaYbodWw3Nd7uY/JL93In9KjKPg2KRbj6UeoXyZbHQxfLQHS+mI7L3p
         escq2uBB1XKzfUByZMNJuhyX49N9uDq+RpSubhMY6sV2qQIW4RTH0WE5iwQenkYUyt50
         3LB4P91DsAeTnqi1evAQIXggK+uqBWEQKhuoH2OJpJLDJrB+BmmNm7r6+zGL29FyqYlJ
         o1Wcbte6S1WjNqvOHS9oGS5YD6UxuzLeA1RfFeInevURrpJ8aSIWII6j2OljGRUzMw15
         ggGg==
X-Gm-Message-State: AOAM531lhV0Vh3SDy6+Pw1pP609wr5RVGmT1jWFAM1QIjpC/YdKRnoIN
        OCYOhImEpGhPiMWa2i05M7OG1yXrKA==
X-Google-Smtp-Source: ABdhPJzEuEUSPqpeb+HZHv5cZfQJ0CJo9W8/H4Hz48+iTTI351KMMU8nEoGwLSxXjG2akEEjDw2SAQ==
X-Received: by 2002:a9d:4006:: with SMTP id m6mr37165854ote.173.1641329350890;
        Tue, 04 Jan 2022 12:49:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v5sm5082322oic.11.2022.01.04.12.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:49:10 -0800 (PST)
Received: (nullmailer pid 1399221 invoked by uid 1000);
        Tue, 04 Jan 2022 20:49:09 -0000
Date:   Tue, 4 Jan 2022 14:49:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm: merge qcom,idle-state with
 idle-state
Message-ID: <YdSyxY2SVXAqvNmS@robh.at.kernel.org>
References: <20211224144835.39193-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224144835.39193-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 03:48:34PM +0100, David Heidelberg wrote:
> Merge Qualcomm specific idle-state binding with generic one.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> v3:
>  - integrate into idle-state.yml
>  - orig. patch name was:
>    "[v2] dt-bindings: arm/msm/qcom,idle-state convert to YAML"
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/arm/idle-states.yaml  | 107 ++++++++++++++++++
>  .../bindings/arm/msm/qcom,idle-state.txt      |  84 --------------
>  2 files changed, 107 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/idle-states.yaml b/Documentation/devicetree/bindings/arm/idle-states.yaml
> index 52bce5dbb11f..fde1557f2332 100644
> --- a/Documentation/devicetree/bindings/arm/idle-states.yaml
> +++ b/Documentation/devicetree/bindings/arm/idle-states.yaml
> @@ -241,6 +241,64 @@ description: |+
>    [6] ARM Linux Kernel documentation - Booting AArch64 Linux
>        Documentation/arm64/booting.rst
>  
> +  ===========================================
> +  5 - Qualcomm specific STATES
> +  ===========================================
> +
> +  cpuidle-qcom is the cpuidle driver for Qualcomm SoCs and uses these idle

What's cpuidle?

(Linux detail doesn't belong here)

> +  states. Idle states have different enter/exit latency and residency values.
> +  The idle states supported by the QCOM SoC are defined as -
> +
> +    * Standby
> +    * Retention
> +    * Standalone Power Collapse (Standalone PC or SPC)
> +    * Power Collapse (PC)
> +
> +  Standby: Standby does a little more in addition to architectural clock gating.
> +  When the WFI instruction is executed the ARM core would gate its internal
> +  clocks. In addition to gating the clocks, QCOM cpus use this instruction as a
> +  trigger to execute the SPM state machine. The SPM state machine waits for the
> +  interrupt to trigger the core back in to active. This triggers the cache
> +  hierarchy to enter standby states, when all cpus are idle. An interrupt brings
> +  the SPM state machine out of its wait, the next step is to ensure that the
> +  cache hierarchy is also out of standby, and then the cpu is allowed to resume
> +  execution. This state is defined as a generic ARM WFI state by the ARM cpuidle
> +  driver and is not defined in the DT. The SPM state machine should be
> +  configured to execute this state by default and after executing every other
> +  state below.
> +
> +  Retention: Retention is a low power state where the core is clock gated and
> +  the memory and the registers associated with the core are retained. The
> +  voltage may be reduced to the minimum value needed to keep the processor
> +  registers active. The SPM should be configured to execute the retention
> +  sequence and would wait for interrupt, before restoring the cpu to execution
> +  state. Retention may have a slightly higher latency than Standby.
> +
> +  Standalone PC: A cpu can power down and warmboot if there is a sufficient time
> +  between the time it enters idle and the next known wake up. SPC mode is used
> +  to indicate a core entering a power down state without consulting any other
> +  cpu or the system resources. This helps save power only on that core.  The SPM
> +  sequence for this idle state is programmed to power down the supply to the
> +  core, wait for the interrupt, restore power to the core, and ensure the
> +  system state including cache hierarchy is ready before allowing core to
> +  resume. Applying power and resetting the core causes the core to warmboot
> +  back into Elevation Level (EL) which trampolines the control back to the
> +  kernel. Entering a power down state for the cpu, needs to be done by trapping
> +  into a EL. Failing to do so, would result in a crash enforced by the warm boot
> +  code in the EL for the SoC. On SoCs with write-back L1 cache, the cache has to
> +  be flushed in s/w, before powering down the core.
> +
> +  Power Collapse: This state is similar to the SPC mode, but distinguishes
> +  itself in that the cpu acknowledges and permits the SoC to enter deeper sleep
> +  modes. In a hierarchical power domain SoC, this means L2 and other caches can
> +  be flushed, system bus, clocks - lowered, and SoC main XO clock gated and
> +  voltages reduced, provided all cpus enter this state.  Since the span of low
> +  power modes possible at this state is vast, the exit latency and the residency
> +  of this low power mode would be considered high even though at a cpu level,
> +  this essentially is cpu power down. The SPM in this state also may handshake
> +  with the Resource power manager (RPM) processor in the SoC to indicate a
> +  complete application processor subsystem shut down.

I'm on the fence whether any of this belongs here... But I don't have a 
better suggestion.

> +
>  properties:
>    $nodename:
>      const: idle-states
> @@ -323,6 +381,44 @@ patternProperties:
>        - exit-latency-us
>        - min-residency-us
>  
> +  "^(ret|spc|pc)$":

Either these need to be added to the existing pattern for node names or 
the node names in the dts files be changed to match the existing 
binding. I think it is safe to do the latter as the driver doesn't care 
about node names.

And then you just need to update the 'compatible' schema.

> +    type: object
> +    description:
> +      Each state node represents a domain idle state description.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - qcom,idle-state-ret
> +              - qcom,idle-state-spc
> +              - qcom,idle-state-pc
> +          - const: arm,idle-state
> +
> +      entry-latency-us:
> +        description:
> +          The worst case latency in microseconds required to enter the idle
> +          state. Note that, the exit-latency-us duration may be guaranteed only
> +          after the entry-latency-us has passed.
> +
> +      exit-latency-us:
> +        description:
> +          The worst case latency in microseconds required to exit the idle
> +          state.
> +
> +      min-residency-us:
> +        description:
> +          The minimum residency duration in microseconds after which the idle
> +          state will yield power benefits, after overcoming the overhead while
> +          entering the idle state.
> +
> +    required:
> +      - compatible
> +      - entry-latency-us
> +      - exit-latency-us
> +      - min-residency-us
> +
> +
>  additionalProperties: false
>  
>  examples:
> @@ -658,4 +754,15 @@ examples:
>          };
>      };
>  
> +  - |
> +    // Example 3 - QCOM SPC
> +    idle-states {
> +      cpu_spc: spc {
> +        compatible = "qcom,idle-state-spc", "arm,idle-state";
> +        entry-latency-us = <150>;
> +        exit-latency-us = <200>;
> +        min-residency-us = <2000>;
> +      };
> +    };
> +
>  ...
