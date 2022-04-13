Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081794FFE29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiDMSu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiDMSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:50:54 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A75DA0F;
        Wed, 13 Apr 2022 11:48:32 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2ec04a2ebadso32319057b3.12;
        Wed, 13 Apr 2022 11:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1rErWVySlUxlEFN2u18NGS5Qm0qvXYHGlMsYpGhhEY=;
        b=o889vKxSZtxv8BEV2OoNHeUSIVSxACJe8n0x+KvpxDr0kg3lDSg1g8LoUE9Bu4dAAe
         I0iUyDRgqQM+YxT7ev9JMk18DB7xCsm0NBYY0yKziHMpPBVYhoEIuHPE0y3+tOiIghU0
         QHrGU+pFLYAbtd6x535V+cs7nmE3stGixEEx91f8SUrxCGmEZ0B4NPXCTsEfdbCexJso
         vN1rL0p+hRNdjj6uBwjtVnohxcEFxd7GQNFhlNHOO2UF1hIvohxjUdbrpOBY+8T8/y0d
         BY3aa+4w9VV3v6CY9Vt8NvvoNMllq5JBLzAtEZiZR4w9pAAAbivq/5mzW1QjjZn3A3Ob
         eqpg==
X-Gm-Message-State: AOAM532UuvfMXcYmQn930+JWT3B73Q7VMEmbT5Qiq10V4IGHVmHDg4AO
        YQUeiVjdulu07zQKtE0HLZsgtYUCjcWXGlEgZG4=
X-Google-Smtp-Source: ABdhPJz9BfsA7QIGi43YRDlzzrWhVjbeGEMJOs01j9nA3vXXWXOOPKhq5d8EhdtGHqqQ5dYXQmK91VGL/RQnfnI1jKs=
X-Received: by 2002:a81:7c45:0:b0:2eb:4759:cc32 with SMTP id
 x66-20020a817c45000000b002eb4759cc32mr224284ywc.515.1649875711933; Wed, 13
 Apr 2022 11:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233832.391817-1-dmitry.osipenko@collabora.com> <20220411233832.391817-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20220411233832.391817-4-dmitry.osipenko@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 20:48:20 +0200
Message-ID: <CAJZ5v0gf1J+yPW14TAdLGLGfO+-2s=r0DDP7d+Rgop3=dB0gaQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/20] reboot: Print error message if restart handler
 has duplicated priority
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 1:39 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add sanity check which ensures that there are no two restart handlers
> registered using the same priority. This requirement will become mandatory
> once all drivers will be converted to the new API and such errors will be
> fixed.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

The first two patches in the series are fine with me and there's only
one minor nit regarding this one (below).

> ---
>  kernel/reboot.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index ed4e6dfb7d44..acdae4e95061 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -182,6 +182,21 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
>   */
>  int register_restart_handler(struct notifier_block *nb)
>  {
> +       int ret;
> +
> +       ret = atomic_notifier_chain_register_unique_prio(&restart_handler_list, nb);
> +       if (ret != -EBUSY)
> +               return ret;
> +
> +       /*
> +        * Handler must have unique priority. Otherwise call order is
> +        * determined by registration order, which is unreliable.
> +        *
> +        * This requirement will become mandatory once all drivers
> +        * will be converted to use new sys-off API.
> +        */
> +       pr_err("failed to register restart handler using unique priority\n");

I would use pr_info() here, because this is not a substantial error AFAICS.

> +
>         return atomic_notifier_chain_register(&restart_handler_list, nb);
>  }
>  EXPORT_SYMBOL(register_restart_handler);
> --
