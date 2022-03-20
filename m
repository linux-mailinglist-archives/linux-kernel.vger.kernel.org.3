Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED304E1BB9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 13:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbiCTMnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245084AbiCTMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:43:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087A1A8479
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 05:42:23 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C7FD73F221
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647780136;
        bh=SdUWMHmZ193wUTPTiF7ipsfDvKGml1ecvzIaMqPfwIA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=LfUJ6lGthumwv+dNyqAWulrgsWx8nIDqdll3IHySJE5nLrX9EL8CRTVvgpTf8Rjmn
         /YePMW5Luo6ilQ0pgRSCe+K24oYeBs1L4G/324jYeLcfCBqxQ/WR3bRLadAhBIOCLS
         N5PcVuaNzevEE7h0PInLw2h+9O50eUwNMLWFS+tXg5GapjccfmXD7uSORfd1tpzQgV
         M1AR3NBCIRKpuJlgKHNJgeNV70vcvQ9q8Z0klOQOULuczqdoRfaed/i36yqhcKserO
         2c61nn/nUWE7ny5R6dkwtjsdzDJzVxez3oGXgt7Gji6FDQY+Bdv+aZpD7oq8HxLpr8
         1R3HfTsPMkIQA==
Received: by mail-ej1-f71.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so5940295ejw.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 05:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SdUWMHmZ193wUTPTiF7ipsfDvKGml1ecvzIaMqPfwIA=;
        b=BLHwy7ZIccO1sM9EuP63BdpwFcLL4iAmh7ag6pBYXGvAjcBf64qX53wQYB06u3tMTL
         R/Sn3pdcbAEayW6iYUVoh1ozD7v4nwoUOwjnLrmE9UiTnlAt9gu/mb1uO792GwMSVtTt
         udhBtPNMep1aMAucmswpKrEWCax9cHDL1LLHtOQ+E0D+2MAsp1z2ABZuyC3VHdY22roE
         HKJMMvJBbKguiAWpQ1MIUymdB4LOlrbZbLHWRlAGI4s8uABGEYdi8hT/mifiLMv68yQ3
         gsDXm9jBAtf0UseWt0b4q7AaG4j2Yp1+HjCp8ryU6i8j+SgVJK8B2k3lT8SBzWVPmvDh
         ERAw==
X-Gm-Message-State: AOAM532uNAazfWSexlr8Tc47/1f+ZByGalif3J5rNY3hUqHkY7+hHu8H
        LDM8GXyUrdNq/YscIeIz7cwVMQdZ44AnmEYlkSnABOR76GaYWQ8xCHKp/9agFcmg3EBdfPlvI5l
        CmAUxoQUFfsaFB3meDpocruS7GVZY4zEpxVNaVtfjuQ==
X-Received: by 2002:a05:6402:484:b0:415:d931:cb2f with SMTP id k4-20020a056402048400b00415d931cb2fmr18507932edv.287.1647780134923;
        Sun, 20 Mar 2022 05:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFr8QjIsnRNA97/xRKhcXrC9HuSe14EplGK5C5xpZHxfHczzlRSkdY15/du/MsMa43QLRVZw==
X-Received: by 2002:a05:6402:484:b0:415:d931:cb2f with SMTP id k4-20020a056402048400b00415d931cb2fmr18507916edv.287.1647780134738;
        Sun, 20 Mar 2022 05:42:14 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c14-20020a170906340e00b006ce98f2581asm5788379ejb.205.2022.03.20.05.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 05:42:14 -0700 (PDT)
Message-ID: <74db8a20-7cce-ff86-7ae4-466416443ba9@canonical.com>
Date:   Sun, 20 Mar 2022 13:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v5 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-4-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220316092525.4554-4-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 10:25, Ashish Mhetre wrote:
> From tegra186 onwards, memory controller support multiple channels.
> Reg items are updated with address and size of these channels.
> Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
> have overall 17 memory controller channels each.
> There is 1 reg item for memory controller stream-id registers.
> So update the reg maxItems to 18 in tegra186 devicetree documentation.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  .../nvidia,tegra186-mc.yaml                   | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> index 13c4c82fd0d3..3c4e231dc1de 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> @@ -34,8 +34,8 @@ properties:
>            - nvidia,tegra234-mc
>  
>    reg:
> -    minItems: 1
> -    maxItems: 3
> +    minItems: 6
> +    maxItems: 18

Still ABI break and now the in-kernel DTS will report dt check errors.

I think you ignored the comments you got about breaking ABI.

Best regards,
Krzysztof
