Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5539147BB62
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhLUH6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:58:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53446
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235383AbhLUH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:58:41 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B8EB3F17B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640073520;
        bh=pdk0rqVNGg8GOBmVYXYE0PO6Xsy3hz9CYzKWBDMLtvc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=hYqpsHdVYeCzj6eUlKLWX+4tJD3Eo9NT9HcvA2FbtqbF635Fbv4+qPXPFYzjVdCd4
         9RzcwpHqFGoPCLQC35znZ27Kzl0YUf41bZ9iLJSPauqK79V5dbIkf/y+pjKcYDCADV
         tJ6R7y4rwEXLR/iUmqf3g0XR2zLRdjEg30M69UzJ4iSum+QryRuCfkMNBfmrd7O5Yj
         hONCZk1BQYiuLmgQ030ZTdhYmOhzYWL5Rvh5X+FbnYg73VHsQCHaISBV77CJJisHY5
         nygI9D3aBXLFhrYM2Xp3DSXyiLf/Y/EvLCBN5SjpX/EJe3ckjc/q4gkfVj60ISBmSS
         u7yu5fLmxXO2w==
Received: by mail-lf1-f69.google.com with SMTP id m8-20020a0565120a8800b00425edb1a456so2292143lfu.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 23:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pdk0rqVNGg8GOBmVYXYE0PO6Xsy3hz9CYzKWBDMLtvc=;
        b=Q/pX8IA1FFY0S7BN9jzrqd5xmUroY+xxjji1qVGKA7clXlExaLrLzWC0GvJoHV8hJ6
         G5/agjKFea6Ulz94yH6Cks53OdYTJLSsd60CoxoqPrVWHJZvVMg6HndL23ROq4b74dQm
         4Z7WKlvUuY8HOqM08kmz6C89vJqWfImq1fX9NXmmdwtn1PzlGGFHFiPk6nUL5yr9Z1mJ
         W0nPitFp5jcqKMpRX0HRa/8Coajq860Oh66NEu+UW4bxSsQrDSEtIw9xERxZndrc3Zre
         9q3gkDviCqMF6w4P7zhDNkXC8XprziqVemghtDq6I7a1JAld5ggi5bBp9MZY4e95JLJu
         wCQg==
X-Gm-Message-State: AOAM533uLU+1nlcEi0Xy8shFTi8KpO1r0RUHVP7XEY+wm1KBWyrXgU+6
        UUtChI1hjeknThmRSTL+GuQ9GjhseqWfyZ4NAj1yJf2aXNeLBvso/o6e0Eb0pzmBw0lBSPjFv3o
        Z2jlY9TXjjmTv7LGl+OPfD1v8KUWBrvyX9LqqVT920Q==
X-Received: by 2002:a2e:904b:: with SMTP id n11mr1696455ljg.120.1640073519967;
        Mon, 20 Dec 2021 23:58:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6tFxWCCcCSBs+LY47MGdabh2z1CnORDM/crApTxNp+QlY+3k+UQKdBFLw/eqol+PpKxcAeA==
X-Received: by 2002:a2e:904b:: with SMTP id n11mr1696447ljg.120.1640073519803;
        Mon, 20 Dec 2021 23:58:39 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v19sm2683822ljg.8.2021.12.20.23.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 23:58:39 -0800 (PST)
Message-ID: <bc65c2d7-7bfa-4ad5-aaff-8875370010b7@canonical.com>
Date:   Tue, 21 Dec 2021 08:58:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: linux-next: manual merge of the samsung-krzk tree with the arm
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
References: <20211220094012.5a340d45@canb.auug.org.au>
 <20211221095314.432527ff@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211221095314.432527ff@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2021 23:53, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 20 Dec 2021 09:40:12 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the samsung-krzk tree got a conflict in:
>>
>>   arch/arm/Kconfig
>>
>> between commit:
>>
>>   54f481a2308e ("ARM: remove old-style irq entry")
>>
>> from the arm tree and commit:
>>
>>   3ac5f9db26bb ("ARM: samsung: Remove HAVE_S3C2410_I2C and use direct dependencies")
>>
>> from the samsung-krzk tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>>
>> diff --cc arch/arm/Kconfig
>> index 15bc7fba0761,391f07c17096..000000000000
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@@ -471,7 -478,7 +471,6 @@@ config ARCH_S3C24X
>>   	select CLKSRC_SAMSUNG_PWM
>>   	select GPIO_SAMSUNG
>>   	select GPIOLIB
>> - 	select HAVE_S3C2410_I2C if I2C
>>  -	select GENERIC_IRQ_MULTI_HANDLER
>>   	select NEED_MACH_IO_H
>>   	select S3C2410_WATCHDOG
>>   	select SAMSUNG_ATAGS
> 
> This is now a conflict between the arm and arm-soc trees.
> 

Thanks for letting us know.

Best regards,
Krzysztof
