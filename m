Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19384CE724
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiCEVKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiCEVKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:10:03 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866854F8A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 13:09:13 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A94C33F5F9
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646514551;
        bh=WAQKhYMo57N8as5lEM8TfNIA75uLIrH1Mak0qxJFf+E=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=K9PYHdGmOms9YAQW9dzC2dxZET+pErICNwRKhTOYz0s4Sz+67HbtnHT9XPAPg4Wyh
         p/EhQW3N187LMeTLVfnYSrQqcThMVSgZE1mdPCrd0W2TSHmVRX4yhOeA1tkdspx0SP
         uhxqqskUZv848pULCvNFzy7Q/w6vvd3g45mag5kEATyydsJRSneQY/roKAd9KkHZOZ
         mFgURPxYidH04QwMLvq2LJVjCG6UcIKyYyNvOlBS6WnvMrFpAxhR8GD1FO/4OjuuFh
         vn3ObyQM/U0/0pgyRJwLKM0d6mqWOH7YVO4vBSSTDk64G3YhEyn/19b8EsNewBQK4l
         WTv91gJwNg8Dg==
Received: by mail-ej1-f71.google.com with SMTP id lf15-20020a170906ae4f00b006da86a43346so4842444ejb.14
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 13:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WAQKhYMo57N8as5lEM8TfNIA75uLIrH1Mak0qxJFf+E=;
        b=SLMy4tNHs4hD92bq/yZ1BEc2CNCmi07OKtQXDPM2VGDD6OpOymYqwBZ7mmGFDjbgeB
         bvoCF88B+wu/hzPsI0dObYhP84pnb2hAVFpFYimfr3uJq3nIvHp3YWSY36eQia8xbWlT
         JG5h9YYBRhHx1laHmHy663/YGkS1iex516URou+cwxGgl2OKunzBau7xwI68xtTQYoby
         Jo03dfaHSY9iZ08pHkIwXQ3zuj8m9BIaPOA1vKoROiP50Vre5Keyzcyv/ihMHZLSO/sT
         ny2DMub9zehaqSYaKYRE9+4dDtLn901Yd/ruIaMA94tBkgngLAzQZX2deQhiMgTa8L3U
         xI1g==
X-Gm-Message-State: AOAM533YaLzOmbtJsWByvrogjVDrjf+OhD2ltkmJ4WOXTrI9ApaN48/n
        DMRenDtSn4/HwAlkvAhkgUuMtmVEcjcs1JjjSOkhR6IIXzNn2e/xTXijoEONeDaiTNcTALRNF/5
        HEXZeeNs6slYJqp33A2A7ta0o6oqp7xUfuuk7WEV19Q==
X-Received: by 2002:a17:907:a0c9:b0:6da:9614:2626 with SMTP id hw9-20020a170907a0c900b006da96142626mr3849154ejc.100.1646514551251;
        Sat, 05 Mar 2022 13:09:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzH7XB367R4/kjja1V8vqLgC03VVcgl4o0Hpo/HnAQb3z1YSU8ztZqR+PCDQe6ctX9cwcHg3Q==
X-Received: by 2002:a17:907:a0c9:b0:6da:9614:2626 with SMTP id hw9-20020a170907a0c900b006da96142626mr3849136ejc.100.1646514551027;
        Sat, 05 Mar 2022 13:09:11 -0800 (PST)
Received: from [192.168.0.139] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b006cf488e72e3sm3196513ejc.25.2022.03.05.13.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 13:09:10 -0800 (PST)
Message-ID: <41a4ee47-9dc4-a79f-97be-5d50e1b1c29c@canonical.com>
Date:   Sat, 5 Mar 2022 22:09:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/4] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220304161159.147784-1-sergiu.moga@microchip.com>
 <20220304161159.147784-4-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220304161159.147784-4-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 17:11, Sergiu Moga wrote:
> Convert RTC binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 -------
>  .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
