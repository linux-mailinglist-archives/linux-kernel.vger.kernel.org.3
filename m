Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D674553EAFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbiFFPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbiFFPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:44:16 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6FECC15D;
        Mon,  6 Jun 2022 08:44:15 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id ay16-20020a056820151000b0041b71517844so958763oob.4;
        Mon, 06 Jun 2022 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1Dyxrxglk8UzaHWlu8Ip8w2vSs7l7OGlq6jwwOsQ960=;
        b=BwrNGtzgFqc5GBs+deBOcDtRAxLlmSKd/PBfifxCqtEON0K0Xetx9idzSHIQMwV5SA
         9f2Lh+l8E89eWdqBoG0wndpJIL4MrXW9B2Z0988Ek2KK4sF5EGuuyAq7HZD0Ne+AbimE
         TGNYT2BK0SktuwFMDQip7/3ArorHNXsQ8yuWySv1otJ8/qyNvpJFPgCcDTeyh864sVq2
         pezAVQqrB9W5SXgH36eWHugxjPI8TZTv1DBDpYyrqYQtjH202Y//b+rcc6ABMSaFiOMf
         ndiybo/ZM8ybLw47HKBm7WsJk1HwxEB1xnxOEWc3TAD7Aao8nS5QOyvldisyxMopaGZ1
         0IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1Dyxrxglk8UzaHWlu8Ip8w2vSs7l7OGlq6jwwOsQ960=;
        b=YbO5WgRttcIfuy2Bv8noKDYE6981tpEhEjrKjiFhsJMKHfhp5bq+gq/JtbzdRZjiZw
         HRGxiD/J1MciCb3OqnRNWXFyy04cdKUOTt7H4Br7pEOVkQ730ojiqVkUWYyhlZ7ryqpj
         jjh2+TgS+5kw6Bje0jP0Tv3afsP4PMJGQuepYkXuqEtOVIkbUqGV5ZL2cNZLrBVdNwUf
         PcYWgXPhjSRzufdoLfSbp3oBtnMwXXMfcWUQANR4sfrTWdaGcjIw7HR6IWGDr6ES4Xkq
         jyeIzyrf8XRrC3A2+REaANYf//VZQncdlhtlOWmjXS9FeKdsdFpOWYxDadEBtSz7QrLk
         4ItQ==
X-Gm-Message-State: AOAM532u87Q1gIsH0w2ZUHS8uzpWABiAKMQ/vX/uMT9KbWN1GXcPsu5L
        58kY5pJ/3aAqyJwlsPJNXaE=
X-Google-Smtp-Source: ABdhPJy1zCj2ZN6ndVK4A6V4NXnjLvRe27BQH9UEBJSslBjosstbd4cuAI508h2hMmqaKojcUerFng==
X-Received: by 2002:a4a:4f16:0:b0:41b:6f0e:4acc with SMTP id c22-20020a4a4f16000000b0041b6f0e4accmr4734194oob.33.1654530254919;
        Mon, 06 Jun 2022 08:44:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m4-20020a9d6084000000b0060b1f3924c3sm8318726otj.44.2022.06.06.08.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 08:44:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <451ad3f1-e365-e136-fa1b-c7bb0b05a15f@roeck-us.net>
Date:   Mon, 6 Jun 2022 08:44:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/23] dt-bindings: arm: update vexpress-config.yaml
 references
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1654529011.git.mchehab@kernel.org>
 <7020edd9e183652249fc95bf61a1055cc342a4dc.1654529011.git.mchehab@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <7020edd9e183652249fc95bf61a1055cc342a4dc.1654529011.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 08:25, Mauro Carvalho Chehab wrote:
> Changeset 7e8339b5162f ("dt-bindings: arm: convert vexpress-config to DT schema")
> renamed: Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
> to: Documentation/devicetree/bindings/arm/vexpress-config.yaml.
> 
> Update the cross-references accordingly.
> 
> Fixes: 7e8339b5162f ("dt-bindings: arm: convert vexpress-config to DT schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/
> 
>   Documentation/devicetree/bindings/hwmon/vexpress.txt     | 2 +-
>   Documentation/devicetree/bindings/regulator/vexpress.txt | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/vexpress.txt b/Documentation/devicetree/bindings/hwmon/vexpress.txt
> index 9c27ed694bbb..4a4df4ffc460 100644
> --- a/Documentation/devicetree/bindings/hwmon/vexpress.txt
> +++ b/Documentation/devicetree/bindings/hwmon/vexpress.txt
> @@ -9,7 +9,7 @@ Requires node properties:
>   	"arm,vexpress-power"
>   	"arm,vexpress-energy"
>   - "arm,vexpress-sysreg,func" when controlled via vexpress-sysreg
> -  (see Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
> +  (see Documentation/devicetree/bindings/arm/vexpress-config.yaml
>     for more details)
>   
>   Optional node properties:
> diff --git a/Documentation/devicetree/bindings/regulator/vexpress.txt b/Documentation/devicetree/bindings/regulator/vexpress.txt
> index d775f72487aa..1c2e92c7831e 100644
> --- a/Documentation/devicetree/bindings/regulator/vexpress.txt
> +++ b/Documentation/devicetree/bindings/regulator/vexpress.txt
> @@ -4,7 +4,7 @@ Versatile Express voltage regulators
>   Requires node properties:
>   - "compatible" value: "arm,vexpress-volt"
>   - "arm,vexpress-sysreg,func" when controlled via vexpress-sysreg
> -  (see Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
> +  (see Documentation/devicetree/bindings/arm/vexpress-config.yaml
>     for more details)
>   
>   Required regulator properties:

