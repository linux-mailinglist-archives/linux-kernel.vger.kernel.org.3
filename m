Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62B2463F73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbhK3Umz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:42:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhK3Umy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:42:54 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638304773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocz4UAzX9H90RlZoo4K+BiBNsMSg7McYV50HWVKdeGk=;
        b=gnn7/lKUoHgmkwMm1eRhZb+13Fq7Q80anKQs/bXwuxrtdwnMB/qTUuP2b1ZS3hW2lajOA0
        dsqCV8fPaL8lqR9FGJ/ahU7aG7DG9LkGblKdW91Ep7JVlmgysFXTFF/CWX5SUSirIhkT6A
        pQZpHONhNP6VqQfDtCTpXAl0IgdIZcx032BHOiC0HSCvMY9kDcnRfR3vPMLSaRCuyuobes
        Egu2YCoRNT9nKOAJx8FM2Dqjo98wwhMm/Kpk/nkp3OhzOiOy7zKXaLMSLgbX/DQfHanwY/
        urnQnBIDgsQ+3OqlIHktn60RoIOuwNF6k2BAJWih9h02l8Ufs3F9iIjab0Ikeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638304773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocz4UAzX9H90RlZoo4K+BiBNsMSg7McYV50HWVKdeGk=;
        b=nDeZObd/KH67YCwggT62X1bX7eP0zO2P1EQgV8LiUMg+GQavf6jLFEVlM36guHPnC8K3X4
        x/OEd5vhmNTGqWDA==
To:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for
 qualified platforms
In-Reply-To: <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1>
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <20211130064623.GB96474@shbuild999.sh.intel.com>
 <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
 <20211130150256.GA19477@shbuild999.sh.intel.com>
 <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 30 Nov 2021 21:39:32 +0100
Message-ID: <87r1axbcor.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can you folks please trim your replies? Finding content in the middle of
quoted nonsense becomes harder with every mail in this thread.

On Tue, Nov 30 2021 at 08:28, Paul E. McKenney wrote:
> On Tue, Nov 30, 2021 at 11:02:56PM +0800, Feng Tang wrote:
>> For this case, I don't have access to the HW and only have the
>> dmesg log, from which it seems the watchdog timer has been postponed
>> a very long time from running.
>
> Thank you for the analysis!
>
> One approach to handle this situation would be to avoid checking for
> clock skew if the time since the last watchdog read was more than (say)
> twice the desired watchdog spacing.  This does leave open the question of
> exactly which clocksource to use to measure the time between successive
> clocksource reads.  My thought is to check this only once upon entry to
> the handler and to use the designated-good clocksource.
>
> Does that make sense, or would something else work better?

Seriously. Jiffies is not usable as watchdog simply because lost ticks
cannot be compensated and you cannot use TSC to bridge them because you
are not trusting TSC. This is simply a circulus vitiosus.

We really need to remove the watchdog requirement for modern hardware.
Let me stare at those patches and get them merged.

Thanks,

        tglx

