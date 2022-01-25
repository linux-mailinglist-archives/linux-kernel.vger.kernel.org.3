Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5292749BA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587318AbiAYRTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:19:31 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55146
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231483AbiAYRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:15:33 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C95073F1E6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130724;
        bh=cRuWMxrPXr7Db37oGINTnI2Imc+mdGIhRauTmNnjcco=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=oi9HT76hgwgTZmqgO5+70sfRhubYBtLTfY8aDwFP9tLpxnEEef7gPfvvGwFekbCmv
         rejQa6MOfJHq1ingAyglF/IOStrwF/ekZqmycHoh58yNdBObHL7QYZbohnShEy3pfC
         uwX8RMhsIpK5TSbRuxpAAsSMV4e7jFMxYdORQZxK9bZ35oQyaabGijysLydqYl5rtQ
         i1Es5BsMzz2K5Qn6KNF7i9R9k92/UYwpUP2jDqZTJ1rDIRiuqaps2FBYLtamxyk9nb
         61yylDGTwnvM5H78jv0UeI3AEj+dFEJSS1DdOH/PMOCbwDJnd7SRbN9bR3RrOld3gf
         4kCRD2TF6E2Nw==
Received: by mail-wm1-f71.google.com with SMTP id a3-20020a05600c348300b0034a0dfc86aaso1435396wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cRuWMxrPXr7Db37oGINTnI2Imc+mdGIhRauTmNnjcco=;
        b=o6X97iXsFJuETLRShW5ekxOW0MZbfiXFbxN2Js8T2oPqqieAztbI7x7dD1k4mngfS+
         CYnAP1vG57UxUpilRNPcrVTbXOVMNspS+VMTn7Mh+rvCOcWNyBUo0T4lhbef58sj3T0E
         YwfJ7gCXKzmMAX1EkNBWGLxy2XXOJ6J1yda6BpS0k7YnFH/QH4LDQhnvvx3VJOhfn1Qt
         A432Advj675emaZiSzQx9JqMk1EJUCKpnrU/bRpl5iQwduzJSJBbSNm88dUAOpBJtlvg
         EVd8R5e3dh6jl72N+FzffjribmYVmqohrNbTjFBTyRrCs1rZUAzQz5fjI/DPTWe79KWY
         TMoQ==
X-Gm-Message-State: AOAM533xTgnXmRUaxCjyzg+J/7XqYsypBjktLO1cBXPIbxiov1D30FaJ
        vfo3D+jA+XA14ZpYpASYS5wqYEwNfXR0a5pqAKJSR5L2qAjDAWh39jClIq2z9NKQjnLtbzBoHdM
        dTmoTr2Ge4hrIZunrY2TR7ONXPGtcxETfQwYR4r52KQ==
X-Received: by 2002:a5d:59ac:: with SMTP id p12mr1764868wrr.437.1643130724393;
        Tue, 25 Jan 2022 09:12:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyn63lsxsGyIy8w2Zle5UfHDf5Cg31gXP3K6sfp7qWzheNoBd+PgghdMtFEcamrKebOUlq3QQ==
X-Received: by 2002:a5d:59ac:: with SMTP id p12mr1764836wrr.437.1643130724154;
        Tue, 25 Jan 2022 09:12:04 -0800 (PST)
Received: from [192.168.0.59] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id u3sm7390429wrs.55.2022.01.25.09.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 09:12:03 -0800 (PST)
Message-ID: <d9682f16-13b7-b6dc-5afd-b2d319143de5@canonical.com>
Date:   Tue, 25 Jan 2022 18:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 00/16] Add support for Tesla Full Self-Driving (FSD)
 SoC
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        sboyd@kernel.org
References: <CGME20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b@epcas5p2.samsung.com>
 <20220124141644.71052-1-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2022 15:16, Alim Akhtar wrote:
> Adds basic support for the Tesla Full Self-Driving (FSD)
> SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
> as well as several IPs.
> 
> Patches 1 to 9 provide support for the clock controller
> (which is designed similarly to Exynos SoCs).
> 
> The remaining changes provide pinmux support, initial device tree support.
> 
> - Changes since v4
> * fixed 'make dtbs_check' warnings on patch 14/16
> 
> - Changes since v3
> * Addressed Stefen's review comments on patch 14/16
> * Fixed kernel test robot warning on patch 04/16
> * rebsaed this series on Krzysztof's pinmux new binding schema work [1]
> 
> - Changes since v2
> * Addressed Krzysztof's and Stephen's review comments
> * Added Reviewed-by and Acked-by tags
> * Rebased on next-20220120
> 
> - Changes since v1
> * fixed make dt_binding_check error as pointed by Rob
> * Addressed Krzysztof's and Rob's review comments
> * Added Reviewed-by and Acked-by tags
> * Dropped SPI, MCT and ADC from this series (to be posted in small sets)
> 
> NOTE: These patches are based on Krzysztof's pinmux for-next branch
> commit 832ae134ccc1 ("pinctrl: samsung: add support for Exynos850 and ExynosAutov9 wake-ups") 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git/log/?h=for-next
> 
> 

Thanks, applied DTS/soc and pinctrl patches.

I expect Sylwester will pick up the clock ones. Otherwise please let me
know to pick it up as well.


Best regards,
Krzysztof
