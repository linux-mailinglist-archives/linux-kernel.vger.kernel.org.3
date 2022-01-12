Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACE48C234
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352509AbiALK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346668AbiALK0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:26:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950A9C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bY2JSU8rJ+dPp80OKJVHcdzdjlnRjYlHBejREtlB6zg=; b=a7KRul1JWTSh1kjSCPmtTe5u3x
        3NtK1XHXoiLuedeRkuwMaZT7uV/6wQN1JVbBjQM51QhE0PMKgctbeoMyeJGuGYlvfOKHU/fK+Zzlu
        S/waPaWdgFrpwpSNDpQ78iSoaUkoHDOc+Qam2i+dZM6XdLqkDpBp2s2FU8mDjXHPJq+0CtAiG8pmm
        kRab8T6kSl4D0OXhEeQsom6jEGaNgz7zzp8ueS1uORxsC6Ks52OAQaNABiw0ZGGwP5Lk/9doKatES
        UXdoBOIJpdei9FGD7f753v8o/FBzvHPl0Av4vebquNV++o4fdxpcwlvg++3zVC1pfo8qg3eb+srVp
        uhrMURdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7apF-00413M-SV; Wed, 12 Jan 2022 10:25:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B1E8300222;
        Wed, 12 Jan 2022 11:25:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7752E20DD2CE1; Wed, 12 Jan 2022 11:25:53 +0100 (CET)
Date:   Wed, 12 Jan 2022 11:25:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [x86/entry_32]  aa93e2ad74:
 BUG:soft_lockup-CPU##stuck_for#s![systemd-logind:#]
Message-ID: <Yd6ssarpDknV1r9z@hirez.programming.kicks-ass.net>
References: <20220106083523.GB32167@xsang-OptiPlex-9020>
 <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
 <Yd4u2rVVSdpEpwwM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd4u2rVVSdpEpwwM@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 01:28:58AM +0000, Sean Christopherson wrote:
> On Tue, Jan 11, 2022, Peter Zijlstra wrote:
> > On Thu, Jan 06, 2022 at 04:35:23PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with clang-14):
> > > 
> > > commit: aa93e2ad7464ffb90155a5ffdde963816f86d5dc ("x86/entry_32: Remove .fixup usage")
> > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/core
> > > 
> > > in testcase: kernel-selftests
> > > version: 
> > > with following parameters:
> > > 
> > > 	group: x86
> > > 
> > 
> > It would be very useful if this thing would also say which of the many
> > x86 selftests fails... it appears to be: ldt_gdt_32.
> > 
> > The below fixes it, but I'm still not entirely sure what the actual
> > problem is, although Andy did find a bug in that the exception handler
> > should do: *(ss:esp) = 0, adding ss-base (using insn_get_seg_base())
> > doesn't seem to cure things.
> 
> Because I was curious...
> 
> The issue is that PARANOID_EXIT_TO_KERNEL_MODE in the handle_exception_return
> path overwrites the entry stack data with the task stack data, restoring the "bad"
> segment value.

Oh gawd... that's terrible, and yes, that now makes perfect sense.

However did you find that?
