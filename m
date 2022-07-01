Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2359356390B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiGASRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiGASRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:17:04 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86D91572E;
        Fri,  1 Jul 2022 11:17:02 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-317a66d62dfso31368617b3.7;
        Fri, 01 Jul 2022 11:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8P1W/M2Ft7EitNG21OG6fNl0ycDFlWrehvj4QKWDQ7E=;
        b=7KzOeKZEE25UD3KnVLxD/fUoe8aDDC6ovjrXTYCyBOqcrGW242nEgqIdRzdxYIZyao
         vYQkXCqDY+YUG76TV4qAISrltFJuQdCb8pqU5M50XjA6uMIjBcfbvEg1rHiJFUYxysS5
         kay3ceMBUjswdPT3VNx7zfawkRgeGrSQes62ZU/F2utz++KMiGjNtr9QesBq6FKu/hUD
         tSYiuhkUOLoPUBIJoBA4YRwfTE8Xpujy0Vq60J6xuRfICPSqMhfAMnMZxpMbPBYb56O4
         qKS/yk9JmC8rkUPIt2suR7WOKKhv5WakS/0AgX01oDI4plXES4XeodViWzKB6BXqs4y/
         nuDQ==
X-Gm-Message-State: AJIora+IrRpjfa8Uxwt62e1F8r4sqMr6SEIwV6FDKWxfkTFIii8ts1Nv
        JQ7/9TGt3YETuY+u0EU1v0ZJLipejQk+hOmEgRw=
X-Google-Smtp-Source: AGRyM1uV4SXroro+TOSvKaalQR95Mjpp8iO4ei0mj/JQ1VCwZ8aVa55ThqR0lIXIQ2eUWc9SMREvu71APW6hYhg4KyY=
X-Received: by 2002:a81:68d7:0:b0:318:11df:a40d with SMTP id
 d206-20020a8168d7000000b0031811dfa40dmr18234495ywc.196.1656699421800; Fri, 01
 Jul 2022 11:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com> <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
In-Reply-To: <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Jul 2022 20:16:48 +0200
Message-ID: <CAJZ5v0hoO6FPLcXf617Y52ePvRAea0JZcqLoqPeVQ4sL8Mib4w@mail.gmail.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     John Garry <john.garry@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
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

On Fri, Jul 1, 2022 at 2:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jul 1, 2022 at 1:54 PM John Garry <john.garry@huawei.com> wrote:
> > On 01/07/2022 12:07, Andy Shevchenko wrote:
> > > On Fri, Jul 1, 2022 at 1:06 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > >> On Fri, Jul 1, 2022 at 1:04 PM John Garry <john.garry@huawei.com> wrote:
> > >>> On 30/06/2022 19:13, Rafael J. Wysocki wrote:
>
> ...
>
> > >>> However Yang Yingliang spotted a pre-existing bug in the ACPI probe and
> > >>> sent a fix today (coincidence?):
> > >>>
> > >>> https://lore.kernel.org/lkml/20220701094352.2104998-1-yangyingliang@huawei.com/T/#u
> > >>>
> > >>> And they conflict. This code has been this way for years, so I just
> > >>> suggest Yang Yingliang resends the fix on top off Rafael's change.
> > >>
> > >> Wondering if Yang can actually switch that to use
> > >> platform_device_register_full().
> >
> > Maybe that would work and simplify things. Let me check it.
> >
> > BTW, when we originally upstreamed this driver there was some ACPI
> > platform device registration code which you/we thought could be factored
> > out later. I can't remember it. I was looking through lore but couldn't
> > find it. I don't remember it being so important, though.
>
> My suggestion is definitely not for the fix itself, but as a follow up.
>
> > > And for the record, I think the Fixes even for very rare bug hits
> > > should go first.
> >
> > ok, I have to admit that I was going to feel awkward asking Rafael to
> > deal with this fix by having a v4 on top of it.
>
> I don't think it's a problem as long as we have an immutable branch /
> tag with that patch. Another approach could be that Rafael can take it
> as a precursor for his series and route via ACPI tree, but let's hear
> what he thinks about this himself.

I can take that fix to my tree and rebase my patch on top of it.
