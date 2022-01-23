Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C0F497163
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiAWMA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 07:00:57 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39112
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231757AbiAWMA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 07:00:56 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 07DDD3FE09
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642939255;
        bh=R8ld3KGRh1s+PUP/6LYVXFBTzLHQGuxsTJ6zIDEbsbs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=o/VqrNFmJFfYQqD455PZf4w+ggELaM0myKV13TPtlHsT113UF8O+1OIUuhJpIfOyP
         A0aFzjIEc1RwDlwmw9EJseAF3lQEcJJOefOBEOdd2hGNO15KTUplhGW3oDEjnV8CFj
         RBmNr7DcyPAAwP/VYiAU3BYW32SUX6vdOLU94J11NbA0u+rfYUNI2i5a55VM4oe+Kv
         sQkbyy6rK9UmfN/S4slpZ2exB0L/UFORry9x40rfYD6Q9VYyXe+eq4q4oM2Z6AHM6L
         r/d4YyYx0x0tHEOAjRJHpSmroe5/FWj7p80Agkyu+GvuZRXBT4WINJQdm/vg1ye18t
         9JYnqdI7UJ6dQ==
Received: by mail-ed1-f69.google.com with SMTP id j1-20020aa7c341000000b0040417b84efeso11218757edr.21
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 04:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R8ld3KGRh1s+PUP/6LYVXFBTzLHQGuxsTJ6zIDEbsbs=;
        b=YaU1y9lxVqOXRaUsnvnYr4Q5VxsozcowEYTvIorDulON/qmhKvUkKSHrlzJGURCrBN
         gnqI3T48hV44+uGkGd/JUT8XeqqKVcRDvYvh7cWzcsiYKjgNNvK5ybycFGZZJW10pmWb
         opipDl282PIbuRzzLN9428Pq2paI4WPilnK9lta6Gr/WfPGVlLIBl/xWLHPof7RaiFRm
         j0+GlvY8lUDhOSSIjYGHyOpLf10g+UuxlNVGolM/kkRFLqcYCMdJU2GceBOxCUYtJ5YP
         dO/54Wu3jXpvijU389GM/Ex88u54CNBezDNHtLW34QdRKyuHLz8SwPzIp7TdDHYuhVPx
         Z41A==
X-Gm-Message-State: AOAM530W6Z0HoEhG2Fc9gl1xvyTAggeqUgJQQHXoIh/wzXy4gKsBeBiF
        d9QlPekS/NH35isE40JIdUB9GncEAVeOiX80illcWmvbzlENPFFPvv1ATpouJxEoN11ogBP5vqT
        lxRokqwtuM2ir+i6Pw9HRqbkfGCnPyBWy+3dVcXcOsA==
X-Received: by 2002:a17:906:5d12:: with SMTP id g18mr1368627ejt.564.1642939254578;
        Sun, 23 Jan 2022 04:00:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeTB3suFnHuSqPCxxt4hqTrIWZZhoJ1FzeZKkPW/SXb8l19G3YdxLLqBAE1J6RZw+usdjIrw==
X-Received: by 2002:a17:906:5d12:: with SMTP id g18mr1368617ejt.564.1642939254409;
        Sun, 23 Jan 2022 04:00:54 -0800 (PST)
Received: from [192.168.0.52] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g12sm4910525edv.89.2022.01.23.04.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 04:00:53 -0800 (PST)
Message-ID: <724c16d2-5afc-4d41-8d84-3ba570d14cee@canonical.com>
Date:   Sun, 23 Jan 2022 13:00:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL 1/2] memory: drivers for v5.17
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20211224111124.6097-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211224111124.6097-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/2021 12:11, Krzysztof Kozlowski wrote:
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.17
> 
> for you to fetch changes up to de369801658a9a54759ac011af770e8c01d9db7f:
> 
>   Merge branch 'for-v5.17/tegra-mc' into mem-ctrl-next (2021-12-22 12:59:03 +0100)
> 
> ----------------------------------------------------------------
> Memory controller drivers for v5.17
> 
> 1. Minor improvements: Mediatek SMI, Freescale/NXP IFC, Tegra20 and
>    Tegra30.
> 2. Convert Freescale/NXP IFC bindings to dtschema.
> 
> ----------------------------------------------------------------
> AngeloGioacchino Del Regno (1):
>       memory: mtk-smi: Use ARRAY_SIZE to define MTK_SMI_CLK_NR_MAX
> 
> Dmitry Osipenko (2):
>       memory: tegra30-emc: Print additional memory info
>       memory: tegra20-emc: Correct memory device mask
> 
> Jason Wang (1):
>       memory: brcmstb_dpfe: fix typo in a comment
> 
> Krzysztof Kozlowski (1):
>       Merge branch 'for-v5.17/tegra-mc' into mem-ctrl-next
> 
> Li Yang (2):
>       dt-bindings: memory: fsl: convert ifc binding to yaml schema
>       memory: fsl_ifc: populate child devices without relying on simple-bus
> 
> Rikard Falkeborn (1):
>       memory: tegra: Constify struct thermal_cooling_device_ops
> 

Arnd, Olof,

I think this one was not pulled by you. Any chances of sending this to
Linus past 5.17-rc1? If not, could you pull it as v5.18 material?


Best regards,
Krzysztof
