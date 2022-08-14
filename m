Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A729591FC7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 14:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiHNMmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 08:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHNMmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 08:42:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7D5201AB
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 05:42:05 -0700 (PDT)
Received: from zn.tnic (p2e55d27b.dip0.t-ipconnect.de [46.85.210.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BFF001EC02F2;
        Sun, 14 Aug 2022 14:41:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660480919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6W9pL26aeXOLT5Po4wAcLyb9mKmJZJw56r9wwihEm44=;
        b=oVsK+GH5n3NWSsuZLFe3QeAUJaWLokJT7sKteb0MSYYSOFXSkAw4T70uWwcA7yUs2thTwK
        pLdUblPv1A2J3ON6bFtaPBbTf4K6hwAozcTxGqNazzWpuPA+vIF7KqS+WIhmHW+W0OkLCj
        YNaG7pbOPVsgsK7qkjve5JLkkUbktMg=
Date:   Sun, 14 Aug 2022 14:41:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [GIT PULL] timer fixes
Message-ID: <YvjtkidVZg2sBY0R@zn.tnic>
References: <Yvd8L0qIbLarxrOQ@gmail.com>
 <YvfQUGLGY7cfZ9gf@zn.tnic>
 <CAHk-=wi+K-LQ121sPbsQonja3Sx-_kXZc6ntauUC2=JPsUrC+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+K-LQ121sPbsQonja3Sx-_kXZc6ntauUC2=JPsUrC+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 01:27:40PM -0700, Linus Torvalds wrote:
> On Sat, Aug 13, 2022 at 9:25 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > That task_struct.sighand is marked __rcu and thus noderef and sparse
> > complains:
> 
> I think that RCU marking is misleading.
> 
> Doing a
> 
>         git grep -e '->sighand'
> 
> shows that we basically never treat that as some kind of RCU pointer.
> 
> Adding a
> 
>         grep -i rcu
> 
> to the above shows that we have a couple of places that do this
> carefully, but they are the exception rather than the rule.
> 
> I think the issue is that "current->sighand" is always safe (and that
> "me->sighand" is the same thing), and that sighand has RCU-delayed
> freeing so that __lock_task_sighand() can safely try to take the lock
> of another process' sighand.
> 
> And we have no real way to explain to sparse that *some* cases are
> fine, others are not and need the sighand lock (after that careful
> __lock_task_sighand thing).

Sounds to me like that sparse check was not such a good idea in the
first place. Especially since the 0day bot is probably warning about all
those cases where we try to lock ->sighand.

It was added by

913292c97d75 ("sched.h: Annotate sighand_struct with __rcu")

Lemme add the involved parties to Cc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
