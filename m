Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7448E8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiANLJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiANLJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:09:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023ACC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C85E1B82547
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8523C36AEB;
        Fri, 14 Jan 2022 11:09:52 +0000 (UTC)
Date:   Fri, 14 Jan 2022 11:09:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: kmemleak detects leak in msr_build_context
Message-ID: <YeFZ/cPoKPx4h1N0@arm.com>
References: <94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de>
 <cd46f836-7d81-2178-c5ab-64db0be17e0e@intel.com>
 <41359b02-5f03-b822-9407-fb8d5ce44e70@molgen.mpg.de>
 <Yd4PwSBbIbg3TnNv@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd4PwSBbIbg3TnNv@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 12:16:17AM +0100, Borislav Petkov wrote:
> On Tue, Jan 11, 2022 at 10:05:43PM +0100, Paul Menzel wrote:
> > [    0.672475] smpboot: CPU0: AMD A6-6400K APU with Radeon(tm) HD Graphics (family: 0x15, model: 0x13, stepping: 0x1)
> 
> I have a similar box to yours:
> 
> [    0.382127] smpboot: CPU0: AMD PRO A12-8800B R7, 12 Compute Cores 4C+8G (family: 0x15, model: 0x60, stepping: 0x1)
> 
> ...
> 
> [    0.974044] x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.
> 
> well, Bulldozer-based at least, and booting with kmemleak enabled is fine:
> 
> $ cat /sys/kernel/debug/kmemleak 
> $
> 
> I wonder whether you have something else applied and forgotten along
> with all those random printks I'm seeing in dmesg...
> 
> Also,
> 
> unreferenced object 0xffff8914823de500 (size 64):
> 					^^^^^^^^
> 
> That's strange too - sizeof(struct saved_msr) is 40 and not 64 so that
> looks weird...

That's probably because slab_post_alloc_hook() doesn't get the original
kmalloc() size, so it uses the slab object size when calling the
kmemleak hook.

-- 
Catalin
