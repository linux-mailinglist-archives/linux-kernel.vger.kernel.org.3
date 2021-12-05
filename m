Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCC2468C26
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 17:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhLEQsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 11:48:54 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49830
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235935AbhLEQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 11:48:53 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1511A40013
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638722725;
        bh=Ynkq06ZARMCOYrhIwJJNWg9AtV11IKTUxlCiNMi7yFs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=dljC7F68rKvH1urViLspgEBeopvIOV6rXIGr9pALyoOvebzQBcJ6n92EfAfZk/9KI
         9TdoJmyPOH5aTQ0+VmOM58ZiUNrOEBKiRAb/Ldy+Y3e+cBFi/Ig4DRGndUW04ncxq3
         jyIweooyRIb0BRqvtq8VEtjEccRNBXNhzPCh7TcaFsmskZsU5oRsIrUrHK7/MoQ+0R
         rBkWdAruCOK+3BqiYOFUFa1Y4C2sNNYKGj513eSVaM9WH359H2IOFE7kte/LbL0jqx
         2Eaa2vpwdgcgFBatT2tCfb31cnF5HeQt4aQLESFiWpLWw9agILpdwJM5Kn+nAPcOGK
         cX1P9EDCRvO/A==
Received: by mail-lf1-f72.google.com with SMTP id g38-20020a0565123ba600b004036147023bso2685383lfv.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 08:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ynkq06ZARMCOYrhIwJJNWg9AtV11IKTUxlCiNMi7yFs=;
        b=cxU54VS0+Q21VeI54TIqvb7dqSp4x4iShxpwZmgv1WK1wVzDKwyfsCJCBO6g4zqP8c
         S8ItbMWIdJmgpWk5FAtqtcLsAMrDtIzwlwxH0SjrKTKv3XBfih4OReLrTbGN/o8ockby
         0AC4YMFpSIf0uLHdGwI2hO5iVwmG9Ir4RQ4ibjFAwsILp6qj1VPwNAqsQeQn8idmA338
         gMKYUAkU0v5dNECgPKkaq32U6ivP3XuNB3uyUowfYIDqIZh82/My09yPqUjUkBdx54hr
         WQjLZVrQJuZTQQ0NPywCh39QjfOuMnWr4NIEtekEqfLQ9G0f/ZHjRTy3Vb/wk6ax59PT
         D9Tg==
X-Gm-Message-State: AOAM531J1HMNWOKQ51av7sFKSSfhD1AWT+mo9/bF42zXxGctPDOmBqtn
        2WS6QWv0PnRq37ZQabEIRPTi9XOpzy36f3DKpeiYYN8iSApJgCEFNFXJkia7s2A6qTNC28kYPPU
        /gZLDY91D64Iw4kh+iygB1MTQVljKQ6eYLku/UNaagg==
X-Received: by 2002:a05:6512:3718:: with SMTP id z24mr30354651lfr.563.1638722724465;
        Sun, 05 Dec 2021 08:45:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRuYQWcf9Blj+BSef7qa3hqIyQBNi63M86AiQYiGhVbFi71sm/nCqsjP+YXZtzSaItqny9OQ==
X-Received: by 2002:a05:6512:3718:: with SMTP id z24mr30354638lfr.563.1638722724308;
        Sun, 05 Dec 2021 08:45:24 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v66sm1118752lfa.6.2021.12.05.08.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 08:45:23 -0800 (PST)
Message-ID: <b650681f-62e4-8bff-37de-ea9066559072@canonical.com>
Date:   Sun, 5 Dec 2021 17:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/6] dt-bindings: clock: Add bindings definitions for
 Exynos7885 CMU
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211205153302.76418-1-virag.david003@gmail.com>
 <20211205153302.76418-3-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211205153302.76418-3-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2021 16:32, David Virag wrote:
> Just like on Exynos850, the clock controller driver is designed to have
> separate instances for each particular CMU, so clock IDs start from 1
> for each CMU in this bindings header too.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>  include/dt-bindings/clock/exynos7885.h | 115 +++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 include/dt-bindings/clock/exynos7885.h


This should be patch 1.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
