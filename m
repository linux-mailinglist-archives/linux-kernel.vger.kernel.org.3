Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24100475CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbhLOQLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:11:52 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49732
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235029AbhLOQLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:11:50 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AC687402EA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639584709;
        bh=HEryT/59cwIP/SgJfqP9kYNmdFO5OiSXHgK40bkLxdM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=O0X4MFdfW9C0nCwVLfHaZBjMBz+yS0FwF5ARgxIANy1Jxaqto9ooU2VAMZmS6Ibaa
         02DSTgQ5ixGykP5PbiCokQpgczADv4u+qL//oR0dVTAOG1kMyPuxGqg2CsjfmchS1f
         QU49CwIgmshFW+hFQ8SUeX4AFT4Q49yYoazYJBUHU6pmR7fjR5RbUoi7bWGJ0CTh4F
         lIredh6VIAhol1EmXWkPwNp9qLpr5bJKuwIfpKq+mJuxTXYwgpYu5Bnpc7V0LaVh69
         waMNM+Hb4MU7iIJmmDxfzyS+GHOmKRToYPB8IhFrYeU2nLEJPX/8nOvH6CMZjVfAiy
         4X32xDBNuyDlw==
Received: by mail-lf1-f70.google.com with SMTP id 24-20020ac25f58000000b0041799ebf529so9754145lfz.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HEryT/59cwIP/SgJfqP9kYNmdFO5OiSXHgK40bkLxdM=;
        b=Rvq6ZcbWvEMJYwjRINfYK/LuzAY5mr7IyhaUSFek6uusxQ7SxGChfn8EPOW3CA+bVU
         NjNrxFGCbQL+yTOeqQ/pX9RaNklgBZCF0VT3+KlmWsW8yCLjnXYXh5/j7ZaFHSw6lcIG
         DhbUhL/EEWwdrMuLuAhJdXF2UOo7sN2N9FqAyIQeivSnEVOxvtrVws0yejLNK89wuXO/
         RdK/rHugrqpd2eJaZDSG97j5PmYrj+Gto7B2nPfzvbNMVIgvd25pJxsd32tDFvU4y6v3
         8OZx6J5GfQFRwPtciQjOmIAGEWm9WsOpgLFv6YV8l5zjHi3G1aW73v5wbhwvAxwbvhM8
         Zkbg==
X-Gm-Message-State: AOAM532nuPRVWhL4HDtmji6Ug4eqieVrJRUJmnyjgyP36pKNSVUAWBk4
        2wTuXImnzKEeIYC175ty9zO0vmxC1kZarVao6w42YjIhEpDR4yG+0cIxh80aD5IOo8xs0hHzcIx
        YHrVCI4DtvL5U3P6X0HIjcZY5QLaJ/Tg0HGmAENZhWg==
X-Received: by 2002:a05:6512:3fa:: with SMTP id n26mr10779816lfq.369.1639584709156;
        Wed, 15 Dec 2021 08:11:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1QHtNZSWhWsx7d0Gr+L7f/sF8couHjZyoyUMKUsr2/tG2om/weSyMTpr4+BviHq0uyXtW0w==
X-Received: by 2002:a05:6512:3fa:: with SMTP id n26mr10779784lfq.369.1639584708997;
        Wed, 15 Dec 2021 08:11:48 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id m3sm522157lji.112.2021.12.15.08.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 08:11:48 -0800 (PST)
Message-ID: <6b5fd3fd-18cf-3b6d-934b-11a82cf404dd@canonical.com>
Date:   Wed, 15 Dec 2021 17:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/7] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
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
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-2-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211215160906.17451-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 17:09, Sam Protsenko wrote:
> System Register is used to configure system behavior, like USI protocol,
> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> make it possible to modify SYSREG registers.
> 
> While at it, add also missing PMU and GPIO clocks, which looks necessary
> and might be needed for corresponding Exynos850 features soon.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
