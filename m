Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9604CCEE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiCDHOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbiCDHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:13:45 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30339192E0C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:09:40 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 331413F5FC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646377762;
        bh=XhhG0wWaf3K6yBJwDmPYA6VsKmLLMnPsayg6VQNoL9o=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vexEf/yPs8XqYl6NUtKiYIxtAC3tiCe3KZhrOCZUrIcps5ywTESoiosiThT+iAIYm
         k8r0jBUhkzgk19/fRZe4zi4URwCetYByhlg4L7+olfPVVLoROrFEFF6r7pVNfGGRsH
         W1Tq3Cpm9cW2a31WJCtZwx1xO0nCwmX0PnW+QsPQwT5PQdgegHD/MmjrCzHaTXbjc5
         xwHFKWoZBpHVpwDjeXu7PAhO/CWZLlwc4J4BmQfmPZyyhXs/LFp9HWs6mQJKRdl8oX
         g2YO7iSjMXtAfJg9pYzx3mXt6cDhQmqBojfLQJlbOP1HqdvwQd+awZMH1HFFzk4IHM
         3mLQ6igsOF9oQ==
Received: by mail-ed1-f72.google.com with SMTP id x22-20020a05640226d600b0041380e16645so4172338edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 23:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XhhG0wWaf3K6yBJwDmPYA6VsKmLLMnPsayg6VQNoL9o=;
        b=3WuiAJ2FieLzBb1qNtAIPJmUqxou9LCEF6rvt0jhzaOpmXf7YN34RSBJpmTSaM5lAQ
         8YF2nmPmQlGYGme9+rf6tZqPG/sKY77gXHQu/vxEPYc6TVqyakGB4Ad58Ml2m/z3c+BW
         Zi/mVZedppbkc6QCElpigmvF2JcYkTA+WxImmyGBPLZLCsUd5t510BRG+piL3cB0HO4P
         +j/g53o6QYCajR1RNZpv5U5+mT0sWdb2harHpdx2ECnk4exMYe8TnXSNG4sVQxUBpFNX
         6d8a+5wn3xJ4lIk042c54hX+Flee5lmx1nmKZmHmPo+i5fwrTbcWujqFHZqnAyYd0fdw
         k/Og==
X-Gm-Message-State: AOAM531j4w+Krdr1p3ym/6qLIprhQxApE+maxdKB/Gsv4iECFM2VemQj
        DAVm4K5E13vNkl4uw/Z5EGSpAVnw1sNpPars/g2glxdl7P8S5ELMLjiVo/zE7Pf5bve6cDJrAo3
        AEqa8xjEbcokULFw4wJTBfr2bgqTpmLdCYF6kbeGPPw==
X-Received: by 2002:a17:907:72c1:b0:6da:be5e:dc98 with SMTP id du1-20020a17090772c100b006dabe5edc98mr607437ejc.283.1646377761658;
        Thu, 03 Mar 2022 23:09:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZbPRGv5bnhCmhmW6GOxSNC610FEmnF8Qt69qFZsxgdxMOr5mYxC1tSKXc+KrPEdq7x4Y8iQ==
X-Received: by 2002:a17:907:72c1:b0:6da:be5e:dc98 with SMTP id du1-20020a17090772c100b006dabe5edc98mr607430ejc.283.1646377761513;
        Thu, 03 Mar 2022 23:09:21 -0800 (PST)
Received: from [192.168.0.138] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090681c800b006d9f7b69649sm1425116ejx.32.2022.03.03.23.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 23:09:20 -0800 (PST)
Message-ID: <d714afb4-0ecb-0caf-564a-b8cc1933d9d5@canonical.com>
Date:   Fri, 4 Mar 2022 08:09:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: kbuild: Print a warning if yamllint is not
 found
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220303221417.2486268-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220303221417.2486268-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 23:14, Rob Herring wrote:
> Running yamllint is effectively required for binding schemas, so print a
> warning if not found rather than silently skipping running it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
