Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660BA4709B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbhLJTIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241625AbhLJTIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:08:07 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803CC0617A1;
        Fri, 10 Dec 2021 11:04:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d10so19750769lfg.6;
        Fri, 10 Dec 2021 11:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rvbAWOjnQ4iiK2qTm1VE6lQGOrcjLKyz5OxaYJHSlms=;
        b=TjeoyxCasR5FMVdl/A0tp1mA72HfZpG7IA3P7NymDxwSTTW3+ca77Hp0RW3fNn90V6
         BsHjIyUl7Vlp+L39rylawnkVapGjnUQqVeWKvetFiA7uvJFxyv0GjUpcVXKt0X+55JJr
         xqXdSvj9BdLL7KX3hwRLKx+qpMEtqmR2FUek4bTb6sXBna+eG0YWGMxM64DOjx5RNWe4
         HoiJuPojsDMo1meIr/+QThmv79vJf2KZerbGrOUNNaqfzynbYTAS2muusrYdRhnsIt5A
         B24OARH3dPFHv5rk46GLF+MM2vVZfTdlA9nyGZ9hBzpvwzg8kPFwKLRgebHs+PEO+1Iq
         vobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rvbAWOjnQ4iiK2qTm1VE6lQGOrcjLKyz5OxaYJHSlms=;
        b=2AnLLKMYY9h33CHEReDkueoANUm2gzmm/2WVoyOxc1+W2EEMK2IZnUyyDvdTghts6V
         IjAxJqrviJAt7VXiVdQdFKeupX4UPh3mt82zLoi2OcOJrteQGyFUsNQ2GIJdvKYWo9St
         5l34yRXkOtT1ayOQWalhHcRGoqd1upbajBqZZvSIyClAi4AlMPSIVSWIDLFhD/INTsEM
         MytSD92t6PKTbcQjXf+QqCCYR2KHo8JkKIVH0+2IKNtwPWUO8Tm7dVmXNGUabHpv/T1Q
         QVyeA0LS3dvKGrRBGSXBcYTqw5C/3rPFt5/0S84ZlY4oJ4c+jKXkaEnM0omUhIOpUAq5
         dCSA==
X-Gm-Message-State: AOAM532SKxdXzz2NRggWRQJDQmeeMCyelnMXh8pmePKtWo7Hks19Zd2n
        LxgNAGS/OYYAi6TpCQyO9saOLIP8MEY=
X-Google-Smtp-Source: ABdhPJyGg6V6axU9mPpKq+4o9ssjbFc0zNzIldal4eICWlLYfWsm94H3hqPTZ3hkXuJwkEExqxjrPg==
X-Received: by 2002:a05:6512:3f84:: with SMTP id x4mr14257818lfa.346.1639163070363;
        Fri, 10 Dec 2021 11:04:30 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id k27sm385556ljc.129.2021.12.10.11.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:04:29 -0800 (PST)
Subject: Re: [PATCH v4 05/25] reboot: Warn if restart handler has duplicated
 priority
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <45025b2d-4be1-f694-be61-31903795cf5d@gmail.com>
Date:   Fri, 10 Dec 2021 22:04:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jMvdhfBqjY+V9h_Z6EH1ohuJH+KjuGiOw_Jor1Tnp7vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 21:27, Rafael J. Wysocki пишет:
> On Mon, Nov 29, 2021 at 12:34 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 29.11.2021 03:26, Michał Mirosław пишет:
>>> On Mon, Nov 29, 2021 at 12:06:19AM +0300, Dmitry Osipenko wrote:
>>>> 28.11.2021 03:28, Michał Mirosław пишет:
>>>>> On Fri, Nov 26, 2021 at 09:00:41PM +0300, Dmitry Osipenko wrote:
>>>>>> Add sanity check which ensures that there are no two restart handlers
>>>>>> registered with the same priority. Normally it's a direct sign of a
>>>>>> problem if two handlers use the same priority.
>>>>>
>>>>> The patch doesn't ensure the property that there are no duplicated-priority
>>>>> entries on the chain.
>>>>
>>>> It's not the exact point of this patch.
>>>>
>>>>> I'd rather see a atomic_notifier_chain_register_unique() that returns
>>>>> -EBUSY or something istead of adding an entry with duplicate priority.
>>>>> That way it would need only one list traversal unless you want to
>>>>> register the duplicate anyway (then you would call the older
>>>>> atomic_notifier_chain_register() after reporting the error).
>>>>
>>>> The point of this patch is to warn developers about the problem that
>>>> needs to be fixed. We already have such troubling drivers in mainline.
>>>>
>>>> It's not critical to register different handlers with a duplicated
>>>> priorities, but such cases really need to be corrected. We shouldn't
>>>> break users' machines during transition to the new API, meanwhile
>>>> developers should take action of fixing theirs drivers.
>>>>
>>>>> (Or you could return > 0 when a duplicate is registered in
>>>>> atomic_notifier_chain_register() if the callers are prepared
>>>>> for that. I don't really like this way, though.)
>>>>
>>>> I had a similar thought at some point before and decided that I'm not in
>>>> favor of this approach. It's nicer to have a dedicated function that
>>>> verifies the uniqueness, IMO.
>>>
>>> I don't like the part that it traverses the list second time to check
>>> the uniqueness. But actually you could avoid that if
>>> notifier_chain_register() would always add equal-priority entries in
>>> reverse order:
>>>
>>>  static int notifier_chain_register(struct notifier_block **nl,
>>>               struct notifier_block *n)
>>>  {
>>>       while ((*nl) != NULL) {
>>>               if (unlikely((*nl) == n)) {
>>>                       WARN(1, "double register detected");
>>>                       return 0;
>>>               }
>>> -             if (n->priority > (*nl)->priority)
>>> +             if (n->priority >= (*nl)->priority)
>>>                       break;
>>>               nl = &((*nl)->next);
>>>       }
>>>       n->next = *nl;
>>>       rcu_assign_pointer(*nl, n);
>>>       return 0;
>>>  }
>>>
>>> Then the check for uniqueness after adding would be:
>>>
>>>  WARN(nb->next && nb->priority == nb->next->priority);
>>
>> We can't just change the registration order because invocation order of
>> the call chain depends on the registration order
> 
> It doesn't if unique priorities are required and isn't that what you want?
> 
>> and some of current
>> users may rely on that order. I'm pretty sure that changing the order
>> will have unfortunate consequences.
> 
> Well, the WARN() doesn't help much then.
> 
> Either you can make all of the users register with unique priorities,
> and then you can make the registration reject non-unique ones, or you
> cannot assume them to be unique.

There is no strong requirement for priorities to be unique, the reboot.c
code will work properly.

The potential problem is on the user's side and the warning is intended
to aid the user.

We can make it a strong requirement, but only after converting and
testing all kernel drivers. I'll consider to add patches for that.
