Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB4E51D22A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389509AbiEFH11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389502AbiEFH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:27:23 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A81066FAD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:23:41 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id kj8so4868597qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23onXbfi6o/fe9WNwg2uDo92nIZIxhI+H8tvrf1C520=;
        b=1yOouoi2Ed3Bc4rnLjQXPgWMrY/wUAOpifArbIOmO6wzaI6cNczVtzPPDANcXiHl8C
         wsKTmkM9wuKuCDPOj/IjqkLf/njWUmmJFRCbRFFEmTIgntaJqK2blePLXb0+zvAe5+mK
         UucmPr5v5Xvqv4Ze9uqhQgvZ6JSjb8qR9dmHCalPJAnjJHucXtDOoCN7muqafuE/yHfA
         HYeQotRP8CEKq4wD68JHLKuY8syYPq/IRU73KUbNugTqUxLhi4DJfoW8p4Xt8w0BZ1GB
         gKjHrlAf/dY3E3PC0boBwaTlYwv1pB438o7uxFZ5X4C/wTn5ee88SujTlz0ln+qvq7Xr
         lZ3w==
X-Gm-Message-State: AOAM532RHdN8j3RDdBrD/dF+jgLKYFFnWTU2teXK6qhZasj8ubmsaI6+
        LlQZfy+cAAETIThVN4mhdyOXT80nxShc9g==
X-Google-Smtp-Source: ABdhPJx7Wk8VJ6/lZdo5kgGrQWFbFOJAXXWNKIviKEoDzhHbRszOVCfhHBQGtIPhCBup71JpGknLqQ==
X-Received: by 2002:a0c:e811:0:b0:456:4f7c:f7b3 with SMTP id y17-20020a0ce811000000b004564f7cf7b3mr1517699qvn.79.1651821820305;
        Fri, 06 May 2022 00:23:40 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id i2-20020ac84f42000000b002f39b99f672sm2100096qtw.12.2022.05.06.00.23.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:23:39 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f7b815ac06so72209657b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:23:39 -0700 (PDT)
X-Received: by 2002:a0d:d953:0:b0:2f7:d5ce:f204 with SMTP id
 b80-20020a0dd953000000b002f7d5cef204mr1486167ywe.502.1651821819502; Fri, 06
 May 2022 00:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <202205041720.i8wJ8uXq-lkp@intel.com> <CAK8P3a3F3Z1NyhVcK6wN+b6Es3gqiYGee8a+pAPsaer4hhHDbQ@mail.gmail.com>
 <CAMuHMdVHUvbembVU92CZ+SXhfb8i8F_==d9rcH18pc=O-F8WOQ@mail.gmail.com> <CAK8P3a3EUPL_WiVPvWdsN7eaDWK9KbbT7VjnGfMzV1_nXLhU3Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3EUPL_WiVPvWdsN7eaDWK9KbbT7VjnGfMzV1_nXLhU3Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 May 2022 09:23:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVz=_XyzG+ss3VFq=PSG5b4VE2MkYWTPJyVdzrw_1RisQ@mail.gmail.com>
Message-ID: <CAMuHMdVz=_XyzG+ss3VFq=PSG5b4VE2MkYWTPJyVdzrw_1RisQ@mail.gmail.com>
Subject: Re: time.c:undefined reference to `mach_get_rtc_pll'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Daniel Palmer <daniel@0x0f.com>
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

Hi Arnd,

On Fri, May 6, 2022 at 9:21 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 4, 2022 at 3:33 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, May 4, 2022 at 2:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, May 4, 2022 at 11:14 AM kernel test robot <lkp@intel.com> wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   107c948d1d3e61d10aee9d0f7c3d81bbee9842af
> > > > commit: 8b22820efb35f93d98638563b0a8f4094e8ee399 m68k: m68328: remove duplicate code
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
> > > > >> time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
> > > >    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
> > > >    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
> > > >
> > >
> > > I think this is just another build failure that was hidden before my patch,
> > > not caused by my patch.
> >
> > That's an m68knommu kernel build with CONFIG_RTC_DRV_GENERIC=y,
> > I guess?
>
> Correct, the  .config file is linked in the original report, just double-checked
> that. More importantly, it's a nommu M68KCLASSIC (dragonball) config,

Sorry, the original report email was delayed by 9 hours, so I
got your response first.

> so the existing #ifdef CONFIG_M68KCLASSIC check in
> arch/m68k/kernel/time.c is insufficient.

Yeah, need to fix that, one day....

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
