Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08793480194
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhL0QX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:23:57 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:33322 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhL0QX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:23:56 -0500
Received: by mail-qt1-f182.google.com with SMTP id v4so11260324qtk.0;
        Mon, 27 Dec 2021 08:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0XPBoj1RaXnBN6RcH30LUhnTxAq4JnLCnWsVVEr/+qA=;
        b=6J9yZdP1bdioOREh/h7cbqBsjzHPOyroRzDlANaYvwyFs1l6YaR4hV/7I0S8to2SZG
         qUyx+qeT25VSshWz1MmPJBGNLzi9rJEHQjpmMB3VXUkHwosXMk0RHvNvhaJok4HiWfwn
         bwMEcB4E1jfisU0EGB2HH60xZY0cE+yh7WMwymp0WytwPO2Bhwg+QJzEEf0EdlM3bt89
         2fvwlp53QgxlKEjUNSW8cukCbuGGkelcEHL+UJURePBb6hEwtC3ydrNxUZ7P9fm6Uf9j
         GKXA0/jBP4OZQh78ZnXgOiZOHV0a/fo8nGe3EejCuEQTBYJPrXlumb8G1qIFN/HMmG3l
         IA9A==
X-Gm-Message-State: AOAM533hirBpvcF79GQse0X471kZDmHye4xnxvYah3lTkIX0i6MndbuQ
        ToZDO1Nu3TOTDhtnE71MKkDMhZZnehQV
X-Google-Smtp-Source: ABdhPJwCZb25uvlMGox7fAPHeiDPIqvL8fhksDBu1he8tlL0dc2XpgOiDwVw1brYa02u5opgCnSTkA==
X-Received: by 2002:ac8:4a87:: with SMTP id l7mr15207527qtq.310.1640622235112;
        Mon, 27 Dec 2021 08:23:55 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id q21sm13046882qkl.52.2021.12.27.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 08:23:54 -0800 (PST)
Received: (nullmailer pid 598138 invoked by uid 1000);
        Mon, 27 Dec 2021 16:23:52 -0000
Date:   Mon, 27 Dec 2021 12:23:52 -0400
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: convert MSM timer to yaml
Message-ID: <YcnomHO8isHkxVIQ@robh.at.kernel.org>
References: <20211224234607.109049-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224234607.109049-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 12:46:06AM +0100, David Heidelberg wrote:
> Convert Qualcomm MSM Timer to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> It has currently issue, that it fights with watchdog/qcom-wdt.yaml
> Both bindings and drivers use similar sets of compatibles and qcom-wdt
> isn't very strictly defined.

What a mess... They should be merged most likely.

> 
>  .../bindings/timer/qcom,msm-timer.txt         | 47 -----------
>  .../bindings/timer/qcom,msm-timer.yaml        | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt b/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
> deleted file mode 100644
> index 5e10c345548f..000000000000
> --- a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -* MSM Timer
> -
> -Properties:
> -
> -- compatible : Should at least contain "qcom,msm-timer". More specific
> -               properties specify which subsystem the timers are paired with.
> -
> -               "qcom,kpss-timer" - krait subsystem
> -               "qcom,scss-timer" - scorpion subsystem
> -
> -- interrupts : Interrupts for the debug timer, the first general purpose
> -               timer, and optionally a second general purpose timer, and
> -               optionally as well, 2 watchdog interrupts, in that order.
> -
> -- reg : Specifies the base address of the timer registers.
> -
> -- clocks: Reference to the parent clocks, one per output clock. The parents
> -          must appear in the same order as the clock names.
> -
> -- clock-names: The name of the clocks as free-form strings. They should be in
> -               the same order as the clocks.
> -
> -- clock-frequency : The frequency of the debug timer and the general purpose
> -                    timer(s) in Hz in that order.
> -
> -Optional:
> -
> -- cpu-offset : per-cpu offset used when the timer is accessed without the
> -               CPU remapping facilities. The offset is
> -               cpu-offset + (0x10000 * cpu-nr).
> -
> -Example:
> -
> -       timer@200a000 {
> -               compatible = "qcom,scss-timer", "qcom,msm-timer";
> -               interrupts = <1 1 0x301>,
> -                            <1 2 0x301>,
> -                            <1 3 0x301>,
> -                            <1 4 0x301>,
> -                            <1 5 0x301>;
> -               reg = <0x0200a000 0x100>;
> -               clock-frequency = <19200000>,
> -                                 <32768>;
> -               clocks = <&sleep_clk>;
> -               clock-names = "sleep";
> -               cpu-offset = <0x40000>;
> -       };
> diff --git a/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml b/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
> new file mode 100644
> index 000000000000..238eb985d0fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/qcom,msm-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM Timer
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +properties:
> +  $nodename:
> +    pattern: '^timer@[a-f0-9]+$'
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: qcom,kpss-timer
> +          - enum:
> +              - qcom,kpss-wdt-apq8064
> +              - qcom,kpss-wdt-ipq8064
> +              - qcom,kpss-wdt-msm8960

Wrong order here. qcom,kpss-timer should be after these as it is less 
specific.
> +          - const: qcom,msm-timer

Drop this compatible string. It is unused and pointless.

> +      - items:
> +          - enum:
> +              - qcom,kpss-timer  # Krait subsystem
> +              - qcom,scss-timer  # Scorpion subsystem
> +          - const: qcom,msm-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: 1st purpose timer
> +      - description: 2nd general purpose timer
> +      - description: 1st watchdog interrupt
> +      - description: 2nd watchdog interrupt
> +      - description: 3nd watchdog interrupt
> +
> +  clocks: true

You must define how many.

> +
> +  clock-names: true
> +
> +  clock-frequency: true
> +
> +  cpu-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: >
> +      Per-cpu offset used when the timer is accessed without the
> +      CPU remapping facilities. The offset is cpu-offset + (0x10000 * cpu-nr).
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    timer@200a000 {
> +        compatible = "qcom,scss-timer", "qcom,msm-timer";
> +        interrupts = <1 1 0x301>,
> +                     <1 2 0x301>,
> +                     <1 3 0x301>,
> +                     <1 4 0x301>,
> +                     <1 5 0x301>;
> +        reg = <0x0200a000 0x100>;
> +        clock-frequency = <19200000>,
> +                          <32768>;
> +        clocks = <&sleep_clk>;
> +        clock-names = "sleep";
> +        cpu-offset = <0x40000>;
> +    };
> -- 
> 2.34.1
> 
> 
