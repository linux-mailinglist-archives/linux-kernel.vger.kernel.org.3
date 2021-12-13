Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD45A4737E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbhLMWrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:47:32 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35718 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbhLMWr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:47:29 -0500
Received: by mail-ot1-f46.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso19087723otr.2;
        Mon, 13 Dec 2021 14:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7iq76j9xQsru49u9+3rqQd0VoNPAObBgJ0oH5ebfPlY=;
        b=JBv1yLFWm35OseQSH2eT2/+exohYSdc8StHnM0xEMjjzrTuPqlNhFfUnu3MCR3WOql
         xEN2tSnDjEoifH4/TsuN8h6trII/3KTqbTaVPqS7njUdOLA8oAXcytTv7VCcGXH60zGU
         XfY/7AyE/1xKX3xHgoStOOGovb6WMzLGLLTnn3IbE0MaMcs4nZ20illol3WU4bUmwIxU
         I2MDJ1Nr4FIuXvs1JTYrXwBmmEmlMVac7R1p7ilvy6OvhW/WiVKbQHJ0JEstE0f9evJZ
         fZBU7I8Tpx8gMtqUUer0UWNbA37X6iYpY0GD4SRo6uwwqQzHadKn1jdlZNNNY1DqZCyx
         ZALA==
X-Gm-Message-State: AOAM531TQOVwF4HSonud1qDjJtYJx1oxKTq36CoywfnLI0jERzw8SkDl
        +fjOn/fvcTZkLx2qi29+8A==
X-Google-Smtp-Source: ABdhPJyHeHXGRgwxR2rPU1zZZyESBD06Ju4KeGQBWvKyp8PkBA41gJm1FsW5NiVaDdvOOq7yfs+pIw==
X-Received: by 2002:a9d:644d:: with SMTP id m13mr1195904otl.131.1639435649184;
        Mon, 13 Dec 2021 14:47:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k1sm2399915otj.61.2021.12.13.14.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:47:28 -0800 (PST)
Received: (nullmailer pid 1720165 invoked by uid 1000);
        Mon, 13 Dec 2021 22:47:27 -0000
Date:   Mon, 13 Dec 2021 16:47:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, - <opensource@rock-chips.com>,
        ~okias/devicetree@lists.sr.ht, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: convert power domain node for rockchip DW
 MIPI DSI
