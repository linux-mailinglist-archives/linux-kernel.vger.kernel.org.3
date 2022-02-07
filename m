Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65D4AC9DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiBGTsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiBGTpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:45:42 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2859C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:45:41 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5DD3E4003D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644263134;
        bh=ZFe7GrDYXMM8CLQ5SMwXw4UQni/9UZT69dDdKHMLJTo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=CXNu75oEuLgWLAAwUIzGlsCrsh6PsFr867GTO1mueUbFGXRKvlITzZsVZddpE3JrP
         PqizrVsInxFq/pkeoTx89IUwlMhbkfYZis3IIF4zKw1ZRd8IaVRg32nDI2mUGdcnON
         c4kKuuU1kIsVHDgjJE9gt2n2B6X/3EHPnIaefbwB6KmMcjuNtB8jw00c5v7vP7i+Mt
         x2SN9pMybsVyANw8uoBaUIPEWW3Pzcge2X8wAo7sscFusK3hMe58jIzX2Rr5zw8oFi
         nQc3J3ux2ScW7S0cPLrZJMRKT4aDXynVF2Sez3CeFrlIZqSuY/IXgqimqLoEqtJhbh
         bx25iwXfh+Xkg==
Received: by mail-ed1-f70.google.com with SMTP id k11-20020a50c8cb000000b0040f84c5bc66so1515447edh.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZFe7GrDYXMM8CLQ5SMwXw4UQni/9UZT69dDdKHMLJTo=;
        b=avWMlnKLIz3wHERxQyu2MSL0K3dy1PamJs6erM0efiG5AjcdDHp2vzv7HQ6IMTG5ro
         WjsQvS59FY3laxdT3q2HtfsZ07kACFmsWH2iYWh5jNEAloCZ/ojI6enZ+7ptlamqTDls
         gzAmh11151NK0rOavaDf3+LBuirfsM+v1Gsf7LAdn780ZpUrEDdSc2Clr4bdDOWYsKXr
         obBEjywF5MwKXDqfAWYNi4e7h5m8BvGjcLBhcNiaaEiIbDdtQ2oAjfrs08C83J0ZuD/q
         QidoJlGzyo6Vup+d20Pl1PjaXgSNDObKyujdrP1UD/qUHSZcavbO2J62ZCuiBt/xmQIJ
         NZuA==
X-Gm-Message-State: AOAM5337ZGUXGFIOLazHJFeEHYicFljuMbIiewAG5WysqqpQiFbp4dRe
        oWRf9Ho97AxgUp7lnMlkdo5Z5maX0b2BmoGxuQvoImfre+GAAZTpUreGFxX4I9rp+taq7EI863l
        JBouKSW9vuZQmTHY3SWBWEosHtF8h+7QtqNuNXQGlqA==
X-Received: by 2002:a17:907:98e8:: with SMTP id ke8mr967999ejc.524.1644263132762;
        Mon, 07 Feb 2022 11:45:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFbHJhhicQcTAJbCV7XtoidiI0ekXusMyI1v7J4cYe1pPDkuk3WrSncw/sfZC1Yn4c59YKVQ==
X-Received: by 2002:a17:907:98e8:: with SMTP id ke8mr967987ejc.524.1644263132572;
        Mon, 07 Feb 2022 11:45:32 -0800 (PST)
Received: from [192.168.0.91] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t22sm5595617edv.105.2022.02.07.11.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 11:45:32 -0800 (PST)
Message-ID: <22952187-80c2-a456-f389-f70a2a30f467@canonical.com>
Date:   Mon, 7 Feb 2022 20:45:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/4] spi: dt-bindings: samsung: convert to dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
 <YgFgQsV2bJS6mjQs@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgFgQsV2bJS6mjQs@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 19:09, Mark Brown wrote:
> On Mon, Jan 24, 2022 at 09:23:44AM +0100, Krzysztof Kozlowski wrote:
>> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
>> controller bindings to DT schema format.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Hi Mark and Lee,

Thanks for the review. The dt-bindings part have Rob's review. I think
this means Lee can pick up the entire set (SPI+MFD)?

Best regards,
Krzysztof
