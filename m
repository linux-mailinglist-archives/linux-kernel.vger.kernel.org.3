Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B54D436B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbiCJJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiCJJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:25:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185F1390FB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:24:14 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA7E83F321
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646904252;
        bh=Vq+x+LnICgNgSaQrOStld4MyN/N8TRx3ztXdKLjhEx0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TGeX02+LAEvK7aT8Bf5Yu4E9v3PIQzt969ZzIKi2WGoDh8xc875K3W2tbcVsXqX3Y
         GGVJ+ADeFWPeUeKWkg8I9ne2Y7np+M7Y1MoKH1cMYX2A2jQFako0ALgihZO6oUAHRy
         vTEmK8e5gFvq1WzYbOtPcotoZNV8UYRRBi0nAaFoyCZiPM0qx1VAJvvvY4R5f5m4gH
         93UU9ddanFJqIUrO9ZOV+8OMFbelP43QJtRofog3kfQM8xf+/zTOo438D5kH+YqS7Q
         +E2G6EFZ1kQiaIa/oQw1BaO+EwFPofNguFIJdWKo4FSYb8GZfc4bR2HqUvxZXWetnC
         hC/uhDak6fgDg==
Received: by mail-ed1-f70.google.com with SMTP id l24-20020a056402231800b00410f19a3103so2785077eda.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vq+x+LnICgNgSaQrOStld4MyN/N8TRx3ztXdKLjhEx0=;
        b=lJuKad1vyIPGR6J0c0oZID/WZQ0Sit3xED+RaU1Y7Th0MEn6Zme64XLrtO6XbOFm6b
         TFS8jmw7NYufNL6NbenUqBDyRYoUeB7wOFlDKi4tmNaCrm8kVPc3V4045uvr+LimkFeQ
         s4eV9W57babQU9TU5S1xTIF0wDcdCGGeMFrA8rqrta6q4uZMmInPV6aEjEnWrtKjzQx5
         iU0ZJAJ6Fih+GbcKYkft7Gqzx/90+dIp6186Q7TXcw6OJIzX/W98OLZ6jnESagYHQ8fn
         G1pq8M3O8YbeMALMBpsGMJ3/BddrW3B23cF87jVCzs+Q3GduoFIyC04ZDM2R14o0nwQZ
         An8A==
X-Gm-Message-State: AOAM533V+RR1jyyhOC6EbKn9G65tzIIEC8nFZVzG7eiRqMUgm8KKOLQ5
        1tMIAR2GcdL09BB0Fvw94CriPVyRfwAZi2lvg6njha3SW1wAQNCA1SOa6IGz1C23ne7uCR38wYB
        Q2ibEepjGJwjlSE4qPbX61z98wBNCK+lZ7jiDGNee2A==
X-Received: by 2002:aa7:de84:0:b0:40f:db98:d0f9 with SMTP id j4-20020aa7de84000000b0040fdb98d0f9mr3362736edv.366.1646904252551;
        Thu, 10 Mar 2022 01:24:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBzUrALp6RBw3QyI4DMV1UDz3vpwLuHFpa3ac6hmg3GtuGPDpwGZ4fXoqGkaFiZShadZCanA==
X-Received: by 2002:aa7:de84:0:b0:40f:db98:d0f9 with SMTP id j4-20020aa7de84000000b0040fdb98d0f9mr3362710edv.366.1646904252290;
        Thu, 10 Mar 2022 01:24:12 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906780400b006ce69ff6050sm1601377ejm.69.2022.03.10.01.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 01:24:11 -0800 (PST)
Message-ID: <d3ac3e2f-71fd-b2b4-7c7e-bb43c681d14e@canonical.com>
Date:   Thu, 10 Mar 2022 10:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1646892810.git.qinjian@cqplus1.com>
 <80256ac7f67c041ae3070638aa6499ee0d0ee0c6.1646892810.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <80256ac7f67c041ae3070638aa6499ee0d0ee0c6.1646892810.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 07:28, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Remove the internal clock parent from DTS
> ---
>  .../bindings/clock/sunplus,sp7021-clkc.yaml   |  39 ++++++
>  MAINTAINERS                                   |   2 +
>  include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
>  3 files changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/sp-sp7021.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
> new file mode 100644
> index 000000000..7d6e3fdd7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sunplus,sp7021-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SP7021 SoC Clock Controller Binding
> +
> +maintainers:
> +  - Qin Jian <qinjian@cqplus1.com>
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-clkc
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    clkc: clock-controller@9c000000 {
> +      compatible = "sunplus,sp7021-clkc";
> +      #clock-cells = <1>;
> +      reg = <0x9c000000 0x280>;

In DTS code, please put reg after compatible. In all your examples and
DTS patches.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
