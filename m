Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF451122E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358674AbiD0HRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358669AbiD0HRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:17:34 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709FD4B1D6;
        Wed, 27 Apr 2022 00:14:24 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id t16so542512qtr.9;
        Wed, 27 Apr 2022 00:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mvUlrTirU9klnitg8TwDGH+tVvlE6Lo8EZa9hr0GIw=;
        b=e9ZmajDgZ/7jQVApNUA0/JMJ24Otyi0XhG2iNMRupVMuPcsGh5ATNibPYGrgyP0b1C
         UGYRkLCEsBXAZIpHEJbok8rzjWZ4ePE2XiZ11HCuV0518dv6UAM/fPrc+wG8GUc8o5+L
         LFwK/Z0ti482txpd/+JARJ9Y6pVhje9sJ5Q3JOhZ1mfJLuYMcxxWXtBd8UcbWxdM1VG8
         vq6fhPvX3RORob6XxhO25g+ov2OhqtsN0qZVANPVS5tsJe46TI/8DnA0xisfc9yqy+P2
         WVlqdu5ZA1m2EuCnjYWA04zT/iBSUUwA0GiHp0P+Bnz5ccCfz7j8k4u8TTKUJLCD7tog
         JSKw==
X-Gm-Message-State: AOAM531PsUzcKakfkKBs1PfIvtptbDvFE4eS9IEFAHfwiXf5iVI9DxO5
        1MuTqk1TVk5fwDmrdeEp714dpg7n24tGPA==
X-Google-Smtp-Source: ABdhPJxlOWa55m+1hstWZnHF/1z6+9yCfsZu+RhdCKKDJSHMuZdFct+KSkQ8gdhKmcG62slG7Iz0UQ==
X-Received: by 2002:ac8:5894:0:b0:2f3:7266:e378 with SMTP id t20-20020ac85894000000b002f37266e378mr6568661qta.631.1651043663435;
        Wed, 27 Apr 2022 00:14:23 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85916000000b002f3402e34a3sm9820192qty.55.2022.04.27.00.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 00:14:22 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2ec42eae76bso8455087b3.10;
        Wed, 27 Apr 2022 00:14:21 -0700 (PDT)
X-Received: by 2002:a81:e10d:0:b0:2f7:bb2a:6529 with SMTP id
 w13-20020a81e10d000000b002f7bb2a6529mr22442009ywh.62.1651043661690; Wed, 27
 Apr 2022 00:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220427001226.1224704-1-keescook@chromium.org>
In-Reply-To: <20220427001226.1224704-1-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 09:14:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJczJGLxbFUyO8YDOAcCqdVQmo1zHj5PYtxruL9MzeOg@mail.gmail.com>
Message-ID: <CAMuHMdWJczJGLxbFUyO8YDOAcCqdVQmo1zHj5PYtxruL9MzeOg@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: cfi: Fix type width for masking PAC bits
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Li <ashimida@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Wed, Apr 27, 2022 at 2:12 AM Kees Cook <keescook@chromium.org> wrote:
> The masking for PAC bits wasn't handling 32-bit architectures correctly.
> Replace the u64 cast with uintptr_t.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/lkml/CAMuHMdVz-J-1ZQ08u0bsQihDkcRmEPrtX5B_oRJ+Ns5jrasnUw@mail.gmail.com
> Fixes: 2e53b877dc12 ("lkdtm: Add CFI_BACKWARD to test ROP mitigations")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thank you, that fixes the m68k allmodconfig build, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/misc/lkdtm/cfi.c
> +++ b/drivers/misc/lkdtm/cfi.c
> @@ -59,7 +59,7 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
>  #endif
>
>  #define no_pac_addr(addr)      \
> -       ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
> +       ((__force __typeof__(addr))((uintptr_t)(addr) | PAGE_OFFSET))

Not related to this patch, but "| PAGE_OFFSET" is not identical
to "+ PAGE_OFFSET" for large kernel sizes.

More specifically, I'm thinking about platforms where "large" would
be >= 32 MiB:
arch/mips/include/asm/mach-ar7/spaces.h:#define PAGE_OFFSET
_AC(0x94000000, UL)
or >= 128 MiB:
arch/x86/Kconfig:         default 0x78000000 if VMSPLIT_2G_OPT

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
