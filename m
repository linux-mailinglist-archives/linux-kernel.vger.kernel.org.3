Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9448E95E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbiANLoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:44:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44780 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbiANLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:44:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ADDCB8259A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D35C36AE5;
        Fri, 14 Jan 2022 11:44:38 +0000 (UTC)
Date:   Fri, 14 Jan 2022 11:44:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: kmemleak detects leak in msr_build_context
Message-ID: <YeFiI1xhiZK7uU+Z@arm.com>
References: <94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de>
 <cd46f836-7d81-2178-c5ab-64db0be17e0e@intel.com>
 <41359b02-5f03-b822-9407-fb8d5ce44e70@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41359b02-5f03-b822-9407-fb8d5ce44e70@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:05:43PM +0100, Paul Menzel wrote:
> Am 11.01.22 um 16:26 schrieb Dave Hansen:
> > On 1/10/22 23:49, Paul Menzel wrote:
> > > Running Linux from commit bf4eebf8cfa2 (Merge tag
> > > 'linux-kselftest-kunit-5.17-rc1' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest),
> > > kmemleak reported the leak below:
> > > 
> > > ```
> > > unreferenced object 0xffff8914823de500 (size 64):
> > >    comm "swapper/0", pid 1, jiffies 4294667581 (age 1253.406s)
> > >    hex dump (first 32 bytes):
> > >      00 00 00 00 00 00 00 00 04 10 01 c0 00 00 00 00  ................
> > >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >    backtrace:
> > >      [<000000007f3b05e9>] __kmalloc+0x177/0x330
> > >      [<0000000008104cca>] msr_build_context.constprop.0+0x32/0xbe
> > >      [<00000000012bab4e>] msr_save_cpuid_features+0x28/0x2f
> > >      [<00000000b7a2262e>] pm_check_save_msr+0x2e/0x40
> > >      [<00000000cbe9d92d>] do_one_initcall+0x44/0x200
> > >      [<0000000094deab7b>] kernel_init_freeable+0x1fc/0x273
> > >      [<00000000d3dbaa56>] kernel_init+0x16/0x160
> > >      [<0000000058c4a8b3>] ret_from_fork+0x22/0x30
[...]
> > I've taken a look through arch/x86/power/cpu.c, and nothing obvious
> > jumped out at me.  msr_build_context() could probably be cleaned up by
> > using kvrealloc(), but it hasn't been touched recently in a way that I
> > would expect things to leak.
[...]
> > I suspect this is a false positive from kmemleak.
> 
> Maybe Catalin can check.

I can't see anything obviously wrong with msr_build_context(), unless it
can somehow be called concurrently, the saved_msrs.array update wouldn't
be safe. Another place to look at is whether saved_context.saved_msrs is
getting corrupt somehow.

If you force another kmemleak scan (through echo scan > /sys/...), does
the leak report disappear? This would be a good indication of a false
positive, though this normally happens with structures that are changed
frequently.

A way to confirm (or rule out) a kmemleak false positive would be to
check that saved_context.saved_msrs.array still points to the
unreferenced object listed above (you may need some kernel
instrumentation). If it doesn't, we'd need to figure out what happened
with the previous array.

-- 
Catalin
