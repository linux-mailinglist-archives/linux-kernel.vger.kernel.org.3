Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA84B0E66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbiBJN2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:28:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiBJN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:28:10 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB452B63
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:28:10 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7A2F33F33A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644499689;
        bh=hoj1LiEc6jqkJABneWxZcsyuXFCY/MGmRmVWsHl1GN4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=izKIrfsbuwZ2dlkemCOZpK/xr7qAYFN4GyP60W7EY3HtIQACLd8stFqL8jHyUTsFE
         a0VTSrxjhusi+47KAjPLmFoUyg6zMj+Rw1lycuNikUamSEJUcPTmkptH0XU9o/0soD
         T1SSP+YxQQPPuCzAAFpw4QXfXur/7i+CLScTDEJoRWbmGQNyFl/JZMjOv7sYi+/Jyz
         wqbYNiS6N4vuZ1pDjjZZjjzZWCdH+ZVmVszHrba19txIvxi+ld4F4Jxi9MzvGvnDgR
         qCcB0yyFuytz6FYqoTStgevs1pjgWAXj7RCn18I+/DtH8ETnoJXcYZJ4sIcHoskvbO
         /ybwJD5JdLQsQ==
Received: by mail-ed1-f71.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso3306354edk.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hoj1LiEc6jqkJABneWxZcsyuXFCY/MGmRmVWsHl1GN4=;
        b=ba2I34iY/gOwGwvjnfX2fPS5E8c6GwfmuJhYWIi6vpFKB2e40lw4B3XXsEVaeJry0+
         e7Or0wLLLfLZ/Dw2hTrZMKY46qo4X0dq9wTkBOFmJ6nAR1ktnjocVBp/Vc3Mkcj57Gzk
         q56QvV8StIcN8GRl9vqYEve9iTODT9iZL1FK6NBLtu1m8/mqoBWKNIJV+BQYSmxW6PQC
         B34XtaKVH2RyGB6DlOE9TV01WChDZluLhvNLhCmQ1koZnpYdTdo43wWDaTOqD5cj8xNt
         8h/F4+7jXRJZdTFHDStMx3yl0VqCNNgLMOUW3jBuUPsnT3EtcITg3VOM3gqFZ496H1G4
         a2VQ==
X-Gm-Message-State: AOAM5316STTZq/DdH3S2jEsLcOCiMsuJSV4iIH2hiAmTDhiAL9sRUlpi
        Ng1zuUu5A6Ea8PX/Ocnz/uRJCshYR2WrHBfZ/TQKmzkjm9auKyp/GXRGgh/k/6a3db055CXvDlZ
        3IUFczfi8k9BHCh/xFykLisljPFiOiei6DfcJmjJWyw==
X-Received: by 2002:a17:906:6a20:: with SMTP id qw32mr6367115ejc.40.1644499689089;
        Thu, 10 Feb 2022 05:28:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCQV8EJ7XNaxTb9IXdvPksWQ9XKbp++XnotRDcOuYvkwb5Pd/g1hTFObll+y4Ehx/w4+70Xw==
X-Received: by 2002:a17:906:6a20:: with SMTP id qw32mr6367099ejc.40.1644499688944;
        Thu, 10 Feb 2022 05:28:08 -0800 (PST)
Received: from [192.168.0.98] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bp16sm5412484ejb.70.2022.02.10.05.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 05:28:08 -0800 (PST)
Message-ID: <153767e8-e064-a47b-5153-ab0a2eb5a0c6@canonical.com>
Date:   Thu, 10 Feb 2022 14:28:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dt-bindings: arm: at91: add Kontron's new KSwitches
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20220210131817.484922-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220210131817.484922-1-michael@walle.cc>
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

On 10/02/2022 14:18, Michael Walle wrote:
> The Kontron KSwitch D10 MMT series ethernet switches features a LAN9668
> SoC with either 8 copper ports or 6 copper port and two SFP cages.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - just use one entry with an enum, thanks Krzysztof
> 
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
