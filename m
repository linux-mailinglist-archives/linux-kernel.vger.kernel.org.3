Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076DE50C471
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiDVWYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiDVWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:22:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239F133B1EB;
        Fri, 22 Apr 2022 14:13:53 -0700 (PDT)
Date:   Fri, 22 Apr 2022 23:13:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650662031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96/sG4U1PMahw+5F2cvDWRLKP9CkFv2MeGAwdZV08Lo=;
        b=ANh7OX8dy7UDbQE5tUInn+33OnlAEFzf2qzE0jCgaNtnwimp1tja/4cy43aHj8733bssAs
        1t6UCwG3hHS2yBSn1x+B8KFA8LuthbsSKj0mwq6uv4UhCpkqwGD3ezC+guhJRCc1BOoiu4
        4kq6u33r744ppk4w7zTzheEfqaKOVUb/oxmgd60GSOAboABQXmNq4vZ6gKN3eff8c4azGe
        USicNG7lxkrk6Hq8QPzCjhc8FkUpWc0oGSjNdA6tagIApvuB2tm2glYrNq3lIqJhDucLFF
        mZt1ywOy5kbVVWHpK04iBZwMd0vSKVy2OIew1szGwt+g3nOT3VL/edqBe0+kRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650662031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96/sG4U1PMahw+5F2cvDWRLKP9CkFv2MeGAwdZV08Lo=;
        b=2fqKG24m2+QfMM/URFklauogxCi4xCU6UwTmlOdXwzuDKiG6RVeO8XwDQuGfIwGvRkPwH5
        XfxCrWoRXUEZGNCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] ptrace-vs-PREEMPT_RT and freezer rewrite
Message-ID: <zzzZz7zJzopLquA6@linutronix.de>
References: <20220421150248.667412396@infradead.org>
 <YmLpNhXD8+EzF9/D@linutronix.de>
 <878rrxnd48.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878rrxnd48.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-22 14:15:35 [-0500], Eric W. Biederman wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> > On 2022-04-21 17:02:48 [+0200], Peter Zijlstra wrote:
> >> Find here a new posting of the ptrace and freezer patches :-)
> >> 
> >> The majority of the changes are in patch 2, which with much feedback from Oleg
> >> and Eric has changed lots.
> >> 
> >> I'm hoping we're converging on something agreeable.
> >
> > I tested this under RT (had to remove the preempt-disable section in
> > ptrace_stop()) with ssdd [0]. It forks a few tasks and then
> > PTRACE_SINGLESTEPs them for a few iterations.
> 
> Out of curiosity why did you need to remove the preempt_disable section
> on PREEMPT_RT?  It should have lasted for just a moment until schedule
> was called.

within that section spinlock_t locks are acquired. These locks are
sleeping locks on PREEMPT_RT and must not be acquired within a
preempt-disable section. (A spinlock_t lock does not disable preemption
on PREEMPT_RT.)

> Eric

Sebastian
