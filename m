Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C1492D88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiARSiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:38:50 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36828
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244716AbiARSio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:38:44 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0155E3FFD0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642531124;
        bh=qiMWFcACm7KXDNL4mR8VjkWhK+rixFnnFkcu11vXqgg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=XZCj+bMvn633jV462x1t52CuIZPi9zKfcWfvwMLRgec6j1Y37eKPYYHL8bfp4BOJk
         2jp6uAcqBvdAQxesAi+Nni6hgIiqJQvBbtMcFeSu3YG1hl26UDmdNJBgywt/HAVIPa
         v3Fbg37w2NDrysNPsewE5TNjpMfWEVc0KFA9zjM4+8uiw8uMcBYMmKO0IPEoCWbdZu
         3knB1fs1chsqkx+996krSN5HsXrSOrpt4SziqCJFjJC40X9O6biH9MhNCQfvihR8sG
         L6dGWW0VwRZg3+qOizAbHxgaBMDAcX6gGYwW0kKF+uBkRc18Q0Ny1hGdmoRj7KH/7C
         b2fpojgaO/QHw==
Received: by mail-ed1-f71.google.com with SMTP id a8-20020a056402168800b004022fcdeb25so7117346edv.21
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qiMWFcACm7KXDNL4mR8VjkWhK+rixFnnFkcu11vXqgg=;
        b=8Mca6BmRwc7OB4pcRhL6ib6LClOn1YBzUp1dpooA5vsYD8T3zgqLuQ4326hvQYux1d
         +KnhWBOrIfi6gYwg8qdsuRbU4YL7HfMHgtIvUb76k34jwXzMJXLhGfGK8luGOeuzQ2Ex
         PZemgvSNj/9zE6H/bg76Ki5bFwnIZLXNAFCPhWd5LHE5ncE7HV9u0RpNFkey8+dV9vja
         ucPC4+ifcURXRy0E2blj79C/v44nYpSfe5o+4EpnzU6e+BAm+4hXihNpSrG96azGn4Y2
         l5SHxFyjQL1EWugoPuV0zETBeu3Y0AaTqPkMYZhKIqujtgNhW3lH61hwHlrccrFZADua
         na2g==
X-Gm-Message-State: AOAM532sehJFS8arOJ1+X46GarspuxciLvRhWxDCxo6k0cR6NKA4CxcS
        1FDc1MzjCDFOdRt/4Qx66tDphC8KR5REEQxMwN4Im3TckrKYGzP2BzuWBfQ8YIq6rXqVbCUq87f
        vPzTDf8FSGGls8cB+Nhkt8p+n8acTpoD34K0W7Kn5Jg==
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr24451513edx.233.1642531123690;
        Tue, 18 Jan 2022 10:38:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxooD5A0kIvNYe5f8A0rLWxL+hfWG//ldtWWszWaLLfWPoEYsl9gzRPsANc68kPgrb0WUfY1w==
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr24451497edx.233.1642531123570;
        Tue, 18 Jan 2022 10:38:43 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f5sm199260edu.38.2022.01.18.10.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:38:43 -0800 (PST)
Message-ID: <b165825c-a04f-d5bd-6bce-8725acdc461d@canonical.com>
Date:   Tue, 18 Jan 2022 19:38:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 11/16] dt-bindings: pinctrl: samsung: Add compatible
 for Tesla FSD SoC
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150056epcas5p4825077a17b8c37b0e7cea60c4dced3c8@epcas5p4.samsung.com>
 <20220118144851.69537-12-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-12-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> Add compatible for Tesla Full Self-Driving SoC. The
> pinctrl hardware IP is similar to what found on most of the
> exynos series of SoC, so this new compatible is added in

s/exynos/Exynos/

> samsung pinctrl binding.

s/samsung/Samsung/

> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

It seems that I will take my dtschema patch (together with pinctrl
driver changes) after merge window, so this will have to be rebased on
new dtschema.

Best regards,
Krzysztof
