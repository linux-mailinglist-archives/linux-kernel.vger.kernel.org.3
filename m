Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064457A411
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiGSQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiGSQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:17:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ABB4F681
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:17:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id o18so13919864pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j99v33ldlK2FlKWV4TdK79PiQjRVPI8FTWxxa1tOtzg=;
        b=xyAHcPPkHVBNE/JfV8PykfXY21OGJO3tYb8jOvOdDWvKZ3n6FFrvFYly2ZDsyG47aq
         LDQBdEnk2K9xm+YjB4uVZCbVDVu29dvWKW2IVRXnEiDaocXiyXdlDLMW6CXLIcz/kR81
         nIDPKMWeMsTFjMSNMkLWDiTZTjJ3DSoEcakCVhvmMk0l5E0wQiCEkhHW8hlnI+jiVirF
         Lx1fvZoAUDWnzq8elL8JxetYAqHgAH0KmeajbeP97UWhhZjqeGWM/KtuX9UcbStGUlXh
         jEJVuSnIxIC7xB+ZC8a2XzNp/qRUdWGjoM19E5dj5SUjYXEOig0vb5TgH4ajeON2SD6q
         8cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j99v33ldlK2FlKWV4TdK79PiQjRVPI8FTWxxa1tOtzg=;
        b=4Dfmw0lLeFUI3ezG0sb1Dyg8rDxGKfsImbQNZc2WVIXP6CoX/khz6F/Fsaby3hyg7Q
         ZEEKLqy1PGMsrWKxv6pH5MIcXg6Tso/zE7yg55C1UFxaaX7JLdqzuyhWMuzbW7J3VAMN
         klC5vG/EMxkNEfAJqqcYLt+2HIqYO8Lvzn1guNotkmhxXpvRXUiZmVk/hVdkrXMOVdJo
         WaRNd4FV6hCl681Lmx1CMupW/p4lRcyGysEdFQXpP/WmhTPog/UrA0DOtZgL9temIYoU
         I9A3GvCym6TwE979VtpnBYwVYF0Ur6deh1v46rmVi6mS+2kSq0TSByqbLjTS4JmDUY8c
         fbyA==
X-Gm-Message-State: AJIora9uP/Ms552KfeuMWjzG5UYkfwblcCJ6H6zXukHRJsMCzpmFN8qt
        rdNCG+x6dA+5Y+XAii3j0W5OVADoUsK4Uw==
X-Google-Smtp-Source: AGRyM1uDNXtAFgSgT5rk5Rv6dIC3uv0YhISGtimtbCkCl2vkoNFU0onmeUEBjPOSoO32fjDz7J8wow==
X-Received: by 2002:a63:3fcc:0:b0:408:c856:dd6d with SMTP id m195-20020a633fcc000000b00408c856dd6dmr29959582pga.354.1658247469226;
        Tue, 19 Jul 2022 09:17:49 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g26-20020aa796ba000000b0052ab5a740aesm11675817pfk.162.2022.07.19.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 09:17:48 -0700 (PDT)
Date:   Tue, 19 Jul 2022 10:17:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Puranjay Mohan <p-mohan@ti.com>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        grygorii.strashko@ti.com, vigneshr@ti.com, kishon@ti.com,
        robh@kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: remoteproc: Add PRU consumer bindings
Message-ID: <20220719161746.GC3393732@p14s>
References: <20220607045650.4999-1-p-mohan@ti.com>
 <20220607045650.4999-2-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607045650.4999-2-p-mohan@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 10:26:45AM +0530, Puranjay Mohan wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add a YAML binding document for PRU consumers. The binding includes
> all the common properties that can be used by different PRU consumer
> or application nodes and supported by the PRU remoteproc driver.
> These are used to configure the PRU hardware for specific user
> applications.
> 
> The application nodes themselves should define their own bindings.
> 
> Co-developed-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> V3->V4:
> * Addressed Rob's comments regarding max and min Items.
> * removed the dependencies tag as it was redundant.
> ---
>  .../bindings/remoteproc/ti,pru-consumer.yaml  | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> new file mode 100644
> index 000000000000..df384b44259b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common TI PRU Consumer Binding
> +
> +maintainers:
> +  - Suman Anna <s-anna@ti.com>
> +
> +description: |
> +  A PRU application/consumer/user node typically uses one or more PRU device
> +  nodes to implement a PRU application/functionality. Each application/client
> +  node would need a reference to at least a PRU node, and optionally define
> +  some properties needed for hardware/firmware configuration. The below
> +  properties are a list of common properties supported by the PRU remoteproc
> +  infrastructure.
> +
> +  The application nodes shall define their own bindings like regular platform
> +  devices, so below are in addition to each node's bindings.
> +
> +properties:
> +  ti,prus:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandles to the PRU, RTU or Tx_PRU nodes used
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      maxItems: 1
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    minItems: 1
> +    maxItems: 6
> +    description: |
> +      firmwares for the PRU cores, the default firmware for the core from
> +      the PRU node will be used if not provided. The firmware names should
> +      correspond to the PRU cores listed in the 'ti,prus' property
> +
> +  ti,pruss-gp-mux-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      enum: [0, 1, 2, 3, 4]
> +    description: |
> +      array of values for the GP_MUX_SEL under PRUSS_GPCFG register for a PRU.
> +      This selects the internal muxing scheme for the PRU instance. Values
> +      should correspond to the PRU cores listed in the 'ti,prus' property. The
> +      GP_MUX_SEL setting is a per-slice setting (one setting for PRU0, RTU0,
> +      and Tx_PRU0 on K3 SoCs). Use the same value for all cores within the
> +      same slice in the associative array. If the array size is smaller than
> +      the size of 'ti,prus' property, the default out-of-reset value (0) for the
> +      PRU core is used.
> +
> +required:
> +  - ti,prus
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    /* PRU application node example */
> +    pru-app {
> +        ti,prus = <&pru0>, <&pru1>;
> +        firmware-name = "pruss-app-fw0", "pruss-app-fw1";
> +        ti,pruss-gp-mux-sel = <2>, <1>;
> +    };

It would be nice to have a full example in order to provide more context.

I am done reviewing this set.

Thanks,
Mathieu

> -- 
> 2.17.1
> 
