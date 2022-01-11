Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB39948BB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346761AbiAKXQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:16:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59176 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233147AbiAKXQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:16:20 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B44A41EC057F;
        Wed, 12 Jan 2022 00:16:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641942974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sJWqp8HpcSRFTfHMI7puDt3d/ZQjpKYsOb7yfXGoTVI=;
        b=sbV2VJ8Hkuf8H5ITEQqP9+TWC30wh1zhfB1HJzw5gbwFpNXeHlR4ZD6tVqnm5gumrS8htb
        6mG041hJA1WxBuaaf+mL2Sy5vwDPPRPjUkjyx1teWuTgodp8i6mEfjlkKo2ip1LvDSAUV/
        D7j8PXvmF/Si46fOa8JZVs+XkxUjjKo=
Date:   Wed, 12 Jan 2022 00:16:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: kmemleak detects leak in msr_build_context
Message-ID: <Yd4PwSBbIbg3TnNv@zn.tnic>
References: <94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de>
 <cd46f836-7d81-2178-c5ab-64db0be17e0e@intel.com>
 <41359b02-5f03-b822-9407-fb8d5ce44e70@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41359b02-5f03-b822-9407-fb8d5ce44e70@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:05:43PM +0100, Paul Menzel wrote:
> [    0.672475] smpboot: CPU0: AMD A6-6400K APU with Radeon(tm) HD Graphics (family: 0x15, model: 0x13, stepping: 0x1)

I have a similar box to yours:

[    0.382127] smpboot: CPU0: AMD PRO A12-8800B R7, 12 Compute Cores 4C+8G (family: 0x15, model: 0x60, stepping: 0x1)

...

[    0.974044] x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.

well, Bulldozer-based at least, and booting with kmemleak enabled is fine:

$ cat /sys/kernel/debug/kmemleak 
$

I wonder whether you have something else applied and forgotten along
with all those random printks I'm seeing in dmesg...

Also,

unreferenced object 0xffff8914823de500 (size 64):
					^^^^^^^^

That's strange too - sizeof(struct saved_msr) is 40 and not 64 so that
looks weird...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
