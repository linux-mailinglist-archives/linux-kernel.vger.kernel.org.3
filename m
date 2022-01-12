Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A064D48BCBA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348039AbiALBy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:54:27 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:46904 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiALBy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:54:26 -0500
Received: by mail-oi1-f178.google.com with SMTP id w188so1484796oiw.13;
        Tue, 11 Jan 2022 17:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jyyKKvrn92emBwTYl6ojD1y8WmP58/pIYIpRrruJx/w=;
        b=mG3eCjZqIXFDXYHQPed7maiPW0xlLhvrCT9nXBDBw7hUjIU46lwVJlo4nqOybRFZVy
         YqMANjh71tn0D+a5IM5+KHSTeZ/6S46t79IYXr1Sih/ce6UtWjXCrmmffMFOiiHsAFxs
         2lNNFaxCuBoLvUONgxbzKpSv9ucI6gKyZqplmqvhgrrOHgeJGIu9bJVWakJtJ1IilFqL
         7WSVqPSQ2sccb+vXMon9JujgLed9jccrskttrdvJ4vEPf154TL1w1/EAYs5+8ZWHhW4g
         fh75RNSjZ9IPhFpp0/BICWAw5BJXls2ViCZ597t5NC+mqUD/miLm/GSluj9lu12+Lk1j
         Whew==
X-Gm-Message-State: AOAM533SRaFDPnG3JHLtfOrA+7ZXIS9pL3dU7W4jh9QxtUZz9mScwAff
        UqpbK6M8FMnEpVuwy3smkA1am822BA==
X-Google-Smtp-Source: ABdhPJyai3eviqa56Rw1cwTXbmGC71Vr+kY41i8iUDYQQFe2H8+v8hh3AGbUdGoLrzSfIGQXsyaa3Q==
X-Received: by 2002:a05:6808:254:: with SMTP id m20mr2737989oie.55.1641952465766;
        Tue, 11 Jan 2022 17:54:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v4sm2255328oot.36.2022.01.11.17.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:54:25 -0800 (PST)
Received: (nullmailer pid 3904441 invoked by uid 1000);
        Wed, 12 Jan 2022 01:54:24 -0000
Date:   Tue, 11 Jan 2022 19:54:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: display: add Amlogic MIPI DSI Host
 Controller bindings
Message-ID: <Yd400IApAqHeSW4B@robh.at.kernel.org>
References: <20220107145515.613009-1-narmstrong@baylibre.com>
 <20220107145515.613009-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107145515.613009-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 03:55:10PM +0100, Neil Armstrong wrote:
> The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI Glue
> on the same Amlogic SoCs.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../display/amlogic,meson-dw-mipi-dsi.yaml    | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
> new file mode 100644
> index 000000000000..f3070783d606
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/amlogic,meson-dw-mipi-dsi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic specific extensions to the Synopsys Designware MIPI DSI Host Controller
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |
> +  The Amlogic Meson Synopsys Designware Integration is composed of
> +  - A Synopsys DesignWare MIPI DSI Host Controller IP
> +  - A TOP control block controlling the Clocks & Resets of the IP
> +
> +allOf:
> +  - $ref: dsi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-g12a-dw-mipi-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: pclk
> +      - const: px_clk
> +      - const: meas_clk
> +
> +  resets:
> +    minItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: top
> +
> +  phys:
> +    minItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base

/schemas/graph.yaml#/properties/port

> +        unevaluatedProperties: false

And this can be dropped.

> +        description: Input node to receive pixel data.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false

Same here.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +        description: DSI output node to panel.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    dsi@7000 {
> +          compatible = "amlogic,meson-g12a-dw-mipi-dsi";
> +          reg = <0x6000 0x400>;
> +          resets = <&reset_top>;
> +          reset-names = "top";
> +          clocks = <&clk_pclk>, <&clk_px>;
> +          clock-names = "pclk", "px_clk";
> +          phys = <&mipi_dphy>;
> +          phy-names = "dphy";
> +
> +          ports {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              /* VPU VENC Input */
> +              mipi_dsi_venc_port: port@0 {
> +                  reg = <0>;
> +
> +                  mipi_dsi_in: endpoint {
> +                       remote-endpoint = <&dpi_out>;
> +                  };
> +              };
> +
> +              /* DSI Output */
> +              mipi_dsi_panel_port: port@1 {
> +                  reg = <1>;
> +
> +                  mipi_out_panel: endpoint {
> +                      remote-endpoint = <&mipi_in_panel>;
> +                  };
> +              };
> +          };
> +    };
> -- 
> 2.25.1
> 
> 
