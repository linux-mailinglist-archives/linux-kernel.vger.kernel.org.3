Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134E3518ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiECUdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiECUdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:33:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BBF32ED1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651609768; x=1683145768;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o4kl1e8M8PVHGwK9GOuu6JSRWmYmeGGCml0ZIEc6joQ=;
  b=paCldGRcOATE3bZuHKsuJqYRDwQmjlsLrCwyNHOstMd00U8hZhn+qbqz
   OB+VrGCNRy+aY/qv4V0qJKQ4j+TNzERhlmolte3nSjtmM7kErnLq6wTCI
   jzizdVwI8ENP9tlPpwePWY37zHKQFxZaXqxkSgM7BzypVQFUrDRGbcq3t
   XInJACLHcZ5y7Z9tmXdpja5x2A8TKNt8CU7L0hvUOn9Ll4PsEmEAZ3+oF
   Y0IuC/obV//vNrpPWDRTazldWKlBfRmzf2KONLqQXp17xV6A5qPMgkWN9
   XRlny/azhYZyTUs+FklZs5f4kwye8hLD3H92F01Ag3dHH45+gxTaN3tbS
   g==;
X-IronPort-AV: E=Sophos;i="5.91,196,1647273600"; 
   d="scan'208";a="311424725"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 04:29:27 +0800
IronPort-SDR: +XA3aG0LTDIEuBxdndbtTShIR47FST9ufbnIWKWuW0kcm7s7L6atBNNkNUC+kXMhXKO3ANMcc4
 2KpBaSVgm9yVjsHBEJ/645pSxuXC/0ShCYeCDE7CHunMdBdIBxGPVP+afR4pmLzjkCvUycosXz
 E29pKzdtr1fsi1lGf0iM5PKmY8Z4+wiYvMqpdKDltO9ODbEmEbhmoxaznJ9FdPYhQ9rgrIC61f
 OtUpPbIZJXH5uKSKZXlqL/n6JDbch0ExDRthFhmItyvpOW7e/JHb1ed6vQQOF3aRKw9GiPDWDH
 mbYQ5flhbrs4/oLHcI1XL2Fr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 13:00:10 -0700
IronPort-SDR: JorwfkjTmw7zXPVLSjvYewm8sNAvmEhF+M7fP3CuXVPMsLghyzeWe2DVu0C+Z2DvRY3LzB49K/
 ChAdEbFZHQoR1UCKcFLEDw35poc5SVJZvyfRF5WYtlYwzIDexjVtJxhrlnpW19Svf7jB0sUtge
 +gi6flohlpr/6E/sA/SgybhLR6q5S6LyZZQkTekapBcqmVlPn21yrkgxEQvLohkliX+pMBqTUO
 8PM4YpR6OtbENnZ0d+FKpKkcTV0IamWg71OedSQOtVUqIYPpWhgpHkqUAugWkV4DxixjLUnZXi
 K6I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 13:29:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KtBQG4bhBz1SVp2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:29:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651609765; x=1654201766; bh=o4kl1e8M8PVHGwK9GOuu6JSRWmYmeGGCml0
        ZIEc6joQ=; b=K6gfJo7qgZRtQaArD+B/LXT+Cw8Srtjyp0LLvUSSd6DGE+OSQvZ
        f0H7xnps3MAxqtnzPPIv3QvJmXLEFCu6PRKFuMYyWD6e4hnPB0Cv6mG4qUd44yQ/
        rjoR8DjJ/CciXoqKPgwu4T1anACIRPI9Xr03MQTbfilcmY3PSJqNethwtZBu5PR8
        N1O/hgvhIFw6IVjboO6MWFGSvCKhnPQ4jWYnaC4u2vk7bDw14uPboJpDttKWfC+b
        lJpfIgGszzsfhBQXWPz4LWx/kiUAklRegy+8fqa/yIyGDH2lPx8yRe0yz4t1jiRK
        faHFG7wIobjEqudmRHfkM7Lk9MQjdWQVLqw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YkUeKvTTTctl for <linux-kernel@vger.kernel.org>;
        Tue,  3 May 2022 13:29:25 -0700 (PDT)
