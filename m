Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F28C52B649
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiERJUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiERJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:20:42 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B8614A273;
        Wed, 18 May 2022 02:20:40 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id j3so1094183qvn.0;
        Wed, 18 May 2022 02:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pk6C9SrDQ3eeugkFD/p41tFZX2e6B2Jxpeux48HKyjk=;
        b=txygStwlYzljOucCJZDWHrYPe2S90mdB6G6H35gZk+ggu88Fm4ov4HY50BIBKX5tXj
         t5pfPyI1rs8vfhWp0MO5ujqQmHKKXGdNAcgRN97F86Fs2hX//0b+lcqw/P5ebeBMugXl
         +u9D3BXraVAuBllAQu/omkx1YnNqxvS+6IdOBfzmcqa3HoOMEXePT1IuqcTpP4e1v6Nm
         5CZq8+GYu+cIhE+Nr9GZTV+h5bSyAxD81Cn2dEscpE0wLIx0BLU/aHSCrR1TlKCY+ypp
         hJlKwWqYofIGaXgUGvsui5rko9PZA9pXZwXfjaq9DkUmCy/9Uoj2wUXrtHS7sf7dt7ce
         f4og==
X-Gm-Message-State: AOAM533EEShWSkZ12vJQWGGxoWjIbGEzeecZmm903i/VbIIgjSX6Xx2A
        RWW9mTzHDjo5lTVN3p9VosT1C+77Fx8MUA==
X-Google-Smtp-Source: ABdhPJzL9mKxNsJYRdeyMnlRDcSOLImMy6jmoiFs3WXk8FIPEEUQtdz5MA/fVE9TSAfB1bHVCn6X/A==
X-Received: by 2002:a0c:b392:0:b0:461:e7fa:2c0f with SMTP id t18-20020a0cb392000000b00461e7fa2c0fmr2222224qve.114.1652865639862;
        Wed, 18 May 2022 02:20:39 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id c2-20020ae9ed02000000b006a04256022bsm1184189qkg.107.2022.05.18.02.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 02:20:39 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id f16so2646417ybk.2;
        Wed, 18 May 2022 02:20:39 -0700 (PDT)
X-Received: by 2002:a25:4289:0:b0:64d:746f:5311 with SMTP id
 p131-20020a254289000000b0064d746f5311mr16654046yba.89.1652865639143; Wed, 18
 May 2022 02:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220518065639.2432213-1-gerg@linux-m68k.org> <20220518065639.2432213-4-gerg@linux-m68k.org>
In-Reply-To: <20220518065639.2432213-4-gerg@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 May 2022 11:20:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWADK4d-OxKYdnRvbtVsGtbZ_+vF2D70S-5hXNt0rqg9w@mail.gmail.com>
Message-ID: <CAMuHMdWADK4d-OxKYdnRvbtVsGtbZ_+vF2D70S-5hXNt0rqg9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] m68knommu: fix 68000 CPU link with no platform selected
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
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

Hi Greg.

On Wed, May 18, 2022 at 8:56 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> If building for a nommu m68k classic CPU and no platform (board) is
> selected then the final link fails with:
>
>      LD      vmlinux.o
>    m68k-linux-ld: cannot find arch/m68k/kernel/head.o: No such file or directory
>    make: *** [Makefile:1158: vmlinux] Error 1
>
> Not selecting a platform is ok, that is a generic 68000 system build.
> All of the platform selections are for 68328 variants.
>
> The underlying problem is that the CPU config option (CONFIG_M68000)
> ends up not being set, it is currently only selected by one of the
> platform choices.
>
> Change CONFIG_M68000 so that it is always enabled for the nommu m68k
> classic configuration.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Thanks for your patch!

> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -37,7 +37,7 @@ endchoice
>  if M68KCLASSIC
>
>  config M68000
> -       bool
> +       def_bool y

And then the selects can be removed, too, as the symbol is now always
enabled?

I'm wondering how to handle this when another nommu-m68k-classic
platform shows up (again, cfr. the removed 68360 support) , that
would need a different head.S?  Of course that's something to be
solved later...

>         depends on !MMU
>         select CPU_HAS_NO_BITFIELDS
>         select CPU_HAS_NO_CAS

Note that mmu-m68k-classic (e.g. CONFIG_MMU=y + allnonfig) has the
same problem.  That config does need other fixes too.  E.g. I have
a local patch to make sure NR_IRQS is never zero, but never got to
solve the missing head.o problem in an acceptable way.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
