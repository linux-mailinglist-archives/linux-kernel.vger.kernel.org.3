Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300CE46C414
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhLGUC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:02:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46476 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhLGUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:02:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ADB6B81751;
        Tue,  7 Dec 2021 19:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACE2C341C3;
        Tue,  7 Dec 2021 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638907135;
        bh=P6KOWuGHoVnwVrtWwBazdojv+W+/YUkxGaQNjvUGvKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TlEvmV73QuGq4kUoY2ZwJLWuvpq5AoYszyAtQM2fNRk+1whk8I3Wz5Ayw0CpwNUcC
         dlu58DN9J20sKQGXYYPhmuhWilnL6qNkjH6M5Yq4kMzFGMJmOdXkRndqF6lJI4tMXb
         CQ2SoL7o9YrxnS59XGZNAw4OWNT/ox0h+PruZcQhao+m+ya6RwZ4vxhsm0dSiRoyvM
         6KX7P+rLHRSGI0uI2jQy5HUufNKKXQy2rLpV4PhgpqYMXe+GJiu6e+4rvahnAPj+2P
         x0/fOTO3Fql9WrBhpnbEq7v1zJa3wQtrY9st2OWto+BvyMt+p1Shc63NQBq7gVEmE3
         sfnQGRJQMDrDQ==
Received: by mail-ed1-f51.google.com with SMTP id g14so336321edb.8;
        Tue, 07 Dec 2021 11:58:55 -0800 (PST)
X-Gm-Message-State: AOAM530KtrhFFyqEWI7fT8wQWuo33DhUgVk0EO+wl6q87M7OYYR5ZNBX
        vgvI0anLRnSYMD6a9NNdZn4gESNrNm6f0ozFzg==
X-Google-Smtp-Source: ABdhPJxVngVyrczHBz+ckXdurPs1Vq3IOkYwtYrU1YfNrC3K+gTjg880WLHBwDb7Y6WDa62QBL6c4yPYypJEtcuV7HQ=
X-Received: by 2002:a17:906:fcbb:: with SMTP id qw27mr1781108ejb.320.1638907133619;
 Tue, 07 Dec 2021 11:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20211205231558.779698-1-daniel.lezcano@linaro.org>
In-Reply-To: <20211205231558.779698-1-daniel.lezcano@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Dec 2021 13:58:41 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+JgudbhJVyGWB0RJ2LPQ6xZFJ7TxWzjNtWXky-kCxA4Q@mail.gmail.com>
Message-ID: <CAL_Jsq+JgudbhJVyGWB0RJ2LPQ6xZFJ7TxWzjNtWXky-kCxA4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: Powerzone new bindings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 5:16 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The proposed bindings are describing a set of powerzones.
>
> A power zone is the logical name for a component which is capable of
> power capping and where we can measure the power consumption.

How is the power consumption measured? I don't see anything in the
binding allowing for that.

> A power zone can aggregate several power zones in terms of power
> measurement and power limitations. That allows to apply power
> constraint to a group of components and let the system balance the
> allocated power in order to comply with the constraint.
>
> The ARM System Control and Management Interface (SCMI) can provide a
> power zone description.

Instead of DT?

>
> The powerzone semantic is also found on the Intel platform with the
> RAPL register.

That means nothing to me...

>
> The Linux kernel powercap framework deals with the powerzones:
>
> https://www.kernel.org/doc/html/latest/power/powercap/powercap.html
>
> The powerzone can also represent a group of children powerzones, hence
> the description can result on a hierarchy. Such hierarchy already
> exists with the hardware or can be represented and computed from the
> kernel.
>
> The hierarchical description was initially proposed but not desired
> given there are other descriptions like the power domain proposing
> almost the same description.
>
> https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/
>
> The description gives the power constraint dependencies to apply on a
> specific group of logically or physically aggregated devices. They do
> not represent the physical location or the power domains of the SoC
> even if the description could be similar.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>    V3:
>      - Removed required property 'compatible'
>      - Removed powerzone-cells from the topmost node
>      - Removed powerzone-cells from cpus 'consumers' in example
>      - Set additionnal property to false
>    V2:
>      - Added pattern properties and stick to powerzone-*
>      - Added required property compatible and powerzone-cells
>      - Added additionnal property
>      - Added compatible
>      - Renamed to 'powerzones'
>      - Added missing powerzone-cells to the topmost node
>      - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>    V1: Initial post
> ---
>  .../devicetree/bindings/power/powerzones.yaml | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
> new file mode 100644
> index 000000000000..ddb790acfea6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/powerzones.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0

New bindings should be dual licensed (add BSD-2-Clause).

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/powerzones.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Power zones description
> +
> +maintainers:
> +  - Daniel Lezcano <daniel.lezcano@linaro.org>
> +
> +description: |+
> +
> +  A System on Chip contains a multitude of active components and each
> +  of them is a source of heat. Even if a temperature sensor is not
> +  present, a source of heat can be controlled by acting on the
> +  consumed power via different techniques.
> +
> +  A powerzone describes a component or a group of components where we
> +  can control the maximum power consumption. For instance, a group of
> +  CPUs via the performance domain, a LCD screen via the brightness,
> +  etc ...
> +
> +  Different components when they are used together can significantly
> +  increase the overall temperature, so the description needs to
> +  reflect this dependency in order to assign a power budget for a
> +  group of powerzones.
> +
> +  This description is done via a hierarchy and the DT reflects it. It
> +  does not represent the physical location or a topology, eg. on a
> +  big.Little system, the little CPUs may not be represented as they do
> +  not contribute significantly to the heat, however the GPU can be
> +  tied with the big CPUs as they usually have a connection for
> +  multimedia or game workloads.

Can't most of this just be assumed. We have some DT data already for
capacity and power per mhz along with opp tables. Isn't that enough
information?

The correlation with CPU and GPU usage is totally workload dependent
which has nothing to do with DT. Nor it is platform specific really.

> +
> +properties:
> +  $nodename:
> +    const: powerzones
> +
> +patternProperties:
> +  "^(powerzone)([@-].*)?$":
> +    type: object
> +    description:
> +      A node representing a powerzone acting as an aggregator for all
> +      its children powerzones.
> +
> +    properties:
> +      "#powerzone-cells":
> +        description:
> +          Number of cells in powerzone specifier. Typically 0 for nodes
> +          representing but it can be any number in the future to
> +          describe parameters of the powerzone.
> +
> +      powerzones:
> +        description:
> +          A phandle to a parent powerzone. If no powerzone attribute is
> +          set, the described powerzone is the topmost in the hierarchy.
> +
> +    required:
> +      - "#powerzone-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    powerzones {
> +
> +      SOC_PZ: powerzone-soc {
> +        #powerzone-cells = <0>;
> +      };
> +
> +      PKG_PZ: powerzone-pkg {
> +        #powerzone-cells = <0>;
> +        powerzones = <&SOC_PZ>;
> +      };
> +
> +      GPU_PZ: powerzone-gpu {
> +        #powerzone-cells = <0>;
> +        powerzones = <&PKG_PZ>;
> +      };
> +    };
> +
> +  - |
> +    A57_0: big@0 {
> +      compatible = "arm,cortex-a57";
> +      reg = <0x0 0x0>;
> +      device_type = "cpu";
> +      powerzones = <&PKG_PZ>;
> +    };
> +
> +    A57_1: big@1 {
> +      compatible = "arm,cortex-a57";
> +      reg = <0x0 0x0>;
> +      device_type = "cpu";
> +      powerzones = <&PKG_PZ>;
> +    };
> +...
> --
> 2.25.1
>
