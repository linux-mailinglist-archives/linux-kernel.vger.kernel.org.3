Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5710F463F15
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbhK3USJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:18:09 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:43703 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343618AbhK3USD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:18:03 -0500
Received: by mail-oi1-f182.google.com with SMTP id o4so43568569oia.10;
        Tue, 30 Nov 2021 12:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6d+ss10iO53NZAt9HGpTQK4XZlOoTAAbyTyzfqydX8s=;
        b=2yz3CgXScF8Uqx0O+5Fmf0IvjnYkfGWvNBJqxuv/bKggFG8SqUJ8EDcvV6BJ2n9SG7
         M0RtIT23xhbO0PjbtgNYZG+okPpcwXQlEjMfBSDH0ENjSzoJL62TjTJPeqoG6z6TtTnt
         ULabxM7V75gvbEHJdJhRejDv//YQNmYMhVOHwi4mXR4/ezoxisle4LDOdV49Aly4AsZs
         iyXHLNN+McG64Ya6p9J8tOBjkdTkbEjUtZxFmkddmPQpzYuN9zuIJK7x4FHjvVhCGwKa
         jmYv061nKKpoBSMKzogQMhXdJNetBovTOUH4KOJnMZdGSPtp8Q0yap7I58L4MC2OaO6N
         slNw==
X-Gm-Message-State: AOAM533Je0bE/PSIpEmkCKHZIO5jyYPmtp3RkKuEboZbjty6zESe+HM5
        kinofnybj4sVbGuthdbxag==
X-Google-Smtp-Source: ABdhPJxUVY5rg+WfjOqdoFf2mwgBYkTGost9flNt2LhldEL+GK2+obmN4BCwbH2K6c88sejyLtyFNA==
X-Received: by 2002:a54:4692:: with SMTP id k18mr1219732oic.93.1638303284060;
        Tue, 30 Nov 2021 12:14:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb7sm2988441oob.14.2021.11.30.12.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:14:43 -0800 (PST)
Received: (nullmailer pid 2935477 invoked by uid 1000);
        Tue, 30 Nov 2021 20:14:42 -0000
Date:   Tue, 30 Nov 2021 14:14:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: mux: Document mux-states property
Message-ID: <YaaGMtE6n0yZNpAI@robh.at.kernel.org>
References: <20211130121847.11112-1-a-govindraju@ti.com>
 <20211130121847.11112-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130121847.11112-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 05:48:46PM +0530, Aswath Govindraju wrote:
> In some cases, it is required to provide the state to which the mux
> controller has be set to, from the consumer device tree node. Document the
> property mux-states that can be used for adding this support.

I having a hard time understanding why you need this. One consumer 
configures a mux one way and another consumer another way? How do you 
arbitrate that? Please elaborate on what 'some cases' are and why it's 
required.

Can't you just add a cell for the 'state' allowing for 1-2 cells 
instead of 0-1?

> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../devicetree/bindings/mux/gpio-mux.yaml     | 11 ++++++--
>  .../devicetree/bindings/mux/mux-consumer.yaml | 14 ++++++++++
>  .../bindings/mux/mux-controller.yaml          | 26 ++++++++++++++++++-
>  3 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
> index 0a7c8d64981a..ee4de9fbaf4d 100644
> --- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
> +++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
> @@ -26,7 +26,10 @@ properties:
>        List of gpios used to control the multiplexer, least significant bit first.
>  
>    '#mux-control-cells':
> -    const: 0
> +    enum: [ 0, 1 ]
> +
> +  '#mux-state-cells':
> +    enum: [ 1, 2 ]
>  
>    idle-state:
>      default: -1
> @@ -34,7 +37,11 @@ properties:
>  required:
>    - compatible
>    - mux-gpios
> -  - "#mux-control-cells"
> +anyOf:
> +  - required:
> +      - "#mux-control-cells"
> +  - required:
> +      - "#mux-state-cells"
>  
>  additionalProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/mux/mux-consumer.yaml b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
> index 7af93298ab5c..64f353714227 100644
> --- a/Documentation/devicetree/bindings/mux/mux-consumer.yaml
> +++ b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
> @@ -25,6 +25,11 @@ description: |
>    strings to label each of the mux controllers listed in the "mux-controls"
>    property.
>  
> +  If it is required to provide the state that the mux controller needs to
> +  be set to, the property "mux-states" must be used. An optional property
> +  "mux-state-names" can be used to provide a list of strings, to label
> +  each of the mux controllers listed in the "mux-states" property.
> +
>    mux-ctrl-specifier typically encodes the chip-relative mux controller number.
>    If the mux controller chip only provides a single mux controller, the
>    mux-ctrl-specifier can typically be left out.
> @@ -35,12 +40,21 @@ properties:
>    mux-controls:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>  
> +  mux-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
>    mux-control-names:
>      description:
>        Devices that use more than a single mux controller can use the
>        "mux-control-names" property to map the name of the requested mux
>        controller to an index into the list given by the "mux-controls" property.
>  
> +  mux-state-names:
> +    description:
> +      Devices that use more than a single mux controller can use the
> +      "mux-state-names" property to map the name of the requested mux
> +      controller to an index into the list given by the "mux-states" property.
> +
>  additionalProperties: true
>  
>  ...
> diff --git a/Documentation/devicetree/bindings/mux/mux-controller.yaml b/Documentation/devicetree/bindings/mux/mux-controller.yaml
> index 736a84c3b6a5..b29dbf521f01 100644
> --- a/Documentation/devicetree/bindings/mux/mux-controller.yaml
> +++ b/Documentation/devicetree/bindings/mux/mux-controller.yaml
> @@ -25,7 +25,9 @@ description: |
>    --------------------
>  
>    Mux controller nodes must specify the number of cells used for the
> -  specifier using the '#mux-control-cells' property.
> +  specifier using the '#mux-control-cells' or 'mux-state-cells'
> +  property. Value of '#mux-state-cells' will always be one greater then
> +  the value of '#mux-control-cells'.
>  
>    Optionally, mux controller nodes can also specify the state the mux should
>    have when it is idle. The idle-state property is used for this. If the
> @@ -67,6 +69,8 @@ select:
>            pattern: '^mux-controller'
>      - required:
>          - '#mux-control-cells'
> +    - required:
> +        - '#mux-state-cells'
>  
>  properties:
>    $nodename:
> @@ -75,6 +79,9 @@ properties:
>    '#mux-control-cells':
>      enum: [ 0, 1 ]
>  
> +  '#mux-state-cells':
> +    enum: [ 1, 2 ]
> +
>    idle-state:
>      $ref: /schemas/types.yaml#/definitions/int32
>      minimum: -2
> @@ -179,4 +186,21 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mux1: mux-controller {
> +        compatible = "gpio-mux";
> +        #mux-state-cells = <1>;
> +        mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +    transceiver4: can-phy4 {
> +        compatible = "ti,tcan1042";
> +        #phy-cells = <0>;
> +        max-bitrate = <5000000>;
> +        standby-gpios = <&exp_som 7 GPIO_ACTIVE_HIGH>;
> +        mux-states = <&mux1 1>;
> +    };
>  ...
> -- 
> 2.17.1
> 
> 
