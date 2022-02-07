Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACBD4AC53A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382668AbiBGQPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391863AbiBGQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:04:13 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054E0C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:04:09 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CD8E24003E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644249847;
        bh=wWFN/kYmy9qogqxR7Mh7jeBKCVIaVeKo6j328DRFO5U=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rhTkA/xBwPaz9wH/5KTJdDAmdUSp8XMvNoMNzIL62XYoWeINEtHNTjLNdfqr5jEpP
         Pls4VsjFLC0iIG44HcwfegBgvioj5DM02xAxMiWMujTU6TYsM40N4FO9retiDd4Ba4
         PqYwXYAmojvTGo8AatZMPKNqjmPjeQa96RraNJ11ppEXrOLe0m8Hb1Ei/q6fsO5os1
         NQTBhUb5dX/Fy6D8xliAjPNSGRBOAGfSXRFhIAEkO2Va/K68KIMt7amNpSUoVcJLY6
         229eBiZRkc4LqEVJT5wW2DGY6y9hj19ossY87yylGeRhst1dnrLbq8oxDLp3ED3cQN
         D6vuMm/Nie2KQ==
Received: by mail-ed1-f72.google.com with SMTP id f6-20020a0564021e8600b0040f662b99ffso2138332edf.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 08:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wWFN/kYmy9qogqxR7Mh7jeBKCVIaVeKo6j328DRFO5U=;
        b=rRRoXzsERr/53VvNK0MNj3tr0E0vrVuQzUSoIugiRWBWCHwZG5YzxNJkV6XkLT3nMg
         AejVzKfvjxt7Yq2ssi7vXAxBD8lx6tcPPc2OaJpZbi8cfRC65IVCDxmV8cOJxwslYgxF
         ap1utCTAs9to/2SWdE2EU1yO/LUJtG4aE1qIJZ/KpOTDeHRslgYrwjxJU6GJcXjJitQC
         MNIZL0dWV2Nrusahof4ZM/UwWr3uL/a0bUnldFMRiArlEnrtjoOxv7ybmgI7nsI8Bz5b
         /Fx3aozA6PJmfR1+RLXxJv+akBI+GHytcCCOg/uVEvJ6QW5sFRy/RiXbiocKzWcYohQK
         ogrQ==
X-Gm-Message-State: AOAM533UiA+bNc2YzYorjow5R9r+L7qkq3vSJdkRuAPJVHFlmKc+UQJb
        s3tZ0EjoZRClpv+0Il0cLZp8Bhsb1I1hcAL4Ic1Yf5AVB57JaOACkWruDOsrEJRro95cX7mB5ZR
        MzJO0kar051mnUmgG82ZWIuc+iBcFafjglPy8bDWOMA==
X-Received: by 2002:a17:907:7b85:: with SMTP id ne5mr329326ejc.572.1644249846682;
        Mon, 07 Feb 2022 08:04:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBm6rX0lrrq+gqVsXaiIiWLV1F3mitDpLqrcgHMbY6Jqelej9PiIrbQrRZpHU2vQlcmagUOw==
X-Received: by 2002:a17:907:7b85:: with SMTP id ne5mr329281ejc.572.1644249846145;
        Mon, 07 Feb 2022 08:04:06 -0800 (PST)
Received: from [192.168.0.90] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i1sm1602107ejv.183.2022.02.07.08.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 08:04:05 -0800 (PST)
Message-ID: <c7e160b0-16fb-79ca-c291-05571bbe8341@canonical.com>
Date:   Mon, 7 Feb 2022 17:04:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: crypto: Convert Atmel TDES to yaml
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     davem@davemloft.net, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, alexandre.belloni@bootlin.com,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220207032405.70733-1-tudor.ambarus@microchip.com>
 <20220207032405.70733-3-tudor.ambarus@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220207032405.70733-3-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 04:24, Tudor Ambarus wrote:
> Convert Atmel TDES documentation to yaml format. With the conversion the
> clock and clock-names properties are made mandatory. The driver returns
> -EINVAL if "tdes_clk" is not found, reflect that in the bindings and make
> the clock and clock-names properties mandatory. Update the example to
> better describe how one should define the dt node.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../bindings/crypto/atmel,tdes.yaml           | 63 +++++++++++++++++++
>  .../bindings/crypto/atmel-crypto.txt          | 23 -------
>  2 files changed, 63 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/atmel,tdes.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/atmel,tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,tdes.yaml
> new file mode 100644
> index 000000000000..7efa5e4acaa1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/atmel,tdes.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/atmel,tdes.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Triple Data Encryption Standard (TDES) HW cryptographic accelerator
> +
> +maintainers:
> +  - Tudor Ambarus <tudor.ambarus@microchip.com>
> +
> +properties:
> +  compatible:
> +    const: atmel,at91sam9g46-tdes
> +

Same comments as for patch 1 plus one new (also applying to previous
one). You named the file quite generic "atmel,tdes" or "atmel,aes", but
what if something newer comes for at91? Maybe name it instead
"atmel,at91sam9-aes"?


Best regards,
Krzysztof
