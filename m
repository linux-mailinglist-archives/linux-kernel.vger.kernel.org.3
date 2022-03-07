Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD24CF3EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiCGIsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiCGIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:47:57 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B97E63538
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:47:04 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 524E43F5F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646642821;
        bh=cTVS5wZOGaAoIcz1M4Y4sLTFfhLOC06ze/gaw6hqXNw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SS+2a6ideT8YDbS371Foym8KXdJxQC/R/mxCiUblsH07rj2xiJIhg3O1KFwChQb+p
         jsVgTssmW8zFH68V3ZKC468/xfdOqKDZgcTYh2zP6VtMIsrZm6ZjZGapTC4DxZmbm7
         Xu5oEuU0s+os9w4hpu0h3heEs0R6+152SqmH17vqMnSgmDozsC/2YuRjZC8/9IGDx1
         hsPU/pr7NyOHYMAI+3q9es3IWu8eI+lKsfzqVvDvRJhAv/Hs9nwpdNTrgNPsJ9p6wS
         tqkxqr1POFZimngoT1MQ/bliQWuSVtb7QdQQjAKp2XhvbspJXjMjQfAhjKNs0lO/RJ
         C/pOrpJk5rvmQ==
Received: by mail-ed1-f72.google.com with SMTP id i17-20020aa7c711000000b00415ecaefd07so5844153edq.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cTVS5wZOGaAoIcz1M4Y4sLTFfhLOC06ze/gaw6hqXNw=;
        b=1D7KlRXu2xXZzYlyRAZs1RVuq9MbT8nFUHwnOXkGS51l2iBHTJGMS/Cvi2M7wR1Or5
         mNA31X4kozwg27nKp8ltnTkXoD7Ma1gu4wjIMrLEnOfJxooAHC5QhGHY7LVK2Grk4r7c
         gvAu/iUrRobfpynRX1YvPYFqRKi0CgWG5D8Aip7DO+J45zxMg0fp9e3dtX0ZDf4NuFX9
         eF0z+iiXKDQ9b+8uw9n469Pir3y5rk09KiSoNebPOT2j5DdkIBR3tuzDxT6EpE7VFFsD
         wl8WPO8pONuGljhcQ6OfVS5S16oKH1bSdD9HTlOdsdaWxOj25OskPb8USQP00naxcUJs
         slXw==
X-Gm-Message-State: AOAM532J1joD36Eg7pr0Z/TgShCcXoxuGzcpdFTYyjRW9/mWJkFfEjJo
        ESnhTUz5dT29qRASm1MPk0l9ofqyEorxS2ePDZYTMq/6dpYkqhbshC895cHj3Hj2f+sIl1GIi7Q
        aT4lbsE1aUv2czzj27kyvfHZgLt8wYB79H82C3aQUvg==
X-Received: by 2002:a05:6402:2754:b0:416:55c4:c883 with SMTP id z20-20020a056402275400b0041655c4c883mr1452292edd.285.1646642820901;
        Mon, 07 Mar 2022 00:47:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlcygC1225VRsCfRH7PGhqlqVVmwDsWlgFrgal65RixQmIDsY1lehMdFc//YJEm1fs3ijWuQ==
X-Received: by 2002:a05:6402:2754:b0:416:55c4:c883 with SMTP id z20-20020a056402275400b0041655c4c883mr1452278edd.285.1646642820720;
        Mon, 07 Mar 2022 00:47:00 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709060f5400b006d6d54b9203sm4474446ejj.38.2022.03.07.00.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:46:59 -0800 (PST)
Message-ID: <e021ee5d-1d4d-61ea-8eb4-51ca87820b2f@canonical.com>
Date:   Mon, 7 Mar 2022 09:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: Enable building on ARTPEC
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel@axis.com, alim.akhtar@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220307083744.1592533-1-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307083744.1592533-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 09:37, Vincent Whitchurch wrote:
> This timer block is used on ARTPEC-8.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/clocksource/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index ae95d06a4a8f..2ea981ef23af 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -419,7 +419,7 @@ config ATMEL_TCB_CLKSRC
>  config CLKSRC_EXYNOS_MCT
>  	bool "Exynos multi core timer driver" if COMPILE_TEST
>  	depends on ARM || ARM64
> -	depends on ARCH_EXYNOS || COMPILE_TEST
> +	depends on ARCH_ARTPEC || ARCH_EXYNOS || COMPILE_TEST

This looks ok, but please also provide compatible in the bindings (if
driver stays the same) on top of my patches specifying number of interrupts:
https://github.com/krzk/linux/commits/n/dt-bindings-exynos-mct-v2

Best regards,
Krzysztof
