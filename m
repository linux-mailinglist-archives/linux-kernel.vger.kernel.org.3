Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F44BB86D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiBRLno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:43:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiBRLnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:43:41 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACFAE00F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:43:25 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B656C3F1B6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645184603;
        bh=2dz0fU06npj7eyUkmqf71aR/j64jZ0aIwZIfUTh8vN0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=DIGUNamiWudZk8wX8rRzJ30PAWuW5OVP4RLVdZW+eSspHfaTjQUOatPkq35NK/m80
         bJM93OE0m9oWf/E77ABCT9UxESsyYDH4oYSa3l1ajo8B+bYydzhs0bDeRsl/yXNguf
         uknW14COKNv/yzlx3pdAhoqRyZLXk0Mx50VpsoDo+crZxKD/pYuRcTsi2KvIN0cHPK
         H5TlXxvelzdzbFpVstXSkkeuk+kK6Sosm0k2r1/fOmS+ooFPFwzNwValDedCnJpQbU
         Ex6fP85I3M9P8sZqDMCt+eB9gyb5HLX1JizwvqRqj85H/jl10LfToWo0qxCbBEQbQA
         6ikVOA7u6wp1A==
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50c88b000000b00410ba7a14acso5372389edh.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2dz0fU06npj7eyUkmqf71aR/j64jZ0aIwZIfUTh8vN0=;
        b=57Ll5yxo2Z83kAqnDlqQYh6syxV9pVMCYYhcAmohgIeYpnFmfdQhBEKBZLAymUGcym
         UMOb7A0a+2Wwi1HiniC55aQEskDTdYGSV/6O+/6R1M7MMKua/aZFXgYHNZuaxmC4Zxw9
         7dex8nZgGh4DOede1E5172fJakQoT/NcyKc3u4PmjfoBro7anvCpKbCdyXRtOAju/Ldh
         HLx2GkgAnDzJQbKuO8azF2w429yY++PCMbC579w9/0jI3vb610zUJcJUAK853SUyKKFK
         sb0TtNjgC8RruRjUo5M+G0309hshqP0sgzQaGIObg2KldUCZbLeLOY42f1ctcaryxmDI
         QiAQ==
X-Gm-Message-State: AOAM5306iqFAZN//aZCJn3iGQOZkwDU4Ejw4Fby9jA4Xy3he6tAA7Pgs
        psGo76WEzapgxrsDXjBU5UEZY8/ODWGS63F4nlG+E0rin99cEeMLclSk5Utbq9X7Sva93xphcwc
        YNBBlsr21LJNfaanqnCHE/0JzaemmObXQjbdFSpJVLg==
X-Received: by 2002:a17:906:aad7:b0:6ce:a6e3:9461 with SMTP id kt23-20020a170906aad700b006cea6e39461mr6091056ejb.186.1645184603447;
        Fri, 18 Feb 2022 03:43:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymrZ8USRQCBiL2OjYELAOGRuSqGgvNMTxjRekMQvvKJ7hBqEdLgUzCYZSykiroGn57ff0oeg==
X-Received: by 2002:a17:906:aad7:b0:6ce:a6e3:9461 with SMTP id kt23-20020a170906aad700b006cea6e39461mr6091044ejb.186.1645184603267;
        Fri, 18 Feb 2022 03:43:23 -0800 (PST)
Received: from [192.168.0.114] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id y21sm2111991ejq.185.2022.02.18.03.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 03:43:22 -0800 (PST)
Message-ID: <939b25f4-f4c0-d393-df6a-8063eb9d40fe@canonical.com>
Date:   Fri, 18 Feb 2022 12:43:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Content-Language: en-US
To:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220218095048.86826-1-cristian.pop@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220218095048.86826-1-cristian.pop@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2022 10:50, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.

Subject needs fixes. You miss spaces there, incorrect prefix. Use git
log --oneline to get the examples subject style in given subsystem.

> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> new file mode 100644
> index 000000000000..35a3fb3fd339
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv4420.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV4420 K Band Downconverter
> +
> +maintainers:
> +  - Cristian Pop <cristian.pop@analog.com>
> +
> +description:
> +  The ADMV4420 is a highly integrated, double balanced, active
> +  mixer with an integrated fractional-N synthesizer, ideally suited
> +  for next generation K band satellite communications
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv4420
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  adi,lo-freq-khz:
> +    description: LO Frequency
> +    $ref: /schemas/types.yaml#/definitions/uint32

Rob's question from v3 remains unanswered...

> +
> +  adi,ref-ext-single-ended-en:
> +    description: External reference selected.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv4420@0 {

Generic node name. It's a kind of plague there... everyone using
specific model as node name.

> +        compatible = "adi,admv4420";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        adi,lo-freq-khz = <16750000>;
> +        adi,ref-ext-single-ended-en;
> +      };
> +    };
> +...


Best regards,
Krzysztof
