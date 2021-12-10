Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EA7470961
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245611AbhLJSzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245600AbhLJSzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:55:42 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C255C0617A1;
        Fri, 10 Dec 2021 10:52:06 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b1so19598432lfs.13;
        Fri, 10 Dec 2021 10:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j1hvlB2w2BrWNScbCJyLwX4oBGKG9hr6NJqtvFkNM/U=;
        b=DpLCPmMgrOty3y0HrpqopSxxp/qGs/dwG/CgN0apuyA6on28PorJtUybksa6iWzXUQ
         1nC+svp1ZReaFc8Ho69TZxII0UpyuP8U7xwSjZaJzyMIRrgh64VdMWwWLpT7FD5pRO3K
         REVQTxyYOO3tzHZOXPhjO1pz+wC6sFrKKUXdbaxaG08xMkm/2y6DNn/B8j1qrJKM7+bp
         P06T1NhQFOSTeILIcDdZiYIbm1FILYdO04vFRszXD6zy1FhLrwMPIaNrfLI1p4FempaK
         JIbIyvDEnU7xy4tOpOMAsYn+ngt9JZU69+QjylTYb0y426O41rF96XAtvzhN80gJmNuF
         j5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j1hvlB2w2BrWNScbCJyLwX4oBGKG9hr6NJqtvFkNM/U=;
        b=3ZsJMtkoZirHmHbtWCQWjhyEWlHvgvc8zux5rplsI9f4VOHxw/aUt1EPe2jrX/LnQp
         iqLWzV9X1NXHQqau+xX+rRCY+eyWx4oU8shnVGgz2tyzr681RM67MfEL/2w4lyurWgz5
         lsJrpyvN3zb6gLWtGLs0pIg8Y8aYynF2t+PuERKIIGVKeStOU7L0Y5Ve68LaBTnxxefy
         XeLOdq2eFXaVhNzm+FziWbE2TZZb5bacFlSH0A7RigNlUH+JhtpAGkMHk2/cdLXfX4Mf
         L3tKKCVYymwgvo5vW1bxbvzgmzpWwQktWMJOxsiintkRkoycTpYBTrLf7o3C8RIECId6
         l0OA==
X-Gm-Message-State: AOAM533OFt8HpoXb56XjtNLLrkUp0Ra6BVbqLH/VeqySuEhONEhfk6Un
        8wvuBWjdzYaDeJzyM081iTTuLj50f7A=
X-Google-Smtp-Source: ABdhPJwwyZAuw0wQQ6Dju/0DgEoENSIDq2aqqR4iP7Vldq5bfh8DtMEIrZOS6poEr19ZPeaYgjpDkg==
X-Received: by 2002:ac2:58d9:: with SMTP id u25mr14351127lfo.514.1639162324540;
        Fri, 10 Dec 2021 10:52:04 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id c21sm387216lfv.29.2021.12.10.10.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:52:04 -0800 (PST)
Subject: Re: [PATCH v4 03/25] notifier: Add
 atomic/blocking_notifier_has_unique_priority()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
 <20211126180101.27818-4-digetx@gmail.com>
 <CAJZ5v0jTJ3f7oUUR690PGaPJsxA8yzua9XDa8MONBHMzHnDfOQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e6ff1cea-a168-1cb0-25c5-fb16c681cf4a@gmail.com>
Date:   Fri, 10 Dec 2021 21:52:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jTJ3f7oUUR690PGaPJsxA8yzua9XDa8MONBHMzHnDfOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 21:19, Rafael J. Wysocki пишет:
...
>> +bool atomic_notifier_has_unique_priority(struct atomic_notifier_head *nh,
>> +               struct notifier_block *n)
>> +{
>> +       unsigned long flags;
>> +       bool ret;
>> +
>> +       spin_lock_irqsave(&nh->lock, flags);
>> +       ret = notifier_has_unique_priority(&nh->head, n);
>> +       spin_unlock_irqrestore(&nh->lock, flags);
> 
> This only works if the caller can prevent new entries from being added
> to the list at this point or if the caller knows that they cannot be
> added for some reason, but the kerneldoc doesn't mention this
> limitation.

I'll update the comment.

..
>> +bool blocking_notifier_has_unique_priority(struct blocking_notifier_head *nh,
>> +               struct notifier_block *n)
>> +{
>> +       bool ret;
>> +
>> +       /*
>> +        * This code gets used during boot-up, when task switching is
>> +        * not yet working and interrupts must remain disabled. At such
>> +        * times we must not call down_read().
>> +        */
>> +       if (system_state != SYSTEM_BOOTING)
> 
> No, please don't do this, it makes the whole thing error-prone.

What should I do then?

>> +               down_read(&nh->rwsem);
>> +
>> +       ret = notifier_has_unique_priority(&nh->head, n);
>> +
>> +       if (system_state != SYSTEM_BOOTING)
>> +               up_read(&nh->rwsem);
> 
> And still what if a new entry with a non-unique priority is added to
> the chain at this point?

If entry with a non-unique priority is added after the check, then
obviously it won't be detected. I don't understand the question. These
down/up_read() are the locks that prevent the race, if that's the question.

