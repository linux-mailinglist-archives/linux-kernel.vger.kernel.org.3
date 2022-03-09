Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0384D37FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiCIRCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiCIRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:01:55 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59FF1704FE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:50:31 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DAE5440333
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646844629;
        bh=n3bsDkHLKbob4SpB/QLI8yY+wMazsO7AAgENM4v1TGo=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=KXXsZ0AcVSloMHe6po2JnxoCCM+ARj/ln8gRf73H39QXi47/W8aaW+jRSA697Auaw
         2EptHfFIEAiNKTS7rGAJni8n5z0BjZ5A9n5U15odtrdOrnItqL51uAJMqkGgxeFD7l
         YyPQQ9fsF3bMmnbBTFe12E1leAzk0iHjxdaf67DJsJWwiHoXWd+1fDTBZO9MKfPRd/
         9osbubKsqZ5x9GJedJOwTlENgxt9sTvwLn7THPAljYxfgk3FkIb40H35m8HP+ErZUu
         IOKBAy+1/bjGgi+2ZttHTDTGJJ0WosWEGGB2B2uaIt97pVj7wN3F5AdO+PEJIzvYoY
         r+M1SjbK9KFAw==
Received: by mail-ed1-f71.google.com with SMTP id i5-20020a056402054500b00415ce7443f4so1598848edx.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3bsDkHLKbob4SpB/QLI8yY+wMazsO7AAgENM4v1TGo=;
        b=sNrMFGVnDtSLmtHsk0I8BJYqnjojRbo7EN2Jsxxk5qrjIrKjADMT20lCZDDD9P8Kmx
         WKNWRcgQPLyvukBf2OX2ToRC64NGvwXiFZpLPLkoCwFx6/gcOQWN7jJ2hD4D8u4pyktu
         SLiDXz5p1qS1smWzihF9O6MvOAGPg3nD5x9Oxz8k0mF53hnlusMbk4No1TuRczCmzLzG
         8ThpJ6TZrgRnBvCAHhDiwl1L0f5V1cr5f9XstAiDViCchQ7iv6jIrTtOv/fEWkRWXnsP
         H29CbdYCugcZGxoswhq0TVyBKZ0NSOZBHaQ6TnqBuJyQLwVrKKpRFWWOcGwjUg4isibC
         qRUQ==
X-Gm-Message-State: AOAM5313ynEmb5LkX2oL4ZQfzG3IBLOV8lN4IUt9/JYM8ewa46V2iDQM
        HZkLMQVqtC59YLoR7Wl3JTMg1gzcpG5X3AaTzMJTjuPbPwBQw7CxvYj865YUUk3chOa5q4sGsGg
        i2cPry5jsUVKu7CAhwFkoOIADVoXA1bxsO+c6j7ULVg==
X-Received: by 2002:a17:907:7205:b0:6db:706e:9453 with SMTP id dr5-20020a170907720500b006db706e9453mr639837ejc.406.1646844629563;
        Wed, 09 Mar 2022 08:50:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCxaTei6vOMnlujVwxaQYI8z9747SILBVem6r7T6w8d5qi1Y8LIsUHSSxKjRH2289mhNKSEw==
X-Received: by 2002:a17:907:7205:b0:6db:706e:9453 with SMTP id dr5-20020a170907720500b006db706e9453mr639816ejc.406.1646844629326;
        Wed, 09 Mar 2022 08:50:29 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402268f00b00416474fbb42sm1032819edd.19.2022.03.09.08.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 08:50:28 -0800 (PST)
Message-ID: <3eed8d0c-e009-2daa-ba66-899fe8f48a90@canonical.com>
Date:   Wed, 9 Mar 2022 17:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] phy: samsung: Fix missing of_node_put() in
 exynos_sata_phy_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Girish K S <ks.giri@samsung.com>,
        Vasanth Ananthan <vasanth.a@samsung.com>,
        Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220309124856.32632-1-linmq006@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220309124856.32632-1-linmq006@gmail.com>
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

On 09/03/2022 13:48, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle() with refcount
> incremented. We should use of_node_put() on it when done.
> 
> Fixes: bcff4cba41bc ("PHY: Exynos: Add Exynos5250 SATA PHY driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/phy/samsung/phy-exynos5250-sata.c | 1 +
>  1 file changed, 1 insertion(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
