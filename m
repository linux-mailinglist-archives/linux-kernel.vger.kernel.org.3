Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AABE4B24A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiBKLoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:44:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiBKLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:44:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3542EA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:44:15 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 71A873F1CA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644579854;
        bh=svIxGzskW3ZGgG1rdvRW93P99PRrS06bKOYgS12kPfQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TH+487q08fjSy/hzhIXv7Qeq4gVnUvyh7Z2M4wr/qksUqtB5n8AxoZRNeJmW//+fu
         Ty+R7Aq2FwIJtKbAwzE+m0ovDmlc9bK4qhQ12YIv3Q2UkWb76UTc7GmprYXPA2PJaq
         XRt8jyIsZZuv6HpKWW0M/lyJfQhFWRqJrS4eQRhHgr9YRkjhOM9imHcjvi1ytQvSFv
         2WFIAdjXFr6gV039N2blCEpIX/v9bBJVbOPKYUJ5d7NV0/6tFwubZks7vhX2I0IWqI
         BU2rHEkSK+emfgtc14yaAXdnedmAIwZ249pUTpVmZIwIUVXLw9szEtulYe/rJuGzkH
         YOQkwRt5m4MHQ==
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso5210779edh.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=svIxGzskW3ZGgG1rdvRW93P99PRrS06bKOYgS12kPfQ=;
        b=ZEhlt0X8ZoV7+b90J6woctF3FoomZvRzmyXRT79AImH1K6ZsQASgH3a/HL9F8mB1lG
         AJTJuUA/XY87k1bcM8tpLbKOdzMHlwqbIjn2yljv7SYJJKWAxj3fUnuOEzPV7naihOLH
         +AHBnPQyTUl+WXCx2zyAx49C7krvZy8/h/XEj7GWl0MjXf2dPz8Lhw8t5a096RaAQS1+
         Ng/rA6xKrTUFSaHjkoGKMA8tl/MkkWm0Xald/z4UTQnWc+ZjzsdcyKoBEPrZ0vAvp0pY
         wMq7JZgyDe/AhR2MXze2uT507pzW55EJ1XesbD00jMPPXMkf/VY3lb+u8FRM1CetzREQ
         jVdg==
X-Gm-Message-State: AOAM5314y4TaxllSeYQmoeaR/Sanuhi6Lyskg7IRLijPpDZ9+6ShIKAs
        O8tqDfcUiQNKHaamfWQA8MB3GeVKpgWsoeFxd+J57AM4g0Y9pUSpiwfaN4K9qTyZEFQBGe5LInF
        gD9xEUBqEs4qXWbReqylQn+/lXz14/9tM1LIFp4F4pA==
X-Received: by 2002:a50:fb85:: with SMTP id e5mr1446475edq.91.1644579854182;
        Fri, 11 Feb 2022 03:44:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2baTwCVDr7oz4C4PJ7yM5Z/qqexNJLfplboKRoblI0EytwPPoJwEaY3FsG58g8YJ8k6iUDQ==
X-Received: by 2002:a50:fb85:: with SMTP id e5mr1446458edq.91.1644579853994;
        Fri, 11 Feb 2022 03:44:13 -0800 (PST)
Received: from [192.168.0.99] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z13sm172232ejl.78.2022.02.11.03.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 03:44:13 -0800 (PST)
Message-ID: <c375e5bd-53b9-e657-7c0a-7e2f9179688b@canonical.com>
Date:   Fri, 11 Feb 2022 12:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add compatible for Mediatek IPM IP
 with single mode
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
 <20220209111938.16137-2-leilk.liu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220209111938.16137-2-leilk.liu@mediatek.com>
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

On 09/02/2022 12:19, Leilk Liu wrote:
> This commit adds dt-binding documentation for
> Mediatek SPI IPM IP with single mode.

Please do not use "This commit":
https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L89

Wrap around 75-chars, just like our guidelines are saying.

> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index bfa44acb1bdd..0a2fc0404cb3 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -41,6 +41,7 @@ properties:
>                - mediatek,mt8135-spi
>                - mediatek,mt8173-spi
>                - mediatek,mt8183-spi
> +              - mediatek,ipm-spi-single
>  
>    reg:
>      maxItems: 1


Best regards,
Krzysztof
