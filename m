Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD6492D36
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347962AbiARSYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:24:17 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42914
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244482AbiARSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:24:16 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A13DA3F313
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642530255;
        bh=mLcBql6ry0uXjx6vo+gnKoiWq+07y5Vfuzwy6oiJwJQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=T1+tO+WzYP/hN3IfHh0xrxU+2xOYeJ8ECvPIHhA3y6uijtmsk7tY2O6AEvKD90q35
         7tEYTbmP3NvsQDp+T1LsL9xZWySVty9n95pUYagwn9hcBTsx+5ncw4p0QQ6bt24vd1
         W5/NTcyByVE+dHR5b3zTaREinoUZN9KwaAYkBeEJQOnfiFh+ZTzRFMuypcDv1ZrEia
         xFF8ipGqPQAGeLiOvfMGYmhWHr/9bFu7wPwLHWqSAsSjXZWUjD5uOEcjfcyKJ02+wD
         bA+OyfPRnn6KPrU34hCJghOgFl312wneUS8R0osd803fBB7zGO+1VxrN8kUxdrXk7n
         5TwHoVqBjvWcg==
Received: by mail-ed1-f72.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so17835609edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mLcBql6ry0uXjx6vo+gnKoiWq+07y5Vfuzwy6oiJwJQ=;
        b=cAmCax4f+8qFYIAQJ1G0QX8MePmYmM418uZKVhFf+ugcf1kvw8/k18Jk9VJdi5M3zM
         pHayXZyEDkIKzP8tSww3hPQ2wSpjDyfrlN8L3ClIbwBM4kgMnJ3qFrR1bEe2YMLLgiBo
         9u3Ih12n0FQDosuJGIcoKOZ3AveKpXuZpp4khaUuhEgqwd0YRsT6cMcz+d6XL5uKA17h
         5nmhPr/hwQusfsKBDHJN1lpjp8yqCvDyF7VEslyY/4fjSTjKVE2UhvSEw6J2xPi0/ybn
         GYs9YM1Lpb/HU5nY5l6IIss4o6sffOeAsxtmK3Ne3lNHzg04kwklB4p0Ok4T7/ysaX5N
         7UDw==
X-Gm-Message-State: AOAM532HeU+OjWOSNX3k3pZWdDtsGEcbOGhiXEPEjxVWHInLJboHeX2Y
        bU/oFs+LUxGdIJX5sI6y8qyhNWj6JJ8vPNnBmErmTw1hPXnkKzAlyhF9CzpqgJTshFuIazlzJwi
        2tlbxIueAzUy3ztgR2ci3n0N+n49kCADnuW1SZp+0Gw==
X-Received: by 2002:a50:fe90:: with SMTP id d16mr26971835edt.361.1642530252980;
        Tue, 18 Jan 2022 10:24:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztrE0/iDUvJZuDQ5B9d9jHRgMofzZ3cOcTTHrRpyH4UXtBTQXBgCc7/qL6dnTKZQKwt/9lDg==
X-Received: by 2002:a50:fe90:: with SMTP id d16mr26971820edt.361.1642530252835;
        Tue, 18 Jan 2022 10:24:12 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b2sm191457edv.37.2022.01.18.10.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:24:11 -0800 (PST)
Message-ID: <735d1001-abcb-67d1-75a6-17db11cdec40@canonical.com>
Date:   Tue, 18 Jan 2022 19:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 03/16] dt-bindings: clock: Document FSD CMU bindings
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
 <CGME20220118150022epcas5p21912423606220552a78c7e22e4133a05@epcas5p2.samsung.com>
 <20220118144851.69537-4-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-4-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> Add dt-schema documentation for Tesla FSD SoC clock controller.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  .../bindings/clock/tesla,fsd-clock.yaml       | 198 ++++++++++++++++++
>  1 file changed, 198 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
> new file mode 100644
> index 000000000000..dc808e2f8327
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
> @@ -0,0 +1,198 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/tesla,fsd-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tesla FSD (Full Self-Driving) SoC clock controller
> +
> +maintainers:
> +  - Alim Akhtar <alim.akhtar@samsung.com>
> +  - linux-fsd@tesla.com
> +
> +description: |
> +  FSD clock controller consist of several clock management unit
> +  (CMU), which generates clocks for various inteernal SoC blocks.
> +  The root clock comes from external OSC clock (24 MHz).
> +
> +  All available clocks are defined as preprocessor macros in
> +  'dt-bindings/clock/fsd-clk.h' header.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - tesla,fsd-clock-cmu
> +      - tesla,fsd-clock-imem
> +      - tesla,fsd-clock-peric
> +      - tesla,fsd-clock-fsys0
> +      - tesla,fsd-clock-fsys1
> +      - tesla,fsd-clock-mfc
> +      - tesla,fsd-clock-cam_csi
> +

I am not particularly happy about FSD naming (so SoC name, sub-arch
name), but Olof was fine with it, so I won't oppose. Bindings look ok.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
