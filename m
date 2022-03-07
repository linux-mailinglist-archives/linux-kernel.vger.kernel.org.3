Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16374D071A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiCGTAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiCGTA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:00:29 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2E64ECD6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:59:33 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 766623F4C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646679571;
        bh=sFr5I+WRledcILsCjq370DCSnN0kDkpnKS2SgkWGsqU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Y2VnIPLntQWUq9HR5fT7xTpWPLNSrbU2iLvnsC05r6EJWc/9ToyJL74SXvuDZ96G9
         qA13T/Sk9gFHRH4sczIS7JbfI6qo7Ezj5VDi8XzX6wc6j9F1bMJZmMt9ao+Yauyzks
         vkXZKMp/z46ZoZklzfbS+otMKNxs03D2FRI8KoKtZvKgL332v7cmN7VS+M/PMWx9iD
         6ogL89oQCZuMHKM3cW6kYzoGS4+/DHVMcqsTNC/PIzVFslt3DNTqRsMZW6VEibeSMG
         jZGTEYDj3UOKU8eOetAdRInQRepYMTBI4aVtZH8wpvbd982AcP6WuLvgoVoET8oP0B
         2qk/v4QKj+d8g==
Received: by mail-ed1-f72.google.com with SMTP id y26-20020a50ce1a000000b00415e9b35c81so6887928edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sFr5I+WRledcILsCjq370DCSnN0kDkpnKS2SgkWGsqU=;
        b=ZmNtU8G79GjZsayXyWJ5vU3qeCKSVDfDNkNRtm//odtqwQaLz2EQi5n3TMulwMXkHT
         FhZBRdPsI57oD4fXhwZQoMratHp5M5n+qIFHG7BZGj4u84ZOM61U9WxC/Zs/eMsEzo2v
         hoYPO69nsXQLwIjSi2Sd7iV9UaITTo6JvExeF5FcKM/sSaTQaUnCsfhAA6Ilpr5o/Zc+
         cSkvkh3zCcOaG9CvDqI6N0BrcXK6NpgCZm++Btsw6mBvOjz7ccEzUQlCoKxH9pvpAXzQ
         P0tmy5Vf2FhMNWmbw87J4eGwa2ERjcAQI/y5gg9266kqNOIO9O6O7ZXSe6l7ommJrD9Y
         VRWg==
X-Gm-Message-State: AOAM533yBe2v/YTosBOuZ/+DHUpkAJ3P/FmfneElja0VCcMfW3ZAm0Vk
        1smU7e1jTdPZrHc0txElRzWqKUKmOxbf3G45C+0tWga1quXXB4/9fgFKvVnru2XxN1PygwbwbW5
        7qYPou3vQAx+JnrZo9nVMkZ9ZQJprpEmm1Z/L1VNVlQ==
X-Received: by 2002:a50:d550:0:b0:416:2ac8:b98e with SMTP id f16-20020a50d550000000b004162ac8b98emr10828121edj.236.1646679571168;
        Mon, 07 Mar 2022 10:59:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXu0txwJE4+P5FIEK6e4oUCg8E1spjxcK+3rVXWuN/ncPvZuceRX30s52MHzZGh58AtN0qkg==
X-Received: by 2002:a50:d550:0:b0:416:2ac8:b98e with SMTP id f16-20020a50d550000000b004162ac8b98emr10828096edj.236.1646679570975;
        Mon, 07 Mar 2022 10:59:30 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p24-20020a1709061b5800b006da6435cedcsm5016329ejg.132.2022.03.07.10.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 10:59:30 -0800 (PST)
Message-ID: <d5c5e3f7-7f50-6c57-f82a-41d5494ea514@canonical.com>
Date:   Mon, 7 Mar 2022 19:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] dt-bindings: cpufreq: mediatek: add mt8186 cpufreq
 dt-bindings
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
 <20220307122151.11666-3-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122151.11666-3-jia-wei.chang@mediatek.com>
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

On 07/03/2022 13:21, Tim Chang wrote:
> 1. add cci property.
> 2. add example of MT8186.

One logical change at a time. Are these related? Why entirely new
example just for "cci" node? Maybe this should be part of existing example?

> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek.yaml    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
> index 584946eb3790..d3ce17fd8fcf 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
> @@ -48,6 +48,10 @@ properties:
>        When absent, the voltage scaling flow is handled by hardware, hence no
>        software "voltage tracking" is needed.
>  
> +  cci:
> +    description:
> +      Phandle of the cci to be linked with the phandle of CPU if present.

This does not look like a standard type, so you need type.



Best regards,
Krzysztof
