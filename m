Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B69471C4A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhLLSqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:46:12 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41480
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231149AbhLLSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:46:10 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2AFF03F1B3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639334769;
        bh=vVmzi0LKYYg7ixdO/Dk9XoMf50KrjdNN8bDu23E8c2o=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=mMcsrNG7e9HpAEThtez52XZddp6vLNfrlhFFw9IsouE7CwlodekjKqRcRcFw5Rymk
         mcPGRqAg/Q9Tj3rO8i/6HxjjPz2mti635Ke2kB44Zuw/K5uaodYMvJc6KtxFgUmXJ2
         lHHW6zecwmMenuPQI0y3Ncpglq/j8gHfJieIFys/4aC46q6bDoJM/zxNlMcIxdSPiK
         JqtqaiV6BavlfJaLw6dda0JLLEZgXXuTRRBTd9ZsGAwOl5BtxudEPIp+U84En9jjma
         pq2btc+sUMt2FaoNGWi9ZPHG28hcs89j/AgeloCGtgoZV9m8ZpXCBdgFKBQ5fOXS1H
         5qC5qQS1FsgBg==
Received: by mail-lf1-f71.google.com with SMTP id z30-20020a0565120c1e00b0041fcb7eaff3so4228547lfu.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vVmzi0LKYYg7ixdO/Dk9XoMf50KrjdNN8bDu23E8c2o=;
        b=oYV2sZQbGf9W4BvNQq/E/+rFEhAeQmI/cbbR1s0K0THMXHHNF5asKb1EcNTVqtM0ws
         ep4CcXoT9XnZjSDAGHNrNuALOVoMfh9UYRH8qoUvhVDaUEVgFuFXulSXgEIOPQ5M3SW6
         6kwnfMT9EP5KxcjKV3l5JSgWSytMkDF+2M0wcxiGsbvttvybHZdYrbw/y4EFAV6oGewZ
         Ipo6CQWKPlZ1Bi3PXTkLN3YTHbMVsqExX6TJ9M13zbc/5VNBVxXYW+xeafIAURNsAbiE
         i9hBHaxJfBLj5nEQm92Bbf7JnNLSoD3PvwBK82DKTolS5Vn1vI/hqrteR/cxq0JlHehJ
         Pw8A==
X-Gm-Message-State: AOAM530x7jrmMZXCcciUzZK1TUr+ot2x/IrRqTAFy2pgK1vo/WgmigTm
        e+t5zZoYDEXv/8UWLAlpnxHg5N7QW9bGnat7d5YxHLmMsxuyQMfU5UuRlSWwJyS56Cmwtm5C3gZ
        Hu4YUN92B00SVEnSU0/Kg97IpewhcSAHUeB6PSpKm9w==
X-Received: by 2002:ac2:454b:: with SMTP id j11mr24306432lfm.41.1639334768466;
        Sun, 12 Dec 2021 10:46:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOgwlcKO57jGOmrAmTRgmvAh4zvqGMhAUOSl1PWLIyn+BOi5YBridhbzZTj3J1IT2ofufJzw==
X-Received: by 2002:ac2:454b:: with SMTP id j11mr24306420lfm.41.1639334768302;
        Sun, 12 Dec 2021 10:46:08 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o17sm1153431lfn.50.2021.12.12.10.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 10:46:07 -0800 (PST)
Message-ID: <ffb00485-ad21-a11a-03ea-3856e2212563@canonical.com>
Date:   Sun, 12 Dec 2021 19:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 2/6] dt-bindings: memory: tegra: Add Tegra234 support
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20211210164741.881161-1-thierry.reding@gmail.com>
 <20211210164741.881161-3-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211210164741.881161-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 17:47, Thierry Reding wrote:
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

(...)

>  /** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC4 */
> diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
> new file mode 100644
> index 000000000000..2662f70c15c6
> --- /dev/null
> +++ b/include/dt-bindings/memory/tegra234-mc.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +
> +#ifndef DT_BINDINGS_MEMORY_TEGRA234_MC_H
> +#define DT_BINDINGS_MEMORY_TEGRA234_MC_H
> +
> +/* special clients */
> +#define TEGRA234_SID_INVALID		0x00
> +#define TEGRA234_SID_PASSTHROUGH	0x7f
> +
> +
> +/* NISO1 stream IDs */
> +#define TEGRA234_SID_SDMMC4	0x02
> +#define TEGRA234_SID_BPMP	0x10
> +
> +/*
> + * memory client IDs
> + */
> +
> +/* sdmmcd memory read client */
> +#define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
> +/* sdmmcd memory write client */
> +#define TEGRA234_MEMORY_CLIENT_SDMMCWAB 0x67
> +/* BPMP read client */
> +#define TEGRA234_MEMORY_CLIENT_BPMPR 0x93
> +/* BPMP write client */
> +#define TEGRA234_MEMORY_CLIENT_BPMPW 0x94
> +/* BPMPDMA read client */
> +#define TEGRA234_MEMORY_CLIENT_BPMPDMAR 0x95
> +/* BPMPDMA write client */
> +#define TEGRA234_MEMORY_CLIENT_BPMPDMAW 0x96
> +

This header is needed by the driver and DTS patches. One of us can apply
it and provide to the other via stable-tag. I think Arnd and Olof prefer
if headers are coming with DTS and are provided to other trees, so maybe
you will take the bindings and provide a tag for me for the driver?

Best regards,
Krzysztof
