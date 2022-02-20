Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270814BCE0C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiBTKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:54:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiBTKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:54:19 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED3B3CA6F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:53:58 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 65BB23F1B6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645354437;
        bh=rbI2U7x1cHPvp7Ypc0YrVspNGO328GiT7owoM0mdXBQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=pF0v2BY9seMzL21UG8rQ37pmt0lidaOTGWuiiPMvjf2RMz4Pc38o51rYvUUfRjidP
         T726UIlkptA0eCSEEbFD1QX8a2U9X0MC4+P9qiBZ+kYVUTV/KwA0FBNuFmKVY4wqV/
         lPNpjjjIajYYvyh0utRpYwFacgE2jZIa01nlepJ+MAbDzavIvpjL5Mtcp3vkTrIWkB
         Y+Vn64nCHTdDieAAp+XtyQNWmKOukFAAtlFkTpHX/2qSZemCzUTr3tg8WHszmz2R7c
         zCtLMxn4PJguhHQ3KSZ7e5n8B8ZVqU0jrBLsuQlj56kjMzPPV7xP3l/ZDQLYu/wQxF
         UpospstLjqV6w==
Received: by mail-ed1-f71.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so8486953edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbI2U7x1cHPvp7Ypc0YrVspNGO328GiT7owoM0mdXBQ=;
        b=hg1kgiuVCoiqnmbbBY/b8fzIiKatWvmajhm7PMU6Wk7dHwWWrXfVps+1FO+jUPtSNJ
         LUZt1vp5ezDcNm9l5S2I5/RiP2C0z92t25crDr7fyHWxdLznFiXviHct/U5gD0+BMxNI
         b6GrK72jcXCapyfmvj+5s0kqTGu6pT/otim+z7qQfLOI0L6lWKV9oZh4s+MQj4GR0/Wm
         04Bq9/y9+UqRNwTPcWtfVUue3KoKBO8pPE+30TBHtDmn+tdwu7tqzxT8lJOHbn/5nIXp
         A9C6xBV/gcF9bR7mWIgk0nAUu9VnSoB5F8I1TITyeOwCtx63qfFavrkcXrd8oBTMQb9+
         lMPw==
X-Gm-Message-State: AOAM531o6YzHj1trlioQTd/PdwOBFs7togEGHpTfMePjjKXi7fRnEoOr
        CkFqzxyDEcXRDQpRDrIj8xGzAkhRGoGpmG90yyWp7n1lUCEkvwbrpGY10DipSjQ9axjgEBMjRk1
        1cncrDpD6REPMkVmFijA/H2UksRzmVealoerB56GISA==
X-Received: by 2002:a05:6402:520a:b0:412:8361:d11e with SMTP id s10-20020a056402520a00b004128361d11emr16281501edd.190.1645354436985;
        Sun, 20 Feb 2022 02:53:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8C7k+C/26qS39pBy5PpopktLCI0D5x+PjoZJAKXQk0+LOpRbf6bMM3TBru7V9NBB4VUGsuw==
X-Received: by 2002:a05:6402:520a:b0:412:8361:d11e with SMTP id s10-20020a056402520a00b004128361d11emr16281489edd.190.1645354436801;
        Sun, 20 Feb 2022 02:53:56 -0800 (PST)
Received: from [192.168.0.117] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id jt11sm1096778ejc.167.2022.02.20.02.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 02:53:56 -0800 (PST)
Message-ID: <69cc2a64-c273-f2f6-b25b-73fc2248bb18@canonical.com>
Date:   Sun, 20 Feb 2022 11:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings:iio:amplifiers: add ada4250 doc
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220214094115.48548-1-antoniu.miclaus@analog.com>
 <20220214094115.48548-2-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214094115.48548-2-antoniu.miclaus@analog.com>
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

On 14/02/2022 10:41, Antoniu Miclaus wrote:
> Add device tree bindings for the ADA4250 driver.

Please put the bindings patch as first in the series.

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/amplifiers/adi,ada4250.yaml  | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> new file mode 100644
> index 000000000000..22283ab48903
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,ada4250.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADA4250 Programmable Gain Instrumentation Amplifier
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Precision Low Power, 110kHz, 26uA, Programmable Gain Instrumentation Amplifier.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ada4250
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply: true

Needs a description, not a true.

As Jonathan said, you should allow spi-max-frequency (so
spi-max-frequency: true).

No io-channel-cells?

> +
> +  adi,refbuf-enable:
> +    description:
> +      Enable internal buffer to drive the reference pin.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      ada4250@0{

Generic node name, so "amplifier".

> +        compatible = "adi,ada4250";
> +        reg = <0>;
> +        avdd-supply = <&avdd>;
> +      };
> +    };
> +...


Best regards,
Krzysztof
