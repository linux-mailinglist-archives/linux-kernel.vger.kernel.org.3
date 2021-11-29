Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61A3462809
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhK2XSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:18:11 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50160 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhK2XRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:17:46 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A9FE110E;
        Tue, 30 Nov 2021 00:14:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638227667;
        bh=2E+nUCq0kD9wspQ2Su7Ab9gxQat9yZe+28mwUrZmAno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGG51HIXuge1nvZ0KUeUTbWlwcpzRxIF/iBkOW1qUFAHRfWDQBpvmiVKMVt3xK8GA
         9Ful7fN/tDBTrwQ6dLPbo7XMb/yKF0vfCYJ6UtHK3FjmaQM20zQSSe0r/Gfz72+fx5
         61jC5Vv1/jnYoMxJyaq1oQtXd9ThYq6hQiS8T8KM=
Date:   Tue, 30 Nov 2021 01:14:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jacopo@jmondi.org, sakari.ailus@iki.fi, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 02/25] dt-bindings: media: atmel: csi2dc: add bindings
 for microchip csi2dc
Message-ID: <YaVeunGtt4bgmITl@pendragon.ideasonboard.com>
References: <20211112142509.2230884-1-eugen.hristev@microchip.com>
 <20211112142509.2230884-3-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112142509.2230884-3-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

Thank you for the patch.

On Fri, Nov 12, 2021 at 04:24:46PM +0200, Eugen Hristev wrote:
> Add bindings documentation for Microchip CSI2 Demultiplexer controller.
> 
> CSI2DC is a demultiplexer from Synopsys IDI interface specification to
> parallel interface connection or direct memory access.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
> - changed the endpoint/port references as suggested by Rob
> 
> Changes in this version :
> - fixed 'sink' name to be actually source.
> - added dma properties and example with dma
> 
> Previous change log:
> Changes in v5:
> - modified bindings as per Rob Herring review
> 
> Changes in v4:
> - Removed property for inter-line-delay and for clock continuous/non-continuous
> - Removed virtual channel by reg for second endpoint
> 
> Changes in v3:
> - Removed some text from description, as it was explained in the schema
> - fixed other things as per Rob's review
> - moved some text inside the schema, like the clock description
> 
> Changes in v2:
> - fixed warnings reported by dt_binding_check
> 
>  .../bindings/media/microchip,csi2dc.yaml      | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml b/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
> new file mode 100644
> index 000000000000..45418c964bf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/microchip,csi2dc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip CSI2 Demux Controller (CSI2DC)
> +
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@microchip.com>
> +
> +description:
> +  CSI2DC - Camera Serial Interface 2 Demux Controller
> +
> +  CSI2DC is a hardware block that receives incoming data from an IDI interface
> +  and filters packets based on their data type and virtual channel identifier,
> +  then converts the byte stream into a cross clock domain to a pixel stream
> +  to a parallel interface that can be read by a sensor controller.
> +  IDI interface is Synopsys proprietary.
> +
> +  CSI2DC provides two pipes, one video pipe and one data pipe. Video pipe
> +  is connected to a sensor controller and the data pipe is accessible
> +  as a DMA slave port to a DMA controller.
> +
> +  CSI2DC supports a single 'port' node as a sink port with Synopsys 32-bit
> +  IDI interface. The connected endpoint must be a IDI interface compatible
> +  device , that can provide 32-bit IDI interface connection as source port.

s/ , //

> +  This port is mandatory.
> +
> +  CSI2DC supports one 'port' node as source port with parallel interface.
> +  This is called video pipe.
> +  This port has an 'endpoint' that can be connected to a sink port of another
> +  controller (next in pipeline).
> +
> +  CSI2DC also supports direct access to the data through AHB, via DMA channel,
> +  called data pipe.
> +  Because of this, the source 'port' child node (second) is not mandatory.
> +  If the source 'port' child node is missing, only data pipe is available.
> +  For data pipe to be available, a dma controller must be referenced.

Ports are hardware elements, so in that sense they should exist if the
hardware is synthesized with the port, even when the port isn't
connected. Connections are then described by endpoints. I think both
port@0 and port@1 should be required, and the above description updated
accordingly.

> +
> +properties:
> +  compatible:
> +    const: microchip,sama7g5-csi2dc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    description:
> +      CSI2DC must have two clocks to function correctly. One clock is the
> +      peripheral clock for the inside functionality of the hardware block.
> +      This is named 'pclk'. The second clock must be the cross domain clock,
> +      in which CSI2DC will perform clock crossing. This clock must be fed
> +      by the next controller in pipeline, which usually is a sensor controller.
> +      Normally this clock should be given by this sensor controller who
> +      is also a clock source. This clock is named 'scck', sensor controller clock.
> +    items:
> +      - const: pclk
> +      - const: scck
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input port node, single endpoint describing the input port.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            description: Endpoint connected to input device
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port node, single endpoint describing the output port.
> +
> +        properties:
> +          endpoint:
> +            unevaluatedProperties: false
> +            $ref: video-interfaces.yaml#
> +            description: Endpoint connected to output device
> +
> +    required:
> +      - port@0
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - ports
> +
> +examples:
> +  # Example for connecting to a parallel sensor controller block
> +  - |
> +    csi2dc@e1404000 {
> +        compatible = "microchip,sama7g5-csi2dc";
> +        reg = <0xe1404000 0x500>;
> +        clocks = <&pclk>, <&scck>;
> +        clock-names = "pclk", "scck";
> +
> +        ports {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               port@0 {
> +                       reg = <0>; /* must be 0, first child port */
> +                       csi2dc_in: endpoint { /* input from IDI interface */
> +                               remote-endpoint = <&csi2host_out>;
> +                       };
> +               };
> +
> +               port@1 {
> +                       reg = <1>; /* must be 1, second child port */
> +                       csi2dc_out: endpoint {
> +                               remote-endpoint = <&xisc_in>; /* output to sensor controller */
> +                       };
> +               };
> +        };
> +    };
> +
> +  # Example for connecting to a DMA master as an AHB slave
> +  - |
> +    #include <dt-bindings/dma/at91.h>
> +    csi2dc@e1404000 {
> +        compatible = "microchip,sama7g5-csi2dc";
> +        reg = <0xe1404000 0x500>;
> +        clocks = <&pclk>, <&scck>;
> +        clock-names = "pclk", "scck";
> +        dmas = <&dma0 AT91_XDMAC_DT_PERID(34)>;
> +        dma-names = "rx";
> +
> +        ports {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               port@0 {
> +                       reg = <0>; /* must be 0, first child port */
> +                       csi2dc_input: endpoint { /* input from IDI interface */
> +                               remote-endpoint = <&csi2host_out>;
> +                       };
> +               };
> +        };
> +    };
> +
> +...

-- 
Regards,

Laurent Pinchart
