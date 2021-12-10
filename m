Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A571470BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbhLJUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhLJUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:20:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1BFC0617A1;
        Fri, 10 Dec 2021 12:16:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l22so20022448lfg.7;
        Fri, 10 Dec 2021 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3TjXmEXDJ/+bmC4Ps/ax4TtRHBZzHR+/4MLS5Bo5vyY=;
        b=pA5gJzqpb6DuYCThgFEy/8I55Q/DWCaUg3a+PUCGAi7titTHPZavt9HNjzNTaNOdtA
         W9bvYLeTFtb26OuFlSespYNsQjEuRbN74aib6efdQf4sRvk0jZOXEyR7Ry1SlPtvny3V
         dHFm88kS0utx46N/B1V95jCju3EdX/3tioPOW0AUjL07+k8WzDTAaYKBNQJxB0pggImt
         zxKY302IiWihQZ6zPY6n4S1ZYz2akRfe0TTR5ci41YrCJJyH8fb1pqNG9DRsK91AXeR3
         4OlRlbRYehYwacP4ScBqgyVswzojoT/ol0CB6bk5gTERql84YP9I/T1kujCvte5MFcNM
         x95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3TjXmEXDJ/+bmC4Ps/ax4TtRHBZzHR+/4MLS5Bo5vyY=;
        b=Z5E4HwNMYLLTdBmn8mNTFzzPDV6OmszU6ADD7WYc0CmUjohhIsXZHhioXuT7G4v4J+
         v711hHi8OWaYIOzfPpQONluZYFWoGkOWFIVbuWStC1qKlnlCeGSOg7Sf4Syk0yqfk/By
         Eb/7K9IM10/HIb6ondKHyeo//uP87oooICuBf7sKFXdpppYHStx7blbMAKfzHq7vN+y4
         Djkzam3+DVV2ljUxI4J6Rz+WUmuxQjz/mdXIsnlzyeUT8533gyhGT8om8q5PUMr5Dwhi
         xqwK/aoW/SdKWhykVtG645rYKLYc0Kj1sXpg2JnoKMHe/i2uz35DuxFLJzw4jXd6kxt4
         KM1w==
X-Gm-Message-State: AOAM530aCh6insR5DZasI1/ehhHZ8aar+QI+dJq/YoqY7tAC5Oym8LMv
        4ntSwcR2cbdYbuPpH62GAQALanUtGUM=
X-Google-Smtp-Source: ABdhPJwE5tZeH/HHL0CnlLb6JayzZfWyUFquo/I1vHYJYjJlUN8IQfec3+fnfy4fMkF6dVQvXojbFQ==
X-Received: by 2002:a05:6512:2292:: with SMTP id f18mr14265704lfu.18.1639167392050;
        Fri, 10 Dec 2021 12:16:32 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id z23sm409427ljn.23.2021.12.10.12.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 12:16:31 -0800 (PST)
Subject: Re: [PATCH v4 03/25] notifier: Add
 atomic/blocking_notifier_has_unique_priority()
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <e6ff1cea-a168-1cb0-25c5-fb16c681cf4a@gmail.com>
 <CAJZ5v0gwnY07vg71_NB8RDWyv84FtMsmx7UTDd8TkUd7vFzc6A@mail.gmail.com>
 <fd158245-aa9a-2e48-0145-004f30005a66@gmail.com>
Message-ID: <218e67e2-1d8c-5727-3862-8884d74aa63e@gmail.com>
Date:   Fri, 10 Dec 2021 23:16:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fd158245-aa9a-2e48-0145-004f30005a66@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 22:33, Dmitry Osipenko пишет:
>> Not really, they only prevent the race from occurring while
>> notifier_has_unique_priority() is running.
>>
>> If anyone depends on this check for correctness, they need to lock the
>> rwsem, do the check, do the thing depending on the check while holding
>> the rwsem and then release the rwsem.  Otherwise it is racy.
>>
> It's fine that it's a bit "racy" since in the context of this series. We
> always do the check after adding new entry, so it's not a problem.
> 
> There are two options:
> 
> 1. Use blocking_notifier_has_unique_priority() like it's done in this
> patchset. Remove it after all drivers are converted to the new API and
> add blocking_notifier_chain_register_unique().
> 
> 2. Add blocking_notifier_chain_register_unique(), but don't let it fail
> the registration of non-unique entries until all drivers are converted
> to the new API.

There is third, perhaps the best option:

3. Add blocking_notifier_chain_register_unique() and fall back to
blocking_notifier_chain_register() if unique fails, do it until all
drivers are converted to the new API.
