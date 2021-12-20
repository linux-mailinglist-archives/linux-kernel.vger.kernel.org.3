Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F9B47B19B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhLTQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:48:57 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38122
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237112AbhLTQs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:48:56 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E0F823F1A9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640018934;
        bh=DYfa/5ectGQzZ8y3l+jSOjS0qhsMHbXVqnPyDEeUiM4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TIXx80+zy2LTFIhlQ46XTw3DOH2m8rTDF6jOFdcIE4a1R6vPaE43eDzOciKl4J2Sc
         x+mScT9KR78TrtqbTBptretqGAiuL8C6Cb2hfDzQbzy/BPFIbuk/8+Gs2Su/5ievq+
         Bj4bfpq88gS4WQYUm6J+vF4m629eP2r8bLJEa55WJgJwsgFrvUbesHDIPJHO4KgCs/
         QN+jNc4gcjvJuVooxPv6i5+z0/M3u29LgNpuZeyR8ZjlskGfvWzcjgpO6yabUF9F9X
         IHsUfDZN/1uLPQf9dSYtXFi2UHY8QOkNaSGP+ReNZiTxbs4Gao85EZe5EdAx5HxBVQ
         b4N7ihIDOYTsg==
Received: by mail-lf1-f72.google.com with SMTP id m1-20020ac24281000000b004162863a2fcso4760938lfh.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DYfa/5ectGQzZ8y3l+jSOjS0qhsMHbXVqnPyDEeUiM4=;
        b=CNlRJvji4lYjY4GyBQe/ZrQszSiCRqTTwJSLWgmIPxqR9IxAZdxsK4Xh1qdFRNIrhH
         7zci2SenyB3jV2KZlYrA3A1SVc+sbTry41lLmcjnHbFmgG2IwlWh/Bn73mAyROaBAOE1
         B0Vk+cZ28uuOnGKF596Krr4jHRaLuOrNtvAk2QQF4JJa4eraqGPervHbUEzl7AL33kiI
         pR1vPr9o3C8xD0yU4Ju7hkJ9SHt25wnHM5hX0QVBLsOx0umZjAKehxYcgWdyuumyi4Jd
         bvxxf/RkEcYs0TfZft4Mn5c/OlCA/V6VHnwCmrcKmRE2YTBa7ozj7kovGeO8Fp8Qn1rN
         WN1w==
X-Gm-Message-State: AOAM531urv+MvspHIs8n+sjLCsVuGU+3zZ3z6CvIU+McqWwNq+TVHm08
        bdqcU5nsqlHCJwEp1SSiCA3kEjE6ItLGg/tcTxTCZKx24uYK33P+OiIcTFQPigjDa5XNilNOw7A
        WokVc9RrN7wdsjRAlcATWe1T2Qr3vtCl0yonu+Ul6CQ==
X-Received: by 2002:ac2:48ae:: with SMTP id u14mr17041107lfg.610.1640018934342;
        Mon, 20 Dec 2021 08:48:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8yqg4GqMCAMMT7Glf5y+TjFZrXMjASbZ479SQVeZWWxSO+eS7MRPqHEL0i+Cg7sbAuuZLPQ==
X-Received: by 2002:ac2:48ae:: with SMTP id u14mr17041093lfg.610.1640018934138;
        Mon, 20 Dec 2021 08:48:54 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id j10sm548950lfp.286.2021.12.20.08.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 08:48:53 -0800 (PST)
Message-ID: <81b39068-a06f-a4c9-bca7-6fb296d4b05d@canonical.com>
Date:   Mon, 20 Dec 2021 17:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [GIT PULL 1/6] samsung: soc: drivers: for v5.17
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20211220115405.30434-1-krzysztof.kozlowski@canonical.com>
 <20211220115405.30434-2-krzysztof.kozlowski@canonical.com>
 <CAK8P3a1A+6f1OsJ-8-8kbmXXbbsrQZTQywOAy59tJoUmdDN49g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAK8P3a1A+6f1OsJ-8-8kbmXXbbsrQZTQywOAy59tJoUmdDN49g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2021 17:26, Arnd Bergmann wrote:
> On Mon, Dec 20, 2021 at 12:54 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>> ----------------------------------------------------------------
>> Samsung SoC drivers changes for v5.17
>>
>> 1. Exynos ChipID: add Exynos7885 support.
>> 2. Exynos PMU: add Exynos850 support.
>> 3. Minor bindings cleanup.
>> 4. Add Exynos USIv2 (Universal Serial Interface) driver. The USI block is
>>    a shared IP block between I2C, UART/serial and SPI. Basically one has
>>    to choose which feature the USI block will support and later the
>>    regular I2C/serial/SPI driver will bind and work.
>>    This merges also one commit with dt-binding headers from my dts64
>>    pull request.
>>
>>    Together with a future serial driver change, this will break the ABI.
>>
>>    Affected: Serial on ExynosAutov9 SADK and out-of-tree ExynosAutov9 boards
>>
>>    Why: To properly and efficiently support the USI with new hierarchy
>>    of USI-{serial,SPI,I2C} devicetree nodes.
>>
>>    Rationale:
>>    Recently added serial and USI support was short-sighted and did not
>>    allow to smooth support of other features (SPI and I2C). Adding
>>    support for USI-SPI and USI-I2C would effect in code duplication.
>>    Adding support for different USI versions (currently supported is
>>    USIv2 but support for v1 is planned) would cause even more code
>>    duplication and create a solution difficult to maintain.
>>    Since USI-serial and ExynosAutov9 have been added recently, are
>>    considered fresh development features and there are no supported
>>    products using them, the code/solution is being refactored in
>>    non-backwards compatible way.  The compatibility is not broken yet.
>>    It will be when serial driver changes are accepted.
>>    The ABI break was discussed with only known users of ExynosAutov9 and
>>    received their permission.
> 
> Thanks a lot for the detailed description, very helpful!
> 
> I've applied pull requests 1 through 4, though it seems that once more
> the automated emails did not go out.
> 
> I can't find the two defconfig patches you mentioned in the introductory
> mail, neither in patchwork nor in my inbox, I assume these were
> numbered 5/6 and 6/6?
> 

Yes, these were patches 5/6 and 6/6 but maybe I made mistakes in address
list. Let me resend them now.


Best regards,
Krzysztof
