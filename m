Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB5508E98
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381236AbiDTRjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiDTRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:39:22 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02291EC74;
        Wed, 20 Apr 2022 10:36:35 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ef4a241cc5so26269767b3.2;
        Wed, 20 Apr 2022 10:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSRYCi9Gu592mc1yy2JGCfSHyy3Om8/ZMl9fXbJ4VAk=;
        b=ryiG9d/g0nAi1suycm097/0o0XNUzQhQjQg2vmNWQnRIOguh9XoKKkRSiJfbsSG5tc
         vQCNo0+01j4eJ/mQfLJcTDSnBGx0HESqEoorumqIjkHocbCnSVc5AO2hUQaKCxpHJfD2
         s2KMfwrawC2ufC8pAbxBn3W72mUZ9NI9d2oRXgGfz3PXSI7erLu0Q5MD0XOYyaXX78Sx
         fg4hKI+bEsO3JvRcsXv0Sn1ykDteglvIOY2N+CC+1I/iYweTYb6H0HU6WcExdZlSZYJ7
         l1WkMOsOj3TKNwSoKoqzcdVgM+5SFmr28Y80vxOn2DL/VKlgEYe2TJ7csyQhLyEt5Bjs
         x9DA==
X-Gm-Message-State: AOAM5303P3RyWlc6t0fECgadJ9ipaqrwLxeq39r1vXCOuBSgSkxTb02D
        kFvVqgxkjJt2E26sxkyIsRmjrANlGzBEx4znGxY=
X-Google-Smtp-Source: ABdhPJzNeFf91aJ2AcO4HxwsyceUmkMGZe3BT/sKo5s3TT3nCPguaeHFtXhd48Duxnk7AG97fF2bO/GqS3ZkGsIQMYE=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr1985644ywm.149.1650476194968; Wed, 20
 Apr 2022 10:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233832.391817-1-dmitry.osipenko@collabora.com>
 <20220411233832.391817-4-dmitry.osipenko@collabora.com> <CAJZ5v0gf1J+yPW14TAdLGLGfO+-2s=r0DDP7d+Rgop3=dB0gaQ@mail.gmail.com>
 <af51d9d0-26ba-fc66-05f1-d92ef7172730@collabora.com> <CAJZ5v0jFQi1x1Fnfk04n+HTTirz19-_xW2NgJtpOYyPgVh3Afw@mail.gmail.com>
 <fa20ae2f-e265-c713-493d-5b2ebcdf7f0a@collabora.com>
In-Reply-To: <fa20ae2f-e265-c713-493d-5b2ebcdf7f0a@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Apr 2022 19:36:23 +0200
Message-ID: <CAJZ5v0iA6St_J5C6+Efygu25g9g-_tLBPc0qQoHbFqfrdT6azQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 3:29 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 4/14/22 14:19, Rafael J. Wysocki wrote:
> > On Thu, Apr 14, 2022 at 12:24 AM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 4/13/22 21:48, Rafael J. Wysocki wrote:
> >>> On Tue, Apr 12, 2022 at 1:39 AM Dmitry Osipenko
> >>> <dmitry.osipenko@collabora.com> wrote:
> >>>>
> >>>> Add sanity check which ensures that there are no two restart handlers
> >>>> registered using the same priority. This requirement will become mandatory
> >>>> once all drivers will be converted to the new API and such errors will be
> >>>> fixed.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>
> >>> The first two patches in the series are fine with me and there's only
> >>> one minor nit regarding this one (below).
> >>>
> >>>> ---
> >>>>  kernel/reboot.c | 15 +++++++++++++++
> >>>>  1 file changed, 15 insertions(+)
> >>>>
> >>>> diff --git a/kernel/reboot.c b/kernel/reboot.c
> >>>> index ed4e6dfb7d44..acdae4e95061 100644
> >>>> --- a/kernel/reboot.c
> >>>> +++ b/kernel/reboot.c
> >>>> @@ -182,6 +182,21 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
> >>>>   */
> >>>>  int register_restart_handler(struct notifier_block *nb)
> >>>>  {
> >>>> +       int ret;
> >>>> +
> >>>> +       ret = atomic_notifier_chain_register_unique_prio(&restart_handler_list, nb);
> >>>> +       if (ret != -EBUSY)
> >>>> +               return ret;
> >>>> +
> >>>> +       /*
> >>>> +        * Handler must have unique priority. Otherwise call order is
> >>>> +        * determined by registration order, which is unreliable.
> >>>> +        *
> >>>> +        * This requirement will become mandatory once all drivers
> >>>> +        * will be converted to use new sys-off API.
> >>>> +        */
> >>>> +       pr_err("failed to register restart handler using unique priority\n");
> >>>
> >>> I would use pr_info() here, because this is not a substantial error AFAICS.
> >>
> >> It's indeed not a substantial error so far, but it will become
> >> substantial later on once only unique priorities will be allowed. The
> >> pr_warn() could be a good compromise here, pr_info() is too mild, IMO.
> >
> > Well, I'm still unconvinced about requiring all of the users of this
> > interface to use unique priorities.
> >
> > Arguably, there are some of them who don't really care about the
> > ordering, so could there be an option for them to specify the lack of
> > care by, say, passing 0 as the priority that would be regarded as a
> > special case?
> >
> > IOW, if you pass 0, you'll be run along the others who've also passed
> > 0, but if you pass anything different from 0, it must be unique.  What
> > do you think?
>
> There are indeed cases where ordering is unimportant. Like a case of
> PMIC and watchdog restart handlers for example, both handlers will
> produce equal effect from a user's perspective. Perhaps indeed it's more
> practical to have at least one shared level.
>
> In this patchset the level 0 is specified as an alias to the default
> level 128. If one user registers handler using unique level 128 and the
> other user uses non-unique level 0, then we have ambiguity.
>
> One potential option is to make the whole default level 128 non-unique.
> This will allow users to not care about the uniqueness by default like
> they always did it previously, but it will hide potential problems for
> users who actually need unique level and don't know about it yet due to
> a lucky registration ordering that they have today. Are you okay with
> this option?

Yes, I am.
