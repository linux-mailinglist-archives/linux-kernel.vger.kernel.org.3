Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C4859552B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiHPI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiHPIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:25:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0394B1403AE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:58:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f20so13406289lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fG6ebq+esaR04I5xSnC4xD/7QUDUFnAnjiwTJZuzpTU=;
        b=HbRzk/VSqzFdbWnSmSJYeONLMiDIX4eolFhsG+ovtUIrYQaEt4fOkjoEJEklJPfWAB
         hCtkii2R/7FvDwsdApsi3VZBEdLZne1ZnDTzCRqDftnrYKUD52HjeIOx//p0e8J5jS/G
         +0BsgvCxCyLK5ILdUXZdVnnYzzfd4HzpH4nuMgS9jiScfrd0v5sTuOmjgyl4sP4ls2Fj
         LJzCTUrSbBmEF//F3bcwugnym76jL/d6xod76SEqG4tpMyPReYWiOb9c1bPCh80CKUUt
         RotrAblPLD/bJQnlvo8zkzY3hH8+Nn1YP/OqkdB7xDZx9hkL0n0Z/3sFwEKwSyiWZxtl
         4cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fG6ebq+esaR04I5xSnC4xD/7QUDUFnAnjiwTJZuzpTU=;
        b=iR3y+qi9BSzLbgYI4qiaiUTvDSakW2b306+A6Z76JAD/vZZ/Jsvmmm2/KkTxwQ073V
         IvcX/zMkB/PptU2m5zlwP7j/sldjFydmNuduI1gVFmSPkxS5LgU+4vtaBqyhfMvPxjm/
         GqW9E40IOLctiKWA4cobd2meXGirOB91hv3iXVLJpvRXyLcQEVBaFZJfC9GS/IOUMYPR
         uAV2gVHQvISEwTadxK4AkkuYNmxj5G4YJs7BlOScaNhOH2lXPMuWAbv+Ni8s5vhqjUNB
         mpUl51r1AMXKg4mMb+5/nshCyOgPKFZGBzPhfhfXpTZijL7+p6p7PrKvNX0fJKcpGeNM
         s9eQ==
X-Gm-Message-State: ACgBeo2n46xs3eD2xXGxI+0yFK+durgY6C7WRv4z/8fW5kPR8d88wSm/
        4GHLG31D1RvbKlyUvG38z5Q1gQ==
X-Google-Smtp-Source: AA6agR6nWRLeZKfkfbcHhmb0twzixrU6OVenWmTfNeYj4Zbsb7EQ2O2nQhUNQ/z+EXIsHXvCkdP56w==
X-Received: by 2002:a05:6512:3d8f:b0:48f:a80b:1872 with SMTP id k15-20020a0565123d8f00b0048fa80b1872mr5975131lfv.21.1660629478374;
        Mon, 15 Aug 2022 22:57:58 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id h6-20020a2ea486000000b0025e57b40009sm1675557lji.89.2022.08.15.22.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 22:57:57 -0700 (PDT)
Message-ID: <96e4a9f2-96a0-764e-8060-58f2c1b23a5b@linaro.org>
Date:   Tue, 16 Aug 2022 08:57:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 4/4] dt-binding: perf: Add Amlogic DDR PMU
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220805071426.2598818-1-jiucheng.xu@amlogic.com>
 <20220805071426.2598818-4-jiucheng.xu@amlogic.com>
 <a3cd55ad-cec2-9570-2078-6724ab1d7300@linaro.org>
 <880842a1-a769-f228-7c91-5402e6d9391e@amlogic.com>
 <c57044ca-3742-37c1-b8ad-14806cbc05ea@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c57044ca-3742-37c1-b8ad-14806cbc05ea@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 12:04, Jiucheng Xu wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>> You have only one item, so remove "items".
> 
> Hi Krzysztof,
> 
> I have tried to remove "items", but error comes.
> 
> properties:
>    compatible:
>      - enum:
>        - amlogic,g12a-ddr-pmu
>        - amlogic,g12b-ddr-pmu
>        - amlogic,sm1-ddr-pmu
> 
> Do I get misunderstand? I think the "item" is necessary.

And how other bindings are doing it?

Best regards,
Krzysztof
