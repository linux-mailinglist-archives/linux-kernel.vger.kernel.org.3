Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43AE4A3F39
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiAaJ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:29:01 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34910
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231160AbiAaJ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:28:59 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 27A953F2FF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643621338;
        bh=dkzBuNd+uNU6CfCWtlWJDYP24x7ho0sbzpUOr5OCq8A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iSqz/uLapSay7G/3A6PkXfNFarhEKpKi77MjwJT3TWh4Sv9zi8xxJc6Rkgnk/UQ3X
         Yvr9zkdtcF2g6oFH10U/HqNYl2JgU6TIPCzY3Hp6miKzhib0mSoE8e1j5EE450Bes6
         qC6Nk/QQtF9ZjHzny9/qSH3PJuaiAnJbMud9Sb5Y1vvXeTeXotimNFdFGDuIj+WzCx
         +sQiPy0qGoT6niPfGMYqQPdW9mH+t2WQCNw63g8++6lWWWNXk4xKf1kdKExTBoWdtp
         Fr8xP9lb7ptdwU+meL0LaKA08Pt3Gn+XokqmPxFvGnoCCSNkBA7DNg376izAfxT+dt
         B9Ji0NE/qyypQ==
Received: by mail-ej1-f69.google.com with SMTP id la22-20020a170907781600b006a7884de505so4749680ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 01:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dkzBuNd+uNU6CfCWtlWJDYP24x7ho0sbzpUOr5OCq8A=;
        b=RdCSt9viaURSNCERjMcFQMgpkR6mDox4X5UDcExbyTGFy38rA23nfn82euOhMrvhEa
         UAXRr5lyd4XbUTj68UmqaSVh6LZj/jPQM8WiF6vPZSX0P14BPyh1kpAyCI6qwBwzVpkh
         H6NXnsa77tBD0LsNAZQxuHcZDYO5eFnotcbaR5H/4y6ebcmPm+DtS2OQo45RshT9YEIQ
         4VRfgZaeGATonXeT5pPCI/d+R2lyKD+TFQelcZkgtLBSvo1s1bFrkrdR4KCtsuBeDVPD
         TCtk3X1Qk88xAozERbfwzOW8z06CzpT4QltaY6qANMk1B/dCMiG6AZ7A4hAh0h21BRKP
         O2yA==
X-Gm-Message-State: AOAM531bBHosTfaM8kVri9jK9RP38m5W8eR6sX1W9jHqeTZhYM+AE/Fn
        FtgyE/tYDiqgCLYl7p7TefD1ogj72afc5+zBY1xdn6g/PCUHWRPQmk/mH+FAC6KzMspNTJlbeZi
        L509iK1tphxzC+al7CDIUmW/pVOd/YdQ64LHLRqMcQA==
X-Received: by 2002:a17:907:d88:: with SMTP id go8mr16082664ejc.343.1643621337680;
        Mon, 31 Jan 2022 01:28:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwUgdzk1HBzC4qCevIT6t5qYbRcRcbKgCipd7W6AaFHRRw14fKuy7dvOGc19/jX8mpPV7Ajw==
X-Received: by 2002:a17:907:d88:: with SMTP id go8mr16082640ejc.343.1643621337451;
        Mon, 31 Jan 2022 01:28:57 -0800 (PST)
Received: from [192.168.0.71] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z2sm2645158ejn.117.2022.01.31.01.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 01:28:56 -0800 (PST)
Message-ID: <1e22e171-9d13-5763-a9e2-a24e7d98e130@canonical.com>
Date:   Mon, 31 Jan 2022 10:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 18/21] memory: emif: Use kernel_can_power_off()
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
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
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
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
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20220130233718.21544-1-digetx@gmail.com>
 <20220130233718.21544-19-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220130233718.21544-19-digetx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2022 00:37, Dmitry Osipenko wrote:
> Replace legacy pm_power_off with kernel_can_power_off() helper that
> is aware about chained power-off handlers.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/emif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
