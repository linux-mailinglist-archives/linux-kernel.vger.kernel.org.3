Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCC24D430B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiCJJGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiCJJGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:06:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A6111375BA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646903111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAYCq9czLIZzoXPdYqqCAowC2htPopAKPdrkAbY8Cbo=;
        b=JwXMsmw+FLdmqNGqQ0Lh7EMQmBiHI9JmeojpSGdQ8EoJgZk17qz0YM+aEtnWhNGjQAfidq
        NY0Z61oBGDVtkG0ff47pFNfgVdWbTV7SqCytgyvrJRCFkOG9NsNkNFrF7hQlb9JfoSVpzc
        clgBhwpsXw01qMills+CIESXyGlW/5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-_ju_elblO9-AfG_HY91MiA-1; Thu, 10 Mar 2022 04:05:08 -0500
X-MC-Unique: _ju_elblO9-AfG_HY91MiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F06D91006AA5;
        Thu, 10 Mar 2022 09:05:06 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.194.252])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0C741059157;
        Thu, 10 Mar 2022 09:05:05 +0000 (UTC)
Subject: Re: [PATCH] dt-bindings: arm: Convert QEMU fw-cfg to DT schema
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220310013552.549590-1-robh@kernel.org>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <9651bc36-3da0-4e2b-1d29-bb4b3ce1389d@redhat.com>
Date:   Thu, 10 Mar 2022 10:05:04 +0100
MIME-Version: 1.0
In-Reply-To: <20220310013552.549590-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/22 02:35, Rob Herring wrote:
> Convert the QEMU fw-cfg binding to DT schema format. As this binding is
> also used on Risc-V now, drop any architecture references and move to a
> common location. The fw-cfg interface has also gained some DMA support
> which is coherent, so add the missing 'dma-coherent'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/fw-cfg.txt        | 38 -------------
>  .../bindings/firmware/qemu,fw-cfg-mmio.yaml   | 54 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/fw-cfg.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/fw-cfg.txt b/Documentation/devicetree/bindings/arm/fw-cfg.txt
> deleted file mode 100644
> index fd54e1db2156..000000000000
> --- a/Documentation/devicetree/bindings/arm/fw-cfg.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -* QEMU Firmware Configuration bindings for ARM
> -
> -QEMU's arm-softmmu and aarch64-softmmu emulation / virtualization targets
> -provide the following Firmware Configuration interface on the "virt" machine
> -type:
> -
> -- A write-only, 16-bit wide selector (or control) register,
> -- a read-write, 64-bit wide data register.
> -
> -QEMU exposes the control and data register to ARM guests as memory mapped
> -registers; their location is communicated to the guest's UEFI firmware in the
> -DTB that QEMU places at the bottom of the guest's DRAM.
> -
> -The authoritative guest-side hardware interface documentation to the fw_cfg
> -device can be found in "docs/specs/fw_cfg.txt" in the QEMU source tree.
> -
> -
> -Required properties:
> -
> -- compatible: "qemu,fw-cfg-mmio".
> -
> -- reg: the MMIO region used by the device.
> -  * Bytes 0x0 to 0x7 cover the data register.
> -  * Bytes 0x8 to 0x9 cover the selector register.
> -  * Further registers may be appended to the region in case of future interface
> -    revisions / feature bits.
> -
> -Example:
> -
> -/ {
> -	#size-cells = <0x2>;
> -	#address-cells = <0x2>;
> -
> -	fw-cfg@9020000 {
> -		compatible = "qemu,fw-cfg-mmio";
> -		reg = <0x0 0x9020000 0x0 0xa>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml b/Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
> new file mode 100644
> index 000000000000..3aac9448e7f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/qemu,fw-cfg-mmio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QEMU Firmware Configuration bindings
> +
> +maintainers:
> +  - Laszlo Ersek <lersek@redhat.com>

Ugh :) I guess this is based on my authorship of historical commit
53275a61bc7a ("devicetree: document ARM bindings for QEMU's Firmware
Config interface", 2015-01-13), and prehaps my R-b on commit
92aed5d6ba90 ("devicetree: update documentation for fw_cfg ARM
bindings", 2016-02-09).

However -- I totally can't maintain this file. (I mean I've probably not
done anything related to it in the past seven years, so I guess it's
time to admit that fact!)

Rob, would you please consider taking it over?

With my name+email replaced with yours:

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thank you!
Laszlo


> +
> +description: |
> +  Various QEMU emulation / virtualization targets provide the following
> +  Firmware Configuration interface on the "virt" machine type:
> +
> +  - A write-only, 16-bit wide selector (or control) register,
> +  - a read-write, 64-bit wide data register.
> +
> +  QEMU exposes the control and data register to guests as memory mapped
> +  registers; their location is communicated to the guest's UEFI firmware in the
> +  DTB that QEMU places at the bottom of the guest's DRAM.
> +
> +  The authoritative guest-side hardware interface documentation to the fw_cfg
> +  device can be found in "docs/specs/fw_cfg.txt" in the QEMU source tree.
> +
> +
> +properties:
> +  compatible:
> +    const: qemu,fw-cfg-mmio
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      * Bytes 0x0 to 0x7 cover the data register.
> +      * Bytes 0x8 to 0x9 cover the selector register.
> +      * Further registers may be appended to the region in case of future interface
> +        revisions / feature bits.
> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    fw-cfg@9020000 {
> +        compatible = "qemu,fw-cfg-mmio";
> +        reg = <0x9020000 0xa>;
> +    };
> +...
> 

