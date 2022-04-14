Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6745500C00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbiDNLWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242597AbiDNLWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:22:09 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A841FCE5;
        Thu, 14 Apr 2022 04:19:44 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id j2so8883136ybu.0;
        Thu, 14 Apr 2022 04:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dY83H0aPEfDTdUo23MndvBRZZwuNuwRYnVKAWx3MFcc=;
        b=hTLRdySs3CnpaoymfFiM0y+PetDtOzg8joG6JeTvcOymw/WDpAF5uzwknJ8t0LRBVT
         I+kcuzIn9LHA4QMYkgS/A+mCY0jUBayfLSo+EgS2HECKTepTptyEdA7DCjIuMujFBvth
         h6DI7Mv4D2wnOc7xe0cCa2NOPDRYjH4MvwDAHO9Eoe9QPeFLUBmvjLWEduB1VwuQ4qML
         xRJUP6xAKE1Ydo/qwllNsbCj3Q9D5xUUiUe4zDWillfZfEUHsV4efvowMqqlArMOJnh+
         8kOex9vW9o7n0FVP+InF2nbmwQo0UHWvtMfQiGghY5VpaPT3mgullEHZfsNRWODIqQnA
         P5gA==
X-Gm-Message-State: AOAM530oo9GlqneVIjgHSjGfNsZkw70uXNGYqI9O/wtyNwppNCSte/dV
        ssEsNqqPvNRMFPyjXj4KDxjmR06F+u8Wu2REZEE=
X-Google-Smtp-Source: ABdhPJyXV07maZap62IutTg/mwVDj/CfiQiLME5IwIFkAJnTY85PIrUap0WcF7eity1wAkpRDD0UVobPG71n48VtbjA=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr1246534ybh.81.1649935183962; Thu, 14 Apr
 2022 04:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233832.391817-1-dmitry.osipenko@collabora.com>
 <20220411233832.391817-4-dmitry.osipenko@collabora.com> <CAJZ5v0gf1J+yPW14TAdLGLGfO+-2s=r0DDP7d+Rgop3=dB0gaQ@mail.gmail.com>
 <af51d9d0-26ba-fc66-05f1-d92ef7172730@collabora.com>
In-Reply-To: <af51d9d0-26ba-fc66-05f1-d92ef7172730@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Apr 2022 13:19:32 +0200
Message-ID: <CAJZ5v0jFQi1x1Fnfk04n+HTTirz19-_xW2NgJtpOYyPgVh3Afw@mail.gmail.com>
Subject: Re: [PATCH v7 03/20] reboot: Print error message if restart handler
 has duplicated priority
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:24 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 4/13/22 21:48, Rafael J. Wysocki wrote:
> > On Tue, Apr 12, 2022 at 1:39 AM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> Add sanity check which ensures that there are no two restart handlers
> >> registered using the same priority. This requirement will become mandatory
> >> once all drivers will be converted to the new API and such errors will be
> >> fixed.
> >>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >
> > The first two patches in the series are fine with me and there's only
> > one minor nit regarding this one (below).
> >
> >> ---
> >>  kernel/reboot.c | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/kernel/reboot.c b/kernel/reboot.c
> >> index ed4e6dfb7d44..acdae4e95061 100644
> >> --- a/kernel/reboot.c
> >> +++ b/kernel/reboot.c
> >> @@ -182,6 +182,21 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
> >>   */
> >>  int register_restart_handler(struct notifier_block *nb)
> >>  {
> >> +       int ret;
> >> +
> >> +       ret = atomic_notifier_chain_register_unique_prio(&restart_handler_list, nb);
> >> +       if (ret != -EBUSY)
> >> +               return ret;
> >> +
> >> +       /*
> >> +        * Handler must have unique priority. Otherwise call order is
> >> +        * determined by registration order, which is unreliable.
> >> +        *
> >> +        * This requirement will become mandatory once all drivers
> >> +        * will be converted to use new sys-off API.
> >> +        */
> >> +       pr_err("failed to register restart handler using unique priority\n");
> >
> > I would use pr_info() here, because this is not a substantial error AFAICS.
>
> It's indeed not a substantial error so far, but it will become
> substantial later on once only unique priorities will be allowed. The
> pr_warn() could be a good compromise here, pr_info() is too mild, IMO.

Well, I'm still unconvinced about requiring all of the users of this
interface to use unique priorities.

Arguably, there are some of them who don't really care about the
ordering, so could there be an option for them to specify the lack of
care by, say, passing 0 as the priority that would be regarded as a
special case?

IOW, if you pass 0, you'll be run along the others who've also passed
0, but if you pass anything different from 0, it must be unique.  What
do you think?
