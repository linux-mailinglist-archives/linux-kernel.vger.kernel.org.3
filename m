Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F105206CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiEIVn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiEIVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:43:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B73712E318;
        Mon,  9 May 2022 14:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19FFBB8199B;
        Mon,  9 May 2022 21:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98FBC385BF;
        Mon,  9 May 2022 21:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652132363;
        bh=bGVROk1yCVFbw1tN5TwGGaOX8G0Pd3s1D8n+lUcuavY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jIjU+8tpltcUUdOqWb8RQToebMMi7jlG6EnTVHQBvz5t4l//CxxmzayoSnWIXtjIq
         fy84fHDqbtXeMASASk++DG2/cUJ91hHqe+1Of9X3a0Eqm2Ev0LsG2q4HBN1O49pRh/
         joc0a+YLoJYyXOtV+WB+uOq6+Eg9WZ38FDg+fEdO7rWaYwefXDFa+7Z2682LO0g4He
         fqu6yjT37l+A8wnb4ZLJ51/OtFAAs5lLs25jPNFrue7rXsnPkmBkwix4cn5/5iwLu6
         rQglFPRi0M/Wk8iwB4xrNXNUkRTDsHz+TWohutLj7rphd2GX07IfzohFQHQSlMvjcM
         6uDxuOP7Y4MIQ==
Date:   Mon, 9 May 2022 14:39:22 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen, dev-domid property description
 for xen-grant DMA ops
In-Reply-To: <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205091436390.43560@ubuntu-linux-20-04-desktop>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com> <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Introduce Xen specific binding for the virtualized device (e.g. virtio)
> to be used by Xen grant DMA-mapping layer in the subsequent commit.
> 
> This binding indicates that Xen grant mappings scheme needs to be
> enabled for the device which DT node contains that property and specifies
> the ID of Xen domain where the corresponding backend resides. The ID
> (domid) is used as an argument to the grant mapping APIs.
> 
> This is needed for the option to restrict memory access using Xen grant
> mappings to work which primary goal is to enable using virtio devices
> in Xen guests.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

The binding is OK and the wording is OK too.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

I am not an expert on the details of writing a good schema, I'll defer
to Rob if he has any comments on that.


> ---
> Changes RFC -> V1:
>    - update commit subject/description and text in description
>    - move to devicetree/bindings/arm/
> 
> Changes V1 -> V2:
>    - update text in description
>    - change the maintainer of the binding
>    - fix validation issue
>    - reference xen,dev-domid.yaml schema from virtio/mmio.yaml
> ---
>  .../devicetree/bindings/arm/xen,dev-domid.yaml     | 37 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/virtio/mmio.yaml |  7 ++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> new file mode 100644
> index 00000000..750e89e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/xen,dev-domid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xen specific binding for virtualized devices (e.g. virtio)
> +
> +maintainers:
> +  - Stefano Stabellini <sstabellini@kernel.org>
> +
> +select: true
> +
> +description:
> +  This binding indicates that Xen grant mappings need to be enabled for
> +  the device, and it specifies the ID of the domain where the corresponding
> +  device (backend) resides. The property is required to restrict memory
> +  access using Xen grant mappings.
> +
> +properties:
> +  xen,dev-domid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The domid (domain ID) of the domain where the device (backend) is running.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    virtio@3000 {
> +            compatible = "virtio,mmio";
> +            reg = <0x3000 0x100>;
> +            interrupts = <41>;
> +
> +            /* The device is located in Xen domain with ID 1 */
> +            xen,dev-domid = <1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> index 10c22b5..29a0932 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -13,6 +13,9 @@ description:
>    See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
>    more details.
>  
> +allOf:
> +  - $ref: /schemas/arm/xen,dev-domid.yaml#
> +
>  properties:
>    compatible:
>      const: virtio,mmio
> @@ -33,6 +36,10 @@ properties:
>      description: Required for devices making accesses thru an IOMMU.
>      maxItems: 1
>  
> +  xen,dev-domid:
> +    description: Required when Xen grant mappings need to be enabled for device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
