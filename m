Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966F45223C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346620AbiEJSUO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 May 2022 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348854AbiEJST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:19:26 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190252A975A;
        Tue, 10 May 2022 11:14:24 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id m128so32191961ybm.5;
        Tue, 10 May 2022 11:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qpqXrLDWUEHd+BUtmgMjhwAa3QcGPruT6uNMBEv9rjU=;
        b=sE0t+MrA2XaCL45MizPmFfYKh+U7rCzOjLv98vxpalwZsq4dz5KZYWa5EvT7z4Dj/J
         72cDF6NlgQd5iWSoHTtTXxceYUf04R6uRHcOV8jsHXPlhwwbDMcx1IMyPtxOrsKhDggi
         wuvB1W8gNO5ex306dapgVyE0ASFzoomTxg7L9zcB+drqohTFQe1hR9PsfiRaJ27pJr9l
         H9JvOI63+Ooq4kqdLZBUXUvsOeixRzwIj1hEV+GcQckk7SAXqz9jSivd5ellFLiPqFs8
         5bJ2n96C8IUu5Z4Fpv4clNCpiCIoJ0o2C6AAumEzIviiNN9HcMufo4dJXUAXqyc/StxF
         2E1g==
X-Gm-Message-State: AOAM531+oHyPotUKmUfvdnQsDixTSyf4gFm2u1Db2FoFEqVUEzAdkJOx
        yFppIfJjpin5xoQr9N1U5JMJQ0EWlcJyxNaNJzA=
X-Google-Smtp-Source: ABdhPJy/3C7Xf5XL6o3yFhMZ917Dv3JWEaRfPbmjw9NKhK3//cChodJMWe9FmxWaGm5UEgRYGP1Nqk2NauJUMOpu3kk=
X-Received: by 2002:a25:e792:0:b0:645:7ddb:b5eb with SMTP id
 e140-20020a25e792000000b006457ddbb5ebmr19781278ybh.482.1652206451725; Tue, 10
 May 2022 11:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220509233235.995021-1-dmitry.osipenko@collabora.com> <20220509233235.995021-2-dmitry.osipenko@collabora.com>
In-Reply-To: <20220509233235.995021-2-dmitry.osipenko@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 May 2022 20:14:00 +0200
Message-ID: <CAJZ5v0gApRhc9+jZLxgNXC2B2tmz450=8+mFZUjTFF1iU7C-gw@mail.gmail.com>
Subject: Re: [PATCH v8 01/27] notifier: Add atomic_notifier_call_chain_is_empty()
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 1:33 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add atomic_notifier_call_chain_is_empty() that returns true if given
> atomic call chain is empty.

It would be good to mention a use case for it.

> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  include/linux/notifier.h |  2 ++
>  kernel/notifier.c        | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index 87069b8459af..95e2440037de 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -173,6 +173,8 @@ extern int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh
>  extern int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
>                 unsigned long val_up, unsigned long val_down, void *v);
>
> +extern bool atomic_notifier_call_chain_is_empty(struct atomic_notifier_head *nh);
> +
>  #define NOTIFY_DONE            0x0000          /* Don't care */
>  #define NOTIFY_OK              0x0001          /* Suits me */
>  #define NOTIFY_STOP_MASK       0x8000          /* Don't call further */
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index ba005ebf4730..aaf5b56452a6 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -204,6 +204,19 @@ int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
>  EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
>  NOKPROBE_SYMBOL(atomic_notifier_call_chain);
>
> +/**
> + *     atomicnotifier_call_chain_is_empty - Check whether notifier chain is empty
> + *     @nh: Pointer to head of the blocking notifier chain
> + *
> + *     Checks whether notifier chain is empty.
> + *
> + *     Returns true is notifier chain is empty, false otherwise.
> + */
> +bool atomic_notifier_call_chain_is_empty(struct atomic_notifier_head *nh)
> +{
> +       return !rcu_access_pointer(nh->head);
> +}
> +
>  /*
>   *     Blocking notifier chain routines.  All access to the chain is
>   *     synchronized by an rwsem.
> --
> 2.35.1
>
