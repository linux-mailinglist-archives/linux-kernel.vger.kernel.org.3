Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A367146162F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377455AbhK2N0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377631AbhK2NYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:24:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19D7C08EE1B;
        Mon, 29 Nov 2021 04:04:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b1so43778622lfs.13;
        Mon, 29 Nov 2021 04:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PNn5ANXHQBQImIpvHbPbNMd2Lqd15EQlJogO89cnByY=;
        b=MI4kP55/Zlm7TBL7y2OrNMI5h+lPZeZmB7t8OlZkmrVqz5nkh2/Y6HuliAe0oVs0Rk
         rFetODlieSY8yYJ/zujS836D4HMa1RwjML/CAxKtomUWXSGb1qL/KVpTn6q2+Uvz6fll
         o53AZuiQAc2GWbWiafTtGZSuw2c5mqIFJqFNiJYF9aTjEDiBqb562eel2zakvhyPlOl3
         pG/pjhw/StA1ckadkeclKZKjMkX16zdmIl6oAlX+4fS7qeRy6PONzcXzKzm9X1QdAno0
         Kkwc07Ys2BvHYPaVq37PhoNg88rbf4eu8IhUwjBo48bGGmIHfJryc8vu/Bws5bIp8Ted
         95RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PNn5ANXHQBQImIpvHbPbNMd2Lqd15EQlJogO89cnByY=;
        b=ofoh+c30kzyAvX7PeNash1HX3Wdv4rC9lL5fjgeHWDZAoqZ3VSFXUrvyMTXyTkHz91
         WP0SKuI050NO18iCfzHFHzZI26EdDDUfK3r7cc2es8wnsVEE1dvDQKPBMcuFVHoHkQhN
         ZvgRCT1aeQ4xpcYTgjI/Jv5cQhixzSFNqbuhpXzC/eGr1qI49Bn4lYdg7YMgQEMHNizw
         uOetJQx1w/rafolkGj9sO4XkBYPLaHFnBKEqglLSCJjKb9SHu797TFKzHwt+Q3+iDqZC
         GGQZdmw1gYnjgGiYcy0EfnLpr9N8w74chiHVlEu8mc1fnEAuKxB93sNn+CCRSiJGXAMP
         tFqg==
X-Gm-Message-State: AOAM531Z5gComcgPWQJ2C4Z88M84Qkfz1GWynH3L4PWV3UmRrJj1Ant2
        GqXkMtb1Mjb9qZfmLR9ekSxxM2RqH8g=
X-Google-Smtp-Source: ABdhPJwfeiycltlybhTj7UKB2JEhJqYEuRYscpRNQomunXBGc+OXGSTBjoVVWr3Sr9Zkv1hFoSwEuA==
X-Received: by 2002:a05:6512:e9c:: with SMTP id bi28mr45440847lfb.245.1638187475542;
        Mon, 29 Nov 2021 04:04:35 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id g12sm1317274lfu.135.2021.11.29.04.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 04:04:34 -0800 (PST)
Subject: Re: [PATCH v2 28/45] mfd: rn5t618: Use devm_register_power_handler()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
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
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-omap@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
References: <20211027211715.12671-1-digetx@gmail.com>
 <20211027211715.12671-29-digetx@gmail.com> <YaS/lStp2b8GhVxw@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <592f2326-b450-1db1-0d3d-804415cf5de6@gmail.com>
Date:   Mon, 29 Nov 2021 15:04:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaS/lStp2b8GhVxw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.11.2021 14:55, Lee Jones пишет:
> On Thu, 28 Oct 2021, Dmitry Osipenko wrote:
> 
>> Use devm_register_power_handler() that replaces global pm_power_off
>> variable and allows to register multiple power-off handlers. It also
>> provides restart-handler support, i.e. all in one API.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/mfd/rn5t618.c | 56 ++++++++++++++++---------------------------
>>  1 file changed, 21 insertions(+), 35 deletions(-)
> 
> For my own reference (apply this as-is to your sign-off block):
> 
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 

Thanks you. This and other driver patches will be slightly changed
because the power-handler was renamed to sys-off handler starting with
the v3 of this series, but yours ack still will be valid here.
