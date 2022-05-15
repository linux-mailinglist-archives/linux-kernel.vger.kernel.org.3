Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5652767A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiEOJCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiEOJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:02:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD944F2B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:02:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652605335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2mDUSPGcPZzaMW7gML3LPCubye4TyOLT8f3zTeFZihs=;
        b=a22bC37E63DPGgcF/cz1PLTXMxwvqwE5Kp+PQ0VF0jHQ0m9peE6Ue6mUsIqGSFnIv2qQwL
        nTN8sn/6BFGBP6WlL2ErTQYt+ZwrJYk7ccXnKdwRmmHOnG5bBJSCJYlFUqDZdDYV1oDVgS
        qkHyXRyBc1958ETMJ7qJdemW9yvK38LhcpYIv0KJXe2JyYNGZFF41b3cexDMBrvcnvCZrT
        +RhA7KFtNXGvpTrg9UnA715yqzW8lL+ak/moaxwSnJxvt4s+BUpIVOdbKPU0pr4CJubhas
        HywYq5cSza59BEFAsRU7a5Z0Uq63NhqIHROLx6zgBBGYQ+v51Yw8DVF2wY8ULA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652605335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2mDUSPGcPZzaMW7gML3LPCubye4TyOLT8f3zTeFZihs=;
        b=l0ei/dXdudkTpXgkRl5uoJzI+bBhcdRFKRkbbHQSjBtbrfr0fS5DeQhr6NQUU/DiIWjZu3
        JDO8C2GHyWd5TpAQ==
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
In-Reply-To: <9e59305039f2c8077ee087313d1df5ff06028cfe.camel@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
 <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
 <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
 <20220513230958.dbxp6m3y3lnq74qb@black.fi.intel.com>
 <543eb3ff98f624c6cfa1d450ac3e9ae8934c7c38.camel@intel.com>
 <87k0aose62.ffs@tglx>
 <9e59305039f2c8077ee087313d1df5ff06028cfe.camel@intel.com>
Date:   Sun, 15 May 2022 11:02:15 +0200
Message-ID: <87zgjjqico.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14 2022 at 23:06, Edgecombe, Rick P wrote:
> On Sat, 2022-05-14 at 10:37 +0200, Thomas Gleixner wrote:
>> > "On success, arch_prctl() returns positive values; on error, -1 is
>> > returned, and errno is set to indicate the error."
>> 
>> Why?
>> 
>>         prctl(GET, &out)
>> 
>> is the pattern used all over the place.
>
> It seems better to me, but we also need to pass something in.
>
> The idea of the "enable" operation is that userspace would pass in all
> the features that it wants in one call, and then find out back what was
> successfully enabled. So unlike the other arch_prctl()s, it wants to
> pass something in AND get a result in one arch_prctl() call. It doesn't
> need to check what is supported ahead of time. Since these enabling
> operations can fail (OOM, etc), userspace has to handle unexpected per-
> feature failure anyway. So it just blindly asks for what it wants.

I'm not convinced at all, that this wholesale enabling of independent
features makes any sense. That would require:

  - that all features are strict binary of/off which is alredy not the
    case with LAM due to the different mask sizes.

  - that user space knows at some potentially early point of process
    startup which features it needs. Some of them might be requested
    later when libraries are loaded, but that would be too late for
    others.

Aside of that, if you lump all these things together, what's the
semantics of this feature lump in case of failure:

  Try to enable the rest when one fails, skip the rest, roll back?

Also such a feature lump results in a demultiplexing prctl() which is
code wise always inferior to dedicated controls.

> Any objections to having it write back the result in the same
> structure?

Why not.

> Otherwise, the option that used to be used here was a "status"
> arch_prctl(), which was called separately to find out what actually got
> enabled after an "enable" call. That fit with the GET/SET semantics
> already in place.
>
> I guess we could also get rid of the batch enabling idea, and just have
> one "enable" call per feature too. But then it is syscall heavy.

This is not a runtime hotpath problem. Those prctls() happen once when
the process starts, so having three which are designed for the
individual purpose instead of one ill defined is definitely the better
choice.

Premature optimization is never a good idea. Keep it simple is the right
starting point.

If it really turns out to be something which matters, then you can
provide a batch interface later on if it makes sense to do so, but see
above.

Thanks,

        tglx
