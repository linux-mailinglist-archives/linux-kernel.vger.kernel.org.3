Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474C750313E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356264AbiDOWD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiDOWD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:03:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF87729CBB;
        Fri, 15 Apr 2022 15:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B6F7B8311C;
        Fri, 15 Apr 2022 22:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D90C385A4;
        Fri, 15 Apr 2022 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650060085;
        bh=3nAlILfONam3A1vF12+Z//hbMZsSoLMl3r4snyjFDkg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=R5ACtTmRa1lWffZNP40CcYwujsVyYLvLu7t4cuSkHx/zaTDgutlQ4iwTl0T+OF46E
         KTk2+o63Z5vwr6TH66atXLG4sAjRb/3Fu3/lo+Yd3s4T2y408M4g5eshPM00FXsruY
         gnQywd9MCBBru4u0+hmOTmRr5Sf6fOH6A8aUY3iN3hikuJ5hZX6mYNnkvR8sfqbHJZ
         6cwdJQMOfy9nf5UrBix4ZArxlSXSr5cEKNoGxqL5AE9/8QMWl5q0TSv2lORkNvm+eu
         0mpduXkufAAx6byB3UeBLcqIFKHPEHxW+sH7kFA7AyIzaxOVMzTIUGBGsnuhnJ9rtg
         ul349pv5wZ/2g==
Date:   Fri, 15 Apr 2022 15:01:24 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [RFC PATCH 3/6] dt-bindings: xen: Add xen,dev-domid property
 description for xen-virtio layer
In-Reply-To: <1649963973-22879-4-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204151300130.915916@ubuntu-linux-20-04-desktop>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com> <1649963973-22879-4-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Introduce Xen specific binding for the virtio-mmio device to be used
> by Xen virtio support driver in a subsequent commit.
> 
> This binding specifies the ID of Xen domain where the corresponding
> device (backend) resides. This is needed for the option to restrict
> memory access using Xen grant mappings to work.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
>  .../devicetree/bindings/virtio/xen,dev-domid.yaml  | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml b/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
> new file mode 100644
> index 00000000..78be993
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/virtio/xen,dev-domid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xen specific binding for the virtio device
> +
> +maintainers:
> +  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> +
> +select: true
> +
> +description:
> +  This binding specifies the ID of Xen domain where the corresponding device
> +  (backend) resides. This is needed for the option to restrict memory access
> +  using Xen grant mappings to work.
> +
> +  Note that current and generic "iommus" bindings are mutually exclusive, since
> +  the restricted memory access model on Xen behaves as a kind of software IOMMU.

I don't think that this last statement is necessary or fully accurate, so
I would remove it. Other than that, this looks good to me.


> +properties:
> +  xen,dev-domid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Should contain the ID of device's domain.

Maybe better as:
"The domid (domain ID) of the domain where the device (backend) is running"



> +additionalProperties: true
> +
> +examples:
> +  - |
> +    virtio_block@3000 {
> +            compatible = "virtio,mmio";
> +            reg = <0x3000 0x100>;
> +            interrupts = <41>;
> +
> +            /* The device is located in Xen domain with ID 1 */
> +            xen,dev-domid = <1>;
> +    };
> -- 
> 2.7.4
> 
