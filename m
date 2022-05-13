Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BA8525BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbiEMG4w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377551AbiEMG4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:56:48 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF3F4D278
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:56:47 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id z126so6471501qkb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A3H48Bilaow1oSqwuU8KPx26Mv8fSUb+Kt8mYEoS3qk=;
        b=MCop/csKcJHnOtYdrU7ZqDmq0z8SILRa0+XTcJSgadOv5zcmcKOEsQJRWxMm+CjzyV
         RksROO/2/XpvNEsYO/BIoC4j6TtYU4jwT1MQ05dRcRJfv4Zc7rlJ5U6oI9xHMqvkAdmY
         IfFZm7JKIo0AthQ4u2M6LXC181Vyc/Amn57qvpBz+0n97SbnYAr9s2IoOQPeuJ5D9Bnr
         Ms2MQlNvLWsQCT+I8SKjHvWH/ZUAz5BIQSEPLexP3ztThb1kjC02HwIovBosmN/9zrhF
         0qCkpBo+vqGKqiNbDDNfvzkHaquVHh+1AXGQ/mtamasGmQd0rjtETKS/xUtKmebfnegY
         aZtA==
X-Gm-Message-State: AOAM532zXPiUVjYRUl+kW2AStZI8eGKmvygKtMFtxAN/zu97+K6kgWnt
        lsvvtYuUHxL+7kfRQ3H2TdEivEf6P3pPQw==
X-Google-Smtp-Source: ABdhPJwuE+3FJL1XWogC7Ph820pLTyHv7m9N7ArigXSVNyEqQxeq0502cLq4Vcz0khSMoDR19Nbonw==
X-Received: by 2002:a37:658f:0:b0:69f:d94e:46c4 with SMTP id z137-20020a37658f000000b0069fd94e46c4mr2578067qkb.52.1652425005943;
        Thu, 12 May 2022 23:56:45 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id v6-20020ae9e306000000b0069fc13ce23esm920506qkf.111.2022.05.12.23.56.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 23:56:45 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id x74so1078536ybe.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:56:45 -0700 (PDT)
X-Received: by 2002:a25:4506:0:b0:648:cfc2:301d with SMTP id
 s6-20020a254506000000b00648cfc2301dmr3267840yba.380.1652425005199; Thu, 12
 May 2022 23:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
 <CAMuHMdW3BsuJOx6r1TmUJJYhqn_v5iDznTw0gnbayQAjBp2OYA@mail.gmail.com> <db869491-142f-4360-0f3c-e4395563088b@uclinux.org>
In-Reply-To: <db869491-142f-4360-0f3c-e4395563088b@uclinux.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 May 2022 08:56:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUb=c5WYviGqJXSVtWe4rob28oOQsPE2V==V3P7hDWwyg@mail.gmail.com>
Message-ID: <CAMuHMdUb=c5WYviGqJXSVtWe4rob28oOQsPE2V==V3P7hDWwyg@mail.gmail.com>
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

Hi Greg,

On Fri, May 13, 2022 at 1:23 AM Greg Ungerer <gerg@uclinux.org> wrote:
> On 11/5/22 22:54, Geert Uytterhoeven wrote:
> > On Wed, May 11, 2022 at 11:48 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> If CONFIG_M54xx=y, CONFIG_MMU=y, and CONFIG_M68KFPU_EMU=y:
> >>
> >>      {standard input}:272: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d1,%d3' ignored
> >>      {standard input}:609: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a1){%d0,#8},%d0' ignored
> >>      {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
> >>      {standard input}:1155: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored
> >>
> >> The math emulation support code is intended for 68020 and higher, and
> >> uses several instructions or instruction modes not available on coldfire
> >> or 68000.
> >>
> >> Originally, the dependency of M68KFPU_EMU on MMU was fine, as MMU
> >> support was only available on 68020 or higher.  But this assumption
> >> was broken by the introduction of MMU support for M547x and M548x.
> >>
> >> Drop the dependency on MMU, as the code should work fine on 68020 and up
> >> without MMU (which are not yet supported by Linux, though).
> >> Add dependencies on M68K_CLASSIC (to rule out Coldfire) and FPU (to rule
> >> out 68xxx below 68020).
> >>
> >> Fixes: 1f7034b9616e6f14 ("m68k: allow ColdFire 547x and 548x CPUs to be built with MMU enabled")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> ---
> >> To be queued in the m68k for-v5.19 branch.
> >>
> >>   arch/m68k/Kconfig.cpu | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> >> index 16ea9a67723c09dc..9abddbbee819f1d3 100644
> >> --- a/arch/m68k/Kconfig.cpu
> >> +++ b/arch/m68k/Kconfig.cpu
> >> @@ -327,7 +327,7 @@ comment "Processor Specific Options"
> >>
> >>   config M68KFPU_EMU
> >>          bool "Math emulation support"
> >> -       depends on MMU
> >> +       depends on M68K_CLASSIC && FPU
> >                        ^^^^^^^^^^^^
> > Whoops, that's a silly typo...
>
> Are you going to resend, or are you thinking of changing the way this is done?

I was going to resend, with the above fixed, and an improved patch
description w.r.t. the dependency on FPU.

> I had thought that CONFIG_FPU enabled meant you had some type of
> floating point support in the kernel - be it hardware or software emulated.
> So I don't have a problem with this "as is".

That matches my understanding, too.

BTW, I'm not familiar with Coldfire FPU support. Does it rely on any
emulation (e.g. for transcendental functions, like '040/'060)?
Would there be any point in making the math emulation code
Coldfire-proof?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
