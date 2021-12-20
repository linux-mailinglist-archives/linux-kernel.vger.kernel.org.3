Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F415347B205
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbhLTRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:21:33 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39022
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232743AbhLTRVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:21:30 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8821240036
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640020889;
        bh=9uepcdD/+xGrreEt0EvBxw805TxTK4a1Lcw9AZ0HvjU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vW3WziXRD0NbDKDIc0uEmapoWe6K9v9+CG0EluJhE+AIDM7zUS3RYZ98YkxP1h6eb
         kczHedPoEqhAsUncW5pOFI6xVHO63NrkO25oub56Ryi3OKRyjYhErRO+Oyt9R575CM
         W+ozbdj1G6dX1WoSPq6PanHMmW5fF6CkbqhWtHUlI21zvnBCEJLKJBAlzp0uAW0rGC
         tarAvssI3y6kSASQKdiznNUZZ+JSSYqsW2ivzNk0nAguNTgIvfd6Fx22gFkot/0e57
         SJ2r928qQbbj79Yn9nv2gxYpHqECOuW7nd3w9W8nafJNxspvc3AYwVrA36hXCsjgKH
         B4NHg8FrkXQSQ==
Received: by mail-lf1-f69.google.com with SMTP id h40-20020a0565123ca800b00402514d959fso4852510lfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9uepcdD/+xGrreEt0EvBxw805TxTK4a1Lcw9AZ0HvjU=;
        b=AbVQxn9KdV3jPTf2x+h92lAyIYfJPPpJyZeT5K2lx4G6FmSr0NdWO/A5sSQNdAqCDD
         8BEOeyMXqMw7p1A5z+nD6rdIICOW2rfwY+HPodYBFrMpnHl81vo1wQhz+6lbEYHIdS3m
         YswyuutGuNGrslNAx6euwSfrNOBTfMR9nmcbFKBxpq92TqVfgNC38wv5ZNHE94NPu6uf
         LlNjat9AW3KtWfj+6IXuiYcCBjdKQ5AZ5f9Y9DdXwl7qXKfIQGgQwJGo3g2/bmYLCwQG
         FCLoI+BnvlUsTfWSshyQ03cD9gRCXFvcEkSjo4xkPX+ztjUIxrCd55uaA//3bv/WwpIK
         sJZg==
X-Gm-Message-State: AOAM533hGMgHuOTQcMVOBq00w3W2rOubU69TfhLGiItwUxNTeJlEYcW5
        TxOIPHjlNhvH8huzLcFltcjSysKoYLPryZqgrnNPh4nkmjRvsNelP6TFuOCCUHKnvDDx0/RbzRb
        TobCnaRW90e13PF+rWDbjcge53WvxcAxIr5VDUofHDA==
X-Received: by 2002:a2e:a176:: with SMTP id u22mr15640206ljl.116.1640020889036;
        Mon, 20 Dec 2021 09:21:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw12jXDaIaPutKBaiiF5L53Z9AtdC+YiU2FcIO9qaPe7iaLjXk+j/FyWgm2N7as2oT8PjAU/A==
X-Received: by 2002:a2e:a176:: with SMTP id u22mr15640183ljl.116.1640020888803;
        Mon, 20 Dec 2021 09:21:28 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y4sm2568279ljp.16.2021.12.20.09.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 09:21:27 -0800 (PST)
Message-ID: <09d4e9d8-6bfa-5676-50cc-49bfc947b444@canonical.com>
Date:   Mon, 20 Dec 2021 18:21:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [GIT PULL 4/6] ARM: samsung: for v5.17
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20211220115405.30434-1-krzysztof.kozlowski@canonical.com>
 <20211220115530.30961-3-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211220115530.30961-3-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2021 12:55, Krzysztof Kozlowski wrote:
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.17
> 
> for you to fetch changes up to 3ac5f9db26bb7a227ccbf160c36a5567b5394299:
> 
>   ARM: samsung: Remove HAVE_S3C2410_I2C and use direct dependencies (2021-11-21 17:46:18 +0100)
> 
> ----------------------------------------------------------------
> Samsung mach/soc changes for v5.17
> 
> 1. Minor fixes for S3C platforms.
> 2. Remove HAVE_S3C2410_I2C Kconfig symbol - not really useful.
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       ARM: s3c: add one more "fallthrough" statement in Jive
> 
> Krzysztof Kozlowski (1):
>       ARM: s3c: include header for prototype of s3c2410_modify_misccr
> 
> Sam Protsenko (1):
>       ARM: samsung: Remove HAVE_S3C2410_I2C and use direct dependencies
> 

Hi Arnd and Olof,

I forgot to mention possible conflict here with arm tree. Conflict is
easy to resolve - just remove lines in all cases like:

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@@ -471,7 -478,7 +471,6 @@@ config ARCH_S3C24X
  	select CLKSRC_SAMSUNG_PWM
  	select GPIO_SAMSUNG
  	select GPIOLIB
- 	select HAVE_S3C2410_I2C if I2C
 -	select GENERIC_IRQ_MULTI_HANDLER
  	select NEED_MACH_IO_H
  	select S3C2410_WATCHDOG
  	select SAMSUNG_ATAGS


Best regards,
Krzysztof
