Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B610B470AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242483AbhLJTx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhLJTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:53:28 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79751C0617A1;
        Fri, 10 Dec 2021 11:49:52 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z7so19884343lfi.11;
        Fri, 10 Dec 2021 11:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Fx2AxGyl7h70TiPIfAS4vLJoC4O4KHoawTu1bt5PLU=;
        b=V/Owe18bjaHxi/q9LMXS8LNROf16L9DCZYGpExoCj+SNTLCiSQNB3HcPLajV/NP5JE
         39hqIvfIb3bc7xrS2E0EYCC3yAPKzLg7BnA0PumFQ89YOCGyLF9Ipz3BTISejc0ZvQJA
         z5FDAeVaX1e2/Z9TFGOO31SRX4KXbVNvKZ2tbYOwQTeu/RyJ9cs6xalps+Kn8iqrggDL
         HFUryH5SPjqHR6nW0F4ENPTnll1o3uJ7tQu3AMV7MUX+qx7nV3LMFjM06jk+Y2dJ7HtP
         J+zk+OszrogiRw5+RRL4W19jTgJEJXo+L0tNHRiDg9ofDsu8gJQpDKtlXAuJgOp4GYiB
         LSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Fx2AxGyl7h70TiPIfAS4vLJoC4O4KHoawTu1bt5PLU=;
        b=0m2nazqEmMMp1ckjsVHQq7ZqF+bEWQpI/PXVwxALXj7VTaR4pePC/QpT3bYbB5TZ1c
         3JEYBRO8rskfIuw+VcvdTRUbg/AD3W2RHn2h3CpwVtRDBaInUW2zPqyyObXH0zTEgm69
         bydNMiR8Aq0HREUwIHDVCqs5YfTkLKhFa1e4nomavcz8Rx5WxnK/3JusLrTGrIxuI3Bf
         XKlxCO7jCNXUjc2F6KveZDDYLHBwr4M3G1E5v9svFx5QwtNUQzu58TW1h57YnDiarmSd
         fR2Qrwz0kdeRpyKN7SZA5AojIP43gRwccWqIo79GikpOu+3hN01Eih06K9FPtmXHs/9d
         FeGQ==
X-Gm-Message-State: AOAM530BnbQuDPvr/E7mIHIEnkX7FRd0EV9VRy4S31qX+60qvIKTuC+u
        w7ZqfcD4CQkoZlzGsjR/CQigW8NzhcE=
X-Google-Smtp-Source: ABdhPJz32UCAa2RfOn9XCHx2JjAq/5XnkzKJ8mqE0CmU9Bnm8cg96K7fElVvubFW0G/2Bv0vNQ8r/g==
X-Received: by 2002:a05:6512:114a:: with SMTP id m10mr14457333lfg.188.1639165790431;
        Fri, 10 Dec 2021 11:49:50 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id z24sm395757lfh.289.2021.12.10.11.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:49:49 -0800 (PST)
Subject: Re: [PATCH v4 05/25] reboot: Warn if restart handler has duplicated
 priority
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20211126180101.27818-1-digetx@gmail.com>
 <20211126180101.27818-6-digetx@gmail.com> <YaLNOJTM+lVq+YNS@qmqm.qmqm.pl>
 <033ddf2a-6223-1a82-ec64-30f17c891f67@gmail.com>
 <YaQeQgbW+CjEdsqG@qmqm.qmqm.pl>
 <091321ea-4919-0579-88a8-23d05871575d@gmail.com>
 <CAJZ5v0jMvdhfBqjY+V9h_Z6EH1ohuJH+KjuGiOw_Jor1Tnp7vg@mail.gmail.com>
 <45025b2d-4be1-f694-be61-31903795cf5d@gmail.com>
 <CAJZ5v0ieTwnBVjW8R_VTdPFH3yr5AwLc+ZEG5N3KrpTH+j8qZw@mail.gmail.com>
 <45228c88-4d51-591e-5da5-9ec468e71684@gmail.com>
 <ad6c7d73-e7d3-4901-fd63-ef87eecd39a2@gmail.com>
Message-ID: <7875d10b-0d9b-ca29-668b-630ea3650fd0@gmail.com>
Date:   Fri, 10 Dec 2021 22:49:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ad6c7d73-e7d3-4901-fd63-ef87eecd39a2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 22:44, Dmitry Osipenko пишет:
> 10.12.2021 22:42, Dmitry Osipenko пишет:
> ...
>>>> There is no strong requirement for priorities to be unique, the reboot.c
>>>> code will work properly.
>>>
>>> In which case adding the WARN() is not appropriate IMV.
>>>
>>> Also I've looked at the existing code and at least in some cases the
>>> order in which the notifiers run doesn't matter.  I'm not sure what
>>> the purpose of this patch is TBH.
>>
>> The purpose is to let developer know that driver needs to be corrected.
>>
>>>> The potential problem is on the user's side and the warning is intended
>>>> to aid the user.
>>>
>>> Unless somebody has the panic_on_warn mentioned previously set and
>>> really the user need not understand what the WARN() is about.  IOW,
>>> WARN() helps developers, not users.
>>>
>>>> We can make it a strong requirement, but only after converting and
>>>> testing all kernel drivers.
>>>
>>> Right.
>>>
>>>> I'll consider to add patches for that.
>>>
>>> But can you avoid adding more patches to this series?
>>
>> I won't add more patches since such patches can be added only after
>> completion of transition to the new API of the whole kernel.
>>
> 
> Thank you for the review.
> 

I meant you, Rafael, and Michał, just in case :)
