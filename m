Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F1055FDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiF2Ksk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF2Ksh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:48:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBC01A38F;
        Wed, 29 Jun 2022 03:48:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r18so13733357edb.9;
        Wed, 29 Jun 2022 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LFOwjQrAynhPJz9w2u2YY2RBLCZh4UAS01+RkIiElc=;
        b=dneHmp6YA1cG3nYmf9UuYKaCuH1hXRFEWx3WTF2ty6a9myUn2eqF9gjXMlXa3La8Gg
         VC10gpLljqL1ooesc7h7mKvbpvw4hc0lzOguyePMZbTAyJTeHzCIAYaTqUgGd1r8dhWT
         Kndakzd/rpUwN2ODtK1/UwYdfjYTxOAn92w7+RI4Jxk5julwlXtzRS2sN7B4ZSqOO3pW
         Ad01BneYF9sAorQLTi1e/j4zfnLe5AfFh1bTHXZmNZ03jidbaYrl0VVPJ58gUFWJSZmh
         EVlxxoxeco5L7nxDkaUNIzOcKfke+Px3y6xgv/EbCA8o+qxDRs6mco8veT05duUJs/VP
         Ld6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LFOwjQrAynhPJz9w2u2YY2RBLCZh4UAS01+RkIiElc=;
        b=483vX/mcDokS7K+QrlS8wR2Kp77L3k5pmGGXGoEUcSazs+LBmexxVAzGxnaSUJK050
         QfY+PoA49mhl0QPCEapE3jLynM/ZPVgae82V/G4IKhVyX42JR5fqCBF8T6OZr/+1/Rgi
         iohpr2lt+IDDHdaouz8+5f41ucHpuo+4u86OxKPWjbwO8Oklsl2xDR2mo9h/W4rXnTqM
         p/Gzgzc3YSyGsCxrUwzQZtR6UbAEyei/U0xtvWkeuBdzn29xx+UngVJgZyugQi7GPGt5
         mfjjGd9/T8ttke4s1rxmXnPwp+6b9Jsxlf+QAaKNPkHPmIt8PO7luJ/vGfJn43M75K1q
         PxGA==
X-Gm-Message-State: AJIora/0FnAYK0aOrYAjQ9x1C/xQyGn9ZFA8SUMboIGySIKqsKW3eqxx
        iRj+oR+FVn68Rh3kHewmT/otSK/XLUT6hA==
X-Google-Smtp-Source: AGRyM1vFiCAQXNLCOYQ/qrf/5NU8lfqplEuPbV4uIYv41Kuoos1HAZTnu7lkf/zQzOzHzELE8gkdpQ==
X-Received: by 2002:a05:6402:3682:b0:435:b12e:57cd with SMTP id ej2-20020a056402368200b00435b12e57cdmr3396614edb.381.1656499714338;
        Wed, 29 Jun 2022 03:48:34 -0700 (PDT)
Received: from sakura.myxoz.lan (195-198-44-182-no2390.tbcn.telia.com. [195.198.44.182])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906078200b006fe89cafc42sm7676800ejc.172.2022.06.29.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:48:33 -0700 (PDT)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     arnd@arndb.de, bigeasy@linutronix.de, chris@chrisdown.name,
        dmitry.torokhov@gmail.com, gustavoars@kernel.org,
        john.ogness@linutronix.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, oleksandr@redhat.com,
        quic_eberman@quicinc.com, seanjc@google.com, tglx@linutronix.de,
        vbabka@suse.cz, x86@kernel.org, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH] kbuild: drop support for CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
Date:   Wed, 29 Jun 2022 12:48:45 +0200
Message-ID: <2842572.mvXUDI8C0e@sakura.myxoz.lan>
In-Reply-To: <20220628210407.3343118-1-ndesaulniers@google.com>
References: <CA+55aFz2sNBbZyg-_i8_Ldr2e8o9dfvdSfHHuRzVtP2VMAUWPg@mail.gmail.com> <20220628210407.3343118-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 28 June 2022 23:04:07 CEST Nick Desaulniers wrote:
> The difference in most compilers between `-O3` and `-O2` is mostly down
> to whether loops with statically determinable trip counts are fully
> unrolled vs unrolled to a multiple of SIMD width.
> 
> This patch is effectively a revert of
> commit 15f5db60a137 ("kbuild,arc: add
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3 for ARC") without re-adding
> ARCH_CFLAGS
> 
> Ever since
> commit cfdbc2e16e65 ("ARC: Build system: Makefiles, Kconfig, Linker
> script")
> ARC has been built with -O3, though the reason for doing so was not
> specified in inline comments or the commit message. This commit does not
> re-add -O3 to arch/arc/Makefile.
> 
> Folks looking to experiment with `-O3` (or any compiler flag for that
> matter) may pass them along to the command line invocation of make:
> 
> $ make KCFLAGS=-O3
> 
> Code that looks to re-add an explicit Kconfig option for `-O3` should
> provide:
> 1. A rigorous and reproducible performance profile of a reasonable
>    userspace workload that demonstrates a hot loop in the kernel that
>    would benefit from `-O3` over `-O2`.
> 2. Disassembly of said loop body before and after.
> 3. Provides stats on terms of increase in file size.
> 

Might be worth cleaning up the rest of the kernel of instances of -O3,
too. -O3 used to build lz4 and mips vdso, for instance. Might be a bit
of a digression, though

--
~miko


