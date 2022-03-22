Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80C84E4917
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiCVWVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiCVWVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:21:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEDCDF2B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:20:04 -0700 (PDT)
Received: from zn.tnic (p200300ea971561dc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61dc:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 540D51EC0528;
        Tue, 22 Mar 2022 23:19:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647987597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+wLjXHgWZkMwbEKVBxHxrfvtzB2gVmwUl628XukYUD0=;
        b=NBIuBzJXz0docrwg/JsRQuvD5mehP+VRjDQ3JFfC7MkCaGbNiPQytJrOBtMDJaPmzxeb09
        AidKrgTofsGhYuda8lNll8cclIl132FIoLQNGywKtsgB5DpmhpWFUc7sO92EZNtDtXYo8Y
        Alug83kl2S3AtYfWWSkF7Fx4FZBJPsM=
Date:   Tue, 22 Mar 2022 23:19:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [GIT PULL] locking changes for v5.18
Message-ID: <YjpLiKRUIB4TGJm0@zn.tnic>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Sebastian.

On Tue, Mar 22, 2022 at 03:05:39PM -0700, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 4:11 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Sebastian Andrzej Siewior (2):
> >       locking/local_lock: Make the empty local_lock_*() function a macro.
> 
> Grr. I noticed this too late, but this one actually breaks the build with clang.
> 
> Why?
> 
> Because it's now a macro, it doesn't use the argument at all, and you get:
> 
>     mm/page_alloc.c:131:40: error: variable 'pagesets' is not needed
> and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>     static DEFINE_PER_CPU(struct pagesets, pagesets) = {
>                                            ^
> 
> and I'm not sure why this doesn't show up with gcc, but apparently gcc
> only warns about unused static functions, not unused static data.
> 
> Or maybe gcc considers it used just because somebody did a typeof on it.
> 
> I thought -tip had started checking with clang, but apparently not.

As a matter of fact, I do see this in my builds:

mm/page_alloc.c:131:40: warning: variable 'pagesets' is not needed and will not be emitted [-Wunneeded-internal-declaration]
static DEFINE_PER_CPU(struct pagesets, pagesets) = {
                                       ^
1 warning generated.

but I dismissed it as one of those not-in-tip-area warnings. Sorry about
that, I'll try to pay more attention in the future.

> I see that the -mm tree has a fix for this, but I'm rather unhappy
> that the -tip tree build checking has deteriorated so much, and clang
> builds will now have a pointless build error that will cause issues
> for bisect.

Ah, you say build error because you have CONFIG_WERROR=y.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
