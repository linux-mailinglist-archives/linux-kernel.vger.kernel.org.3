Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B80542832
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbiFHHNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343598AbiFHGLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:11:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD2188E42;
        Tue,  7 Jun 2022 22:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6859BB823CE;
        Wed,  8 Jun 2022 05:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF184C34116;
        Wed,  8 Jun 2022 05:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654666055;
        bh=MlRI3FslLxCpadUQCkxKP9EyE+xCG5VhPqp7eO/RKxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTmq5cb3aiOFARjJfOSrWvmBbg4IqDeMYLAQcEwT3SvNyrlnsEdo+bJds7+Exmdp1
         79OrZgnbP09WSyuTFdvTyLah6ugaMZ0kez+KabcbeZ8t+RmwASwCkX7odNddl6yr6R
         MpgZoZU5zCgBI4H6UxtnJnfjlqCDb50dNLRMK7iirwicyyRs17a4fFjr1M+htOawKO
         MHyg7HHPVKiM4wuNrSNYHTep0JDdxmzQJitkoMH17qYMBcYHwsm4aubrdp6Yy11mck
         fYzRn/OXDH5gklZfaHxdLnwzgwLdwqoLF7wfqldmpcxcfnkI+cdpcFrefdlWXanfjB
         hgTz8Dxc3vbcw==
Date:   Wed, 8 Jun 2022 08:25:38 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Jarkko Sakkinen <jarkko@profian.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathaniel McCallum <nathaniel@profian.com>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Song Liu <song@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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
        Anup Patel <anup@brainfault.org>,
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
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] kprobes: Enable tracing for mololithic kernel images
Message-ID: <YqAy0qjI4Lktk/uJ@iki.fi>
References: <20220608000014.3054333-1-jarkko@profian.com>
 <CAJF2gTQgCn2CyZ4+VBqEEBT2b4+1KxoEXxrd+Ritk=58+U8EFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQgCn2CyZ4+VBqEEBT2b4+1KxoEXxrd+Ritk=58+U8EFA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 10:35:42AM +0800, Guo Ren wrote:
> .
> 
> On Wed, Jun 8, 2022 at 8:02 AM Jarkko Sakkinen <jarkko@profian.com> wrote:
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
> It's strange when MODULES is n, but vmlinux still obtains module_alloc.
> 
> Maybe we need a kprobe_alloc, right?

Perhaps not the best name but at least it documents the fact that
they use the same allocator.

Few years ago I carved up something "half-way there" for kprobes,
and I used the name text_alloc() [*].

[*] https://lore.kernel.org/all/20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com/ 

BR, Jarkko
