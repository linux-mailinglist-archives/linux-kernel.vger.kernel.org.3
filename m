Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C9B51A0F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350601AbiEDNhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350589AbiEDNhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:37:01 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E7922D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:33:25 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id h3so817884qtn.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHLG3LK3T4GfLB78t/R62gL/IMn6Ku8arAOqdFJ64Yc=;
        b=DKGOWJf9Ip/fKN5Dnk8qGDOEeA8SeLELn38oAXiEeDY3uZVeUOcUXzFGRqp0MRiq4u
         Blfjd4zDBm2WqbOG3qhRmWGgUrvO16ZmjZzIIEgJIHki3EHDIw0EwcUBpFuRc/o/F6SD
         EIm6XizAXMfY35AXSGFpxBDuHLNGWT61VqpnlCFbzDKQ24fagtZw77dEaY93ROc8c2YM
         zuuBgiVePRGWjzQsev9Sf06YMdnhPLg6bGQs8I3K1HRkqtX+c5uBbEHaq1yfH9R2o3fk
         iTuWyystuJrBQ5sr3cEeOMEhKDghPrEObBdv4Vf6P9g8ZpaV2taSIq8Rgv/TEMf28asV
         ez9g==
X-Gm-Message-State: AOAM531dGL/+o2k13S8YDb+Wb2BYD9z4Ckghs63OKsU4DyLtWdUM+xq4
        1Rq+RiSV4K9iY+p0fF4JO4cARGD+Tn5LFQ==
X-Google-Smtp-Source: ABdhPJzszEPIgNglwr90oODkKGV7S4CkFh3CO2BoQv669K15Ii9G4sbEVPzVF+Auw00ElEv86cPjxg==
X-Received: by 2002:ac8:5c0f:0:b0:2f3:afd1:3e06 with SMTP id i15-20020ac85c0f000000b002f3afd13e06mr6186635qti.249.1651671204108;
        Wed, 04 May 2022 06:33:24 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id g5-20020a379d05000000b0069fc13ce1ecsm7606094qke.29.2022.05.04.06.33.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 06:33:23 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2f7b815ac06so15451697b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:33:23 -0700 (PDT)
X-Received: by 2002:a81:6588:0:b0:2f8:b75e:1e1a with SMTP id
 z130-20020a816588000000b002f8b75e1e1amr19797234ywb.358.1651671203161; Wed, 04
 May 2022 06:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <202205041720.i8wJ8uXq-lkp@intel.com> <CAK8P3a3F3Z1NyhVcK6wN+b6Es3gqiYGee8a+pAPsaer4hhHDbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3F3Z1NyhVcK6wN+b6Es3gqiYGee8a+pAPsaer4hhHDbQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 May 2022 15:33:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHUvbembVU92CZ+SXhfb8i8F_==d9rcH18pc=O-F8WOQ@mail.gmail.com>
Message-ID: <CAMuHMdVHUvbembVU92CZ+SXhfb8i8F_==d9rcH18pc=O-F8WOQ@mail.gmail.com>
Subject: Re: time.c:undefined reference to `mach_get_rtc_pll'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Daniel Palmer <daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, May 4, 2022 at 2:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 4, 2022 at 11:14 AM kernel test robot <lkp@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   107c948d1d3e61d10aee9d0f7c3d81bbee9842af
> > commit: 8b22820efb35f93d98638563b0a8f4094e8ee399 m68k: m68328: remove duplicate code
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
> > >> time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
> >    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
> >    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
> >
>
> I think this is just another build failure that was hidden before my patch,
> not caused by my patch.

That's an m68knommu kernel build with CONFIG_RTC_DRV_GENERIC=y,
I guess?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
