Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF684CCF15
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiCDHcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbiCDHcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:32:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38914192C82
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:31:33 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F19CF3F5F9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646379091;
        bh=znesbVorVsm63iCSSQmBPsZdwQn81pwm1UwoEW27Z4s=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=XWILBgk1RZT4tjCIfg0GQKUxdUG9diADsp3bIWb8HDkbIf174VXs+VMFbtoxaeLjf
         bkMQiIC0+XZcxA4DdDioZX3VZ+iA5cElczxhhvp7RWRK4tkX4EVxTqpd8Ql6QBFFBk
         vfACzqApbdbIeAdMSul6mok4skfKtNiTpjqKud/fzpAoAU30YGB+LhyTWCg3lA4VK+
         oxHwGifgJNEdQkxqR63+2PujmeKgZObCgwa7aYsr1+3ogILlUbPueVOT3tsHNbj5MM
         6EgdTXroc30RcYeBnso74kAsGxXKebTDpRu+0Rb90ZLStbTJVb+aWT2RFjZo0nHo7S
         xxoWu5PRZwMoA==
Received: by mail-ej1-f72.google.com with SMTP id la22-20020a170907781600b006a7884de505so4011588ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 23:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=znesbVorVsm63iCSSQmBPsZdwQn81pwm1UwoEW27Z4s=;
        b=TqK0g5JC13eV1f4mHjgPyQsnDI7blI6SsIRb7iXGTEFvpc9uQfjLq4ZDm+tLLVULUB
         49HSo3IuT2Rm3z6UhHqgxzZAIdfVzASluZlTtzZX+YsVi7ynrP9r/DOwl/3Nc4+bhx8o
         /5E5ZGa2adB13kse8rKCvUSw7xSH3VIZgh4MCTe4gdOxU8k1w+UzMZYUQPlLia98AUZL
         cqYbJczxZ89/rvR6n2/kdmYVf4+JweCPBZvanxHwDhvTqzVHEqNEuz2+V60KeS12/RLE
         UsPqQwOL1kwBXx0/qgApTvdnmTbyhtf8c9Vv3UhcbSfZFO88+CBsVe/Imf9U7IZ0Bidb
         NBmg==
X-Gm-Message-State: AOAM5305XcQN9xvf620bthGhfU4tlKYpOuDCsLgAzar6O/IpbgdxQ6VO
        4pUKYMm/9ztti+/UuiDJrlHZi1a/gqUP4BSGDJ79CB60n2530pmEDhYpi3ymtEsCQ0VyXQOyB7b
        Yr2XU+5lP0yRuWY2XbUSJNOknj5Sy57+RHpIumPevQQ==
X-Received: by 2002:a17:907:c0c:b0:6d1:8c46:6415 with SMTP id ga12-20020a1709070c0c00b006d18c466415mr30485461ejc.326.1646379090608;
        Thu, 03 Mar 2022 23:31:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGxs7X16ZzeLCZ/AHvyM0eIiEfVTT/3+RbXNFeYwjEzaLA6uLgNdT/DxKdJK+w4/ntCeI8hg==
X-Received: by 2002:a17:907:c0c:b0:6d1:8c46:6415 with SMTP id ga12-20020a1709070c0c00b006d18c466415mr30485439ejc.326.1646379090348;
        Thu, 03 Mar 2022 23:31:30 -0800 (PST)
Received: from [192.168.0.138] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709063e4700b006da6357b1c0sm1445738eji.196.2022.03.03.23.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 23:31:29 -0800 (PST)
Message-ID: <53fbfcde-0f5e-8ea2-4bca-c7a414f96c57@canonical.com>
Date:   Fri, 4 Mar 2022 08:31:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: mfd: Fix pinctrl node name warnings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        - <patches@opensource.cirrus.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org
References: <20220303232350.2591143-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220303232350.2591143-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 00:23, Rob Herring wrote:
> The recent addition pinctrl.yaml in commit c09acbc499e8 ("dt-bindings:
> pinctrl: use pinctrl.yaml") resulted in some node name warnings:
> 
> Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml: \
>  lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> Documentation/devicetree/bindings/mfd/cirrus,madera.example.dt.yaml: \
>  codec@1a: $nodename:0: 'codec@1a' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: \
>  pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> 
> Fix the node names to the preferred 'pinctrl'. For cirrus,madera,
> nothing from pinctrl.yaml schema is used, so just drop the reference.
> 
> Fixes: c09acbc499e8 ("dt-bindings: pinctrl: use pinctrl.yaml")
> Cc: Rafał Miłecki <rafal@milecki.pl>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Fix lochnagar-pinctrl nodename in example
> v3:
>  - And fix lochnagar-pinctrl nodename in 'required'. Sigh...
> ---
>  Documentation/devicetree/bindings/mfd/brcm,cru.yaml         | 4 ++--
>  Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml | 6 +++---
>  .../devicetree/bindings/pinctrl/cirrus,madera.yaml          | 3 ---
>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
> index be4a2df71c25..b85819fbb07c 100644
> --- a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
> +++ b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
> @@ -39,7 +39,7 @@ patternProperties:
>    '^phy@[a-f0-9]+$':
>      $ref: ../phy/bcm-ns-usb2-phy.yaml
>  
> -  '^pin-controller@[a-f0-9]+$':
> +  '^pinctrl@[a-f0-9]+$':
>      $ref: ../pinctrl/brcm,ns-pinmux.yaml
>  
>    '^syscon@[a-f0-9]+$':
> @@ -94,7 +94,7 @@ examples:
>              reg = <0x180 0x4>;
>          };
>  
> -        pin-controller@1c0 {
> +        pinctrl@1c0 {

DTS also need such change.

Best regards,
Krzysztof
