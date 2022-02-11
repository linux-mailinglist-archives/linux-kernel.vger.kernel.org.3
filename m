Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5692A4B2022
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbiBKI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:26:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243046AbiBKI0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:26:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBBE4D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:26:51 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3B9B3402B8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644568010;
        bh=OR7jE1UhZuxjFeUVRgEAKlAE7aaLAk74Il6Prfqk7uw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZNcWzwY2zhwd106PwQHMsixNzToCYG9AbPFTFPx6UgX637lncXlE2J0X2FlNZxiod
         oUqsSLJfgDarSd8RHmM8Lm4Zn3SRctahM2g3+EFbzm8j24nmNP9rWb7snKpYHcHNq8
         Rv+bHqz143fl3EJ0MyB24bn4S/YeE6h625ZDahBZ/iALmNTAxqWiRDR3H+Djqbz9jw
         44xa4psHKMGIfLfqPsE6UggAnMCB6OhaqxxU6dixJlivDU6ZGE1MHFl2XIhn7xtCtC
         Saz1dBrvasWBt/9wwYNiSfJkI30QEaCBHSAmjsQhops8r26+KOJjjJkEH+9rimLjHz
         1ahD0eM2tWTyg==
Received: by mail-ed1-f72.google.com with SMTP id cr7-20020a056402222700b0040f59dae606so4912133edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OR7jE1UhZuxjFeUVRgEAKlAE7aaLAk74Il6Prfqk7uw=;
        b=dKUYk3d2zR+4OAshkuhfPaqg9/TKlfXNG4Ld2fpxk1TeFgMhuCWpLSvSzc19UOJTIU
         RwVxhjf+ERnp/FuDMK/NcHSPLjsnmx9ts4uXiObwYaHQ9urA5DrPCtMxX7BIKBFoidfP
         M0c6bcHzDdx6tMU3VB5ixb5DqhzjyWhGxvpHvv84a5MDSniTsngF8h9OV7QXqUYzhtRg
         BEpaS3S/EuKQ1268N6GGRLlMZ8ipXjRgneg7vs7/Z39+7QiW3ul8qEYraf4exQruQWPH
         mcE0h7uH5crBDWWLiQcrZ1IGBthHI5RlGPBOaHtwM0sRawwoR5Vx02AN7NNaCODF2qoU
         uEOQ==
X-Gm-Message-State: AOAM5316uz6RIHOhPae2q88y9sVoBa7lEJpPJ1Z27AnWT9Mp/PJXsl3D
        d1snZBK7dREq5DC3E+wYLevjEShFPgTClhusmkMceGxZTFlLtxAZkbFDLwqEj5kED0W3kLGejmS
        t6E5BTDJVCZEmN0NvgIDGnBeciOoY6EtkBB1VJlBHuQ==
X-Received: by 2002:a17:907:7e8c:: with SMTP id qb12mr404206ejc.539.1644568009813;
        Fri, 11 Feb 2022 00:26:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwbi8tCTvaUprEwRjQBxSIVsyAo4IJ6grHRnlsTdT5gQ/87ce41uK0+9C6Rc1374U2AbHWFQ==
X-Received: by 2002:a17:907:7e8c:: with SMTP id qb12mr404189ejc.539.1644568009644;
        Fri, 11 Feb 2022 00:26:49 -0800 (PST)
Received: from [192.168.0.99] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id y11sm7497470edu.2.2022.02.11.00.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 00:26:49 -0800 (PST)
Message-ID: <8e44a919-cd2b-669c-aff3-bb79f16c6541@canonical.com>
Date:   Fri, 11 Feb 2022 09:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PACTH v3 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        alexandre.belloni@bootlin.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kavyasree.kotagiri@microchip.com, devicetree@vger.kernel.org
References: <20220211082114.452911-1-tudor.ambarus@microchip.com>
 <20220211082114.452911-2-tudor.ambarus@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220211082114.452911-2-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2022 09:21, Tudor Ambarus wrote:
> Convert Atmel AES documentation to yaml format. With the conversion the
> clock and clock-names properties are made mandatory. The driver returns
> -EINVAL if "aes_clk" is not found, reflect that in the bindings and make
> the clock and clock-names properties mandatory. Update the example to
> better describe how one should define the dt node.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../crypto/atmel,at91sam9g46-aes.yaml         | 66 +++++++++++++++++++
>  .../bindings/crypto/atmel-crypto.txt          | 20 ------
>  2 files changed, 66 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> new file mode 100644
> index 000000000000..fe59ad30b171
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/atmel,at91sam9g46-aes.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Advanced Encryption Standard (AES) HW cryptographic accelerator
> +


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
