Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F998525C31
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377726AbiEMHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377718AbiEMHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:12:43 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3727926BCAE;
        Fri, 13 May 2022 00:12:42 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id c1so6451860qkf.13;
        Fri, 13 May 2022 00:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAckVErL2I+GEDHxjlLL0tfPz7bzJ1rQmGwF9AMR3q4=;
        b=EvuB/7PdV0V6wXGIOJUUpFOsGeOEj7AGsYkGpf7rVVVEbXEp7NA18eTsSvTQEFPP0E
         SL4OmO+/ziNEuWa4HmLv82KhNV0C/3f0y2n6qgqdXDFmeV65aMGumfA6W5ckn0Enrr+j
         Rw/aCwJkyt3tYtuE2obfDETK18ZClONUDIhgaBPqPV2et/JUht3M8plrQPAkefojuxvk
         ZZCAIxFTrC9ZudcGUlCZYKpnFfUg/y7bCA0qhC2SGiAxonvFiy0fJcD/355LcdJ+6E/c
         l13DSXfkRzebC9HMAOuo6766EYn1hnH5y12pT6Jw0f+isyyawbxG5+TnuAkQp7Xd89dZ
         8cTA==
X-Gm-Message-State: AOAM531oOTANdR25eWjnAFUt862cFJKv9RQkhvp5D5/3+66UAZg8eL9G
        M12trEAirgwl+VcpMXi2a+a79j8plSMhxg==
X-Google-Smtp-Source: ABdhPJzBQ/gLzRBbQ5SHtMSs9roWZSL7AslMLDIrBfSVvMGaNqiaFbVbzuP4WkXFj1yd/WLq2rBfVA==
X-Received: by 2002:a37:6287:0:b0:69f:c147:405c with SMTP id w129-20020a376287000000b0069fc147405cmr2694536qkb.16.1652425961014;
        Fri, 13 May 2022 00:12:41 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id e1-20020a05620a208100b0069fc13ce205sm935510qka.54.2022.05.13.00.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 00:12:40 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id m128so13821756ybm.5;
        Fri, 13 May 2022 00:12:40 -0700 (PDT)
X-Received: by 2002:a25:4506:0:b0:648:cfc2:301d with SMTP id
 s6-20020a254506000000b00648cfc2301dmr3314186yba.380.1652425960343; Fri, 13
 May 2022 00:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220513064952.3610672-1-gerg@linux-m68k.org>
In-Reply-To: <20220513064952.3610672-1-gerg@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 May 2022 09:12:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
Message-ID: <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
Subject: Re: [PATCH] m68knommu: fix undefined reference to `mach_get_rtc_pll'
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

On Fri, May 13, 2022 at 8:50 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> Configuring for a nommu classic m68k target and enabling the generic rtc
> driver (CONFIG_RTC_DRV_GENERIC) will result in the following compile
> error:
>
>    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>    time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
>
> "mach_set_rtc_pll" and "mach_get_rtc_pll" are only defined in the common
> MMU setup code, and are really only implemented in any meaningful way on
> classic M68K MMU enabled machines. So conditionally limit their use to

And only on Q40/Q60.

> MMU enabled classic M68K systems.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Thanks for your patch!

> --- a/arch/m68k/kernel/time.c
> +++ b/arch/m68k/kernel/time.c
> @@ -62,7 +62,7 @@ void timer_heartbeat(void)
>  }
>  #endif /* CONFIG_HEARTBEAT */
>
> -#ifdef CONFIG_M68KCLASSIC
> +#if defined(CONFIG_M68KCLASSIC) && defined(CONFIG_MMU)
>  #if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
>  void read_persistent_clock64(struct timespec64 *ts)
>  {

read_persistent_clock64() uses mach_hwclk(), which is provided by
both setup_mm.c and setup_no.c, so it's always available?
Albeit not populated by coldfire or nommu platform code, so I see
the point in depending on MMU (no nommu Amiga support yet ;-).

Perhaps rtc_ioctl() should depend on CONFIG_Q40?

> @@ -140,7 +140,7 @@ static int __init rtc_init(void)
>
>  module_init(rtc_init);
>  #endif /* CONFIG_RTC_DRV_GENERIC */
> -#endif /* CONFIG M68KCLASSIC */
> +#endif /* CONFIG M68KCLASSIC && CONFIG_MMU */
>
>  void __init time_init(void)
>  {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
