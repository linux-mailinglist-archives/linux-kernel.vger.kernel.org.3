Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A11523372
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbiEKMy4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 May 2022 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242826AbiEKMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:54:50 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5AA6B7E2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:54:49 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id f3so2011150qvi.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q5qER0/5H5wBfui39NpZxFiYcytefU8SErVM/nlWBlU=;
        b=qpl7QZ3X5Nz0Z/Q/Az9QCXfTh4hKZZLz83+ugE0L5bvun48i1Z6ubZdO6VEwbZGQLZ
         K4l4yIeSkGkeRopHmyL8xuitEE6E0vVmhml8tSe0jXElYCHXD6Gj7OdGF9VknS0+73ls
         S+vxY0SXmqOL1pYUpa+0x3++xxIT6OEyDt4HMpRjND1dLJ7OjTEUoWcI1+Z4Wu9+DHMC
         OR/fyYwqJPjze89mzKZoTrXBkNOnRTCFYLvVoOyrBK7S7YhLyBM14KL7xZ1Tiu0oT35i
         LKdpewc6eM/FsXXaRMS/wJsZEH7mLGNhlmaxgumHTJtzS0d9fM7updy400TdvvM6Uav5
         dNOg==
X-Gm-Message-State: AOAM5325KdJkfTXrG8EFSpaNv3qyAUfa2YqbhhkVsHqQDcIPL2HKta2c
        SOeEVrElxp03+xXDSKw5QSgq/xAAb/u/Fg==
X-Google-Smtp-Source: ABdhPJwymMVXyWJVIsEgopaGk3zIuxkNHW/WrTbl5Weo45CgydITxwW8QdHBjlZuGxKX9cbl6Zm6QA==
X-Received: by 2002:a0c:aac6:0:b0:45a:aa3d:1658 with SMTP id g6-20020a0caac6000000b0045aaa3d1658mr21660953qvb.71.1652273688408;
        Wed, 11 May 2022 05:54:48 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id g24-20020a05620a13d800b0069fe1fc72e7sm1169384qkl.90.2022.05.11.05.54.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 05:54:47 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2f863469afbso20278057b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:54:47 -0700 (PDT)
X-Received: by 2002:a0d:d689:0:b0:2fb:9a57:8517 with SMTP id
 y131-20020a0dd689000000b002fb9a578517mr2566059ywd.502.1652273687431; Wed, 11
 May 2022 05:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
In-Reply-To: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 May 2022 14:54:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW3BsuJOx6r1TmUJJYhqn_v5iDznTw0gnbayQAjBp2OYA@mail.gmail.com>
Message-ID: <CAMuHMdW3BsuJOx6r1TmUJJYhqn_v5iDznTw0gnbayQAjBp2OYA@mail.gmail.com>
Subject: Re: [PATCH] m68k: math-emu: Fix dependencies of math emulation support
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 11:48 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> If CONFIG_M54xx=y, CONFIG_MMU=y, and CONFIG_M68KFPU_EMU=y:
>
>     {standard input}:272: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d1,%d3' ignored
>     {standard input}:609: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a1){%d0,#8},%d0' ignored
>     {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
>     {standard input}:1155: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored
>
> The math emulation support code is intended for 68020 and higher, and
> uses several instructions or instruction modes not available on coldfire
> or 68000.
>
> Originally, the dependency of M68KFPU_EMU on MMU was fine, as MMU
> support was only available on 68020 or higher.  But this assumption
> was broken by the introduction of MMU support for M547x and M548x.
>
> Drop the dependency on MMU, as the code should work fine on 68020 and up
> without MMU (which are not yet supported by Linux, though).
> Add dependencies on M68K_CLASSIC (to rule out Coldfire) and FPU (to rule
> out 68xxx below 68020).
>
> Fixes: 1f7034b9616e6f14 ("m68k: allow ColdFire 547x and 548x CPUs to be built with MMU enabled")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> To be queued in the m68k for-v5.19 branch.
>
>  arch/m68k/Kconfig.cpu | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index 16ea9a67723c09dc..9abddbbee819f1d3 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -327,7 +327,7 @@ comment "Processor Specific Options"
>
>  config M68KFPU_EMU
>         bool "Math emulation support"
> -       depends on MMU
> +       depends on M68K_CLASSIC && FPU
                      ^^^^^^^^^^^^
Whoops, that's a silly typo...

>         help
>           At some point in the future, this will cause floating-point math
>           instructions to be emulated by the kernel on machines that lack a

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
