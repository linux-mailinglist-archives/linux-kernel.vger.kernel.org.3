Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18092469135
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhLFINd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:13:33 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37138
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238917AbhLFINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:13:31 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7A7E040013
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638778202;
        bh=RAlMJw0hAlKemm+s7FpJu1a4HkFRFtFKnNsdQrbM5jQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jd4QPUoY22x6/hEAVg8EqKSjZQkUamtzyBVq2s3bIYO6PQdYv8NR150g/dGActRlm
         rABzxYaQYRWk2Q1jBfrGT2ic6WelaB98EqoLxsUNsKCMP8f3WSQiBU/jU4Uq3tWGH6
         HjKzKKowIOarVDIX623Zg/fM8FygTvDwSdHNEt2uRmFI4JsfO+eyp/mJ5URvh30IhU
         R4dqzCkVDNFJ+Zx8MBtH0QlubmlAjZFFiBnYaenOCXRGaiGJmHLVUyY2Aq+dpx8M9O
         27c1vb/5j+PRTHPbDVUP0irdrGWZKN0Zme61vEWzAfm3OHy+o0BfAt04EC7ad16+RJ
         0kEATiIT+KJ4g==
Received: by mail-lf1-f70.google.com with SMTP id d2-20020a0565123d0200b0040370d0d2fbso3523499lfv.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 00:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RAlMJw0hAlKemm+s7FpJu1a4HkFRFtFKnNsdQrbM5jQ=;
        b=QlsQVNcnxA1UntNFMaOcmJyRwL92CbDmTw2iBV/A9lTASxjnwh3IhjmXHEM7UmKQAS
         Y0ZEP41Szj5fPpUiBotPxuI6y2K5ozT2hUPghYwSHw/HrXMjOW0M+yMHvD3KIVaVryBo
         yWDIfXJC2Q0HrZD0yoL/vOHpGsyP3Fs5YVzsYlXHwDkal+UO6UBL7w/rWV3kyEQZMMn0
         cGVMrEAbUFpHYWTbAjicURbUCY7NpmSE7bDI9kR4y0G6K6+SKJduYmKLrv+EMlA5UKZh
         61xgteNa+jYTmQB9I+TNWP/lUMU1af7uKYiv9Nb4GQUnm40IAyG3sCeV+bY26cvpGQ/i
         Wsew==
X-Gm-Message-State: AOAM533hwcl/XB8qq79TMhwkybf8z51a/Cmh2oucZv5ciejHNJpQ7cZ9
        nbwKulV5o++S1XbxiUF9E5BHP4KplJVxTy51/VvIhWE5eiFs+yJvFi+W7uTgZCYYXfmwGF1su+3
        1TBInSVRc1S8Zyv+OObqqKSSqobBrmnPh3FhFtzFJfg==
X-Received: by 2002:a05:6512:3b11:: with SMTP id f17mr33997577lfv.374.1638778201760;
        Mon, 06 Dec 2021 00:10:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAi8u771n2ANIoB27JZ3uxy05oSrdAsnB24TPCYR67hNBGWM9/5D+FROg+GPMnY/eFSJkqWA==
X-Received: by 2002:a05:6512:3b11:: with SMTP id f17mr33997550lfv.374.1638778201516;
        Mon, 06 Dec 2021 00:10:01 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v8sm40028lfq.177.2021.12.06.00.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 00:10:01 -0800 (PST)
Message-ID: <a0e49624-99b2-6dce-b426-d67a9a74c5c8@canonical.com>
Date:   Mon, 6 Dec 2021 09:10:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 4/7] clk: samsung: Make exynos850_register_cmu shared
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
References: <20211205230804.202292-1-virag.david003@gmail.com>
 <20211205230804.202292-5-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211205230804.202292-5-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 00:07, David Virag wrote:
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
>  drivers/clk/samsung/Makefile           |  1 +
>  drivers/clk/samsung/clk-exynos-arm64.c | 94 ++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-exynos-arm64.h | 20 ++++++
>  drivers/clk/samsung/clk-exynos850.c    | 94 ++------------------------
>  4 files changed, 119 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/clk/samsung/clk-exynos-arm64.c
>  create mode 100644 drivers/clk/samsung/clk-exynos-arm64.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
