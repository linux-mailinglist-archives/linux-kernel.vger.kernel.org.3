Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7A4823E5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 13:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhLaMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 07:02:43 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50754
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhLaMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 07:02:41 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 228F83F206
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640952160;
        bh=DK4b7SeKibw8lubZey1sb4uTn4FV7x816K3kbbgYWl8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uc62tn02ch55W/jW5oeM7iYIYpz+Xl1+zIaJDnzrQNTlP0cJKUp2FyCw0SWA+T1xF
         8hCRROYXGmeAfrgFSKZzWFf/49JvUfRaHTlDjBOYAwF+4qdrYxaHmonxLeMKT6qHjH
         dTF4ecVorVHvYAuDOEKqXSBkcB66eIbclIQ6Pmr7rV7J4O6w+ckqktqZDGA3cCdslG
         W4SfYD+9FV/Bqa0Q+4411YIIOmXGwb5MlB7sw2U29ovG4V6gjF+CYUgDPspqnwkP3a
         ChuAJ0sbQHLhYEdIMZ7/dMrw4AwlK/ixh2nF2nlYw20D8yYqXcv4uzd6qbyzcKfm9V
         zxKly5Vg/Bpcw==
Received: by mail-lj1-f197.google.com with SMTP id k11-20020a05651c0a0b00b0022dc4d55f14so6287718ljq.22
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 04:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DK4b7SeKibw8lubZey1sb4uTn4FV7x816K3kbbgYWl8=;
        b=fhOfgGPXyqPWw8Bk3FOJHV+N/62tqd6OFH+0NrpEpefQRU9pxqh+yAoJ2aFj8L13kR
         kLQpwOjh2Itn2MxsUdBSi7YWa0nWA/mh8UYxvzC3Ybi7B/ue2BZ0z6fEGy4NpMDxqolF
         XZOXNwBWqVmhjJDIZFpWSAF523ZyNNL6Sq44bB6184PlB0v/+licRKsvTa4LOItyqVmE
         vcfttpj9I9FOdO8kqzWDwrkmmyuEm4A2fgyFRBeOqUG5F09OocHALUSExP1ilrMg2N4h
         Sn37GIvUhGVqv3kdv8zemgBbnOlaI+hZ7AX9Y7GzaZUeimF8715azEXV3X7EXYQxujt4
         fNiA==
X-Gm-Message-State: AOAM533q4nialAAO5vQVGSbDuKlbb0QkWvV4U2L0+lN+7AF+iRW/ASpj
        LgV6rSMl9V06zWx6NwNrSZ0KlF/eavo82RNeNAPdKtuDqFyL/5A8y5gcIRUfKPO8SyZSLUsUR7C
        cWgu2eluMnkf7r5WBBnqdCRa+ntsKG79D0lS1njGztA==
X-Received: by 2002:a19:f80a:: with SMTP id a10mr31794655lff.203.1640952159464;
        Fri, 31 Dec 2021 04:02:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxM7O5azEaqF42QCZWl1/KJ+fXu32zsgTK4Tkau/+xGggZDXzpD41ErMb/I8LFsyRrH1ClKg==
X-Received: by 2002:a19:f80a:: with SMTP id a10mr31794639lff.203.1640952159218;
        Fri, 31 Dec 2021 04:02:39 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b8sm2751040lft.96.2021.12.31.04.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 04:02:38 -0800 (PST)
Message-ID: <3b7e0827-bda5-91c5-24a5-77c67e2273ab@canonical.com>
Date:   Fri, 31 Dec 2021 13:02:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFT][PATCH 2/3] arm64: dts: exynos: fix WLAN pin configuration
 in TM2
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>, stable@vger.kernel.org
References: <20211230195325.328220-1-krzysztof.kozlowski@canonical.com>
 <20211230195325.328220-2-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211230195325.328220-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2021 20:53, Krzysztof Kozlowski wrote:
> Each pin configuration in pin controller should be a node with
> "samsung,pins" and other similar properties.  However the macro PIN()
> (used for initial/sleep states) defines entire node, so PCIe WLAN pin
> configuration node was ignored.
> 
> Fixes: 98c03b6eef3f ("arm64: dts: exynos: add the WiFi/PCIe support to TM2(e) boards")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

This patch is not correct, because the driver/bindings allow and work
with such DTS. Please ignore.


Best regards,
Krzysztof
