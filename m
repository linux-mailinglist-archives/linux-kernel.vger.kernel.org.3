Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3384A47A731
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhLTJgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:36:15 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55320
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhLTJgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:36:14 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 21C543F07F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639992973;
        bh=IwmUkfQQuaN3okDT7GWPwPvdQQAzqCja/1LenmoCoEo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=cuHLRV2s+FQEY0qQh2SN5okGBDBUW59LkXj48OfyzLcmBEN5kErLq8D9E93tLpFCM
         0XCFjwV09UYpcvZI2doQuXtLIz3hAqz2rV4LJRLWx3MM1qCH3sRzRwW42T8GOBUTsV
         iQE0nsDwjIZOzb6n+GMRAc0yAnGfH4Smu2BngRxdEL9OSZnrpbNbXPSbbg3PX5GfU0
         qUY3BReTsmUtf3plPgGGKUyz5Aogut9UWMc1XaIFvA1qywqHAkiHzNzB8epPUp4w3Y
         vBsw7+FGcOitbKfON6g8HM8RHFBP0urb3mbu7BAQD/YEcxdwSjiV/VGCxg0phDi+1P
         +61TigIUaQvLg==
Received: by mail-lf1-f71.google.com with SMTP id r21-20020ac25f95000000b004259e6ab262so2353025lfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IwmUkfQQuaN3okDT7GWPwPvdQQAzqCja/1LenmoCoEo=;
        b=SRszh/OibKcrKrZwyeSkvxUZhPSHK/Ci+Fn4g2LR2xy0GcgBhbAIYq7dtKR9Q3erI8
         PTAfZiNm8/KVISvHfNHs/TXt9RVIMgOs9sZjzrJS+9QwZETKQW2kMjUT+YOdX5N3h2kD
         HG51bnZ3VQAU4ZvmS2pWOAoc1Cybj2TQw9MBgu2qOBzmlvziBrsbD6fqLJWlifHHblwD
         UNnMUMMUgznIZpO7Fgp5I6P97xV6TrsrM5QAQkkoZzMPqtTkY++AETRsWrKMlprjlHDN
         wz+Cp6vTcjSO8G85/QAuQzN/J2+st1ugixj4bS/9FW/u3vE240pLUZb1byjMytvOcVX2
         5itA==
X-Gm-Message-State: AOAM531CDKgK6vfrX/GehaC5eq2tin+RXm7b6Z7iS8MOJ0ly9GgNaBeQ
        wECKCRN2LAcvQafkGC5+vHoXLHmQdQ8UF6Xpv0bzstQBPvnkRDVmfgvM4Uc3R1xRoEhz2oXRkD9
        OvBBo4fz/FjFZJ9Pdc07UAs1Bf/ppiWITcm0nhijwvw==
X-Received: by 2002:a05:6512:4028:: with SMTP id br40mr522664lfb.365.1639992972625;
        Mon, 20 Dec 2021 01:36:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyT/5JqRisnSYB/tPDmuH5uFX9Zpw1WHoE/0Ws/4gk4AqKHpkLfVxOtQaWkZ1afKZK2oRKW0g==
X-Received: by 2002:a05:6512:4028:: with SMTP id br40mr522641lfb.365.1639992972442;
        Mon, 20 Dec 2021 01:36:12 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p18sm959112lfc.297.2021.12.20.01.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 01:36:10 -0800 (PST)
Message-ID: <cc1c2906-60c2-7d4a-78c3-014f6712f9b2@canonical.com>
Date:   Mon, 20 Dec 2021 10:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 3/7] dt-bindings: Add vendor prefix for WinLink
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211217161549.24836-1-semen.protsenko@linaro.org>
 <20211217161549.24836-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211217161549.24836-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2021 17:15, Sam Protsenko wrote:
> WinLink Co., Ltd is a hardware design and manufacturing company based in
> South Korea. Official web-site: [1].
> 
> [1] http://win-link.net/
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Ack goes after your SoB. First you create patch, sign it and then Rob
sees it and acks it.


Best regards,
Krzysztof
