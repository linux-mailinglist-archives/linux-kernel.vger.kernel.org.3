Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253595513C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbiFTJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbiFTJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:10:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E43BDEB7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:10:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF0A1113E;
        Mon, 20 Jun 2022 02:10:33 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B72B3F7D7;
        Mon, 20 Jun 2022 02:10:30 -0700 (PDT)
Date:   Mon, 20 Jun 2022 10:10:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v5 2/8] arm64: extable: make uaaccess helper use
 extable type EX_TYPE_UACCESS_ERR_ZERO
Message-ID: <YrA5f44hySky8v5g@FVFF77S0Q05N>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-3-tongtiangen@huawei.com>
 <Yqw6TP3MhEqnQ+2o@FVFF77S0Q05N>
 <4371a7c9-8766-9fee-2558-e6f43f06ad19@huawei.com>
 <0da734f3-5743-3df3-3f90-d92e5bd585ce@huawei.com>
 <Yq3HoUyEcnKKk1AY@FVFF77S0Q05N>
 <684f0362-6e58-753d-32e1-112c6ffe6d12@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <684f0362-6e58-753d-32e1-112c6ffe6d12@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:59:12AM +0800, Tong Tiangen wrote:
> 在 2022/6/18 20:40, Mark Rutland 写道:
> > On Sat, Jun 18, 2022 at 04:42:06PM +0800, Tong Tiangen wrote:
> > > > > > diff --git a/arch/arm64/include/asm/asm-extable.h
> > > > > > b/arch/arm64/include/asm/asm-extable.h
> > > > > > index 56ebe183e78b..9c94ac1f082c 100644
> > > > > > --- a/arch/arm64/include/asm/asm-extable.h
> > > > > > +++ b/arch/arm64/include/asm/asm-extable.h
> > > > > > @@ -28,6 +28,14 @@
> > > > > >        __ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
> > > > > >        .endm
> > > > > > +/*
> > > > > > + * Create an exception table entry for uaccess `insn`, which
> > > > > > will branch to `fixup`
> > > > > > + * when an unhandled fault is taken.
> > > > > > + * ex->data = ~0 means both reg_err and reg_zero is set to wzr(x31).
> > > > > > + */
> > > > > > +    .macro          _asm_extable_uaccess, insn, fixup
> > > > > > +    __ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_UACCESS_ERR_ZERO, ~0)
> > > > > > +    .endm
> > > > > 
> > > > > I'm not too keen on using `~0` here, since that also sets other bits
> > > > > in the
> > > > > data field, and its somewhat opaque.
> > > > > 
> > > > > How painful is it to generate the data fields as with the C version
> > > > > of this
> > > > > macro, so that we can pass in wzr explciitly for the two sub-fields?
> > > > > 
> > > > > Other than that, this looks good to me.
> > > > > 
> > > > > Thanks,
> > > > > Mark.
> > > > 
> > > > ok, will fix next version.
> > > > 
> > > > Thanks,
> > > > Tong.
> > > 
> > > I tried to using data filelds as with C version, but here assembly code we
> > > can not using operator such as << and |, if we use lsl and orr instructions,
> > > the gpr will be occupied.
> > > 
> > > So how about using 0x3ff directly here? it means err register and zero
> > > register both set to x31.
> > 
> > I had a go at implementing this, and it seems simple enough. Please see:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/extable/asm-uaccess
> > 
> 
> I made the following modifications, and the other parts are based on your
> implementation:
> 
> arch/arm64/include/asm/asm-extable.h
> [...]
> .macro          _asm_extable_uaccess, insn, fixup
> _ASM_EXTABLE_UACCESS(\insn, \fixup)
> .endm
> [...]

I also made this same change locally when testing, and building with GCC 11.1.0
or LLVM 14.0.0 I am not seeing any problem when building, and the result is as
expected:

| [mark@lakrids:~/src/linux]% usekorg 11.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- defconfig
| *** Default configuration is based on 'defconfig'
| #
| # No change to .config
| #
| [mark@lakrids:~/src/linux]% usekorg 11.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -j50 arch/arm64/lib/
|   CALL    scripts/atomic/check-atomics.sh
|   CC      arch/arm64/kernel/asm-offsets.s
|   CALL    scripts/checksyscalls.sh
|   AS      arch/arm64/kernel/vdso/note.o
|   AS      arch/arm64/kernel/vdso/sigreturn.o
|   LD      arch/arm64/kernel/vdso/vdso.so.dbg
|   VDSOSYM include/generated/vdso-offsets.h
|   OBJCOPY arch/arm64/kernel/vdso/vdso.so
| make[2]: Nothing to be done for 'arch/arm64/lib/'.
|   AS      arch/arm64/lib/clear_page.o
|   AS      arch/arm64/lib/clear_user.o
|   AS      arch/arm64/lib/copy_from_user.o
|   AS      arch/arm64/lib/copy_page.o
|   AS      arch/arm64/lib/copy_to_user.o
|   CC      arch/arm64/lib/csum.o
|   CC      arch/arm64/lib/delay.o
|   AS      arch/arm64/lib/memchr.o
|   AS      arch/arm64/lib/memcmp.o
|   AS      arch/arm64/lib/memcpy.o
|   AS      arch/arm64/lib/memset.o
|   AS      arch/arm64/lib/strchr.o
|   AS      arch/arm64/lib/strcmp.o
|   AS      arch/arm64/lib/strlen.o
|   AS      arch/arm64/lib/strncmp.o
|   AS      arch/arm64/lib/strnlen.o
|   AS      arch/arm64/lib/strrchr.o
|   AS      arch/arm64/lib/tishift.o
|   AS      arch/arm64/lib/crc32.o
|   AS      arch/arm64/lib/mte.o
|   CC [M]  arch/arm64/lib/xor-neon.o
|   AR      arch/arm64/lib/built-in.a
|   AR      arch/arm64/lib/lib.a
| [mark@lakrids:~/src/linux]% usekorg 12.1.0 aarch64-linux-objdump -j __ex_table -D arch/arm64/lib/clear_user.o
| 
| arch/arm64/lib/clear_user.o:     file format elf64-littleaarch64
| 
| 
| Disassembly of section __ex_table:
| 
| 0000000000000000 <__ex_table>:
|         ...
|    8:   03ff0003        .inst   0x03ff0003 ; undefined
|         ...
|   14:   03ff0003        .inst   0x03ff0003 ; undefined
|         ...
|   20:   03ff0003        .inst   0x03ff0003 ; undefined
|         ...
|   2c:   03ff0003        .inst   0x03ff0003 ; undefined
|         ...
|   38:   03ff0003        .inst   0x03ff0003 ; undefined
|         ...
|   44:   03ff0003        .inst   0x03ff0003 ; undefined

> The following errors are reported during compilation:
> [...]
> arch/arm64/lib/clear_user.S:45: Error: invalid operands (*ABS* and *UND*
> sections) for `<<'
> [...]

As above, I'm not seeing this.

This suggests that the EX_DATA_REG() macro is going wrong somehow. Assuming the
operand types correspond to the LHS and RHS of the expression, this would mean
the GPR number is defined, but the REG value is not, and I can't currently see
how that can happen.

> "<<" is invalid operands in assembly, is there something wrong with me?

At the moment I can only assume there is a local problem. I'd suspect a typo
somewhere, but maybe you have a toolchain which behaves differently?

Thanks,
Mark.