Message-ID: <YbfNfwQVK0mBch6z@robh.at.kernel.org>
References: <20211206212651.126405-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206212651.126405-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:26:50PM +0100, David Heidelberg wrote:
> Convert into YAML format into format, which can be validated.
> 
> Changes:
>  - drop panel from example
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../display/rockchip/dw_mipi_dsi_rockchip.txt |  93 --------
>  .../rockchip/rockchip,dw-mipi-dsi.yaml        | 200 ++++++++++++++++++
>  2 files changed, 200 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
> deleted file mode 100644
> index 39792f051d2d..000000000000
> --- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
> +++ /dev/null
> @@ -1,93 +0,0 @@
> -Rockchip specific extensions to the Synopsys Designware MIPI DSI
> -================================
> -
> -Required properties:
> -- #address-cells: Should be <1>.
> -- #size-cells: Should be <0>.
> -- compatible: one of
> -	"rockchip,px30-mipi-dsi", "snps,dw-mipi-dsi"
> -	"rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi"
> -	"rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi"
> -- reg: Represent the physical address range of the controller.
> -- interrupts: Represent the controller's interrupt to the CPU(s).
> -- clocks, clock-names: Phandles to the controller's pll reference
> -  clock(ref) when using an internal dphy and APB clock(pclk).
> -  For RK3399, a phy config clock (phy_cfg) and a grf clock(grf)
> -  are required. As described in [1].
> -- rockchip,grf: this soc should set GRF regs to mux vopl/vopb.
> -- ports: contain a port node with endpoint definitions as defined in [2].
> -  For vopb,set the reg = <0> and set the reg = <1> for vopl.
> -- video port 0 for the VOP input, the remote endpoint maybe vopb or vopl
> -- video port 1 for either a panel or subsequent encoder
> -
> -Optional properties:
> -- phys: from general PHY binding: the phandle for the PHY device.
> -- phy-names: Should be "dphy" if phys references an external phy.
> -- #phy-cells: Defined when used as ISP phy, should be 0.
> -- power-domains: a phandle to mipi dsi power domain node.
> -- resets: list of phandle + reset specifier pairs, as described in [3].
> -- reset-names: string reset name, must be "apb".
> -
> -[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[2] Documentation/devicetree/bindings/media/video-interfaces.txt
> -[3] Documentation/devicetree/bindings/reset/reset.txt
> -
> -Example:
> -	mipi_dsi: mipi@ff960000 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
> -		reg = <0xff960000 0x4000>;
> -		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru SCLK_MIPI_24M>, <&cru PCLK_MIPI_DSI0>;
> -		clock-names = "ref", "pclk";
> -		resets = <&cru SRST_MIPIDSI0>;
> -		reset-names = "apb";
> -		rockchip,grf = <&grf>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			mipi_in: port@0 {
> -				reg = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				mipi_in_vopb: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&vopb_out_mipi>;
> -				};
> -				mipi_in_vopl: endpoint@1 {
> -					reg = <1>;
> -					remote-endpoint = <&vopl_out_mipi>;
> -				};
> -			};
> -
> -			mipi_out: port@1 {
> -				reg = <1>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				mipi_out_panel: endpoint {
> -					remote-endpoint = <&panel_in_mipi>;
> -				};
> -			};
> -		};
> -
> -		panel {
> -			compatible ="boe,tv080wum-nl0";
> -			reg = <0>;
> -
> -			enable-gpios = <&gpio7 3 GPIO_ACTIVE_HIGH>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&lcd_en>;
> -			backlight = <&backlight>;
> -
> -			port {
> -				panel_in_mipi: endpoint {
> -					remote-endpoint = <&mipi_out_panel>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
> new file mode 100644
> index 000000000000..7efa201e0e51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
> @@ -0,0 +1,200 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-mipi-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip specific extensions to the Synopsys Designware MIPI DSI
> +
> +maintainers:
> +  - opensource@rock-chips.com
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,px30-mipi-dsi
> +      then:
> +        properties:
> +          clocks:
> +            maxItems: 1
> +          clock-names:
> +            items:
> +              - const: pclk

It's amazing that this version of the h/w can work without a reference 
clock. I only point that out because it means you can't really use 
bridge/snps,dw-mipi-dsi.yaml...

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3288-mipi-dsi
> +      then:
> +        properties:
> +          clocks:
> +            maxItems: 2
> +          clock-names:
> +            items:
> +              - const: ref
> +              - const: pclk
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3399-mipi-dsi
> +      then:
> +        properties:
> +          clocks:
> +            minItems: 4
> +            maxItems: 4
> +          clock-names:
> +            items:
> +              - const: ref
> +              - const: pclk
> +              - const: phy_cfg
> +              - const: grf
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - rockchip,px30-mipi-dsi
> +              - rockchip,rk3288-mipi-dsi
> +              - rockchip,rk3399-mipi-dsi
> +          - const: snps,dw-mipi-dsi
> +      - items:
> +          - const: rockchip,px30-mipi-dsi
> +      - items:
> +          - const: rockchip,rk3288-mipi-dsi
> +      - items:
> +          - const: rockchip,rk3399-mipi-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks: true
> +
> +  clock-names: true
> +
> +  phys:
> +    maxItems: 1
> +    description: The external PHY
> +
> +  phy-names:
> +    const: dphy
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false

You are not defining any extra port or endpoint properties, so you can 
use '/schemas/graph.yaml#/properties/port' here.

> +        description: >
> +          Video port for the VOP input.
> +
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: Connection to the VOPB
> +
> +          endpoint@1:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: Connection to the VOPL
> +
> +        required:
> +          - endpoint@0
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: >
> +          Video port for panel or subsequent encoder
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: apb
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the GRF to mux vopl/vopb
> +
> +  power-domains: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#phy-cells':
> +    const: 0
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - rockchip,grf
> +  - ports
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: true

This is pretty much never right except for common bindings referenced by 
another schema. You need to reference dsi-controller.yaml and use 
'unevaluatedProperties: false'.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3288-cru.h>
> +
> +    mipi_dsi: mipi@ff960000 {

dsi@...

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
> +        reg = <0xff960000 0x4000>;
> +        interrupts = <0 83 4>;
> +        clocks = <&cru 148>, <&cru PCLK_MIPI_DSI0>;
> +        clock-names = "ref", "pclk";
> +        resets = <&cru SRST_MIPIDSI0>;
> +        reset-names = "apb";
> +        rockchip,grf = <&grf>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            mipi_in: port@0 {
> +                reg = <0>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                mipi_in_vopb: endpoint@0 {
> +                    reg = <0>;
> +                    remote-endpoint = <&vopb_out_mipi>;
> +                };
> +                mipi_in_vopl: endpoint@1 {
> +                    reg = <1>;
> +                    remote-endpoint = <&vopl_out_mipi>;
> +                };
> +            };
> +
> +            mipi_out: port@1 {
> +                reg = <1>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                mipi_out_panel: endpoint {
> +                    remote-endpoint = <&panel_in_mipi>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.33.0
> 
> 
