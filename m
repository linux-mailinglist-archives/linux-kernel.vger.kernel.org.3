Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A554B7358
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiBOPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:46:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbiBOPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:45:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359E7D15C6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:42:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FEC56173E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF950C340EB;
        Tue, 15 Feb 2022 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644939778;
        bh=vzyFMhGsfn/rk38bV9aGlalnsputB6BGCOL+8B6o7Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNI7u7wCnN07cGh93W7Jd2myp7Re0Mh/JT2m2U4uaG4f9AeseBcC/QduH/JcqR04y
         cP5NTTOKadVvlnJHKQICUaTDLLqurPFWI9LN+Lm27I6SM+jRQB/YfyBmEVNGETBSip
         B8P2lD1yNsvJ1H0/skAMArzHE2BsIntxz39fGWxnxLUA3h79TO5ny3U4vfgQCotx1m
         KsZPsbtJ7LGVFW56/a4/r/i/yUGNHH1Hdwl7X/pM0qLmwA5Ia6WbkVOBO6R+6FGLGY
         EtagshxnP+Kt9dJlwccOjjLqEAdZu6+gaqTzJ3vor5es0Ap3N5RFxdg3ITxcSL5qkZ
         ZugoJMetxYw/w==
Date:   Tue, 15 Feb 2022 23:34:59 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, alexandre.ghiti@canonical.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 0/3] unified way to use static key and optimize
 pgtable_l4_enabled
Message-ID: <YgvIIw1CV4gxn2lS@xhacker>
References: <20220125165036.987-1-jszhang@kernel.org>
 <mhng-41f2520d-7583-41b3-ae7a-95e74117676a@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-41f2520d-7583-41b3-ae7a-95e74117676a@palmer-ri-x1c9>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 03:52:44PM -0800, Palmer Dabbelt wrote:
> On Tue, 25 Jan 2022 08:50:33 PST (-0800), jszhang@kernel.org wrote:
> > Currently, riscv has several features why may not be supported on all
> > riscv platforms, for example, FPU, SV48 and so on. To support unified
> > kernel Image style, we need to check whether the feature is suportted
> > or not. If the check sits at hot code path, then performance will be
> > impacted a lot. static key can be used to solve the issue. In the
> > past FPU support has been converted to use static key mechanism. I
> > believe we will have similar cases in the future. For example, the
> > SV48 support can take advantage of static key[1].
> > 
> > patch1 introduces an unified mechanism to use static key for riscv cpu
> > features.
> > patch2 converts has_cpu() to use the mechanism.
> > patch3 uses the mechanism to optimize pgtable_l4_enabled.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
> > 
> > Jisheng Zhang (3):
> >   riscv: introduce unified static key mechanism for CPU features
> >   riscv: replace has_fpu() with system_supports_fpu()
> >   riscv: convert pgtable_l4_enabled to static key
> 
> I see some build failures from LKP, but I don't see a v2.  LMK if I missed
> it.

Hi Palmer,

I also saw the build failure due to RV32, fixing it is easy but I have
some thoughts/questions here after reading Atish's "fraemework for RISC-V
ISA extensions" series. 

Hi All,

I'm considering how to support cpu features or new ISA extensions.
IMHO, we will need some static keys for ISA extenstions as well as
the cpu features. for example:

if (static_branch_likely(&has_isa_ext_foo))
	do_something;

So I have a big question here about CPU features VS. ISA extensions:

1. Is CPU feature == ISA extension?
If yes, then it seems we'd better rebase this series on the ISA
extension series. If no, which is the super set? If CPU feature
is the super set, then if one kind of future cpu feature is implemented
via. the ISA extension, do we need to combine the cpu feature bitmap
with the ISA extension bitmap? how?

2. Is SV48 considered as riscv ISA extension?

I will also comment in Atish's series.

Thanks

> 
> > 
> >  arch/riscv/Makefile                 |   3 +
> >  arch/riscv/include/asm/cpufeature.h | 105 ++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/pgalloc.h    |   8 +--
> >  arch/riscv/include/asm/pgtable-64.h |  21 +++---
> >  arch/riscv/include/asm/pgtable.h    |   3 +-
> >  arch/riscv/include/asm/switch_to.h  |   9 +--
> >  arch/riscv/kernel/cpu.c             |   2 +-
> >  arch/riscv/kernel/cpufeature.c      |  29 ++++++--
> >  arch/riscv/kernel/process.c         |   2 +-
> >  arch/riscv/kernel/signal.c          |   4 +-
> >  arch/riscv/mm/init.c                |  23 +++---
> >  arch/riscv/mm/kasan_init.c          |   6 +-
> >  arch/riscv/tools/Makefile           |  22 ++++++
> >  arch/riscv/tools/cpucaps            |   6 ++
> >  arch/riscv/tools/gen-cpucaps.awk    |  40 +++++++++++
> >  15 files changed, 234 insertions(+), 49 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/cpufeature.h
> >  create mode 100644 arch/riscv/tools/Makefile
> >  create mode 100644 arch/riscv/tools/cpucaps
> >  create mode 100755 arch/riscv/tools/gen-cpucaps.awk
