Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093684B9CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiBQKNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:13:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbiBQKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:13:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140AB143469;
        Thu, 17 Feb 2022 02:13:01 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id n24so7474925ljj.10;
        Thu, 17 Feb 2022 02:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OO8O5AkWPhI/5yGYSTEQp+LjZetKZnyQ+pZ7++XrzEA=;
        b=X8w7in6JtN9+vwIDY375tbKdJ6/kAXjQzoJEMNX/aRNZ/xldyGjWjXODYmSy5mi1RE
         IVBvYSJ5Q0hWoh3euDgluS6hajxAwota0SjPBhdLfholDQzq33VHuJfcHHzCkXGyz8tb
         MDBzs6ibY/EGdDqB/ff2GewtKr6TpYHNqvy5y4L9nhOeKSaVrEEfVSAdHs3oIc8/KGvy
         BUoC/Ntz4HLIebyoKI3bup9qeurRZrprpsOzzaMBNquRHtxpasWvx6s1xD7yjJ47gW7a
         aqMUkT2VhDOvjwLmzIlZFje3GuDLrgVXuDJcvjJJbqm/WRU77L4UMZYg+2nxY7fnS64M
         8wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OO8O5AkWPhI/5yGYSTEQp+LjZetKZnyQ+pZ7++XrzEA=;
        b=7pr47jE/gdAdaDrCCfyYmBUiEIX35Jia+LTn+J6qHiHUFJ3a6Bm/wYJfBtMgD80XM7
         08+9aZXK57FDzfN0oNQNxysoi9K3/Z9SCmgPPmMAqi5DvgiNWbWGtT1Psubir4+SXU+o
         gRV+UCMI/bHhNXyFqqq4EYldR+1mU0vky+FWzW805Nb6ZzUABhsqUHBgWy3W64kJuagb
         xrQofwp652Cdq7wqG1Ppo7wdJLFt4fCdhv7dcE/6F5zEC0gt38PkKdGWMDRMUqoHH14A
         Lbe+x56E4n+G+Qrx8fdAHjTSmjCd/nzEYPt6JB/gtxXm0ufp6JJ870vKPi7kBlYpJT/q
         PKYw==
X-Gm-Message-State: AOAM531lg7CNRkr5GP49SV/u3DBjyETkU9AirEe1YGwbGmOKQGR7AOrk
        mSTXBVd88G2R12+sHTThCSLVPemO/hU=
X-Google-Smtp-Source: ABdhPJzppLbwPh7ryO4JRMtpJc/4Lz2rbVquaymBUgCgBO2OneSkA3o02raf386TVCaqFDiGA98BPg==
X-Received: by 2002:a05:651c:1544:b0:246:1887:cf4c with SMTP id y4-20020a05651c154400b002461887cf4cmr917179ljp.118.1645092779295;
        Thu, 17 Feb 2022 02:12:59 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id o10sm5079173lfl.116.2022.02.17.02.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 02:12:58 -0800 (PST)
Message-ID: <4f0d1b50-9f55-dd81-f0c7-f5e0dfd75c2a@gmail.com>
Date:   Thu, 17 Feb 2022 13:12:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 00/21] Introduce power-off+restart call chain API
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
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
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20220130233718.21544-1-digetx@gmail.com>
 <635e8121-fca4-580c-6af5-d9317a2eee1b@gmail.com>
 <CAJZ5v0g0MrBm2+GwctkB7kUyBEt6HTAexRCFFRmTF1UKDrVQ-g@mail.gmail.com>
 <de2cbd2a-8d0d-8678-e514-b153d04546cc@gmx.de>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <de2cbd2a-8d0d-8678-e514-b153d04546cc@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.02.2022 23:30, Helge Deller пишет:
> On 2/16/22 13:25, Rafael J. Wysocki wrote:
>> On Tue, Feb 15, 2022 at 11:00 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>> 31.01.2022 02:36, Dmitry Osipenko пишет:
>>>> Problem
>>>> -------
>>>>
>>>> SoC devices require power-off call chaining functionality from kernel.
>>>> We have a widely used restart chaining provided by restart notifier API,
>>>> but nothing for power-off.
>>>>
>>>> Solution
>>>> --------
>>>>
>>>> Introduce new API that provides both restart and power-off call chains.
>>>>
>>>> Why combine restart with power-off? Because drivers often do both.
>>>> More practical to have API that provides both under the same roof.
>>>>
>>>> The new API is designed with simplicity and extensibility in mind.
>>>> It's built upon the existing restart and reboot APIs. The simplicity
>>>> is in new helper functions that are convenient for drivers. The
>>>> extensibility is in the design that doesn't hardcode callback
>>>> arguments, making easy to add new parameters and remove old.
>>>>
>>>> This is a third attempt to introduce the new API. First was made by
>>>> Guenter Roeck back in 2014, second was made by Thierry Reding in 2017.
>>>> In fact the work didn't stop and recently arm_pm_restart() was removed
>>>> from v5.14 kernel, which was a part of preparatory work started by
>>>> Guenter Roeck. I took into account experience and ideas from the
>>>> previous attempts, extended and polished them.
>>>
>>>
>>> Rafael and all, do you see anything critical that needs to be improved
>>> in this v6?
>>>
>>> Will be great if you could take this patchset via the power tree if it
>>> looks okay, or give an ack.
>>
>> I need some more time for this, sorry.

No worries, we're not in a rush.

>> I'm a bit concerned about seeing no response to this set from anyone.
>>
>> It looks like multiple platforms may be affected by it in principle,
>> so doesn't anyone care?

The platforms that didn't provide ack so far are: SH, x86, IA64, MIPS
and NDS32. At least x86 and MIPS are alive, not sure why maintainers
didn't bother to answer yet.

> I did looked into the whole patch set after applying it locally.
> 
> While I agree a new combined API is good, and the beginning looked promising,
> after some time I started to ask myself if the whole infrastructure might
> be a little overdesigned.
> 
> Anyway, I tested it and it works for me on parisc.
> And it's probably better than what we have today.

Thank you!
