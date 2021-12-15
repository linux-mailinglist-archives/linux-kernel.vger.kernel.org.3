Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD4475BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbhLOPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:15:27 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46620
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243717AbhLOPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:15:25 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D3073F177
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639581324;
        bh=NJlwDd5bAMJRuNFENJ45/ccB1wsP6KiGSWfHC0fnYW0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=l0OHpa9cmZHYaccz0KjPdBc0/gVx49QDBbDqToE/mwwAmtmavrdip4aEwYFs46aCw
         eJ8m419WVSbhhMyzCaUPjLAJN7WrKmgSlcERMDf7YyM2T++YsEsOOOkkZZpSWRNoV+
         TnAlW5dS44A/fu9xf/bNwm5gnPEur6RnbouW0/Iyjja+SsA3iEsO41mm9p0yXbUPTM
         8u1xyBCppk20+lmcVv5b3UD0eN/mNK0QqUA0i613FV+wNX4p6WMjUnXEMcqjpSKQnc
         NzaktrJGDZsVUTpz9cO6CQVaNPLd8SS/wxuJpVf5D/bWHo+XDhg7He16xwo10vwxx4
         9OFvbaE0crAqw==
Received: by mail-lj1-f199.google.com with SMTP id b3-20020a2ebc03000000b0021ffe75b14cso7132261ljf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NJlwDd5bAMJRuNFENJ45/ccB1wsP6KiGSWfHC0fnYW0=;
        b=y7MM81g2DWhoPvs85VoDCDRbxK9Do9SFrgatbdl72ZXVG3RmSMCi1Bbt4PYDHaWSzM
         vT14e5zTh4To9mAxHnI8tUGwBUEYZq4deBH/Ez0GnkapAm+WJJ3CTljcvsBsC4gIPwbr
         1+Nvaw8MVy5tWVTC7DfNoVP3xS7HsSBUodMYviETpam9BX3ayT+2kY8BcNQ2X/gn4q8Y
         GGPlvo4CHg5OY3nwEF7+EGo8gSN3u11V9QtDqszif/nviRM+ZSZRO+yO6qp8IS50sHXj
         hCXrUNC+J9a7ink9vgFwGcCxV4DtimlqTzzDIxTq3A5kb13ZPMPvhdoEAUv39tfpwwlZ
         h6xQ==
X-Gm-Message-State: AOAM530m7tQNWvYHpJxErsE++OBh0O4Me0GKXHEyGK2J7MTlgwVqdO8d
        VqssfYOrKF+w6H7llx0SzWxFP8R45KrSE/J0hILBxCU3MOZ9iyf5+zPs/c60BY/qjrMxDdeNMCS
        KCx6FiCqVXr5DsQQ8yhJczPGXve+0A9ETHxLPp5saow==
X-Received: by 2002:a05:6512:1395:: with SMTP id p21mr10063208lfa.98.1639581323845;
        Wed, 15 Dec 2021 07:15:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSqjwtfFgEsXQmVVMjGxzT6u23CbpHjbBKaHBmzxKigW2rHXI/vvH2ToOQ3mNIqgQ+BBJjMw==
X-Received: by 2002:a05:6512:1395:: with SMTP id p21mr10063195lfa.98.1639581323675;
        Wed, 15 Dec 2021 07:15:23 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id h12sm362245lfc.239.2021.12.15.07.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 07:15:23 -0800 (PST)
Message-ID: <90ce73cb-0dec-d7a7-9bb5-f10a8cd7c250@canonical.com>
Date:   Wed, 15 Dec 2021 16:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 2/6] dt-bindings: memory: tegra: Add Tegra234 support
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20211213162151.916523-1-thierry.reding@gmail.com>
 <20211213162151.916523-3-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211213162151.916523-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2021 17:21, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Document the variant of the memory controller and external memory
> controllers found on Tegra234 and add some memory client and SMMU
> stream ID definitions for use in device tree files.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - conditionally set minItems for reg properties
> 
>  .../nvidia,tegra186-mc.yaml                   | 20 ++++++++++++
>  include/dt-bindings/clock/tegra234-clock.h    |  9 ++++++
>  include/dt-bindings/memory/tegra234-mc.h      | 32 +++++++++++++++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 include/dt-bindings/memory/tegra234-mc.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Provide me a stable tag with the headers, please.

Best regards,
Krzysztof
