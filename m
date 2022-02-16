Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4061E4B859B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiBPKaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:30:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiBPKaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:30:02 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFC9220BE2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:29:50 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B068D4060F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645007388;
        bh=8Ae2IyDPIYtSDwfICZYtX6NpzxBQNSp7pmdTk/Ww12w=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qSAvNyBmI6VMwGxZEohN/GJocZjYDQvs1IYOk8wTJn6z8vm5Af3PAbsGAcMliXdQk
         TKR/C8DIIQoPpXzRH533o0DyFjstEzYIHoSG1nwPcqOWOPErUKLEMzg1e5R60vqDHe
         Cdn6bJFq5gbPaC/gLUUpfIXRAuUj0zbaxW4GmQcCxJqVk9EpLlVED3D44asI2y9NBv
         NWhOxZmZ1jocBZz+EzLvMN837mpZNioWd8qAhoOPBMgbmMCrkCL/x5kDqGBirNeI7g
         46urYFi3vpEYsT6mPc8NAToOGNgAX3DkKatNO8we83PeRMALcVgqJ5n23qeayyMsFL
         kOm0gAJJHgSKg==
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a056402354900b0040fb9c35a02so1267918edd.18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Ae2IyDPIYtSDwfICZYtX6NpzxBQNSp7pmdTk/Ww12w=;
        b=q6vklAe7P5TdEPFhWzZwZbFfvYH86L59Gpue7HH3FkG+FQGP03kOsYRvgskZ4vPwjs
         5SlDJqslSfX4AJcpUvOL+rx0vLSnJ2ZMg8cvHnTD41h7G4Uv+KqSNfXklv1n5MnOikUZ
         mhnbuWrJE2k39+BTXA+6XawY7nlCHiSyBP7CFn1lhNm1h22dZ67YiYk5v6nYsbqz8fP1
         RNyFYdhO6pzBw8xXmHtcwricmhoUII6jaseIbtkWuQFqod3R01fYHWbB5RpeERL5/jow
         QPY9mPnNg6wGgquRHep7oBOdR1JJcyxR1AXWxc0LtESmJuT4yNiElHad2JflZjbeBtJq
         ypeQ==
X-Gm-Message-State: AOAM532coglztSr+hmBZWpNyR1CQajAg0e1XFF790EP1YrKYTjw88Rda
        E+8abXpvvHQ2xbSIot/FBjS5WgEL2wdkBPXT8iYlDD+e0XoCOvAyIk0AcbtvLPYkB1oJiH00mbn
        8o+LMMg7KMM2mb/8uCUWFjBUwQp6idmhlH9RAJ/3uXA==
X-Received: by 2002:a17:907:70c1:b0:6ce:78ff:bad4 with SMTP id yk1-20020a17090770c100b006ce78ffbad4mr1757697ejb.68.1645007388015;
        Wed, 16 Feb 2022 02:29:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB8SV5fiPCVTykaHtbYxxGP3rr/oFhGzeVD5CLSmaDY/7MY+BRd9s2Om9TXV6Oz9hnD0yY4A==
X-Received: by 2002:a17:907:70c1:b0:6ce:78ff:bad4 with SMTP id yk1-20020a17090770c100b006ce78ffbad4mr1757676ejb.68.1645007387804;
        Wed, 16 Feb 2022 02:29:47 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p25sm5037598ejn.33.2022.02.16.02.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 02:29:47 -0800 (PST)
Message-ID: <2249cf46-5c54-2e59-f247-5a22f2e6e5b9@canonical.com>
Date:   Wed, 16 Feb 2022 11:29:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/6] dt-bindings: Document Tegra234 HDA support
Content-Language: en-US
To:     Mohan Kumar <mkumard@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, thierry.reding@gmail.com,
        tiwai@suse.com, jonathanh@nvidia.com, spujar@nvidia.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220216092240.26464-1-mkumard@nvidia.com>
 <20220216092240.26464-6-mkumard@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220216092240.26464-6-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 10:22, Mohan Kumar wrote:
> Update binding document for HDA support on Tegra234 chip.
> 
> Tegra234 has max of 2 clocks and 2 resets which requires to add
> minItems and maxItems for clocks and resets as Tegra chips can
> now have minimum of 2 and maximum of 3 clocks and reset support.
> 
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> index 2c913aa44fee..12c31b4b99e1 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> @@ -23,6 +23,7 @@ properties:
>        - const: nvidia,tegra30-hda
>        - items:
>            - enum:
> +              - nvidia,tegra234-hda

Why putting it in non-alphabetical order? Although someone put
nvidia,tegra124-hda already at the end of list... having things ordered
is helpful to avoid conflicts and makes code easier to read.


Best regards,
Krzysztof
