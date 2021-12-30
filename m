Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFA481FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbhL3TmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:42:05 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33518
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240410AbhL3TmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:42:04 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 635803F179
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 19:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640893323;
        bh=7AmioCkJUoaV5KEZ7nDRZ+lrq8M0NvYRcknuM8019yg=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=JwyRT8pyJzZNwc2TF/1yxiLe9U7FH20x+17FOzIfd6Auvt9rhcTlIcDHVzwOVXyLw
         AHdHvEg6QCi45+A9o/lzkCeooHNkad9/zGx/1uIJZaiLZVsUWN4TChDTB85glfoZ33
         8d3JGZQRr6ffL/QhDCPyPd9ssoiiXK0tDqAulmC9lMZuKm5MsN2ZapSWHu2v0KjAJK
         h+yYj6SvbGUpZQQrYCj5vqVka32gI1tC3JXiVKVnpuL5gniUqtolOsX9fDLoJmlo8w
         3Lk7wn8b84QnCtBWbshoRT2UNt4q1o15Uu6Eow9i3nelcAAFmDPHJtk8Qifo4gynlu
         g4NjvOYawCtsQ==
Received: by mail-lj1-f197.google.com with SMTP id bd7-20020a05651c168700b0022d71e1839bso8485521ljb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=7AmioCkJUoaV5KEZ7nDRZ+lrq8M0NvYRcknuM8019yg=;
        b=LoIVrqq6Y19OSmCHcwIWOnJHWlpxkChyv7N/ipFZN98hkY2DSFr8Djt49624HtiHCg
         RhCF7IaAIpQMXVsOOJocXUnXIxWltFtnXKTa3uu4w0R6MRnr9e+KYmaiy7ozXc3IFACp
         8kIoVCmrezYPYcUy7JCAAZqo4sajm8WVg3ynZwd1JJfW6tCl+Z+R7MI7S/IYlGTdS3gn
         zDUtRPeotJR06GttcJZtFccwY5oaS1Fs+wS4txB8A/p+8DgZipSNmjfllTfxiz//uZp7
         mq0dJSBmc+FaG7utLpgPj4mLkpkWJCx7G/48dZHmvlWoH+AfzGbMyDAosGLvZWPG2TNf
         94bw==
X-Gm-Message-State: AOAM531skWGv175NaZrKq5Z0VbnC6i4qSCC+UtCNCaAttwbTPuo0RcET
        /98IQ9dkecbzF3Nd+cNb4zPtvz+fKBawp06BOOyoojizKyQxxmsQKNqWDZqn/oICFkp2xLm2g3x
        TocyBPOjY4nKbQfNVgjGZpNrcjfQw6pT91m0JPV1JiA==
X-Received: by 2002:a05:6512:220f:: with SMTP id h15mr28544191lfu.137.1640893322832;
        Thu, 30 Dec 2021 11:42:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwikFBFCGTECtglqH5hREBXZdnSFKZjK3Dcp9RQIDLCjyKmXNp7Ggu0IP0SiZ3FzyPJRyuzCQ==
X-Received: by 2002:a05:6512:220f:: with SMTP id h15mr28544179lfu.137.1640893322677;
        Thu, 30 Dec 2021 11:42:02 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y11sm2565604lfe.252.2021.12.30.11.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 11:42:02 -0800 (PST)
Message-ID: <88e6c551-b6ef-4676-ff85-6bc725d7d767@canonical.com>
Date:   Thu, 30 Dec 2021 20:42:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Exynos850 and ExynosAuto v9 pinctrl wakeup muxed interrupt
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanho Park <chanho61.park@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
References: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
In-Reply-To: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2021 20:34, Krzysztof Kozlowski wrote:
> Hi Chanho and Sam,
> 
> I am slowly finishing dtschema for Samsung pinctrl drivers [1] and I
> noticed that Exynos850 and Auto v9 do not define interrupt in pinctrl
> node with: wakeup-interrupt-controller. This is an interrupt muxing
> several external wakeup interrupts, e.g. EINT16 - EINT31.
> 
> For Exynos5433 this looks like:
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/exynos/exynos5433.dtsi#L857
> 
> Missing muxed interrupt for Exynos850 and Autov9 might be fine, although
> you should see in dmesg error log like:
>     "irq number for muxed EINTs not found"
> 
> Can you check that your wakeup-interrupt-controller is properly defined
> in DTSI? If yes, I will need to include such differences in the dtschema.
> 

Exynos850 DTSI additionally defines 32 interrupts for ALIVE pinctrl and
8 for CMGP. This looks suspicious - driver does not support multiple
interupts and how would they even work? What would be the source? It
seems that Exynos850 should move these interrupts to wakeup pinctrl
banks (actually - they are defined there!).

I'll send a patch for this.

> [1] https://github.com/krzk/linux/tree/n/dt-bindings-samsung-pinctrl-schema
> 
> Best regards,
> Krzysztof
> 


Best regards,
Krzysztof
