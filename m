Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C1E48A0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiAJUaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:30:52 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38629 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiAJUat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:30:49 -0500
Received: by mail-ot1-f42.google.com with SMTP id r7-20020a05683001c700b005906f5b0969so16363658ota.5;
        Mon, 10 Jan 2022 12:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MKJQ46PXBRbX6bCNyZMsAP+5yRLdHD8JjzPIOUXANYM=;
        b=TIfFS1VAQf0koBpQZ9xuxiyFWP4i5BmLCroFQY+Xy3heA09wsord20jGzqynz2Z6zI
         pemJ5bSCpksEvBKHyDHE72b5sLURkjN9nrIHzMdTbGM4zwmJ8T1QIGIGdML66XI24Yfq
         FN2l1p5n+YsNbPgG0/iMV98o79XXvzBW4R9YGUfzi1N6EFK0EVELB3v0lD6AwD5rA2jA
         oY1uabdSA6kqBLlz55JPu3pCHnoGh7JOAFowZCaWJsVkjPrNJCTq8M1DMfOnGWEZOQQ6
         EYbTNJpWhA0QxfATRykw9KWsWdr7aUFvSVIvC/YaB516mGYaB9pQOzIx8+LABP5hq2Ul
         eGUg==
X-Gm-Message-State: AOAM5312uR9TPdoOZdIMwHbdN0xO/TmpD9vgxuoZXHImKPyv+fy/Q2AV
        OLLru1cGd5MsK9hj0R7/xg==
X-Google-Smtp-Source: ABdhPJypI0jh4xGPymX7WW4kmfi4y2tlwYVgBPzl//PWUOT801iF3brtIEXzIAcl5zs/7z6xi1Q/oQ==
X-Received: by 2002:a9d:2243:: with SMTP id o61mr1159065ota.126.1641846648609;
        Mon, 10 Jan 2022 12:30:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t66sm1321881oie.39.2022.01.10.12.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 12:30:47 -0800 (PST)
Received: (nullmailer pid 1451794 invoked by uid 1000);
        Mon, 10 Jan 2022 20:30:46 -0000
Date:   Mon, 10 Jan 2022 14:30:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 2/3] dt-bindings: nvmem: add U-Boot environment
 variables binding
Message-ID: <YdyXdrgh7+I2CaX6@robh.at.kernel.org>
References: <20211230090449.11808-1-zajec5@gmail.com>
 <20211230090449.11808-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211230090449.11808-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 10:04:48AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This binding allows describing a (part of) MTD device (partition) that
> contains a block with environment variables. Operating system usually
> needs to parse that block to read variables values that may affect
> booting process & device configuration.

What do the u-boot folks think about this binding? This needs an ack 
from a u-boot maintainer.

> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: s/u,boot/u-boot/
> ---
>  .../devicetree/bindings/nvmem/u-boot,env.yaml | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> new file mode 100644
> index 000000000000..e3296e005ffd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: U-Boot environment variables
> +
> +description: |
> +  U-Boot uses environment variables to store device parameters and
> +  configuration. They may be used for booting process, setup or keeping end user
> +  interesting info.
> +
> +  Data is stored on flash partition in a U-Boot specific format (CRC32 and NUL
> +  separated key-value pairs).
> +
> +  This binding allows specifying data location and format (default one or vendor
> +  specific).
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - u-boot,env
> +      - brcm,env
> +
> +  reg:
> +    maxItems: 1
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            label = "uboot";
> +            reg = <0x0 0x100000>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            nvmem@10000 {

I think most existing cases define a partition for the u-boot env, but 
this looks like you have it nested with other u-boot related data? Is 
there any reason to nest the partitions? A compatible in a partition 
node should be enough.

> +                compatible = "u-boot,env";
> +                reg = <0x10000 0x10000>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 67558097bb66..271c29c84c7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19624,6 +19624,11 @@ W:	http://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/pci/tw686x/
>  
> +U-BOOT ENVIRONMENT VARIABLES
> +M:	Rafał Miłecki <rafal@milecki.pl>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> +
>  UACCE ACCELERATOR FRAMEWORK
>  M:	Zhangfei Gao <zhangfei.gao@linaro.org>
>  M:	Zhou Wang <wangzhou1@hisilicon.com>
> -- 
> 2.31.1
> 
> 
