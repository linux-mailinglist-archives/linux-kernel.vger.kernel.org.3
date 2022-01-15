Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C748F7E7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiAOQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:37:37 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35256
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229665AbiAOQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:37:36 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D5FC73F1C8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642264655;
        bh=yj6+HZalP4HtPojT66FrfosvNQEgUfV8RHCwny3+cII=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=GSX6tfXYqQ4EQrtE75u3r8vlCzrqbKB7vFT2XpMauUDq2t3GIaoI4m/E//COcWbs8
         N3qPu60KIaPPJGneRbIVZMaySB3oa3ZCOypFGxABWvUVBDfz+AU8lHhgEJSIgdIrl7
         1nUYI1+frIBHBxCl0mMQ1mO3VkqteRj6O9Mh3MyLPUApeOB78jJXWaeMZpvr3VFP0O
         zt/hDjzg4mTjwgWDoTfSlVCI0jGJw8hdkiTPGM4Vf8zU66P81OOGVl1ZGCzXKRhWh1
         40l9CWrKp/NQ6OtHo+JoPp8qtXX7xVAKI+Qj/a4USJsCZU6LDnynphjW9PZkChT18c
         w8MvWuGtKz8ew==
Received: by mail-wm1-f72.google.com with SMTP id 24-20020a05600c229800b0034bfa8a1531so634063wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yj6+HZalP4HtPojT66FrfosvNQEgUfV8RHCwny3+cII=;
        b=FYEE90j4Dtpt+/TxV8tO2vhLLv3hCQdTmaujfbYT0hcG6yAPRz0QVYffoUYzA+Lumk
         4JBQmlz0KV6QbGwBvjWIrR0/mvv55vAtoRNv6qNUSKpiAfu9af2L6nGvN5BvIgb3R1de
         KeKuwgXanlSvQsXMVsZ1xOPDci7dMUCpyQPrRx5eq1NbnXycMLqCwggNT/zGimZk3bEK
         eTvt4CAwU3aUjq2Dub19bnOHGvqob9rymz/IRtjsyZUs7gnA0qcmhQsBz633JBrKtafL
         YzKMhsH62i7O6+Rr2FK7VBCHyB56UgW75aTBDWhj8QdhijFZ4KRd8Xt0MSAAjCcD3ueB
         tN/w==
X-Gm-Message-State: AOAM530tQa3F+O6gAR0C1mquBGEY+9FheBiALzT7TINZelLcF5dqIpIX
        xjwobVh7odebsdZX3wfTCjHNRR043MixE1mj4YiSuseT0XWYSnVPpcC+MUlzCUlCzvs+JUgUVxI
        0HBQHwbBbbp7hWjXFw6DNq3WmUnDo7gqAlDytZF/r1g==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr13025392wmc.18.1642264655573;
        Sat, 15 Jan 2022 08:37:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLmmpo9e/3+GJkqC2GFexeIlRoX2GDOBUBnCE1ML1vmhGd4NkAg4u0iGjoNJewDmHP5vBQFQ==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr13025379wmc.18.1642264655380;
        Sat, 15 Jan 2022 08:37:35 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b13sm8767590wrh.32.2022.01.15.08.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 08:37:34 -0800 (PST)
Message-ID: <763b84a1-4cf0-505e-f678-3474058059e2@canonical.com>
Date:   Sat, 15 Jan 2022 17:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 0/3] Add initial support for exynos5420-chagallwifi
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, semen.protsenko@linaro.org,
        virag.david003@gmail.com, martin.juecker@gmail.com,
        cw00.choi@samsung.com, m.szyprowski@samsung.com,
        alim.akhtar@samsung.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220115162703.699347-1-henrik@grimler.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220115162703.699347-1-henrik@grimler.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2022 17:27, Henrik Grimler wrote:
> Samsung's tablet Galaxy Tab S 10.5" (wifi) has codename chagallwifi
> and is one of several tablets released in 2013 - 2014 based on Exynos
> 5420.  This initial devicetree adds support for accessing device over
> USB or UART, and allows using a rootfs in either the internal eMMC or
> an external sdcard.  4 out of 8 CPUs are brought up when device boots,
> which is the same as on the somewhat similar device
> exynos5420-arndale-octa.
> 
> Patch 2 is necessary after a secure-firmware node is added, otherwise
> device hangs during the CPU1BOOT secure monitor call. Without the
> secure-firmware node we are not able to bring up any secondary CPUs.
> 
> Changes since v1
> ================
> 
> Fix mmc_0 and usbdrd in patch 3: 
> * Remove extra, non supported, options from mmc_0 node 
> * Do not set usbdrd supplies. Usb networking does not work with them 
>   specified, but it works fine with dummy regulators

Re-try with supplies after fixing the regulators (my comment to v1).
These should work, unless your regulators are wrongly configured or you
used wrong supplies.

I just sent a review for v1, so please go through it.

Best regards,
Krzysztof
