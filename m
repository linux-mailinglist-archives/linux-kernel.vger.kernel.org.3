Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1646422F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhK3XXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:23:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbhK3XXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:23:06 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638314383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e111LIKZavR5Ap7W3LLc0xJOhBbc72l4NAIKK/riH20=;
        b=jVHCKr18rC446+/i/MI85GqozKPYaxhvv++q18iXjFcoiIGiyTxNc2d/Hro6fKLgqt448Z
        DpAVuBnvhKPtD/Pw4eDOaMke01tcdO2+9FhVCXJnOqi3UsujYK7p7hEIxadb+PcDwU+caB
        bRnSN54VrXvBvdsfKybIlud0CvGvcvjFtojTEqq6fnrlaJgkgLey1Rzngv8zGkPW3ytLMA
        2TLBxWVc+JV2g3MojRXCVULu2hX8M0d9Kt9zRPwfa/u603TlBHOzx12Fj5ElgjURoJigrk
        oU+m2cJyut45T4NxMnb+aHV0Xhw9CbBISeG31mJZs+r/AZ0MlqwjKaNjHovYkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638314383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e111LIKZavR5Ap7W3LLc0xJOhBbc72l4NAIKK/riH20=;
        b=FfZt2XZ5hvvUwpulxXE0kVWcsKe85n1V1o1c/rvq+IBiXRZC7XHczEaqkUH2GpGAdV0Q3n
        QVahvVTaykFs3FAA==
To:     paulmck@kernel.org
Cc:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for
 qualified platforms
In-Reply-To: <20211130224825.GA641268@paulmck-ThinkPad-P17-Gen-1>
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <20211130064623.GB96474@shbuild999.sh.intel.com>
 <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
 <20211130150256.GA19477@shbuild999.sh.intel.com>
 <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1> <87r1axbcor.ffs@tglx>
 <20211130204721.GZ641268@paulmck-ThinkPad-P17-Gen-1> <87ilw9b95q.ffs@tglx>
 <20211130224825.GA641268@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 01 Dec 2021 00:19:43 +0100
Message-ID: <87tuft9qpc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30 2021 at 14:48, Paul E. McKenney wrote:
> On Tue, Nov 30, 2021 at 10:55:45PM +0100, Thomas Gleixner wrote:
>> > OK, HPET or nothing, then.
>> 
>> Older machines also have pm_timer. But those beasts seem to have lost
>> that too.
>
> I suppose that one way of avoiding clock-skew messages is to have only
> one clock.

Indeed. It's a complete mystery why it takes ages to implement reliable
clocks in hardware.

>> >> We really need to remove the watchdog requirement for modern hardware.
>> >> Let me stare at those patches and get them merged.
>> >
>> > You are more trusting of modern hardware than I am, but for all I know,
>> > maybe rightfully so.  ;-)
>> 
>> Well, I rather put a bet on the hardware, which has become reasonable
>> over the last decade, than on trying to solve a circular dependency
>> problem with tons of heuristics which won't ever work correctly.
>
> Use of HPET to check the interval length would not be circular, right?

As long as the HPET works reliably :)

>> TSC_ADJUST is a reasonable safety net and since its invention the amount
>> of BIOS wreckage has been massively reduced. Seems the nastigram in
>> dmesg when detecting a change in TSC_ADJUST had an effect or maybe
>> Microsoft enforces a tinkerfree TSC by now and we get the benefit. :)
>> 
>> I still wish to have a knob to lock down TSC to read only, but that's
>> probably for christmas 2030 or later. :)
>
> Indeed.  How would BIOS writers hide their SMI handlers?  :-/

TSC_ADJUST already ruined that party.

Thanks,

        tglx
