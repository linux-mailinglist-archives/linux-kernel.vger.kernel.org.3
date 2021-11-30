Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD14641C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhK3Wvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:51:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35024 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhK3Wvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:51:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5ABFBB81D39
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 22:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8E6C53FCC;
        Tue, 30 Nov 2021 22:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638312506;
        bh=Jrv04/IrWzzfSXF8XxNL+EHvTy1MiHKmqPvIE8MC5dc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nIejIOTsZN3XhuWAIw53EDG6RJUlqL7RTuydKKBTDm8FmqFrqo98nRnZEm8V+dI65
         C1GieU+T5U2VFq7mKdUJJp/LPPFNHK+HYPSjQHlBejYu/i8okEe3CswvsCpIL4c4E6
         KX9YSJuWldC7uv9mNGidYxt01sefc3W4Lvs4O9xSWggJ1r9pkwQfTKDFRDEldg5FUD
         CmfVzUbXlOUrJhsher1ivDK7DpT50IL2GhYLUOBgtetuk88IxR7/NtxlkMtbzUpuAw
         UxLYvB61s85yx9kjgttx01Z9d0dsIUzJ05JCbqE08Ede/c7Lu+BNwh/cjodstoZPSN
         v/Eh/S0cWsc8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9C1B75C0367; Tue, 30 Nov 2021 14:48:25 -0800 (PST)
Date:   Tue, 30 Nov 2021 14:48:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for qualified
 platforms
Message-ID: <20211130224825.GA641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <20211130064623.GB96474@shbuild999.sh.intel.com>
 <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
 <20211130150256.GA19477@shbuild999.sh.intel.com>
 <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <87r1axbcor.ffs@tglx>
 <20211130204721.GZ641268@paulmck-ThinkPad-P17-Gen-1>
 <87ilw9b95q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilw9b95q.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:55:45PM +0100, Thomas Gleixner wrote:
> On Tue, Nov 30 2021 at 12:47, Paul E. McKenney wrote:
> > On Tue, Nov 30, 2021 at 09:39:32PM +0100, Thomas Gleixner wrote:
> >> Seriously. Jiffies is not usable as watchdog simply because lost ticks
> >> cannot be compensated and you cannot use TSC to bridge them because you
> >> are not trusting TSC. This is simply a circulus vitiosus.
> >
> > OK, HPET or nothing, then.
> 
> Older machines also have pm_timer. But those beasts seem to have lost
> that too.

I suppose that one way of avoiding clock-skew messages is to have only
one clock.

> >> We really need to remove the watchdog requirement for modern hardware.
> >> Let me stare at those patches and get them merged.
> >
> > You are more trusting of modern hardware than I am, but for all I know,
> > maybe rightfully so.  ;-)
> 
> Well, I rather put a bet on the hardware, which has become reasonable
> over the last decade, than on trying to solve a circular dependency
> problem with tons of heuristics which won't ever work correctly.

Use of HPET to check the interval length would not be circular, right?

> TSC_ADJUST is a reasonable safety net and since its invention the amount
> of BIOS wreckage has been massively reduced. Seems the nastigram in
> dmesg when detecting a change in TSC_ADJUST had an effect or maybe
> Microsoft enforces a tinkerfree TSC by now and we get the benefit. :)
> 
> I still wish to have a knob to lock down TSC to read only, but that's
> probably for christmas 2030 or later. :)

Indeed.  How would BIOS writers hide their SMI handlers?  :-/

							Thanx, Paul
