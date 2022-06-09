Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9E54451D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiFIHsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiFIHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:48:52 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDB76A043;
        Thu,  9 Jun 2022 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3xoIRA2BBvzVO0XOc/JU1zTILnsefWyOV49Y7IJ3FLY=; b=AGRuyJpQp9QMikHh/33qL0JsHV
        U+WVKRpKqJjJvGyaFDokMlWsSCM9no5evqxr8XfHexEuz39eb12W7RP7lrous4XASMRUkOLz5VouH
        wLOvqEp2LZsitkUiAmo4QZ4OqBM+FawBjbkxe3L4iSs+u4EoDbAZTWfm7hCu0mzKN+/zIyvki4As7
        StixFRJyaOTciQhpHuJ8zWO31vomCg9cRzQQEama2CztMyJ+0N8odAUMXxupDZVXJ2vDzPMCIz1fo
        q5Sz7FLf2dgFeqPVWUX5WWIQ+PRyBjxQp0aakORxRQrSWetvEE8P/oPwTCIquE+kqksSrLBnCbWei
        uIwhbQZg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32800)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nzCtn-0005fb-B8; Thu, 09 Jun 2022 08:48:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nzCtG-0002ae-KM; Thu, 09 Jun 2022 08:47:38 +0100
Date:   Thu, 9 Jun 2022 08:47:38 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jarkko Sakkinen <jarkko@profian.com>
Cc:     linux-kernel@vger.kernel.org,
        Nathaniel McCallum <nathaniel@profian.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
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
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] kprobes: Enable tracing for mololithic kernel images
Message-ID: <YqGlmpbx8HTrWmpF@shell.armlinux.org.uk>
References: <20220608000014.3054333-1-jarkko@profian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608000014.3054333-1-jarkko@profian.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 02:59:27AM +0300, Jarkko Sakkinen wrote:
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 553866751e1a..d2bb954cd54f 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -44,6 +44,11 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>  obj-$(CONFIG_ISA_DMA_API)	+= dma.o
>  obj-$(CONFIG_FIQ)		+= fiq.o fiqasm.o
>  obj-$(CONFIG_MODULES)		+= armksyms.o module.o
> +ifeq ($(CONFIG_MODULES),y)
> +obj-y				+= module_alloc.o
> +else
> +obj-$(CONFIG_KPROBES)		+= module_alloc.o
> +endif

Doesn't:

obj-$(CONFIG_MODULES)		+= module_alloc.o
obj-$(CONFIG_KPROBES)		+= module_alloc.o

work just as well? The kbuild modules.rst documentation says:

        The order of files in $(obj-y) is significant.  Duplicates in
        the lists are allowed: the first instance will be linked into
        built-in.a and succeeding instances will be ignored.

so you should be fine... or the documentation is wrong!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
