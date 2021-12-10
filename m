Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E78470977
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245663AbhLJS56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245647AbhLJS55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:57:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0E3C0617A1;
        Fri, 10 Dec 2021 10:54:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u3so19759874lfl.2;
        Fri, 10 Dec 2021 10:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IKf1m11e2CmLOphgB5tXRwG67Tf75LBrlnq5Vg7yJZw=;
        b=IxhbpvG2CFXB3xmkjVMdWRMntYmHOq8xg7eP7zr/AbSS5vu1B9sdxo5o91nGOD2995
         QQ3KG6tw48EY7IhOrAyb30j6v2PDl8KJF+jKSnPayvNkG1XmqZAU+fLfW7OnlwsZZOnn
         0A9elkL050dIg2mh2nAMxrCkv1StUF1LjCWn+NlhosKjCmIUCMa0MKcmxWQ+/W+IgKI6
         i8CNkkus5bglRUlOxac8XP3LVuSzA40MUvRiA2U0B7IAsHpJ1AsKj9N6snoJl+u70szG
         pZzPqoOnQIc/elfvbeQCxFa9JUiQLy0NMI8wwjD0fM288MJ0ySJSpfHIgwDyPyb7i3mv
         C2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IKf1m11e2CmLOphgB5tXRwG67Tf75LBrlnq5Vg7yJZw=;
        b=ATBGtFOO9lS2ZkdI/AuSuu9PS+Inp2r31yRXHU5hBPIbkJraYoSCJQiS5QSFJSHd4l
         RE/1wrOzGq8p62AsHN47zvzncKuqJSSr8b2quBV3WTC7vNHfFFTCmSdbGACDoxVpqbXV
         gE1a/W6xHU0FprSZVOBV3Ra5eFwJGj5GOrDzAGFC/BPbvrOmqinJlRrT/ike9x1BJ3Ba
         47CAoEPGLwk69X7nJOdmh1GtOAJMpTlpTif21ZP9IlfQWPC6TdBl7febG80bQoaPVqE4
         ++Bp6JfwnjKLKAeMmsVcObJ+fhmIG4rR5oUHU6xu5f9V+4UA0hAoNlTZvd5jl8dnASz+
         VbgA==
X-Gm-Message-State: AOAM532GRf235Gc/nZSzObeM/gPYVNzr/bw39oK3E5iqx7wj0vVcCfJF
        rs6WcM7pUziox9KLl2aduEJjuJBVTwg=
X-Google-Smtp-Source: ABdhPJyNtPZVq+j4jRpVe2vNWn4eVPA/mLyRKU7MjcAV9J6qXLR8NEClMh21SuEPG0vCBnH7Acz/0w==
X-Received: by 2002:ac2:4c4d:: with SMTP id o13mr13668768lfk.196.1639162460068;
        Fri, 10 Dec 2021 10:54:20 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id v15sm390403ljj.5.2021.12.10.10.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:54:19 -0800 (PST)
Subject: Re: [PATCH v4 06/25] reboot: Warn if unregister_restart_handler()
 fails
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
 <20211126180101.27818-7-digetx@gmail.com>
 <CAJZ5v0ii7tGRDbxw+5GqdyONXvRPznXUqBZd03+pdoAd+pH=JQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c518ce36-09d2-16a3-cec2-6bab8260e3cf@gmail.com>
Date:   Fri, 10 Dec 2021 21:54:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ii7tGRDbxw+5GqdyONXvRPznXUqBZd03+pdoAd+pH=JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 21:32, Rafael J. Wysocki пишет:
> On Fri, Nov 26, 2021 at 7:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Emit warning if unregister_restart_handler() fails since it never should
>> fail. This will ease further API development by catching mistakes early.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  kernel/reboot.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index e6659ae329f1..f0e7b9c13f6b 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -210,7 +210,7 @@ EXPORT_SYMBOL(register_restart_handler);
>>   */
>>  int unregister_restart_handler(struct notifier_block *nb)
>>  {
>> -       return atomic_notifier_chain_unregister(&restart_handler_list, nb);
>> +       return WARN_ON(atomic_notifier_chain_unregister(&restart_handler_list, nb));
> 
> The only reason why it can fail is if the object pointed to by nb is
> not in the chain.

I had exactly this case where object wasn't in the chain due to a bug
and this warning was very helpful.

>  Why WARN() about this?  And what about systems with
> panic_on_warn set?

That warning condition will never happen normally, only when something
is seriously wrong.

Those systems with panic_on_warn will get what was they asked for.
