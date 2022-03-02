Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841D04CAE5F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbiCBTPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbiCBTPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:15:02 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA6B4D256
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:14:19 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1FB5C3F607
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646248457;
        bh=p1lNUzsyoygIQb4L2BztQSrDhNhm7EIFYsQhESyqtHE=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
         In-Reply-To:Content-Type;
        b=N7xWiX7Y+wM7aYTctJJztMq4FjOSdNg7TuMXUu2AtOwKdfiARgIS8LGwLu6lpo0Hp
         1zlDSoTPqqTbYNT+4ejsYEMYxzu1v583xVwf3ayQMLaSlH0KQccOxRCRvPRwced34C
         8dohXZO7c9Wou3yqFNvEbKMcDhPx56h37aI5wOyON2jMM8mdfvPgbyfkyY/58wu2e6
         GGJ1N49CPsM5YDyv3aDjeh4ezcoA+qLV6wTEnym4Dezjn1r61lgMxIP9YO7b7Pd6Nw
         wagD0l0EwhuSwNF7+Pwi9det0ndVDmaeevRmzfeJYsiw9HBx1vzpZ6++EaH7z2Iz5Y
         bT8QcXQkY5t+A==
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b004090fd8a936so1508140edw.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=p1lNUzsyoygIQb4L2BztQSrDhNhm7EIFYsQhESyqtHE=;
        b=ZOJwGYeC2mMQZtM4xFTBrL6KDV84gQWrk9UIKIPcQqyLfgEy/7xAnTQvfCuHB2lhys
         FRrbs99DkamdrKs0T5otm4oUOWkgC7nrIRcnO/lvqI61dpR7l9j8L51ZqDQsPOXbZ+n6
         EVooyjhWp0L+SwiWQX3erwjn8tJUKqEBbiQerQypmPweJZlQhrR4Nfl3rp5Mkk/rqylm
         by+9zO+u0wL+yCRXZmRL91c4luT0/67UjKd0OG8t+61zFxhRFde+teBWvTvxK+ofNzbS
         9Me+jxuNUF5a8hkLcV1JEHf0SNG9e9u+du3jJ/4hgVaU2aNLJVmzHCaFsLH31qRwIgvd
         N+EQ==
X-Gm-Message-State: AOAM53112bZV6/UmPaoXec4+pB+k0hJ69hLjYnmk7TZJCkoCVPpixigt
        VzLGii80inKJBsArynPaC8DUuoS54mFuya+H8RK1amCLLN0qSihfwMZlZpzby7CD/Hv8bNkeFwl
        gjGG5cbY/RA4H7oHsFdc4j5t4cfvf2XyntyLEq2vG2w==
X-Received: by 2002:a05:6402:3715:b0:410:a415:fd95 with SMTP id ek21-20020a056402371500b00410a415fd95mr31118778edb.288.1646248456782;
        Wed, 02 Mar 2022 11:14:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx80uydDYoRT21wjUie2CEHYaY3fv75k/SRY4zouePopuxmW5Gc7gpstyQour9osDg3GWw0eQ==
X-Received: by 2002:a05:6402:3715:b0:410:a415:fd95 with SMTP id ek21-20020a056402371500b00410a415fd95mr31118763edb.288.1646248456608;
        Wed, 02 Mar 2022 11:14:16 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id bx1-20020a0564020b4100b00410f01a91f0sm8975726edb.73.2022.03.02.11.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:14:16 -0800 (PST)
Message-ID: <de345f86-47a6-115f-8e0b-29589e1289c6@canonical.com>
Date:   Wed, 2 Mar 2022 20:14:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/3] mfd/power/regulators: dt-bindings: max14577:
 convert to dtschema
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
References: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
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

On 15/02/2022 08:47, Krzysztof Kozlowski wrote:
> Hi,
> 

Hi Lee,

Mark reviewed regulator patch. Can you take entire set via MFD?

Best regards,
Krzysztof

> Changes since v2
> ================
> 1. Add tags.
> 2. Drop DTS patch (applied).
> 3. mfd: Fix indentation in bindings example.
> 4. regulator: Drop regulator-name requirement and use
>    unevaluatedProperties.
> 
> Changes since v1
> ================
> 1. MFD: Use absolute path to schemas
> 2. Regulator: mention all allowed properties,
>    additionalProperties=false, add min/max values for voltages and
>    current, don't use patternProperties when not needed.
> 
> Dependencies
> ============
> 1. DTS patch 1/4: nothing depends on it, sending here so Rob's automatic
>    checker won't complain about DTS.
>    I will take it via Samsung SoC tree.
> 
> 2. Final MFD patch (4/4) depends on regulator and power, so the last
>    patches (2+3+4) should go via same tree.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (3):
>   dt-bindings: power: supply: maxim,max14577: convert to dtschema
>   regulator: dt-bindings: maxim,max14577: convert to dtschema
>   dt-bindings: mfd: maxim,max14577: convert to dtschema
> 
>  .../devicetree/bindings/mfd/max14577.txt      | 147 -------------
>  .../bindings/mfd/maxim,max14577.yaml          | 195 ++++++++++++++++++
>  .../bindings/power/supply/maxim,max14577.yaml |  84 ++++++++
>  .../bindings/regulator/maxim,max14577.yaml    |  78 +++++++
>  MAINTAINERS                                   |   3 +-
>  5 files changed, 359 insertions(+), 148 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml
> 