Received: from [10.225.81.200] (unknown [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KtBQD1mr9z1Rvlc;
        Tue,  3 May 2022 13:29:24 -0700 (PDT)
Message-ID: <773f5323-43af-6764-ea74-2a3bac2022e8@opensource.wdc.com>
Date:   Wed, 4 May 2022 05:29:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 02/23] dt-bindings: ata: ahci-platform: Detach common
 AHCI bindings
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
 <20220503200938.18027-3-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220503200938.18027-3-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/04 5:09, Serge Semin wrote:
> In order to create a more sophisticated AHCI controller DT bindings let's
> divide the already available generic AHCI platform YAML schema into the
> platform part and a set of the common AHCI properties. The former part
> will be used to evaluate the AHCI DT nodes mainly compatible with the
> generic AHCI controller while the later schema will be used for more
> thorough AHCI DT nodes description. For instance such YAML schemas design
> will be useful for our DW AHCI SATA controller derivative with four clock
> sources, two reset lines, one system controller reference and specific
> max Rx/Tx DMA xfers size constraints.
> 
> Note the phys and target-supply property requirement is preserved in the
> generic AHCI platform bindings because some platforms can lack of the
> explicitly specified PHYs or target device power regulators.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Folks, I don't really see why the phys/target-supply requirement has been
> added to the generic AHCI DT schema in the first place. Probably just to
> imply some meaning for the sub-nodes definition. Anyway in one of the
> further patches I am adding the DW AHCI SATA controller DT bindings which
> won't require having these properties specified in the sub-nodes, but will
> describe additional port-specific properties. That's why I get to keep the
> constraints in the ahci-platform.yaml schema instead of moving them to the
> common schema.
> 
> Changelog v2:
> - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> ---
>  .../devicetree/bindings/ata/ahci-common.yaml  | 117 ++++++++++++++++++
>  .../bindings/ata/ahci-platform.yaml           |  68 +---------
>  2 files changed, 123 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> new file mode 100644
> index 000000000000..72e24b246040
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ahci-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Properties for Serial ATA AHCI controllers
> +
> +maintainers:
> +  - Hans de Goede <hdegoede@redhat.com>
> +  - Jens Axboe <axboe@kernel.dk>

This should probably be me rather than Jens since Jens is no longer maintaining
libata/ahci.

> +
> +description:
> +  This document defines device tree properties for a common AHCI SATA
> +  controller implementation. It's hardware interface is supposed to
> +  conform to the technical standard defined by Intel (see Serial ATA
> +  Advanced Host Controller Interface specification for details). The
> +  document doesn't constitute a DT-node binding by itself but merely
> +  defines a set of common properties for the AHCI-compatible devices.
> +
> +select: false
> +
> +allOf:
> +  - $ref: sata-common.yaml#
> +
> +properties:
> +  reg:
> +    description:
> +      Generic AHCI registers space conforming to the Serial ATA AHCI
> +      specification.
> +
> +  reg-names:
> +    description: CSR space IDs
> +
> +  interrupts:
> +    description:
> +      Generic AHCI state change interrupt. Can be implemented either as a
> +      single line attached to the controller as a set of the dedicated signals
> +      for the global and particular port events.
> +
> +  clocks:
> +    description:
> +      List of all the reference clocks connected to the controller.
> +
> +  clock-names:
> +    description: Reference clocks IDs
> +
> +  resets:
> +    description:
> +      List of the reset control lines to reset the controller clock
> +      domains.
> +
> +  reset-names:
> +    description: Reset line IDs
> +
> +  power-domains:
> +    description:
> +      List of the power domain the AHCI controller being a part of.
> +
> +  ahci-supply:
> +    description: Power regulator for AHCI controller
> +
> +  target-supply:
> +    description: Power regulator for SATA target device
> +
> +  phy-supply:
> +    description: Power regulator for SATA PHY
> +
> +  phys:
> +    description: Reference to the SATA PHY node
> +    maxItems: 1
> +
> +  phy-names:
> +    maxItems: 1
> +
> +  ports-implemented:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description:
> +      Mask that indicates which ports the HBA supports. Useful if PI is not
> +      programmed by the BIOS, which is true for some embedded SoC's.
> +    maximum: 0x1f
> +
> +patternProperties:
> +  "^sata-port@[0-9a-f]+$":
> +    type: object
> +    description:
> +      It is optionally possible to describe the ports as sub-nodes so
> +      to enable each port independently when dealing with multiple PHYs.
> +
> +    properties:
> +      reg:
> +        description: AHCI SATA port identifier
> +        maxItems: 1
> +
> +      phys:
> +        description: Individual AHCI SATA port PHY
> +        maxItems: 1
> +
> +      phy-names:
> +        description: AHCI SATA port PHY ID
> +        maxItems: 1
> +
> +      target-supply:
> +        description: Power regulator for SATA port target device
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: true
> +
> +required:
> +  - reg
> +  - interrupts
> +
> +additionalProperties: true
> +
> +...
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 9304e4731965..76075d3c8987 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -36,8 +36,7 @@ select:
>      - compatible
>  
>  allOf:
> -  - $ref: "sata-common.yaml#"
> -
> +  - $ref: "ahci-common.yaml#"
>  
>  properties:
>    compatible:
> @@ -69,90 +68,35 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    description:
> -      Clock IDs array as required by the controller.
>      minItems: 1
>      maxItems: 3
>  
>    clock-names:
> -    description:
> -      Names of clocks corresponding to IDs in the clock property.
>      minItems: 1
>      maxItems: 3
>  
>    interrupts:
>      maxItems: 1
>  
> -  ahci-supply:
> -    description:
> -      regulator for AHCI controller
> -
> -  phy-supply:
> -    description:
> -      regulator for PHY power
> -
> -  phys:
> -    description:
> -      List of all PHYs on this controller
> -    maxItems: 1
> -
> -  phy-names:
> -    description:
> -      Name specifier for the PHYs
> -    maxItems: 1
> -
> -  ports-implemented:
> -    $ref: '/schemas/types.yaml#/definitions/uint32'
> -    description: |
> -      Mask that indicates which ports that the HBA supports
> -      are available for software to use. Useful if PORTS_IMPL
> -      is not programmed by the BIOS, which is true with
> -      some embedded SoCs.
> -    maximum: 0x1f
> -
>    power-domains:
>      maxItems: 1
>  
>    resets:
>      maxItems: 1
>  
> -  target-supply:
> -    description:
> -      regulator for SATA target power
> -
> -required:
> -  - compatible
> -  - reg
> -  - interrupts
> -
>  patternProperties:
>    "^sata-port@[0-9a-f]+$":
>      type: object
> -    additionalProperties: false
> -    description:
> -      Subnode with configuration of the Ports.
> -
> -    properties:
> -      reg:
> -        maxItems: 1
> -
> -      phys:
> -        maxItems: 1
> -
> -      phy-names:
> -        maxItems: 1
> -
> -      target-supply:
> -        description:
> -          regulator for SATA target power
> -
> -    required:
> -      - reg
>  
>      anyOf:
>        - required: [ phys ]
>        - required: [ target-supply ]
>  
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
>  unevaluatedProperties: false
>  
>  examples:


-- 
Damien Le Moal
Western Digital Research
