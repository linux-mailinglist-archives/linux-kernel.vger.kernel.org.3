Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019F7492DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348234AbiARSpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:45:17 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37112
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348109AbiARSpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:45:15 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B808C40028
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642531514;
        bh=8osQ58FXOlPLsyJtfHmM/yZUY3A/YErqa44d4fjUxZo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=mmbbYsyFZhEI7i+nLccllqAmuXXlqTDBvA7kRDC7I3V2o/Zb6LDlF4SsQmzVaBACk
         DSePPeSOmSSkt/83YPQEeyi8SHBpo9qIOOzurbH0xB0LumzkifafAfEiOwsa7XtyMQ
         AUXdottNxAsQaUV0wHvnvKNSL5j79pL/Nm9CtfPnNC+AWTnM+JtZxYd5EUPPuo7ty7
         AiKRvYG/btL7Hdpx5Wx8COjU5OtrG2m7eqAkV2o5xUqkqGarB56ljXZsDDLKeO+WTJ
         UoR5edqG9WDzOIw0JIXZeFj9/bc+imY3PNL1XnTpB4Zg0j4RCxjaZMb80OPKnbeeOI
         o/i5OhI1dN0tA==
Received: by mail-ed1-f70.google.com with SMTP id ee53-20020a056402293500b004022f34edcbso7172283edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8osQ58FXOlPLsyJtfHmM/yZUY3A/YErqa44d4fjUxZo=;
        b=BMnJ+bjX29t5lGWQ0UlG5gV3lS/+G6bsikWgZLg9eDSdE6EKelLC+lH7mTTE25CAfJ
         KG9fgI0CxfOmDDiivOBYuojBGIHwrqDA/g+Dv/Mzyx/0E9pEqvg8IaI/qBLJ3DmY1kVI
         hY0LMM/v/Ps/SUXOyyGKKeH/1iIHaX+e0uVAbZIHcZuLWICA0IiYBXXbRfGyWrB872uL
         MQCUEs1SaJKiF11lWU6TYZ49HaOVyk335FP2Hoc9erpRCGYfr/DxO6xhXUPs4jA3TP4k
         mp/5X3rmKp/V7k6s2dlVHTpwTixc0OmOWxXVKPQJZB+AvCFam2IqJqFqEdrAgUEG8Ehc
         m+Uw==
X-Gm-Message-State: AOAM5307AjcQ6diV19zJigMmW/txs1hZOYIO19vNUnpwhmFBFE4ekbAD
        txxszjUE/s9tg4atMxzpL/rnZQv3UAo1NPzkU0zl4pIcWnrXxCquXXlwBLQJJyVys4YXEXPxKfO
        19awp9YnpyZeGd08rrB/Og2nhNV2mRuOvufNRCWe9JQ==
X-Received: by 2002:a05:6402:2803:: with SMTP id h3mr27373589ede.241.1642531513204;
        Tue, 18 Jan 2022 10:45:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0Sfnsmx7DF4yXoTCVe+Weay6/LhuR9yDgGS2HHh01RVl40jGVz2Nf6Gg8Nhp5upcIJt2wHg==
X-Received: by 2002:a05:6402:2803:: with SMTP id h3mr27373579ede.241.1642531513056;
        Tue, 18 Jan 2022 10:45:13 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id k16sm5671861ejk.172.2022.01.18.10.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:45:12 -0800 (PST)
Message-ID: <43e72d34-0e11-9ff6-6924-0cab62b51891@canonical.com>
Date:   Tue, 18 Jan 2022 19:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 14/16] arm64: dts: fsd: Add initial device tree support
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Arjun K V <arjun.kv@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150108epcas5p2d9cd4db7cb368c2bfbd7d058eba4107c@epcas5p2.samsung.com>
 <20220118144851.69537-15-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-15-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> Add initial device tree support for "Full Self-Driving" (FSD) SoC
> This SoC contain three clusters of four cortex-a72 CPUs and various
> peripheral IPs.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Arjun K V <arjun.kv@samsung.com>
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> Signed-off-by: Shashank Prashar <s.prashar@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  MAINTAINERS                           |   8 +
>  arch/arm64/Kconfig.platforms          |   7 +
>  arch/arm64/boot/dts/Makefile          |   1 +
>  arch/arm64/boot/dts/tesla/Makefile    |   3 +
>  arch/arm64/boot/dts/tesla/fsd-evb.dts |  39 ++
>  arch/arm64/boot/dts/tesla/fsd.dtsi    | 651 ++++++++++++++++++++++++++
>  6 files changed, 709 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/tesla/Makefile
>  create mode 100644 arch/arm64/boot/dts/tesla/fsd-evb.dts
>  create mode 100644 arch/arm64/boot/dts/tesla/fsd.dtsi
> 

I saw you dropped the MCT timer from DTSI. I wonder why?

Not very happy with FSD naming (as discussed before), but board
compatible looks reasonable. Code looks good to me:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Similarly to previous vendor-prefix patch, please let me know if it's
expected me to take it. I assume no. :)


Best regards,
Krzysztof
