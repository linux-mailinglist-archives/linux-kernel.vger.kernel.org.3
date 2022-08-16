Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8921B595968
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiHPLGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiHPLFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:05:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76307481DA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:57:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u1so14230416lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=J81JV8hikPsZojzsvlP6ILAJmYNXwPnWvXa+KmRWS0Q=;
        b=jQQ+eLT7HYQLMb9V/o5Ded/h8BWxCiDtI/PoG0ObjjGccnrgEph81/L11DMGNa5VSx
         iSsWR3L/RelHi1s7Hy6B/ms0E7wFYWjJgftDMTEpCF8Oc2aGCvnlhgjAYuWe9204VNrT
         h58IUY0eTvayl5HBu8vWSfh0g5DkPWiKseWZzyVL9BM1bWMEVlZQqtaAt4afXf12Ln+7
         J2IFswj4RWJXN3bBRKggBFgCGCF3USyAVfbyZGVfqAPY3q89DJxMhvQJSQ2Qc2ZpyZ5p
         Diqfrbo52SaMc5Pw2DMYrZd2Ju2RGqbVrmyq4QzdJYVHTcA0yj1pYu1Up4dHUIiEZcmI
         EgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=J81JV8hikPsZojzsvlP6ILAJmYNXwPnWvXa+KmRWS0Q=;
        b=BjwKySsE5lAvwap71Fq6gfosX/pvugwB4S7GOxahlV28Yay5LD6nkTH0Zg8L0dg/gj
         KHHN7R4KgQrqxUg+mi+E3+piIL35PoV/6BrW/C50TYxx6dsRE5H1TbGTm1zNwaWLKZ4e
         BwuUZz2VoHBfoYBR4FK0tX726KikGucCBpGVQlhnJnuo/6DtTJqQ21LGxj5E3Jzykbx8
         FtwqP/HC5cr7MXozBM6GjgmbAK4sCuoNBw9Aszre0hDS7r+/770LxvGgu2pDLyDOEHSH
         28lAjnQqhItp4AnTfZIINELn0Mp0Shcm1osQtZKxRYKsBvWrbPukJy4Xki7nAZMFu2O9
         i1wA==
X-Gm-Message-State: ACgBeo2Gqvsq8rw1KJs3JWeykDO5P4kK0pZZxY6hI0aalwDvxI9f/9fi
        ERp1a1YcVv7kvoVnzL6m3oV0uQ==
X-Google-Smtp-Source: AA6agR5BXtY+i9FUTQzbBUsXLd2vZVPfTFvV7zCU6pC5DN18tLDE/qWfQ2L1Ip3a8zZIsZ8WLZHO7A==
X-Received: by 2002:a05:6512:c19:b0:48a:f3bc:5537 with SMTP id z25-20020a0565120c1900b0048af3bc5537mr6670576lfu.490.1660643853696;
        Tue, 16 Aug 2022 02:57:33 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id h4-20020a19ca44000000b0048b0aa2f87csm1335298lfj.181.2022.08.16.02.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 02:57:33 -0700 (PDT)
Message-ID: <3b5358e3-9ba6-49a8-fa37-da237ba56ddb@linaro.org>
Date:   Tue, 16 Aug 2022 12:57:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] regulator: dt-bindings: Add Allwinner D1 LDOs
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815043436.20170-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 07:34, Samuel Holland wrote:
> +  reg:
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    items:
> +      - description: NVMEM cell for the calibrated bandgap reference trim value
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: bg_trim
> +
> +patternProperties:
> +  "^(a|hp)ldo$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +unevaluatedProperties: false

one more: this must be additionalProperties:false, because you do not
reference any other schema in top level. Same in second file.

Best regards,
Krzysztof
