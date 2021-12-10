Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15362470A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbhLJTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242169AbhLJTqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:46:23 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B0C0617A1;
        Fri, 10 Dec 2021 11:42:47 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id p8so15243931ljo.5;
        Fri, 10 Dec 2021 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=enFW8kq8VV/q8dA9a71dgatcJTVb3G9Q0VbIAiUg3GI=;
        b=OX0KzgQUdES/90pWlhpcoFWULe5/02wjF+ZN5bPPd3PaEe6K8Rw2QbmG+hYBDryF8r
         t1f6EkNRPieboSxPtviSTR/1V4y4Mr8zIstzUICcEoY48eKM2+0m88Bup+wVJuu+v7rM
         mwIk5EqSpZDyoTDNu1aQivf7cqdLiwt7kJ7MYsCU49jLtqsBENUcVljNfz8djr77JsJw
         nEuxWBBZFJueyYpPkJsYZuSAKA0Qf9vITcyimaXwItLwdGCf5tFbJFT6C3clmEwXp7kg
         1TFGkI4NdX0eDs8czP/NCn+FzZ3eaPKoluKA8KfWOjMbGdEYGco1sgCURxizjwPPW+3Z
         YGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=enFW8kq8VV/q8dA9a71dgatcJTVb3G9Q0VbIAiUg3GI=;
        b=1CBLgn9WJHZMjFXSUdp+K6zZ8485AEfGLkgj0laB61nRxiE6nFNIJGhCet1Kn0kjxm
         hry+Plckms5c2yXSkF59xpXIrv/X8CJCbvYbqE9vjyvgvV2RnkBfuJvu3CYthgOJRbM0
         yCzq+lLo3usMGMrVNhUfblxd6CbCJoc0H0e4RHvOVeixl1HkXOfedMDqoBfW56IGRL6/
         RO4hSwD+vZBp5bkdmGRE4/Zb6cvpOzON1JZNGt0ZmmzCRVLRGp0b5XvHaGndM2XJCeER
         hEv89G+LqLWInuS/Ycm+w2BmtqyfvIxECLuf8F3YtA2TrXO2xItEHZPFa5zq/x6zdCmZ
         sMgw==
X-Gm-Message-State: AOAM532r0wB1ErO4buMdgX8dBZ3wpD+48wAdRQSx48Fw0r+fyM4RusoR
        33IVo9KCl+gfejeBL/QBGTwH4mdY9PM=
X-Google-Smtp-Source: ABdhPJw7x5EmEcRpJsG2MrtTa2zjfPAYa0CkU29XHMHibYlDXJBMyWndjSh2p83fU9klfOOOmpp/mQ==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr15096538ljg.68.1639165365371;
        Fri, 10 Dec 2021 11:42:45 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id a24sm397890ljd.25.2021.12.10.11.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:42:45 -0800 (PST)
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
 <45025b2d-4be1-f694-be61-31903795cf5d@gmail.com>
 <CAJZ5v0ieTwnBVjW8R_VTdPFH3yr5AwLc+ZEG5N3KrpTH+j8qZw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <45228c88-4d51-591e-5da5-9ec468e71684@gmail.com>
