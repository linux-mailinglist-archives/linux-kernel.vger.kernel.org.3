Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEBB4734AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhLMTJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhLMTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:09:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB03C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:09:22 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F30EA1EC01FC;
        Mon, 13 Dec 2021 20:09:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639422557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1qN1RpOhsJkbmi5eTSjHFBRg7F1oVNKYFeFXAAGuN0o=;
        b=TXO/EOp1JfkkBK33WmHy06lcgo5358XB5HYC1/N++X19E8Q7emydEnQW1LAUiOVNtnmq9B
        fkMgHA2eTugODyrAQ3+ZgkphRCwJZ6eARHAUdpSAwM3m/DjJt+2QBMPEMF0QZtTZ/p5dAm
        vXzPxBN1deAV2R0vBKzT90h785jItQY=
Date:   Mon, 13 Dec 2021 20:09:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] X86/db: Change __this_cpu_read() to this_cpu_read()
 in hw_breakpoint_active()
Message-ID: <YbeaXT1Y80baey3t@zn.tnic>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213042215.3096-2-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:22:13PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>

Lai, what you're touching is complex stuff. If your commit messages
are hard to parse then that makes reviewing those patches not a fun
experience. Not in the least.

So please try to restrain yourself and write proper English. Run your
commit message through a spellchecker at least so that there are no
funky words.

Also, read Documentation/process/submitting-patches.rst for hints on
how to write it.

The structure and the explanation is in the right direction but please
try to formulate them as understandable as possible.

> __this_cpu_read() can not be instrumented except its own debugging code
> when CONFIG_DEBUG_PREEMPT.  The debugging code will call
> __this_cpu_preempt_check().  __this_cpu_preempt_check() itself is also
> noinstr, so __this_cpu_read() can be used in noinstr.
> 
> But these is one exception when exc_debug_kernel() calls local_db_save()
> which calls hw_breakpoint_active() which calls __this_cpu_read().  If
> the data accessed by __this_cpu_preempt_check() is also watched by
> hw_breakpoints, it would cause recursive #DB.

Up until here is good.
 
> this_cpu_read() in X86 is also non instrumentable, and it doesn't access

"x86" not "X86" or any other way.

Also, read this: Documentation/process/maintainer-tip.rst

as it has more hints about commit message structure etc.

> to any extra data except the percpu cpu_dr7, and cpu_dr7 is disallowed
> to be watched in arch_build_bp_info().  So this_cpu_read() is safe to
> be used when hw_breakpoints is still active, and __this_cpu_read() here
> should be changed to this_cpu_read().
> 
> This problem can only happen when the system owner uses a kernel with
> CONFIG_DEBUG_PREEMPT enabled and deliberately use hw_breakpoints on
> the data that __this_cpu_preempt_check() accesses.  Sot it is just a
> problem with no significance.
> 
> One might suggest that, all the data accessed by noinstr functions
> should be marked in denylist for hw_breakpoints.  That would complexify

should be marked in denylist for hw_breakpoints.  That would complexify
Unknown word [denylist] in commit message, suggestions:
        ['deny list', 'deny-list', 'dentistry']

should be marked in denylist for hw_breakpoints.  That would complexify
Unknown word [complexify] in commit message, suggestions:
        ['complexity', 'complexion']

> the noinstrment framework and add hurdles to anyone that who want to

the noinstrment framework and add hurdles to anyone that who want to
Unknown word [noinstrment] in commit message, suggestions:
        ['instrument']

So you need to restrain yourself and stop inventing new English words.

> add a new noinstr function.  All we need is to suppress #DB in the IST

Who is "we"?

> interrupt entry path until safe place where #DB is disabled in hardware
> or #DB handler can handle well even it hits data accessed by noinstr
> function.  Changing __this_cpu_read() to this_cpu_read() is fit for it.

You don't need to write *what* your patch is doing - that is clear from
the diff.

I'll let Peter comment on what should actually be used.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
