Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D931F547A1F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiFLMbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiFLMbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75F84EA1B;
        Sun, 12 Jun 2022 05:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5144360EBA;
        Sun, 12 Jun 2022 12:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D957FC34115;
        Sun, 12 Jun 2022 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655037062;
        bh=75vg2kGshxM5YQM0eTP5ZRYR8Fcv4/li4Jk7t1TdZ38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ihwcLZes9inwOPuBDeaJye7gcke1UBLU+1VBGf4DvKCK8cnpB6u1SzgyKO4ftcfZG
         ErQikmY7mpilG3tu8wVrlaHYSKH7Nu92Hyqnw97kzveTBBIVOS3uQ3Jqgu9GFW4w0/
         jmS6W7bFFcvW2dOW/LuS2HXtqiKHxLtKSxRKUtWOPvP35PudVpnCQhmoWF/hc9228f
         gVQ4oyLRAILBu9zA0K+lA3/gxYbMJXzy+bnGsqhl3RfaVq5/VfkBb87Ki9hv8Dkl4s
         ONjTLXhsGE6D3ntAiXzcwMS2P7ueWXHWUvDCIewbY4eDMY//09jGQh9ejxWsMYhY9O
         DS4tlNoS30DUQ==
Date:   Sun, 12 Jun 2022 21:30:41 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@profian.com>,
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
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] kprobes: Enable tracing for mololithic kernel images
Message-Id: <20220612213041.b1ec5d1ec3426e90e669c495@kernel.org>
In-Reply-To: <CAPhsuW7NZXepczZGyV2Ti4hNSupLBoKgA64K=zJN4uVBTxN37g@mail.gmail.com>
References: <20220608000014.3054333-1-jarkko@profian.com>
        <CAMj1kXFsdEq6XZ6eOuf8Ks-F4qgneVxFeLYNN_S4JaPy8koEyw@mail.gmail.com>
        <CAPhsuW7NZXepczZGyV2Ti4hNSupLBoKgA64K=zJN4uVBTxN37g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 11:19:19 -0700
Song Liu <song@kernel.org> wrote:

> On Wed, Jun 8, 2022 at 9:28 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hello Jarkko,
> >
> > On Wed, 8 Jun 2022 at 02:02, Jarkko Sakkinen <jarkko@profian.com> wrote:
> > >
> > > Tracing with kprobes while running a monolithic kernel is currently
> > > impossible because CONFIG_KPROBES is dependent of CONFIG_MODULES.  This
> > > dependency is a result of kprobes code using the module allocator for the
> > > trampoline code.
> > >
> > > Detaching kprobes from modules helps to squeeze down the user space,
> > > e.g. when developing new core kernel features, while still having all
> > > the nice tracing capabilities.
> > >
> > > For kernel/ and arch/*, move module_alloc() and module_memfree() to
> > > module_alloc.c, and compile as part of vmlinux when either CONFIG_MODULES
> > > or CONFIG_KPROBES is enabled.  In addition, flag kernel module specific
> > > code with CONFIG_MODULES.
> > >
> > > As the result, kprobes can be used with a monolithic kernel.
> >
> > I think I may have mentioned this the previous time as well, but I
> > don't think this is the right approach.
> >
> > Kprobes uses alloc_insn_page() to allocate executable memory, but the
> > requirements for this memory are radically different compared to
> > loadable modules, which need to be within an arch-specific distance of
> > the core kernel, need KASAN backing etc etc.
> 
> I think the distance of core kernel requirement is the same for kprobe
> alloc_insn_page and modules, no?

This strongly depends on how kprobes (software breakpoint and
single-step) is implemented on the arch. For example, x86 implements
the so-called "kprobe-booster" which jumps back from the single
stepping trampoline buffer. Then the buffer address must be within
the range where it can jump to the original address.
However, if the arch implements single-step as an instruction
emulation, it has no such limitation. As far as I know, arm64
will do emulation for the instructions which change PC register
and will do direct execution with another software breakpoint
for other instructions.

Why I'm using module_alloc() for a generic function, is that
can cover the limitation most widely.
Thus, if we have CONFIG_ARCH_HAVE_ALLOC_INSN_PAGE flag and
kprobes can check it instead of using __weak function, the
kprobes may not need to depend on module_alloc() in general.

Thank you,

> 
> Thanks,
> Song
> 
> >
> > This is why arm64, for instance, does not implement alloc_insn_page()
> > in terms of module_alloc() [and likely does not belong in this patch
> > for that reason]
> 
> 
> 
> >
> > Is there any reason kprobes cannot simply use vmalloc()?
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
