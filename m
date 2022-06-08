Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643DF543B60
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiFHSVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiFHSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8CA478;
        Wed,  8 Jun 2022 11:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8169161BE2;
        Wed,  8 Jun 2022 18:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7868C341C7;
        Wed,  8 Jun 2022 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654712371;
        bh=BrMt+22N41uzooUnzPUoRXnpI1kF+bmp+ST9j+9wk1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=StmQEqAdS/onK3x3jVjIrEPS7TE62tVZdrRl7yCCLHSUtqUl0sszeA6m8IlQMUNsA
         NvP9xfO+4f6DpVsUlbf1p7SW00y59l0D1/aohwUdP1Rx+Aw3fUa72rTgnaXH2ZU83H
         cAkDe0Y5m+t3lNizmtlx2uVxbXKzZBnvDSWMoorJ15pwBINXXH+G8wX2sAst40Zjua
         Eaf5HK8xbP0FLlhBxPWDLcKebIC3jMHyhOXWNqtOvhPj5z9/w2cb4RaJ1eBhXASHvn
         wc+WGtmUbt6NeBYy6IhVV/qOnSfCrnCFdt5r6qizloiVh1oWyc8bULajR66pSo9DRj
         4zGyMP7SfH29Q==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ef5380669cso217877987b3.9;
        Wed, 08 Jun 2022 11:19:31 -0700 (PDT)
X-Gm-Message-State: AOAM530hdWvnvRxyK7MCL6E7R9l1l2aUROIA99QN9AERsiDXI/GpyXAi
        6qGYvifuCqiPLRLCfenOoxe80dIbx90DlbdSGNM=
X-Google-Smtp-Source: ABdhPJzriHyGLGwDai2rVcky87dr5my3t8HULhAS0zE1LEI+/L1Wv0eduSFTK2BSoTXq6GOLOf6KiMiv8mt8c35aPAU=
X-Received: by 2002:a81:4a82:0:b0:2ff:94b4:b4d1 with SMTP id
 x124-20020a814a82000000b002ff94b4b4d1mr38668766ywa.130.1654712370883; Wed, 08
 Jun 2022 11:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220608000014.3054333-1-jarkko@profian.com> <CAMj1kXFsdEq6XZ6eOuf8Ks-F4qgneVxFeLYNN_S4JaPy8koEyw@mail.gmail.com>
In-Reply-To: <CAMj1kXFsdEq6XZ6eOuf8Ks-F4qgneVxFeLYNN_S4JaPy8koEyw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 8 Jun 2022 11:19:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7NZXepczZGyV2Ti4hNSupLBoKgA64K=zJN4uVBTxN37g@mail.gmail.com>
Message-ID: <CAPhsuW7NZXepczZGyV2Ti4hNSupLBoKgA64K=zJN4uVBTxN37g@mail.gmail.com>
Subject: Re: [PATCH] kprobes: Enable tracing for mololithic kernel images
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jarkko Sakkinen <jarkko@profian.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Guenter Roeck <linux@roeck-us.net>,
        Dave Anglin <dave.anglin@bell.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexei Starovoitov <ast@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Changbin Du <changbin.du@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liao Chang <liaochang1@huawei.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Wu Caize <zepan@sipeed.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tobias Huschle <huschle@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 9:28 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hello Jarkko,
>
> On Wed, 8 Jun 2022 at 02:02, Jarkko Sakkinen <jarkko@profian.com> wrote:
> >
> > Tracing with kprobes while running a monolithic kernel is currently
> > impossible because CONFIG_KPROBES is dependent of CONFIG_MODULES.  This
> > dependency is a result of kprobes code using the module allocator for the
> > trampoline code.
> >
> > Detaching kprobes from modules helps to squeeze down the user space,
> > e.g. when developing new core kernel features, while still having all
> > the nice tracing capabilities.
> >
> > For kernel/ and arch/*, move module_alloc() and module_memfree() to
> > module_alloc.c, and compile as part of vmlinux when either CONFIG_MODULES
> > or CONFIG_KPROBES is enabled.  In addition, flag kernel module specific
> > code with CONFIG_MODULES.
> >
> > As the result, kprobes can be used with a monolithic kernel.
>
> I think I may have mentioned this the previous time as well, but I
> don't think this is the right approach.
>
> Kprobes uses alloc_insn_page() to allocate executable memory, but the
> requirements for this memory are radically different compared to
> loadable modules, which need to be within an arch-specific distance of
> the core kernel, need KASAN backing etc etc.

I think the distance of core kernel requirement is the same for kprobe
alloc_insn_page and modules, no?

Thanks,
Song

>
> This is why arm64, for instance, does not implement alloc_insn_page()
> in terms of module_alloc() [and likely does not belong in this patch
> for that reason]



>
> Is there any reason kprobes cannot simply use vmalloc()?
>
