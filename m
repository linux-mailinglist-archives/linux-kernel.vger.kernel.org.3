Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A45952B51A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiERIiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiERIiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:38:19 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00AB8CB30;
        Wed, 18 May 2022 01:38:17 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id x22so1111669qto.2;
        Wed, 18 May 2022 01:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqP3rX70nNLfHywlN+OLLWN2SShnMZ8noQpRFjy348k=;
        b=Mn5AfLuIRaEUlS4xYxIPEySUgZnC6oBWnO5fNvpudsaOISRuESfQcNY1YKMhxDfjVF
         iU9Qwd/KqBwandq4ag2e1nQhx4SQrjlycdP1rTdg6XPl834tLMXAU6hBTGtJmZF2HqwD
         uVRHc0KKqlUDY2SXaqoX+guWhjCUyWm3ayvLP9kzbifhPF3wvKFgqCtevFEsRfknXFoE
         L8d5xVi9vNfOmW+QIRI94xyzL1MA5K/vw9rJ22NTHGF8o5izOdnAwRVzHQ3VqFgb0f/N
         ILPnKTpJFnEut+Z/OnMXPEHDinn+8dwHWfZtdDRjX50Q6Q8lP7WRsQBNZ3tzRKZqI3Ws
         Xplg==
X-Gm-Message-State: AOAM531N9XK2EPeDqHdHXMSu0z+CAwvRPzh3AEW0m4FC/i8oGPcq47ha
        1XhuyzXn0WIRg9u/8AnyNOL53fvwijAQmw==
X-Google-Smtp-Source: ABdhPJzctBhc0soTVGp2gj5kxHZtE2tvy8OlkaZFgoTSGz72qO+3ueLORx1xOWUvtQ28r+Z0VgRGNA==
X-Received: by 2002:a05:622a:38b:b0:2f3:dcce:a7a3 with SMTP id j11-20020a05622a038b00b002f3dccea7a3mr22989381qtx.439.1652863096963;
        Wed, 18 May 2022 01:38:16 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id n7-20020ac81e07000000b002f39b99f6bfsm922296qtl.89.2022.05.18.01.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 01:38:16 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id o80so2497089ybg.1;
        Wed, 18 May 2022 01:38:16 -0700 (PDT)
X-Received: by 2002:a25:e7ce:0:b0:64d:6028:96b9 with SMTP id
 e197-20020a25e7ce000000b0064d602896b9mr18846478ybh.365.1652863095784; Wed, 18
 May 2022 01:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220518065639.2432213-1-gerg@linux-m68k.org> <20220518065639.2432213-2-gerg@linux-m68k.org>
In-Reply-To: <20220518065639.2432213-2-gerg@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 May 2022 10:38:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUookR3LVSEYxc6XBt5aDWQ7NR=7s35Qh5ONbaSaQ-MMA@mail.gmail.com>
Message-ID: <CAMuHMdUookR3LVSEYxc6XBt5aDWQ7NR=7s35Qh5ONbaSaQ-MMA@mail.gmail.com>
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

On Wed, May 18, 2022 at 8:56 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> Configuring for a nommu classic m68k target and enabling the generic rtc
> driver (CONFIG_RTC_DRV_GENERIC) will result in the following compile
> error:
>
>    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>    time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
>
> There is no definitions of "mach_set_rtc_pll" and "mach_get_rtc_pll" in the
> nommu code paths. Move these definitions and the associated "mach_hwclk",
> so that they are around their use case in time.c. This means they will
> always be defined on the builds that require them, and not on those that
> cannot use them - such as ColdFire (both with and without MMU enabled).
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
