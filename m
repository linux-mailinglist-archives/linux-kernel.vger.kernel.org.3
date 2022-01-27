Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDBF49DE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiA0Jdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:33:46 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45600
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238660AbiA0Jdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:33:37 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 04BA03F1B3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643276015;
        bh=ab1luuZzn+rKwB0G/H73SwnYANJP++VOjHTq7jQ19wY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=j7X4ELq6R73cQTTV+KhiFFg2KIZeMEhRVhWV5UEu5HtqS4+LmdhKNFy9nLzf/3vfP
         O2A2BVqIuhn8wDJFtcDZsqIqCwjaR7uqtYgogJAUxZw28wnSMV8a/rHc1yJgTCAI/c
         wx3C26T6ypR51MSUnwdpNE+qVUqa9Gat2m7tWr5EFhwHyjVZIPdCx921nKh3AkPslY
         mM0DaQ48EvEEUNIvF3eVtW3PLElJ0rD0SeFVbp7cM7KKIkpv0lRETh+EYxzBdyELh7
         3dsIEh3sHYnoXDwhLkd1+AJ6OG5iyx1Tb4+ShWYTJK+bC0VkPPOJoFBTU1tKV2vZw0
         7BiHQnS+0QB8A==
Received: by mail-wm1-f69.google.com with SMTP id o194-20020a1ca5cb000000b00350b177fb22so3148995wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ab1luuZzn+rKwB0G/H73SwnYANJP++VOjHTq7jQ19wY=;
        b=GrXZYcSQFgHGRl/Q9QjIE+YPdbuubzVa2iR5crEiAgjgjAvx4BBbgwIxzGZu+ORhBt
         VEqOeh61IGJjvrhWA2aqSrAIiWp7hyZrMYTq1Tw1zF8Fk71WRmCLACyxqncT4955WutX
         mnHZ2KsFGTUceQzA/I7lGzEOpnMtD5PEUKne4ynksIl0+Gu2Z1J+fTcJAzV4YZWYMht/
         mljjHFB9SAwkYhSQEnx7Q+ECT9o748ESAg+weZ7SAXb9q6bVSlOTnvpxmeL9klJocTkt
         olzEwFzl/AHk6ChQb2+MnU/MU+xm7o2X0rsUTxusXErAmwgxfFbBjH/mBkkQNHAqzZKf
         OXJg==
X-Gm-Message-State: AOAM531mQM8Omoco2DtsGRloL3pjqfItAGZqLYxjhDBFjJGT0XyZ+kbw
        peFZdqyRYcFF3RJhEfRmcLUPOJ6L3h85WNTIsohnnu8nd702bCTJiMxJdKkD3jYmt7z7Ew7SOlx
        ed4X9H3o9glKkQkS3R3a+F6iG2daNAZrOWysj1MooVg==
X-Received: by 2002:a5d:6dac:: with SMTP id u12mr2301429wrs.410.1643276014737;
        Thu, 27 Jan 2022 01:33:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwackDtjcmH0YUiJyk7XzFedBt6pMCl5S0pLhlnvxCHhFBKHp3Es5kkgM0yYe1bv2SYad+4QQ==
X-Received: by 2002:a5d:6dac:: with SMTP id u12mr2301414wrs.410.1643276014525;
        Thu, 27 Jan 2022 01:33:34 -0800 (PST)
Received: from [192.168.0.63] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p7sm1533601wmq.20.2022.01.27.01.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 01:33:34 -0800 (PST)
Message-ID: <cb11d2e0-dd03-9a48-74f3-0a22f49f16b5@canonical.com>
Date:   Thu, 27 Jan 2022 10:33:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2021 12:29, Krzysztof Kozlowski wrote:
> Hi,
> 
> Second pull with DTS for ARM64, on top of previous pull.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 51b1a5729469cef57a3c97aa014aa6e1d2b8d864:
> 
>   dt-bindings: pinctrl: samsung: Add pin drive definitions for Exynos850 (2021-12-20 10:35:32 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.17-2
> 
> for you to fetch changes up to a1828d772e0738c30a383a7d335aded2f2baf908:
> 
>   arm64: dts: exynos: Add initial E850-96 board support (2021-12-22 12:31:13 +0100)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM64 changes for v5.17, part two
> 
> Add initial Exynos850 support and WinLink E850-96 board using it.
> 
> ----------------------------------------------------------------
> Sam Protsenko (2):
>       arm64: dts: exynos: Add initial Exynos850 SoC support
>       arm64: dts: exynos: Add initial E850-96 board support
> 

I'll send all this as v5.18 material, so this pull-req can be skipped.


Best regards,
Krzysztof
