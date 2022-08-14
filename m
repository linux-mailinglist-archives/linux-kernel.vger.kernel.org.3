Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF05925D5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiHNRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHNRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:43:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148EFDE88
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 10:43:07 -0700 (PDT)
Received: from zn.tnic (p2e55d27b.dip0.t-ipconnect.de [46.85.210.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 864531EC0666;
        Sun, 14 Aug 2022 19:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660498982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zTKEtPgPScqoSwv+oy+vf/aynW9Ycy4y6/0TBuFm6Ac=;
        b=AmqpCZR4tU2UAYxjdAjJkN7eUCazkDpQtTcGAlWeDVZqxkfIcaZyjUrqMlbSIpLEgbV3mQ
        lLNBpcsI4srVh+vRcOe8IS7gRFoggvmvoFHJBREsSjME4k1skr/159zf74SAj05WDhBubR
        31IWV29iH8zYdQqG7+cBG7Xw7ZFvlzg=
Date:   Sun, 14 Aug 2022 19:42:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [GIT PULL] timer fixes
Message-ID: <Yvk0IAtAUkkUNedZ@zn.tnic>
References: <Yvd8L0qIbLarxrOQ@gmail.com>
 <YvfQUGLGY7cfZ9gf@zn.tnic>
 <CAHk-=wi+K-LQ121sPbsQonja3Sx-_kXZc6ntauUC2=JPsUrC+g@mail.gmail.com>
 <YvjtkidVZg2sBY0R@zn.tnic>
 <20220814172445.GR2125313@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220814172445.GR2125313@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 10:24:45AM -0700, Paul E. McKenney wrote:
> If it is causing more trouble than it is worth, then I have not objection
> to taking a different approach.

Well, pretty much every file I tried in the output of

git grep -e '->sighand'

triggers that sparse warning. For example:

$ make C=1 kernel/signal.o

...

kernel/signal.c:195:31: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:195:31:    expected struct spinlock [usertype] *lock
kernel/signal.c:195:31:    got struct spinlock [noderef] __rcu *
kernel/signal.c:198:33: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:198:33:    expected struct spinlock [usertype] *lock
kernel/signal.c:198:33:    got struct spinlock [noderef] __rcu *
kernel/signal.c:480:9: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:480:9:    expected struct spinlock [usertype] *lock
kernel/signal.c:480:9:    got struct spinlock [noderef] __rcu *
kernel/signal.c:484:34: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:484:34:    expected struct spinlock [usertype] *lock
kernel/signal.c:484:34:    got struct spinlock [noderef] __rcu *
kernel/signal.c:517:9: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:517:9:    expected struct spinlock [usertype] *lock
kernel/signal.c:517:9:    got struct spinlock [noderef] __rcu *
kernel/signal.c:520:36: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:520:36:    expected struct spinlock [usertype] *lock
kernel/signal.c:520:36:    got struct spinlock [noderef] __rcu *
kernel/signal.c:542:53: warning: incorrect type in initializer (different address spaces)
kernel/signal.c:542:53:    expected struct k_sigaction *ka
kernel/signal.c:542:53:    got struct k_sigaction [noderef] __rcu *
./include/uapi/asm-generic/signal-defs.h:83:29: error: multiple address spaces given
kernel/signal.c:698:33: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:698:33:    expected struct spinlock [usertype] *lock
kernel/signal.c:698:33:    got struct spinlock [noderef] __rcu *
kernel/signal.c:700:31: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:700:31:    expected struct spinlock [usertype] *lock
kernel/signal.c:700:31:    got struct spinlock [noderef] __rcu *
kernel/signal.c:1328:9: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:1328:9:    expected struct spinlock [usertype] *lock
kernel/signal.c:1328:9:    got struct spinlock [noderef] __rcu *
kernel/signal.c:1329:16: warning: incorrect type in assignment (different address spaces)
kernel/signal.c:1329:16:    expected struct k_sigaction *action
kernel/signal.c:1329:16:    got struct k_sigaction [noderef] __rcu *
kernel/signal.c:1349:34: warning: incorrect type in argument 1 (different address spaces)
kernel/signal.c:1349:34:    expected struct spinlock [usertype] *lock
kernel/signal.c:1349:34:    got struct spinlock [noderef] __rcu *
kernel/signal.c:1938:36: warning: incorrect type in initializer (different address spaces)
kernel/signal.c:1938:36:    expected struct spinlock [usertype] *lock
kernel/signal.c:1938:36:    got struct spinlock [noderef] __rcu *
kernel/signal.c:2048:44: warning: cast removes address space '__rcu' of expression
kernel/signal.c:2067:65: warning: too many warnings

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
