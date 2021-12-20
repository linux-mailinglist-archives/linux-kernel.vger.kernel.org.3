Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D17347A712
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhLTJbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:31:42 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59302
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229575AbhLTJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:31:40 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B9CED3F207
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639992698;
        bh=q7I5LUCu0tEwQU8mlJ01Zkswbw7h7CV+lz20uT47oA0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Ng1l1eIritaiNWM0hFMVK7QICsmgRUs2q1QqNrul9KMoMONrspnBU2h12FnNVJJy2
         c+mzWAocGLskq3DAaYdSUMw39JejHBXCIaegQJBvEBU3jYBOayZy7V8G44o3SodcJb
         jrz5Zng1Dy6NIgk38cjbq2gX6dt/GvCOpKlSc97hVTXytGGKtmu8x2KV4NIHi2CPqM
         WHWPYX5e9JunAzXtISzebwOYuN9SKpkZCkEXXxwiZUvkEDnn05v3shZmeu2r+zdrBh
         A5yjmkxFSlZtZBEdbMv5+BgmhlTx360cftJhqm80JymCIRQmu9INP9EQZrpqx73iit
         cH2oekmxGcVPQ==
Received: by mail-lf1-f72.google.com with SMTP id z23-20020a0565120c1700b004258a35caf2so2575128lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q7I5LUCu0tEwQU8mlJ01Zkswbw7h7CV+lz20uT47oA0=;
        b=Z3JJcOH4vD3LYUPYGE3aICYBdyrmLmkBGOkwY9rV8EWyXkRowNs6Z99CAlJwwYd6nq
         dSflSWVelHzuZhqrJTqxcC3jfnGtCeV7Tzvw8dtAgsovymQMM7x7W+UqK4Q8KhSbZD0O
         mSxQ20APpcQvMzNJ+8EGR+EvppsaG3YjsiITJtxijhFmUPB1sLVLkKv835DnMvEE9szq
         9WBqezNJ5iDPn6NyWR3Gly8uvQ89J5qaF7j3GB0WLvo5n9TmAl9fm7pNXNhC/YBI+c/f
         Ghuoxl6WfhWInAeKl3+BFAuM7mppWeK+R7D329BXdqWT23GVAtb1RaogSkcF2xobX3oK
         7bGA==
X-Gm-Message-State: AOAM530mv26P+pavB8lf02vSlCpiw64NtcDy5w2MVE+CAifMou7dKufF
        w2ZDHbyySP29sCo0hMpfu9IGX4AoIIUF6fbEkgebAgFTM5dxdVyL9ZhYMGnuW6qga2MQoRp8cmX
        MwmHEKPIyE1YSk2913/BHK6yGx5efGICCSwMzhfiRzQ==
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr14038817ljp.249.1639992696181;
        Mon, 20 Dec 2021 01:31:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgVVgGiKkGKbx4ide5sjyVaqJ3UmUjO0Zkflx9HK1jDuh36xwydUtGqYdkrGBefX8MPBCelg==
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr14038784ljp.249.1639992695825;
        Mon, 20 Dec 2021 01:31:35 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id j19sm2466716lji.94.2021.12.20.01.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 01:31:34 -0800 (PST)
Message-ID: <5bd5c0bf-4390-22c2-e4e0-cb02b80dfb9c@canonical.com>
Date:   Mon, 20 Dec 2021 10:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
Content-Language: en-US
To:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20211217161549.24836-1-semen.protsenko@linaro.org>
 <20211217161549.24836-2-semen.protsenko@linaro.org>
 <2fdc5c97-6c19-8e70-d717-28b29d86160c@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <2fdc5c97-6c19-8e70-d717-28b29d86160c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2021 23:29, Sylwester Nawrocki wrote:
> On 17.12.2021 17:15, Sam Protsenko wrote:
>> System Register is used to configure system behavior, like USI protocol,
>> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
>> make it possible to modify SYSREG registers.
>>
>> While at it, add also missing PMU and GPIO clocks, which looks necessary
>> and might be needed for corresponding Exynos850 features soon.
>>
>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>
>> Acked-by: Rob Herring<robh@kernel.org>
>> Acked-by: Chanwoo Choi<cw00.choi@samsung.com>
>> Signed-off-by: Sam Protsenko<semen.protsenko@linaro.org>
> 
> Apologies for late reply, this patch is applied now.
> 

Sam,

The clock is used in the DTSI, so since this was applied, there are only
two choices now:
1. wait for next cycle with DTSI and DTS,
2. Resubmit with replacing the newly added clocks in DTSI/DTS with
numbers and a TODO note.

Best regards,
Krzysztof
