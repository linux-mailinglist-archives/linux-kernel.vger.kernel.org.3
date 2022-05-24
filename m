Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA602532462
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiEXHtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiEXHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:49:42 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F797994CF;
        Tue, 24 May 2022 00:49:41 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id g3so14203828qtb.7;
        Tue, 24 May 2022 00:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFuesu4eXOzVy5OiyTe49D1dgIorHEfZWrHJUHl/IrQ=;
        b=5moe+8LIVlj0hQKkYp8fdAtqM2S3lgWdW/pw7q2djMV1xtEUqwInMtxpjWG0EaGgZK
         87P3d7ixl3cAwB8kyXd7xOI1wKVsmdvCrgeV6s+HxRl+m5C76zJbTtB3hRmfUIIW+l8g
         BygAzeEtubjjBIAebV0Rw0oHyUghXlYiXYHGMT3vYDGhLNgEidK7q7k52xnKDgFg2Bxx
         0dlvD3u4SBqqmZgpOXnFk7kC3y5K+KIqCi/bt9ZoDowQ4/cty5+k1UUg3sfg1qvT2Jgl
         +zx6qDRIPNNlXxDaXyAxxGCJX7YKOcEr7Fg3H+lniAqmiw8s1/iUbVlhGRU3u/ajIzJh
         NDkQ==
X-Gm-Message-State: AOAM533f0gy/FHs7Sws2drAoSV2uTcMOoeP/oDmUhtfrE2/CHbQMjD5Q
        /AvcJs7CYnrMgrEKpYV26Y4IhFkaOoCLkP7o
X-Google-Smtp-Source: ABdhPJwF2Akp7K9TnywwQv70mnuOh+hFX8SnrDepWBxlTKCf70T+3+cPUlmlVGq+s04YURznEvnKIQ==
X-Received: by 2002:a05:622a:1389:b0:2f9:46b4:2990 with SMTP id o9-20020a05622a138900b002f946b42990mr217397qtk.237.1653378580567;
        Tue, 24 May 2022 00:49:40 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id g1-20020a379d01000000b0069fc13ce1fesm5623169qke.47.2022.05.24.00.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 00:49:40 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id z7so8208377ybf.7;
        Tue, 24 May 2022 00:49:40 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr25491340ybu.604.1653378579929; Tue, 24
 May 2022 00:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220518065639.2432213-1-gerg@linux-m68k.org> <20220518065639.2432213-2-gerg@linux-m68k.org>
 <CAMuHMdXTn6ysmjg5cr2RvYG=8f3azC1B4v=via0ePua_hv6TgA@mail.gmail.com>
In-Reply-To: <CAMuHMdXTn6ysmjg5cr2RvYG=8f3azC1B4v=via0ePua_hv6TgA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 May 2022 09:49:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+k4kGv+vKSGNnwhKCk3eYv5uQd=UgNJQ1HVYxuOUv5g@mail.gmail.com>
Message-ID: <CAMuHMdV+k4kGv+vKSGNnwhKCk3eYv5uQd=UgNJQ1HVYxuOUv5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] m68knommu: fix undefined reference to `mach_get_rtc_pll'
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
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

Hi Greg,

On Tue, May 24, 2022 at 9:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, May 18, 2022 at 8:56 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> > Configuring for a nommu classic m68k target and enabling the generic rtc
> > driver (CONFIG_RTC_DRV_GENERIC) will result in the following compile
> > error:
> >
> >    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
> >    time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
> >    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
> >    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
> >
> > There is no definitions of "mach_set_rtc_pll" and "mach_get_rtc_pll" in the
> > nommu code paths. Move these definitions and the associated "mach_hwclk",
> > so that they are around their use case in time.c. This means they will
> > always be defined on the builds that require them, and not on those that
> > cannot use them - such as ColdFire (both with and without MMU enabled).
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>
> > --- a/arch/m68k/kernel/time.c
> > +++ b/arch/m68k/kernel/time.c
> > @@ -82,6 +86,11 @@ void read_persistent_clock64(struct timespec64 *ts)
> >  #endif
> >
> >  #if IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
> > +int (*mach_get_rtc_pll)(struct rtc_pll_info *);
> > +int (*mach_set_rtc_pll)(struct rtc_pll_info *);
> > +EXPORT_SYMBOL(mach_get_rtc_pll);
> > +EXPORT_SYMBOL(mach_set_rtc_pll);
>
> Oops, this causes build failures for Q40 with CONFIG_RTC_DRV_GENERIC=n,
> as arch/m68k/q40/config.c uses mach_]gs]et_rtc_pll() unconditionally.

I think the simplest solution is to move these up, next to mach_hwclk.

>
> > +
> >  static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
> >  {
> >         mach_hwclk(0, tm);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
