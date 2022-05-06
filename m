Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44A51DA2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442052AbiEFOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442080AbiEFOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:14:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877529C96;
        Fri,  6 May 2022 07:10:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id C4EBD1F46719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651846231;
        bh=aPzN11eOYyBmn6uYxSJ4z+OxGW0B11goKlzatjEFOG4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A5kW1JJmvHfMp+G3BYZfs1DtIoJxwTSAkQcm9HkU230sGHCbaarPy3d3ylVb7ghQK
         QFidNeP16CsPIu7NGef5buR6vQrZaa2Bu2Ol7ocivR52MK99+p14lZHhPhckFBadHq
         LWO8HGz0L5XHJgOXIl4zHum9KGrTPQ8XNRCAiPLiBFHqfgiXkDJFYnZvSeZjgWY6Sf
         b+r6JcWvC90AjEGx12tTLe293/2dwUtSGPf4vDeIZmmldanQoeJoRJ1W5+Zs/dm4mK
         YMULBdy55mQ6HS0+7WhL/7UJ3ikAvXuW+YZrNYtURWDPqYm9/aozEGozBwUb1cqkv6
         H0OATVRjsYPpg==
Message-ID: <ca422804-0fa0-5fef-07e2-a9ff005a495c@collabora.com>
Date:   Fri, 6 May 2022 17:10:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v7 04/20] kernel: Add combined power-off+restart handler
 call chain API
Content-Language: en-US
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20220411233832.391817-1-dmitry.osipenko@collabora.com>
 <20220411233832.391817-5-dmitry.osipenko@collabora.com>
 <CAJZ5v0gnTSoeNP+QXwrZ45FQY4howVkJMuCjM=j+_-2BngJdQg@mail.gmail.com>
 <990621e7-9f8a-8b4a-02ec-fd6c1e1f48ff@collabora.com>
 <CAJZ5v0jxXtwot0qpib4UG8Tz8Hd1dEbgo58tEdPFboU8xwKHNw@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJZ5v0jxXtwot0qpib4UG8Tz8Hd1dEbgo58tEdPFboU8xwKHNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 21:47, Rafael J. Wysocki wrote:
>>>> +       POWEROFF_PREPARE,
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct power_off_data - Power-off callback argument
>>>> + *
>>>> + * @cb_data: Callback data.
>>>> + */
>>>> +struct power_off_data {
>>>> +       void *cb_data;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct power_off_prep_data - Power-off preparation callback argument
>>>> + *
>>>> + * @cb_data: Callback data.
>>>> + */
>>>> +struct power_off_prep_data {
>>>> +       void *cb_data;
>>>> +};
>>> Why does this need to be a separate data type?
>> To allow us extend the "struct power_off_prep_data" with more parameters
>> later on without a need to update each driver with the new arguments.

> I'm not really sure what you mean here.  Can you give an example?
> 

The restart callbacks use more than the cb_data and we have:

struct restart_data {
	void *cb_data;
	const char *cmd;
	bool stop_chain;
	enum reboot_mode mode;
};

If we'll ever need to extended struct power_off_data similarly to the
restart_data, then we will need to update all the power-off callbacks
instead of adding a new field to the power_off_data.

Hence, for example, if you'll want to extend power_off_data with "enum
poweroff_mode mode", then for each driver you'll need to do this change:

-power_off(void *cb_data)
+power_off(void *cb_data, enum poweroff_mode mode)

and you won't need to do that using struct power_off_data.

Why do we need this? Because I saw in the past people changing kernel
APIs that way when they wanted to add new arguments and then needed to
update every call site around the kernel.

-- 
Best regards,
Dmitry
