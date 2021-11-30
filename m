Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F15463E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245721AbhK3TW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:22:28 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33291 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245699AbhK3TW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:22:26 -0500
Received: by mail-ot1-f47.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso31768315otf.0;
        Tue, 30 Nov 2021 11:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OF1LduFTTSRI9VRvBAmxpKfvR5vYDD0TXr59BS8NBsk=;
        b=6exX1GNUyKmqWS/UgOqu1fylVaoNQLKdu54Wxvvt4hmdJk+fYptVyN3nljitEPaxzS
         NQnJIF62xu+arThRUXLMgtTWCbHoSmCoGrTxIKra2YyXjjWaT+dXyOGzWoDqTFndqQ/Y
         qNXvdhefRPxL/px/Ojhe7+j9Dn6+KRB3gFR+lmqJaV/4CxPpOAmh1XMETYqvKkxkt4yS
         TXryN8n8xa7/2Mokv8m1hQ1jGMrMTyDSt5CO0fwmSUZBqKYoTgzu5s8Y1QxRMyaywk32
         WlS+MhU4U9sCenDDLMvsHJZb5n68I1fxf0QnxN8P5vzgbtibStojKzUTl+oaFiZ2oA27
         jrgA==
X-Gm-Message-State: AOAM530VTaVaCVuww5E+WAzNIY8NUGyEhTcb5ocU9ykELTS35wvmE8jR
        vRQBIvI13iphI1IsdMtB+g==
X-Google-Smtp-Source: ABdhPJxPuvTylUr8LHoXN6srxSCAQqg8d9HqWMXsxY0z3t4QMbxbqZQ9Y51mP+wRoX5sJHuOz24LKQ==
X-Received: by 2002:a9d:24c3:: with SMTP id z61mr1157237ota.100.1638299942808;
        Tue, 30 Nov 2021 11:19:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e21sm3262978ote.72.2021.11.30.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:19:01 -0800 (PST)
Received: (nullmailer pid 2848687 invoked by uid 1000);
        Tue, 30 Nov 2021 19:19:00 -0000
Date:   Tue, 30 Nov 2021 13:19:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH] dt-bindings: nvmem: add transformation support
Message-ID: <YaZ5JNCFeKcdIfu8@robh.at.kernel.org>
References: <20211123134425.3875656-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123134425.3875656-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:44:25PM +0100, Michael Walle wrote:
> This is my second attempt to solve the use case where there is only the
> base MAC address stored in an EEPROM or similar storage provider. This
> is the case for the Kontron sl28 board and multiple openwrt supported
> boards.
> 
> The first proposal [1] didn't find much appreciation and there wasn't
> any reply to my question or new proposal [2]. So here we are with my new
> proposal, that is more flexible and doesn't fix the ethernet mac only.
> This is just an RFC for the device tree representation for now to see if
> this is the correct way to tackle this.
> 
> I'm also aware of the latest post process hook support [3]. This doesn't
> fix the base mac address issue, but I think it also doesn't solve the
> case with swapped ethernet addresses in the general case. That hook will
> involve the driver to do the swapping, but how would the driver know
> if that swapping is actually required. Usually the interpretation of the
> content is opaque to the driver, after all it is the user/board
> manufacturer who does program the storage device. We might be lucky in
> the imx-ocotp case because the IMX reference manual actually states
> where and in which format the mac address is programmed.

A compatible string can define what is the format of the data.

> Introduce a transformation property. This is intended to be just an
> enumeration of operations. If there will be a new operation, support for
> it has to be added to the nvmem core.
> 
> A transformation might have multiple output values, like in the base mac
> address case. It reads the mac address from the nvmem storage and
> generates multiple individual addresses, i.e. on our board we reserve 8
> consecutive addresses. These addresses then can be assigned to different
> network interfaces. To make it possible to reference different values we
> need to introduce an argument to the phandle. This additional argument
> is then an index into a list of values.

I still don't think trying to encode transformations of data into the DT 
is right approach.

> 
> Example:
>   mac_addresses: base-mac-address@10 {
>     #nvmem-cell-cells = <1>;
>     reg = <10 6>;
>     transformation = <NVMEM_T_ETH_OFFSET 0 1 7>;
>   }
> 
>   &eth0 {
>     nvmem-cells = <&mac_addresses 0>;
>     nvmem-cell-names = "mac-address";
>   };
> 
>   &eth1 {
>     nvmem-cells = <&mac_addresses 2>;
>     nvmem-cell-names = "mac-address";
>   };
> 
> The NVMEM_T_ETH_OFFSET transformation takes N additional (dt) cells and
> will generate N values. In this example BASE_MAC+0, BASE_MAC+1, BASE_MAC+7.
> An nvmem consumer can then reference the nvmem cell with an index. So eth0
> will get BASE_MAC+0 and eth1 will get BASE_MAC+7.
> 
> This should be sufficient flexible for many different transformations
> without having to touch the bindings except for adding documentation and
> checks for new transformations.

The content and number of cells is supposed to be opaque to the client 
and interpreted by the provider. That's sort of true here, but not 
really because the interpretation is tied to 'transformation'. So I'm 
okay with adding cells, but not fixing the interpretation of them. A 
compatible should determine how the cells are interpreted.


> I do have one question regarding "#nvmem-cell-cells" (aside from the
> awkward naming): is it allowed to have that property optional if there
> is no additional argument to the phandle?

We don't have any choice if we add "#nvmem-cell-cells". There's already 
cases without it.

> 
> [1] https://lore.kernel.org/all/20210414152657.12097-2-michael@walle.cc/
> [2] https://lore.kernel.org/linux-devicetree/362f1c6a8b0ec191b285ac6a604500da@walle.cc/
> [3] https://lore.kernel.org/lkml/20211013131957.30271-1-srinivas.kandagatla@linaro.org/
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../devicetree/bindings/nvmem/nvmem.yaml      | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 456fb808100a..8893d045be77 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -26,11 +26,34 @@ properties:
>    "#size-cells":
>      const: 1
>  
> +  '#nvmem-cell-cells':
> +    enum: [0, 1]
> +    description:
> +      Must be 1 if the transformations has multiple output values.
> +      The argument is then the index into the list of output values.
> +      For example, if the nvmem cell only specify a base ethernet
> +      address the transformation can then create different individual
> +      ethernet addresses.
> +
>    read-only:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
>        Mark the provider as read only.
>  
> +  transformation:
> +    description:
> +      Transform the content of a NVMEM cell. Sometimes it is necessary
> +      to preprocess the content of a cell so it is usable by the NVMEM
> +      consumer. There are also cases where one NVMEM cell value can
> +      generate a list of values.
> +
> +      Use one of the NVMEM_T_* prefixed definitions from the header
> +      include/dt-bindings/nvmem/nvmem.h.
> +
> +      Some transformations might have additional arguments.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +
>    wp-gpios:
>      description:
>        GPIO to which the write-protect pin of the chip is connected.
> @@ -98,6 +121,12 @@ examples:
>                reg = <0xc 0x1>;
>                bits = <2 3>;
>            };
> +
> +          ethernet_base_mac: base-mac-address@100 {
> +              #nvmem-cell-cells = <1>;
> +              reg = <0x100 0x6>;
> +              transformation = <NVMEM_T_ETH_OFFSET 0 1 2 7>;
> +          };
>        };
>  
>  ...
> -- 
> 2.30.2
> 
> 
