Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD71449E4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbiA0Ojc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242440AbiA0Oja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:39:30 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ED3C061747;
        Thu, 27 Jan 2022 06:39:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o12so5695802lfg.12;
        Thu, 27 Jan 2022 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XkYKE/mqIw+ZogEPzGoXmtOQI8nkKTmA4V70TLbVWS4=;
        b=BHb2Xn1jq66/9MHahrzGm/gWUKtVbh/58wKW18vGWzni3fO5qyqP4VG1OOnOie8Jsh
         gDERoDSbSutwAXYx2C5vNn4TrrwM4BpgdHcNKbywEL+R5MYLhL5n2nGGvdHyYC3+WdiR
         AH7kOLTk/zgQKoF333ryAx/KFlOhDG6pX/tZk4LwhLgv5peCfB01DtWBVE+9RHO5Zn9/
         GlTTQk4e9TGZCrINPfliTtlCZdTAH9LmWOb+qXQAmfLULPmn+Omh2L6j2NgulGAPM/A+
         p0mPzTS/Ny1WZgGK/AicqnPTN5Ub7NU4t23e3Ka67Gnz7TG7Nyg0lXeqh7s3FoDGgrJx
         11/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XkYKE/mqIw+ZogEPzGoXmtOQI8nkKTmA4V70TLbVWS4=;
        b=6iLmI2H/+JAizdRH6u1BkFYrXGezfYRXBsQmrG1wzIbN24qW/yFCoQz0+XMdIv+q73
         FuLJ5a4+50vMIMcbDUB/qV0D637F9LN1XErH7td7BBURsprUfxL/Vs8dvCyhUGCxqcCE
         X62D+ivGdSIulisip3vQj/PZLdqlCDRoPN3p5EG08/VUkKboGb4lMIovRmdkGOSgYqKt
         c4BJQuN+8rVdRv+010k6M0EL+wxXNxw4Gapg1Rz6P5RoGtHOXIzUkzrk7s/NM0TXJqQy
         rDgvK3mN8qGrqCpPe9PfIMPNpmjJmsKQy9qY+IyYOt72Anjm6/3xMzxyhS8tH8g5LYKz
         Y2Nw==
X-Gm-Message-State: AOAM533hWHQ1QUAKT+lgDSES8w8zPc2JK3tXStRuzgstZIx7CvVncyGb
        cTyGmBUc2MqLgz77jeCl0k8=
X-Google-Smtp-Source: ABdhPJy1MhVvMOXi8UxQ8s4idXCyJ+ifGIsp8CpwyHRf9+W1A9LbFInI9I0x2geweWfK/i1YhzfC+Q==
X-Received: by 2002:a05:6512:3d1c:: with SMTP id d28mr2997039lfv.135.1643294367899;
        Thu, 27 Jan 2022 06:39:27 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id r13sm476323lfr.65.2022.01.27.06.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:39:22 -0800 (PST)
Message-ID: <e8d3ca39-ddeb-2c21-6000-1cc65da57915@gmail.com>
Date:   Thu, 27 Jan 2022 17:39:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 04/21] kernel: Add combined power-off+restart handler
 call chain API
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
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
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20211212210309.9851-1-digetx@gmail.com>
 <20211212210309.9851-5-digetx@gmail.com> <Ydofs2CIfA+r5KAz@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <Ydofs2CIfA+r5KAz@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michał,

09.01.2022 02:35, Michał Mirosław пишет:
> BTW, I couldn't find a right description of my idea of unifying the
> chains before, so let me sketch it now.
> 
> The idea is to have a single system-off chain in which the callback
> gets a mode ({QUERY_*, PREP_*, DO_*} for each of {*_REBOOT, *_POWEROFF, ...?).
> The QUERY_* calls would be made in can_kernel_reboot/poweroff(): all
> would be called, and if at least one returned true, then the shutdown
> mode would continue. All of PREP_* would be called then. After that
> all DO_* would be tried until one doesn't return (succeeded or broke
> the system hard). Classic for(;;); could be a final fallback for the
> case where arch/machine (lowest priority) call would return instead
> of halting the system in machine-dependent way. The QUERY and PREP
> stages could be combined, but I haven't thought about it enough to
> see what conditions would need to be imposed on the callbacks in
> that case (maybe it's not worth the trouble, since it isn't a fast
> path anyway?). The goal here is to have less (duplicated) code in
> kernel, but otherwise it seems equivalent to your API proposal.

Thank you again for yours proposal! IMO, it's much more important to
keep the core code simple and maintainable, rather than try to optimize
it without a very good reason, given that this isn't a hot code path at
all and saving a couple of bytes won't be noticeable. The poweroff,
restart and reboot were separated before this series and I'm finding
that it's easier to follow the code when it's structured that way. I'm
not convinced that we need to change it.
