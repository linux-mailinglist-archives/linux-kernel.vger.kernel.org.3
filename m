Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE4489FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbiAJTBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbiAJTBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:01:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0AC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:01:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641841270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qb2LYR0mvCXQteUYlTd24mwtEO8GRj2FXYrjHJf3/S8=;
        b=UygH+TboO+7X+UCg7mnm+o8eLbiErmkBTg7Hi8JIhlyL29QGLbREvrYva71oCQovdLGVlP
        +zV1X44uHiRuxb71KQUOzDFDN6sKGour2zDTf8wj4R3KY7n8m3B6cCWMIefbY/HQJG09UZ
        BpcOqWzNjk9Wgn7A1vLF7hMma63CB+kQZH0yrtILNsJWHmETBR9Ow41IrqOzfM0biXY50y
        GExRFz6Wmm3nee1LDkAklAXiUlo1B8YeQCmmoMLX5Yr3WdMkdndwIdXvP9QZlIq6tFsE6e
        SsoUv4cAEWwFY+LTEfxaE7tvO6k9e5sJ+n6i0vLTjIDESWs6i4mcKqbwO5FkeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641841270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qb2LYR0mvCXQteUYlTd24mwtEO8GRj2FXYrjHJf3/S8=;
        b=ph7L0eTmTnYvCBz1S/5XS55TqCiVg5/C95Q5K7fJ6x81q4MtCH+YsMAzNVmfI1q/JVmWw/
        iAq1ik3IgdkRAOBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] core/urgent for v5.16-rc6
In-Reply-To: <CAHk-=wgC3Q4+3Dc4FhQ6WopwZxoMMVxaA2TSJm-CH1CQ4hQWfw@mail.gmail.com>
References: <Yb82O5i2DVcK9nAJ@zn.tnic>
 <CAHk-=wiNMghi=nZc432_Sj4QwG+BtxGUtovnpVQk-LpDj8r3ZA@mail.gmail.com>
 <15b1a9af-f8ff-c3e2-ba3e-cdbd29ae38db@intel.com>
 <CAHk-=wgMEnZqKcUEH9ADg38ifSJa_Mui7FF=-L1-8=_MQfNFAw@mail.gmail.com>
 <CAHk-=wgC3Q4+3Dc4FhQ6WopwZxoMMVxaA2TSJm-CH1CQ4hQWfw@mail.gmail.com>
Date:   Mon, 10 Jan 2022 20:01:09 +0100
Message-ID: <87ilurqutm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20 2021 at 08:25, Linus Torvalds wrote:
> On Mon, Dec 20, 2021 at 8:20 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Whatever. I don't care that much, but this all smells like you just
>> dug your own hole for very questionable causes, and instead of a
>> "don't do that then" this all is doubling down on a bad idea.
>
> It further looks like it's really only the sas_ss_size that is
> checked, so if people wan tto have a lock, make it clear that's the
> only thing that the lock is about.
>
> So the actual "do I even need to lock" condition should likely just be
>
>         if (ss_size < t->sas_ss_size)
>                 .. don't bother locking ..
>
> but as mentioned, I don't really see much of a point in being so
> careful even about the growing case.
>
> If somebody is changing xstate features concurrently with another
> thread setting up their altstack, they can keep both pieces.

In principle I agree, but the whole signal stack business is a nightmare
and the way how a program ends up using some xfeature is hideous at
best.

An application does not necessarily know about it at all because the
usage is hidden in random library code. So there is a chance to run into
concurrency issues for real.

Let me grab your (Dave's) patch and rework the whole thing into
something sensible. I had a patch around which replaced sighand lock
with an explicit lock for that purpose. Let me dig that out and polish
it all up.

Thanks,

        tglx


