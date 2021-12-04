Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8228D468472
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377344AbhLDL01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:26:27 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42242
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354802AbhLDL00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:26:26 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8051B3F1F0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 11:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638616978;
        bh=VWrgPdQvcehxcTv/NTpHcumL9ZsfNr4LJN61gCWR58c=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YuNyNiuQ3L/IiHQ7Q8vRWjZtKM1fd9bQ5fXsMmmls5iTTzo0l+HfZOPfmMA2gZR26
         3nMOj1JoRpgvwRtA7OkdEAl6U6L+YeSrZa/CCqXbq7wvEKKl7znYtvKui07LFk79au
         MkkJmWyN5DYMdkNPMBEHjb4Ok5ICzzlPNPNH7FErKqwgxSWwBGxDaK8i45ZxwjGVbl
         7Sn6iU+c79SiGZMsmg3vANHfjIjrLeYy7pw73WjqD5BGCLD6diO3BFUJ4nyj0joZIP
         ih7/RnN19me5s+YNF+fA8ylKMAF1vZci2KQvtW2OeoQDVslHkhLEUTJebOaBhnY0eX
         qf04TQrRDhGcg==
Received: by mail-lj1-f200.google.com with SMTP id u28-20020a2ea17c000000b0021126b5cca2so2112690ljl.19
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 03:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VWrgPdQvcehxcTv/NTpHcumL9ZsfNr4LJN61gCWR58c=;
        b=hqS/Hl6bj13bLQisvyx6UJec1qTQXZcg155fXZMyqTjhh7MRs8hAdGk8typEtY+qs1
         ySVa2FCCUzXb2u5RyJVVkcEE6YKtAgX9apOyFvaaJ0sEu8SmB8CuIV7uH9gFYqBAZudw
         JZbcE5jJ+xJ95PlUwjLSHJxbCVJ/LKRTXFE6psX0AFsNzGNszEQVw0vrfyVPmBb5Kybg
         xE2/bubyH8Rg+NaLOBeNwljTpPFr9/IjOcVposFMBjN3JBUUiMBVNJcl74raZQlKjYBO
         BDx0RrwuxtW7y8Rr/ToWsnBLNqGI8ya8XllkDQWWyjRg9BTa/yL7G4zXT1cmE8iH+DmL
         6mYA==
X-Gm-Message-State: AOAM533yBTgRL8YNIuxPTrRGJxLdoT7H6wWadqTggALJSU2TuR6k92HY
        6FrChlE2r3fi1sY2K0tnE5NLdiBx9FUt8AF5d5puAYL4c6SKkUSilmIrCVB8PgKvMCwIsz2KzJF
        rd6J+yP7AARzrakgf+E1KVvjilV6nI3KTJiuDqwXLlQ==
X-Received: by 2002:a05:6512:11c5:: with SMTP id h5mr23522440lfr.431.1638616977755;
        Sat, 04 Dec 2021 03:22:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJze2o9ZJ1AQBAsY7I2NINj1v4O5RSoJKKQqolS4JwELuRVFLJalwqvb2oNZ+ZlVRDVHdcFmuw==
X-Received: by 2002:a05:6512:11c5:: with SMTP id h5mr23522413lfr.431.1638616977476;
        Sat, 04 Dec 2021 03:22:57 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id k22sm731492lfu.95.2021.12.04.03.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 03:22:56 -0800 (PST)
Message-ID: <f8f9fab1-cea2-ebc6-6870-4929edfaef77@canonical.com>
Date:   Sat, 4 Dec 2021 12:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 RESEND 3/5] tty: serial: samsung: Remove USI
 initialization
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chanho Park <chanho61.park@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-4-semen.protsenko@linaro.org>
 <CAHp75Vd8PFhs8_Ji5x1X2Ph5ey+8JrRuneWCrG=5a+52Lh-ptQ@mail.gmail.com>
 <CAPLW+4mEw0x_rZ19h+rbz4qm=6OVgQvvbEJWL0wWQguMiWB7-g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAPLW+4mEw0x_rZ19h+rbz4qm=6OVgQvvbEJWL0wWQguMiWB7-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2021 17:22, Sam Protsenko wrote:
> On Wed, 1 Dec 2021 at 12:54, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> On Wed, Dec 1, 2021 at 12:42 AM Sam Protsenko
>> <semen.protsenko@linaro.org> wrote:
>>>
>>> USI control is now extracted to dedicated USI driver. Remove USI related
>>
>> the dedicated
>>
>>> code from serial driver to avoid conflicts and code duplication.
>>
>> Would it break run-time bisectability?
>> If so, why is it not a problem?
>>
> 
> It shouldn't. This patch is [3/5], and USI driver (which takes the
> control over the USI registers) is [2/5]. As for Device Tree, the only
> platform using "samsung,exynos850-uart" right now is Exynos Auto V9
> SADK (serial node is declared in exynosautov9.dtsi). I don't have
> Exynos Auto V9 datasheet, so I can't really add the USI node properly
> there, nor I can test that. I guess it should be done separately from
> this patch series.
> 
> Chanho, Krzysztof:
> 
> Guys, what are your thoughts on this? Basically with this patch series
> applied, Exynos Auto V9 serial might become not functional. New USI
> node should be added for UART case in Exynos Auto V9 dtsi (providing
> correct sysreg, SW_CONF offset, clocks, etc), and serial node should
> be encapsulated inside of that USI node. Also, USI node should be
> referenced and enabled in SADK dts, providing also "clkreq-on"
> property. More details can be found in [PATCH 1/5]. Do you think it's
> ok to take this series as is, and add that later? Because otherwise we
> might need to collaborate to add that Exynos Auto V9 enablement into
> this patch series, which might take more time...

The patch in current state will probably break Exynos Auto v9 boards,
including the in-tree one, unless bootloader sets the USI to serial. The
trouble is that. Changing the Exynos Auto v9 DTSI in these series would
solve it only partially, because the kernel still won't be bisectable.

Breaking Auto v9 serial within a kernel is okay for me, because the
board was added recently, I don't expect products using it and it is
still development phase. This of course assuming that it's users agree,
so the question is to Chanho and other folks.

Best regards,
Krzysztof
