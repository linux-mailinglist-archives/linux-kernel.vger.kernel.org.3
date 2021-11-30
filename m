Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0113B4640CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhK3V7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:59:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhK3V7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:59:07 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638309346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nHfB8Pk3/TQyOVkMURVEb7OOv8O48mc6HJzHoh5OtGU=;
        b=yhtsZLZkeXEs9ipighuqJySAF2RXkBYU8ifLcWM38O71K+PSBpit3qxVc21ZdgP/yfMkZ+
        OmqnVp7eQzae8Z8h9sjX5zaG1rbYmYvfKambG6SKvr6OVaqA0WmPnAu4fSnusDs2LP5oxI
        +D4OOe50fBqM+vyEe9k0bcyQRNYn3FJqeityBlTEsELd/1WlmKuoEhlOJV3jsflmviDYBl
        HHWbXNW4PSx4jQEBeAVygdIshUPsedOMnMo1BP7MKmjI9OnFRuTxJWCVVF8l/Z/A3AqweP
        mW43bCEjsEkjDWF+8wccbHmA6FKCHTE/qbaXMqOiQceKNnoKsHUgET8ZHP3D5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638309346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nHfB8Pk3/TQyOVkMURVEb7OOv8O48mc6HJzHoh5OtGU=;
        b=HU14gC8EMLs7oS6Yg4VzbAt9P92PBVtJ7f28iHwFd6T0BW2eegRPFyFYvrBjoWlv04CzC0
        8iO7sfSzDLDA55CQ==
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
In-Reply-To: <20211130204721.GZ641268@paulmck-ThinkPad-P17-Gen-1>
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <20211130064623.GB96474@shbuild999.sh.intel.com>
 <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
 <20211130150256.GA19477@shbuild999.sh.intel.com>
 <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1> <87r1axbcor.ffs@tglx>
 <20211130204721.GZ641268@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 30 Nov 2021 22:55:45 +0100
Message-ID: <87ilw9b95q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30 2021 at 12:47, Paul E. McKenney wrote:
> On Tue, Nov 30, 2021 at 09:39:32PM +0100, Thomas Gleixner wrote:
>> Seriously. Jiffies is not usable as watchdog simply because lost ticks
>> cannot be compensated and you cannot use TSC to bridge them because you
>> are not trusting TSC. This is simply a circulus vitiosus.
>
> OK, HPET or nothing, then.

Older machines also have pm_timer. But those beasts seem to have lost
that too.

>> We really need to remove the watchdog requirement for modern hardware.
>> Let me stare at those patches and get them merged.
>
> You are more trusting of modern hardware than I am, but for all I know,
> maybe rightfully so.  ;-)

Well, I rather put a bet on the hardware, which has become reasonable
over the last decade, than on trying to solve a circular dependency
problem with tons of heuristics which won't ever work correctly.

TSC_ADJUST is a reasonable safety net and since its invention the amount
of BIOS wreckage has been massively reduced. Seems the nastigram in
dmesg when detecting a change in TSC_ADJUST had an effect or maybe
Microsoft enforces a tinkerfree TSC by now and we get the benefit. :)

I still wish to have a knob to lock down TSC to read only, but that's
probably for christmas 2030 or later. :)

Thanks,

        tglx
