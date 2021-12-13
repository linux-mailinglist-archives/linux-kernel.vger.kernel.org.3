Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340E4472BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhLMLjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:39:31 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47080
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236292AbhLMLj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:39:28 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 05CE33F175
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639395567;
        bh=KylFWhwXr7f8U5vfUNkHsHS6aLRbPvrnv2I4vw8dDyE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=AKFpYwgBcvU6JsRumaVsy4k3vawuGtr5PgxKkGdT/YENTdGrT98wkO+5rT/+TwmVI
         1v/Vgn8LYR2YwL39CaGuPhX7RaoqVFABbrlZPue8uEU6jMUDzityVIf1NIHJsYDqXa
         cBUrV0mDunp5tCdy2hDTwx/pWqrqqX9UGRytDvQk8hs6W/V1DCmqbHobEmv09oHnMy
         INELTSBj0oX2Ahu8LVlnaiYKAGIpnkDze22GF+ihCOJylULcCUpRZWDmEoptlFD5wL
         cjMFbs96TM9kljaHNmXfUSe5WNZLECBOKSTJ6V1eytDQK8TX/8w1i+8l3wePJ2JHNU
         ALwjwS0Sg49Cw==
Received: by mail-lf1-f70.google.com with SMTP id e5-20020ac25ca5000000b0041bf2d8f2e1so7376675lfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KylFWhwXr7f8U5vfUNkHsHS6aLRbPvrnv2I4vw8dDyE=;
        b=L6bojuZoLixw7Zs18ZbQzsmSVdxZ7iIrQJxgmNUcOZPZ4LxxPuS+p+wtqmsN4wFSZt
         h7i6FlmsFn0VP8kYD/EvfLQO57rKkAxgxdJgD/n35iHaX/uw3gJq2/HkiWBf9mJ0IVtZ
         mEgoTmtUvH3Qmmpa8dWnZ/mf4ApAT8QcelX4DCgdUKXFSIkAM/HpPXsb3fDBpywrQpm+
         4iJrHXu1ZizYpQaKctHD1FGfRQxhWjWj/0LKlm/eIgLUaHQ3XeBIIAat7h4W0Sgh6RmR
         ihQ0TEg+zInf99kT0b9FIkej1XCatwXRzbA9OshKWcy0kXVMk9TyQMsB37ShMZGASyuZ
         sy7w==
X-Gm-Message-State: AOAM532HPbXefLExFQdZmGpB8octfUEynHpjW77Pb9LWO7vy1MTD26z1
        neJG4Nm4lYftzPwARCZTmK3uFPpd+b180IOmpc6fmXczF/ptXj2v9B+E3BffbgzXgpT7d8MCuBf
        N0sLIBPp5AQq5iyX8MaoBV1K7ultLkJCYuX9rN2T5VA==
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr29704509lfv.481.1639395566535;
        Mon, 13 Dec 2021 03:39:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMDwS3UVx1tzJXGjwPvVGUvSyOkIaeaGrkDixoDzMSC898Xum7q6HTEqxsQYuAixVEDjnS9A==
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr29704491lfv.481.1639395566369;
        Mon, 13 Dec 2021 03:39:26 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v19sm1433603ljg.8.2021.12.13.03.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 03:39:25 -0800 (PST)
Message-ID: <fbadbd75-ac68-fa06-9303-76892567d179@canonical.com>
Date:   Mon, 13 Dec 2021 12:39:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 5/5] tty: serial: samsung: Fix console registration
 from module
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211204195757.8600-1-semen.protsenko@linaro.org>
 <20211204195757.8600-6-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211204195757.8600-6-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2021 20:57, Sam Protsenko wrote:
> On modern Exynos SoCs (like Exynos850) the UART can be implemented as a
> part of USI IP-core. In such case, USI driver is used to initialize USI
> registers, and it also calls of_platform_populate() to instantiate all
> sub-nodes (e.g. serial node) of USI node. When serial driver is
> built-in, but USI driver is a module, and CONFIG_SERIAL_SAMSUNG_CONSOLE
> is enabled, next call chain will happen when loading USI module from
> user space:
> 
>     usi_init
>       v
>     usi_probe
>       v
>     of_platform_populate
>       v
>     s3c24xx_serial_probe
>       v
>     uart_add_one_port
>       v
>     uart_configure_port
>       v
>     register_console
>       v
>     try_enable_new_console
>       v
>     s3c24xx_serial_console_setup
> 
> But because the serial driver is built-in, and
> s3c24xx_serial_console_setup() is marked with __init keyword, that
> symbol will discarded and long gone by that time already, causing failed
> paging request.
> 
> That happens during the next config combination:
> 
>     EXYNOS_USI=m
>     SERIAL_SAMSUNG=y
>     SERIAL_SAMSUNG_CONSOLE=y
> 
> That config should be completely possible, so rather than limiting
> SERIAL_SAMSUNG choice to "m" only when USI=m, remove __init keyword for
> all affected functions.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v3:
>   - (none)
> 
> Changes in v2:
>   - This patch is added in v2
> 
>  drivers/tty/serial/samsung_tty.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
