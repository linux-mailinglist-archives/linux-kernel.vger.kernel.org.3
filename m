Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F42049F496
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346948AbiA1Hqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:46:37 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36424
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346935AbiA1Hqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:46:36 -0500
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C4B434000F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643355989;
        bh=ixfHGk4E4QKK3EIDf5++FWfRVMfvES+jMYa7lfsYCcU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jdh3OavQsdy/rdS7Z5NhMrLL6er/DwpvR5MQwT55N3kSEclzhRnV3lsImUmpHK/o5
         HKdwobwIPCSZSaDyMWXvn5D2o7+xfrhnbvD2rAHyYcu5PA3SZB9G9H4I+as+B98LQZ
         r+QUD7atnmgX5fiNRgW/yoGoLuzrxAxgZN5R315KZpvxK/HGagOJbdusgORoseuX/g
         ChymHQZORdrIGhR+8t59jE6hH91zFog41s5eZaGWAGtiQm+yFpEiil4RRn/71Bmyzg
         EnuXa6kKtwvczt7XCeLda0/en59sBFTKiwFydyoUKsfjFb7TmboETI334t7XMsj1Qd
         v3ISXRHQDfh2w==
Received: by mail-ej1-f70.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso2474698ejc.21
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ixfHGk4E4QKK3EIDf5++FWfRVMfvES+jMYa7lfsYCcU=;
        b=O51awcTVJ0BXWuzrodzYnqrUiwO5iNJDFfqMRcUa+6ZiRMWIu7keQwxPiOeQEi2n2F
         ovsbPTPieg2J7amM0eNdGbWMbHrrvoK9j5Y/WRisYx7xkxAqojH36bqn0Ilx5D0czEY3
         tcJKUPq2AIt8bnGOwsQQ34L2PuPP4DAYF7WfHiEougn9LkEYhhp3t4G1WBwGkJON4nwn
         vAcZ/vw+DLZh2Xv6/AV9831htirxtZXFK6msASzB3xjJ3m/p4P/dl7rEj0W7MMYvcfOg
         tRQZeQL6jt0ORhsPvW/SnpOnTtDqf+YQ3BukZtiSMHUp5zVGoFXKzxykQWgFY/F7zG7W
         e2wA==
X-Gm-Message-State: AOAM532Kg8CBfoheQIAaUVuWDEg+PIypGjFExV28C8P5xYb6jQ+CM5cw
        PycryFLNn6hP8/SUb2UrhEkWAqg1Zae+REtf9lqF1euPrF5e4TYSnIeyg2TkV8G0n2dgck5cgG8
        3x6aJaMy4tNnF988X/fO5nOoT4f8l48H8X4bluKdnHQ==
X-Received: by 2002:a17:907:7f11:: with SMTP id qf17mr6000011ejc.110.1643355989017;
        Thu, 27 Jan 2022 23:46:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBKI3OdYNKL+iVn4dBMF0bjplRUObl9/kuR8cSaSq0LTJZulgFr07pEI+pSgjh16oRKSaAxA==
X-Received: by 2002:a17:907:7f11:: with SMTP id qf17mr5999989ejc.110.1643355988795;
        Thu, 27 Jan 2022 23:46:28 -0800 (PST)
Received: from [192.168.0.65] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id mh20sm9629812ejb.175.2022.01.27.23.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 23:46:28 -0800 (PST)
Message-ID: <51ce758d-b96d-c9b1-b439-e97cc59d1052@canonical.com>
Date:   Fri, 28 Jan 2022 08:46:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
 <cb11d2e0-dd03-9a48-74f3-0a22f49f16b5@canonical.com>
 <CAPLW+4=Hj-vamn5EoV-SmB5JwEbuik9hF2XuhB+tU11GwXPQdg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAPLW+4=Hj-vamn5EoV-SmB5JwEbuik9hF2XuhB+tU11GwXPQdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 17:58, Sam Protsenko wrote:
> On Thu, 27 Jan 2022 at 11:33, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 27/12/2021 12:29, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> Second pull with DTS for ARM64, on top of previous pull.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>>> The following changes since commit 51b1a5729469cef57a3c97aa014aa6e1d2b8d864:
>>>
>>>   dt-bindings: pinctrl: samsung: Add pin drive definitions for Exynos850 (2021-12-20 10:35:32 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.17-2
>>>
>>> for you to fetch changes up to a1828d772e0738c30a383a7d335aded2f2baf908:
>>>
>>>   arm64: dts: exynos: Add initial E850-96 board support (2021-12-22 12:31:13 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Samsung DTS ARM64 changes for v5.17, part two
>>>
>>> Add initial Exynos850 support and WinLink E850-96 board using it.
>>>
>>> ----------------------------------------------------------------
>>> Sam Protsenko (2):
>>>       arm64: dts: exynos: Add initial Exynos850 SoC support
>>>       arm64: dts: exynos: Add initial E850-96 board support
>>>
>>
>> I'll send all this as v5.18 material, so this pull-req can be skipped.
>>
> 
> Krzysztof,
> 
> As clock changes are merged in mainline now, do you want me to re-send
> those two dts patches using corresponding clock constants, instead of
> hard-coded numbers?

Yes, please.

Best regards,
Krzysztof
