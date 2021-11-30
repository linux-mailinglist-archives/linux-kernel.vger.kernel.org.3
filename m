Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4316D463F77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbhK3Uuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbhK3Uuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:50:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E70C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:47:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46524CE1B35
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FFBC53FCC;
        Tue, 30 Nov 2021 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638305242;
        bh=v/1mm6MmMQFQsrmHMtEPYpqXXQrLsL4ZKK7w2E4f6TM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fjK+gwDqwnBoxroD0CIBUdeZ0Xx3FDyQpk80878fC17EJfxqqoMUzkmrAEeL57Ucr
         pHmiGDGYgp5klBX2jpUeCXRVuQqvU3VvzNCxbng9jUni/zDM4PumC594oITnyL9JAX
         c9DFj7WvRxRn/pHjQ7zkph23xvc3xTRi4fv83Zh40JCFri/+bYhDsE/Q8f2axjJyHt
         +7OpC4SSLaybISw4PLOc5F0LD9nIgbhkNxvHfvFAig/UC44sxEFEZ3Ujnk2PWW8Ujj
         ZMrRgg/hZw4epkYBeWfRTnM8jClVMfBL1hCM1yOKF/78mNW7dp9TYDl40J75ZhZ21Q
         y72iU5fX9UM5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 001E55C0367; Tue, 30 Nov 2021 12:47:21 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:47:21 -0800
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
Message-ID: <20211130204721.GZ641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <20211130064623.GB96474@shbuild999.sh.intel.com>
 <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
 <20211130150256.GA19477@shbuild999.sh.intel.com>
 <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <87r1axbcor.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1axbcor.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:39:32PM +0100, Thomas Gleixner wrote:
> 
> Can you folks please trim your replies? Finding content in the middle of
> quoted nonsense becomes harder with every mail in this thread.
> 
> On Tue, Nov 30 2021 at 08:28, Paul E. McKenney wrote:
> > On Tue, Nov 30, 2021 at 11:02:56PM +0800, Feng Tang wrote:
> >> For this case, I don't have access to the HW and only have the
> >> dmesg log, from which it seems the watchdog timer has been postponed
> >> a very long time from running.
> >
> > Thank you for the analysis!
> >
> > One approach to handle this situation would be to avoid checking for
> > clock skew if the time since the last watchdog read was more than (say)
> > twice the desired watchdog spacing.  This does leave open the question of
> > exactly which clocksource to use to measure the time between successive
> > clocksource reads.  My thought is to check this only once upon entry to
> > the handler and to use the designated-good clocksource.
> >
> > Does that make sense, or would something else work better?
> 
> Seriously. Jiffies is not usable as watchdog simply because lost ticks
> cannot be compensated and you cannot use TSC to bridge them because you
> are not trusting TSC. This is simply a circulus vitiosus.

OK, HPET or nothing, then.

> We really need to remove the watchdog requirement for modern hardware.
> Let me stare at those patches and get them merged.

You are more trusting of modern hardware than I am, but for all I know,
maybe rightfully so.  ;-)

							Thanx, Paul
