Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947BD5720AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiGLQVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiGLQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:21:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFBC8CAF28;
        Tue, 12 Jul 2022 09:21:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF0841596;
        Tue, 12 Jul 2022 09:21:09 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3AAA3F73D;
        Tue, 12 Jul 2022 09:21:07 -0700 (PDT)
Date:   Tue, 12 Jul 2022 17:21:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
Message-ID: <Ys2fbFm/qeLE2zol@FVFF77S0Q05N.cambridge.arm.com>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1t8win0pVPPuig@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys1t8win0pVPPuig@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 01:49:55PM +0100, Mark Rutland wrote:
> On Tue, Jul 12, 2022 at 03:27:09PM +0530, Naresh Kamboju wrote:
> > [    0.500613] ------------[ cut here ]------------
> > [    0.500709] kernel BUG at arch/arm64/kernel/traps.c:497!
> > [    0.500777] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [    0.500860] Modules linked in:
> > [    0.500947] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> >    5.19.0-rc6-next-20220711 #1
> > [    0.501034] Hardware name: FVP Base RevC (DT)
> > [    0.501109] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    0.501209] pc : do_undefinstr+0x284/0x2b4
> > [    0.501381] lr : do_undefinstr+0x150/0x2b4
> > [    0.501509] sp : ffff80000affbbc0
> > [    0.501509] x29: ffff80000affbbc0 x28: ffff000800330000 x27: ffff800009f00444
> > [    0.501759] x26: ffff800009fe6038 x25: 0000000000000001 x24: ffff80000a115968
> > [    0.501923] x23: 0000000040400009 x22: ffff800009f80de0 x21: ffff80000affbd90
> > [    0.502109] x20: 0000000001000000 x19: ffff80000affbc40 x18: ffffffffffffffff
> > [    0.502309] x17: 000000000000003f x16: 000000000000000a x15: ffff0008002b1a1c
> > [    0.502422] x14: ffffffffffffffff x13: ffff0008002b1268 x12: 20726f20746e6573
> > [    0.502683] x11: ffff80000aa12950 x10: 0000000000000073 x9 : ffff8000093bcd6c
> > [    0.502856] x8 : 000000003d4d554e x7 : ffff80000affbce0 x6 : 0000000000000001
> > [    0.503030] x5 : ffff80000a9ef000 x4 : ffff80000a9ef2e0 x3 : 0000000000000000
> > [    0.503234] x2 : ffff000800330000 x1 : ffff000800330000 x0 : 0000000040400009
> > [    0.503409] Call trace:
> > [    0.503480]  do_undefinstr+0x284/0x2b4
> > [    0.503562]  el1_undef+0x30/0x60
> > [    0.503709]  el1h_64_sync_handler+0x84/0xd0
> > [    0.503811]  el1h_64_sync+0x64/0x68
> > [    0.503909]  net_sysctl_init+0x8/0x7c
> > [    0.504053]  do_one_initcall+0x50/0x2b0
> > [    0.504158]  kernel_init_freeable+0x24c/0x2d4
> > [    0.504245]  kernel_init+0x30/0x140
> > [    0.504381]  ret_from_fork+0x10/0x20
> > [    0.504509] Code: 17ffff98 a9425bf5 17ffffbb a9025bf5 (d4210000)
> > [    0.504627] ---[ end trace 0000000000000000 ]---
> 
> We should really improve this WARN to something that tells us about the actual
> failing instruction.

FWIW, I've put together a series to improve the reporting here:

  https://lore.kernel.org/linux-arm-kernel/20220712161452.4142444-1-mark.rutland@arm.com

Thanks,
Mark.
