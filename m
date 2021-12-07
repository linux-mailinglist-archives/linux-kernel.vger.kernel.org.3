Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E3E46B723
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhLGJgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:36:14 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60080
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233719AbhLGJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:36:12 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5677B3F1C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638869561;
        bh=T6+9s82eszvtvdECt4LjIhYDKx4D2t9XfbY0joue/Fo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Jm/Hyhx5pGgs/QGzfTB/OsnrNBMqsQU9++qLk3/KoWnoQ4UHRZLulY0Mk3AiPqjmq
         smFLibq2s9roLJVdkjNgDZ4eYO2c9YFNdfCMrO7YRZUBtr0ZIu/mledv+VMGjtwGsy
         fGlNzPB/2wK6CoW8CJKxwvp3yGROf0c4VWEfjoWuZ2OJxzL7lTuBtnCchc06T8Md+2
         0eHrN5jH+dNzzVDyxGP6RoJPIhNOjmv2oCrtw4WTa3Qg1nj6gei2ttffpOKJlcPFQ7
         1a0gxN1vu9U4dVYCXQQXdW39961opiE42Xw901EkT5iuixKg4Y26RGOhXOOvbrrr4H
         fPIytuhbIPv+w==
Received: by mail-lf1-f69.google.com with SMTP id m2-20020a056512014200b0041042b64791so5109313lfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 01:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T6+9s82eszvtvdECt4LjIhYDKx4D2t9XfbY0joue/Fo=;
        b=ZltaoXiUXLp7/zGUao7wMh6naM8ho7QO6C9mIvDhdL/i3QFVTOjH6Yd+XxsFCBp3RN
         pj8h0IhjRE8SgefDzEGDO32sIN8SNUhNai5zrCR4meD5NqfvAgOnh2tyaOnzpAYjx/eM
         4+yVQiUfiiTUVAckR6apuVzZJaASsgRveEh0I2hGnOa3l7zBP9V81g5/PFls++10MArE
         /i9tPkQVbG1x5v5NCnU06mz6ZljnJYDQ3I00DId6WZ2l3N14DQS452XExlCetzI2kVrQ
         PNYAVLtWwaow9/IErYdIKzlojnkSm7Q5vz4ZT2IVFxgJwhZ0gJynJB3oghb8CExrVkLG
         5rQw==
X-Gm-Message-State: AOAM533hA5RSVAHp1zQFxNzaRP9eSi5zGh5QUeAfeoubFeTXxSpJkMRc
        ZRRnpAduDe8dKB/wQH+bn9ThjA4RdkK5IPcAVZK/YKhXmTY/xSkJWh4qL49stVGJOB6zHdFQ+p2
        9/ICA5SVhgUG9pfj4W1S7pZkI4tWLTwWlnlGWK/JETA==
X-Received: by 2002:a2e:994a:: with SMTP id r10mr41066360ljj.301.1638869560696;
        Tue, 07 Dec 2021 01:32:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKyBwQ35QuPUmJsbOyAfvODA2PllK81Af6yVKERMwFTiAYBejXq04Tp3ARzZKlv7wtY5zCdQ==
X-Received: by 2002:a2e:994a:: with SMTP id r10mr41066327ljj.301.1638869560444;
        Tue, 07 Dec 2021 01:32:40 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l5sm1553374ljh.66.2021.12.07.01.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:32:39 -0800 (PST)
Message-ID: <f2f2a084-9362-db44-27e9-19b54d350775@canonical.com>
Date:   Tue, 7 Dec 2021 10:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 4/7] clk: samsung: Make exynos850_register_cmu shared
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-5-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211206153124.427102-5-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 16:31, David Virag wrote:
> Rename exynos850_register_cmu to exynos_arm64_register_cmu and move it
> to a new file called "clk-exynos-arm64.c".
> 
> This should have no functional changes, but it will allow this code to
> be shared between other arm64 Exynos SoCs, like the Exynos7885 and
> possibly ExynosAuto V9.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - New patch
> 
> Changes in v3:
>   - Fix SPDX comment style in clk-exynos-arm64.h
> 
> Changes in v4:
>   - Fix missing headers but still remove of_address.h
>   - "__SAMSUNG_CLK_ARM64_H" -> "__CLK_EXYNOS_ARM64_H" in
>     clk-exynos-arm64.h everywhere (only the comment at the end had the
>     latter by accident)
> 
>  drivers/clk/samsung/Makefile           |  1 +
>  drivers/clk/samsung/clk-exynos-arm64.c | 94 ++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-exynos-arm64.h | 20 ++++++
>  drivers/clk/samsung/clk-exynos850.c    | 88 ++----------------------
>  4 files changed, 119 insertions(+), 84 deletions(-)
>  create mode 100644 drivers/clk/samsung/clk-exynos-arm64.c
>  create mode 100644 drivers/clk/samsung/clk-exynos-arm64.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
