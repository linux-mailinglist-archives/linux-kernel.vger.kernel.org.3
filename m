Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87FA4D2BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiCIJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCIJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:19:52 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EAF2AC41
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:18:54 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7075B3F79C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646817533;
        bh=8BjTP/+1yUB9Aiej+vTJ+iAQ4nFO9laQpO6aipSI9Uo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=mmaQZV1R9nHyKXKVjvd7HBHUGO8/qsu3d7DgPEIHv5zxOnqHF7I5U9dKxZ8hsynV0
         2cBInbF4L5CcxzO3Ad+hR9zPnggQ96qdND5Y/q8rVPduw26vXOG/Oy0ba7ioHN4bJy
         nBp9shWy3rf68VtM71rFSsFr6HR7XBVH+vTfLIJ+Adzhs5PqolY/6yDCA5sFtwFcxb
         mDLUwvQ8np7ylp+fbXNLd1TpypMpfV1nWNZn5KGzDRoM1C0fq1EXHg/f7q7e/YQnEP
         hlFhpphKbpet88uGBLRyNyq6i8xh//LhVZqVXuVvjM0A18jzklwD9xPBtzq/fQkfVI
         jtKz+cFWZAFdA==
Received: by mail-ed1-f72.google.com with SMTP id l8-20020a056402028800b0041636072ef0so938001edv.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8BjTP/+1yUB9Aiej+vTJ+iAQ4nFO9laQpO6aipSI9Uo=;
        b=VPQx02mp/vC0GGnG1g63UTI0jYSp921EeE/Gwt4zDpcj9EhPoW6CXhbEYKYLc1+RTY
         Mkkj7Scy+fDJP/j0xr4CtN0k8BRp9QSh5T0kHx6FPk4SPfgydqHTok3twMdLG06yWLlv
         S4bJcYDERjyOYlO9cChML4QtLsK75zPKQJRxGyjwph3krADdeSHZZiMeeKfhFEzhXG7K
         upV15VH6MK3zYmVbDvNC7zqZCdxq9ex6ahhQ+a5sPOou/2nDQcyGMo+0U1PvrZkhGwin
         Ibj7csQUee+ET9pptzaMTAKOzQRjINV065Q7mA8OTEqshpWz/wCDt7pismIjmUKUnCLl
         UlYA==
X-Gm-Message-State: AOAM530L/JjTDJN2s2Up7GEye5E1Roqkqe9eVScfDH72AB3Z9GPSHOZG
        WDxaWiM6Nzko3511wd3vVx0wFsdzBgFr5a1eTq7QiFjeI3RSEokBQ4sC4ouzg5RoYyN1DFkNY3I
        Ll3oeq4918RborV00OkFFvHAeq1Sl2mGv/hn7TAQLYg==
X-Received: by 2002:a05:6402:42c6:b0:415:fe7d:4963 with SMTP id i6-20020a05640242c600b00415fe7d4963mr20366880edc.317.1646817533109;
        Wed, 09 Mar 2022 01:18:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKBgYsIlQkmTPZZedYYFZfkqd0y8tOMc44J8WrRfvbA7BIK5mWKSKmpE5UARw9e0KjYHAZ0w==
X-Received: by 2002:a05:6402:42c6:b0:415:fe7d:4963 with SMTP id i6-20020a05640242c600b00415fe7d4963mr20366870edc.317.1646817532959;
        Wed, 09 Mar 2022 01:18:52 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id m1-20020a056402430100b004167e4606a8sm541596edc.74.2022.03.09.01.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 01:18:52 -0800 (PST)
Message-ID: <a177b16a-c55e-8338-f34f-c7b9edcd94c0@canonical.com>
Date:   Wed, 9 Mar 2022 10:18:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: manual merge of the mfd tree with the arm-soc tree
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220309132952.525b3aa4@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220309132952.525b3aa4@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/03/2022 03:29, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mfd tree got a conflict in:
> 
>   Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> 
> between commit:
> 
>   e465ea5cc05d ("dt-bindings: soc: samsung: usi: refer to dtschema for children")
> 
> from the arm-soc tree and commit:
> 
>   0ff4827ed66f ("spi: dt-bindings: samsung: Convert to dtschema")
> 
> from the mfd tree.
> 
> I fixed it up (I just used the former version) and can carry the fix as
> necessary. 

Hi Arnd, Lee and Olof,

This conflict will pop-up when sending to Linus. I propose to resolve it
slightly different - just remove the conflicting lines. After merge
window I will properly reference the other schema inside properties (not
description). This can look like:
################
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml

+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml

@@ -17,13 +17,6 @@ description: |

   child nodes, each representing a serial sub-node device. The mode setting

   selects which particular function will be used.

 

-  Refer to next bindings documentation for information on protocol subnodes that

-  can exist under USI node:

-

-  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml

-  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt

-  [3] Documentation/devicetree/bindings/spi/samsung,spi.yaml

-

 properties:

   $nodename:

     pattern: "^usi@[0-9a-f]+$"

################

Best regards,
Krzysztof
