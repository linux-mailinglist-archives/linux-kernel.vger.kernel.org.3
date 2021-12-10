Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8D470AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbhLJTsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbhLJTsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:48:21 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4EC0617A1;
        Fri, 10 Dec 2021 11:44:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d10so19922486lfg.6;
        Fri, 10 Dec 2021 11:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bghkq/gqakBG3UMA9KtKqv9kgT5Wq1LJh/DaMMP+Buo=;
        b=lFdiyPZK17AYCTV65ZUsvdfciaNUYWPxmzSgJajTwQ07RVOIMn5cd3OMLqgm70DBAO
         sO9a+0M7Ylp7HtPfjlNdELPWJPhFEsL+BBJZhlleZ8ktrzvWgXu2rCggboh+AgCAyR+i
         WdIEhcqPzr+EGbl0oQk36HsGosG8oJ4OqatnVU+rYKpyd3R/jmhh8wJ5nt8gGw45GBZy
         rNd0gesXdm60r4RJ7qNGWsHGKiq3UiUqi5FkpCzhl0LGExdzbir7EPh4UTzIBF/YRE+s
         kyUVKadGSflj2NYa6m+B4vuldmIqJM59VgWObzoRC+XA5qxz4D0b/H+jRuY2tRZWYoPI
         /XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bghkq/gqakBG3UMA9KtKqv9kgT5Wq1LJh/DaMMP+Buo=;
        b=Yv6IH6SrSQ1c3JpqWa5MpYmgChnZih8nvFQqQmLYftDxX5xaJAr4p4ZTZts+8GV6Ni
         2AynflRal7bP4vgAPpIl3j9YcjofygUPNvc01+6OpSogXyQILj7GMInD9LkNKiKkhFPX
         4h9xKQi63nuIafzdXUMX7tEwogffxxZ2qvz5dJjF+xVMC61MuxhMmDKLywmp0jZWuZDk
         ixgqyhOKx0b5wT+VtkHQcxWOYTQss+IyM0uMRV7ure/vTqtXILO1VRcmulcbDvliFtY3
         08AlHawbMECGShisLdzdB/hVkd/AxjkOjNv5hxV0f0b2l8JK72fYey4lTPEwKjkaT36h
         T42w==
X-Gm-Message-State: AOAM531z0l7AxYgD7zxXdY+RqUaz2xhKmW/8GS+bVr23Joqcy6AYTgTS
        Ac7QbfK2cvjq94gJqZvU49Os3W2m4tM=
X-Google-Smtp-Source: ABdhPJwdPpKxpD5iCVpMoy0RbhPzj8+6gSmN9/Uu5pMKxteqUazmF0c3BRQXsHXIE6Vu9MIa4P5vrA==
X-Received: by 2002:ac2:4c50:: with SMTP id o16mr14291331lfk.517.1639165484083;
        Fri, 10 Dec 2021 11:44:44 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id c15sm394938lfb.154.2021.12.10.11.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:44:43 -0800 (PST)
Subject: Re: [PATCH v4 05/25] reboot: Warn if restart handler has duplicated
 priority
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
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
Message-ID: <ad6c7d73-e7d3-4901-fd63-ef87eecd39a2@gmail.com>
Date:   Fri, 10 Dec 2021 22:44:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <45228c88-4d51-591e-5da5-9ec468e71684@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 22:42, Dmitry Osipenko пишет:
...
>>> There is no strong requirement for priorities to be unique, the reboot.c
>>> code will work properly.
>>
>> In which case adding the WARN() is not appropriate IMV.
>>
>> Also I've looked at the existing code and at least in some cases the
>> order in which the notifiers run doesn't matter.  I'm not sure what
>> the purpose of this patch is TBH.
> 
> The purpose is to let developer know that driver needs to be corrected.
> 
>>> The potential problem is on the user's side and the warning is intended
>>> to aid the user.
>>
>> Unless somebody has the panic_on_warn mentioned previously set and
>> really the user need not understand what the WARN() is about.  IOW,
>> WARN() helps developers, not users.
>>
>>> We can make it a strong requirement, but only after converting and
>>> testing all kernel drivers.
>>
>> Right.
>>
>>> I'll consider to add patches for that.
>>
>> But can you avoid adding more patches to this series?
> 
> I won't add more patches since such patches can be added only after
> completion of transition to the new API of the whole kernel.
> 

Thank you for the review.
