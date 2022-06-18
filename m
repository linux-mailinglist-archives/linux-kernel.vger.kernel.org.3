Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4045504CA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 14:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiFRMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 08:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiFRMkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 08:40:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78C0A1EAE0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 05:40:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EF68113E;
        Sat, 18 Jun 2022 05:40:13 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.35.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6859A3F792;
        Sat, 18 Jun 2022 05:40:08 -0700 (PDT)
Date:   Sat, 18 Jun 2022 13:40:01 +0100
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
Message-ID: <Yq3HoUyEcnKKk1AY@FVFF77S0Q05N>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-3-tongtiangen@huawei.com>
 <Yqw6TP3MhEqnQ+2o@FVFF77S0Q05N>
 <4371a7c9-8766-9fee-2558-e6f43f06ad19@huawei.com>
 <0da734f3-5743-3df3-3f90-d92e5bd585ce@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0da734f3-5743-3df3-3f90-d92e5bd585ce@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 04:42:06PM +0800, Tong Tiangen wrote:
> > > > diff --git a/arch/arm64/include/asm/asm-extable.h
> > > > b/arch/arm64/include/asm/asm-extable.h
> > > > index 56ebe183e78b..9c94ac1f082c 100644
> > > > --- a/arch/arm64/include/asm/asm-extable.h
> > > > +++ b/arch/arm64/include/asm/asm-extable.h
> > > > @@ -28,6 +28,14 @@
> > > >       __ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
> > > >       .endm
> > > > +/*
> > > > + * Create an exception table entry for uaccess `insn`, which
> > > > will branch to `fixup`
> > > > + * when an unhandled fault is taken.
> > > > + * ex->data = ~0 means both reg_err and reg_zero is set to wzr(x31).
> > > > + */
> > > > +    .macro          _asm_extable_uaccess, insn, fixup
> > > > +    __ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_UACCESS_ERR_ZERO, ~0)
> > > > +    .endm
> > > 
> > > I'm not too keen on using `~0` here, since that also sets other bits
> > > in the
> > > data field, and its somewhat opaque.
> > > 
> > > How painful is it to generate the data fields as with the C version
> > > of this
> > > macro, so that we can pass in wzr explciitly for the two sub-fields?
> > > 
> > > Other than that, this looks good to me.
> > > 
> > > Thanks,
> > > Mark.
> > 
> > ok, will fix next version.
> > 
> > Thanks,
> > Tong.
> 
> I tried to using data filelds as with C version, but here assembly code we
> can not using operator such as << and |, if we use lsl and orr instructions,
> the gpr will be occupied.
> 
> So how about using 0x3ff directly here? it means err register and zero
> register both set to x31.

I had a go at implementing this, and it seems simple enough. Please see:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/extable/asm-uaccess

Mark.
