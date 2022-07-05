Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B45672ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiGEPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiGEPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:44:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F0F2ADB;
        Tue,  5 Jul 2022 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YXOVzFNFx/d0xO77KJVr1MjwZXUfSymtjaW6FSuQCgs=; b=LXfa0kxtypFYqAtz+ojoxkj2bC
        +f7Cu/r/v7GhDmDWwCzjMIPo4ImZKRT61WTDT3D78htU9DjT6vOW/UeiBzTgUpZghUQRRXc6eXVGP
        N8lpG1SWaf0COY/QIHkE7bxsFQ5unFRtVVnpQWOMP1mhDVGKHZx4UxbPGO99o9l8g97A4W40GkWt7
        Xh4viabMZIqjgavSLmk/yKDDvrp5cA8si92fSOAHQWEAaDqqmUrIAQgJXZ6w7L5dU3se0x8NN9bhX
        7WOEYEKQHoJP5BH7MW6Ju5uv11pwPQgySNe7v5iObTO2hcNxO5+0UhFgU07WuP8rxtttT+/gD/FjX
        il3sMmrg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8kie-000hUT-JP; Tue, 05 Jul 2022 15:44:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91A01980059; Tue,  5 Jul 2022 17:44:06 +0200 (CEST)
Date:   Tue, 5 Jul 2022 17:44:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        svens@linux.ibm.com
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <YsRcRgfZFl0K4L9h@worktop.programming.kicks-ass.net>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-12-ebiederm@xmission.com>
 <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <877d5ajesi.fsf@email.froward.int.ebiederm.org>
 <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
 <YrtKReO2vIiX8VVU@tuxmaker.boeblingen.de.ibm.com>
 <87czess94h.fsf@email.froward.int.ebiederm.org>
 <20220628184850.05f60d1e@gandalf.local.home>
 <87pmisqgs0.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmisqgs0.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:39:59PM -0500, Eric W. Biederman wrote:

> > That is, the two paths should already be synchronized, and the memory
> > barriers will not help anything inside the locks. The locking should (and
> > must) handle all that.
> 
> I would presume so to.  However the READ_ONCE that is going astray
> does not look like it is honoring that.
> 
> So perhaps there is a bug in the s390 spin_lock barriers?  Perhaps there
> is a subtle detail in the barriers that spin locks provide that we are
> overlooking?

So the thing is, s390 is, like x86, a TSO architecture with SC atomics.
Or at least it used to be; I'm not entirely solid on the Z196 features.

I've been looking at this and I can't find anything obviously wrong.
arch_spin_trylock_once() has what seems a spurious barrier() but that's
not going to cause this.

Specifically, s390 is using a simple test-and-set spinlock based on
their Compare-and-Swap (CS) instruction (so no Z196 funnies around).

Except perhaps arch_spin_unlock(), I can't grok the magic there. It does
something weird before the presumably regular TSO store of 0 into the
lock word.

Ooohh.. /me finds arch_spin_lock_queued().. *urfh* because obviously a
copy of queued spinlocks is what we need.

rwlock_t OTOH is using __atomic_add_*() and that's all Z196 magic.

Sven, does all this still reproduce if you take out
CONFIG_HAVE_MARCH_Z196_FEATURES ? Also, could you please explain the
Z196 bits or point me to the relevant section in the PoO. Additionally,
what's that _niai[48] stuff?

And I'm assuming s390 has hardware fairness on competing CS ?