Date:   Fri, 10 Dec 2021 22:42:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ieTwnBVjW8R_VTdPFH3yr5AwLc+ZEG5N3KrpTH+j8qZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 22:14, Rafael J. Wysocki пишет:
> On Fri, Dec 10, 2021 at 8:04 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 10.12.2021 21:27, Rafael J. Wysocki пишет:
>>> On Mon, Nov 29, 2021 at 12:34 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 29.11.2021 03:26, Michał Mirosław пишет:
>>>>> On Mon, Nov 29, 2021 at 12:06:19AM +0300, Dmitry Osipenko wrote:
>>>>>> 28.11.2021 03:28, Michał Mirosław пишет:
>>>>>>> On Fri, Nov 26, 2021 at 09:00:41PM +0300, Dmitry Osipenko wrote:
>>>>>>>> Add sanity check which ensures that there are no two restart handlers
>>>>>>>> registered with the same priority. Normally it's a direct sign of a
>>>>>>>> problem if two handlers use the same priority.
>>>>>>>
>>>>>>> The patch doesn't ensure the property that there are no duplicated-priority
>>>>>>> entries on the chain.
>>>>>>
>>>>>> It's not the exact point of this patch.
>>>>>>
>>>>>>> I'd rather see a atomic_notifier_chain_register_unique() that returns
>>>>>>> -EBUSY or something istead of adding an entry with duplicate priority.
>>>>>>> That way it would need only one list traversal unless you want to
>>>>>>> register the duplicate anyway (then you would call the older
>>>>>>> atomic_notifier_chain_register() after reporting the error).
>>>>>>
>>>>>> The point of this patch is to warn developers about the problem that
>>>>>> needs to be fixed. We already have such troubling drivers in mainline.
>>>>>>
>>>>>> It's not critical to register different handlers with a duplicated
>>>>>> priorities, but such cases really need to be corrected. We shouldn't
>>>>>> break users' machines during transition to the new API, meanwhile
>>>>>> developers should take action of fixing theirs drivers.
>>>>>>
>>>>>>> (Or you could return > 0 when a duplicate is registered in
>>>>>>> atomic_notifier_chain_register() if the callers are prepared
>>>>>>> for that. I don't really like this way, though.)
>>>>>>
>>>>>> I had a similar thought at some point before and decided that I'm not in
>>>>>> favor of this approach. It's nicer to have a dedicated function that
>>>>>> verifies the uniqueness, IMO.
>>>>>
>>>>> I don't like the part that it traverses the list second time to check
>>>>> the uniqueness. But actually you could avoid that if
>>>>> notifier_chain_register() would always add equal-priority entries in
>>>>> reverse order:
>>>>>
>>>>>  static int notifier_chain_register(struct notifier_block **nl,
>>>>>               struct notifier_block *n)
>>>>>  {
>>>>>       while ((*nl) != NULL) {
>>>>>               if (unlikely((*nl) == n)) {
>>>>>                       WARN(1, "double register detected");
>>>>>                       return 0;
>>>>>               }
>>>>> -             if (n->priority > (*nl)->priority)
>>>>> +             if (n->priority >= (*nl)->priority)
>>>>>                       break;
>>>>>               nl = &((*nl)->next);
>>>>>       }
>>>>>       n->next = *nl;
>>>>>       rcu_assign_pointer(*nl, n);
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> Then the check for uniqueness after adding would be:
>>>>>
>>>>>  WARN(nb->next && nb->priority == nb->next->priority);
>>>>
>>>> We can't just change the registration order because invocation order of
>>>> the call chain depends on the registration order
>>>
>>> It doesn't if unique priorities are required and isn't that what you want?
>>>
>>>> and some of current
>>>> users may rely on that order. I'm pretty sure that changing the order
>>>> will have unfortunate consequences.
>>>
>>> Well, the WARN() doesn't help much then.
>>>
>>> Either you can make all of the users register with unique priorities,
>>> and then you can make the registration reject non-unique ones, or you
>>> cannot assume them to be unique.
>>
>> There is no strong requirement for priorities to be unique, the reboot.c
>> code will work properly.
> 
> In which case adding the WARN() is not appropriate IMV.
> 
> Also I've looked at the existing code and at least in some cases the
> order in which the notifiers run doesn't matter.  I'm not sure what
> the purpose of this patch is TBH.

The purpose is to let developer know that driver needs to be corrected.

>> The potential problem is on the user's side and the warning is intended
>> to aid the user.
> 
> Unless somebody has the panic_on_warn mentioned previously set and
> really the user need not understand what the WARN() is about.  IOW,
> WARN() helps developers, not users.
> 
>> We can make it a strong requirement, but only after converting and
>> testing all kernel drivers.
> 
> Right.
> 
>> I'll consider to add patches for that.
> 
> But can you avoid adding more patches to this series?

I won't add more patches since such patches can be added only after
completion of transition to the new API of the whole kernel.
