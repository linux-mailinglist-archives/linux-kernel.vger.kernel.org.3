Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA84EEC80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbiDALq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiDALq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:46:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B6AE33B0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:45:06 -0700 (PDT)
Date:   Fri, 1 Apr 2022 13:45:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648813505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7i6/O5ILryekqXQJ6olrqRxKKJfslH08xthB5phvm8=;
        b=ev8Fs6xjSuQd1unPeFkOUH3G/dtkXgSvoxnrRWpsRb9EeYgvlDnpPVQs2UcY4H40TR7vLb
        0VfRbH80ItoIE5PYreUX/vtDdPXjKoG6xM3eI5EjcGpJbPwvttbrSsTP7hONK76+EXDLEP
        NsgA0J3ieABo5tWzGc2qeXnULdF8muI9qUhUyQNCjAYiGy9FjfOUNoCIARFxtF08eqTCGm
        UyO6TkK0iLlCBLbjuiJYw+8tXKG/sHbuE0EAuQHQWG5lYqLy55m1oLTEkWPZEHrx495UVk
        9+IGhQ5EgJdQ5Pwgp0Xpofat6H+8/GIhGyo/r/MSa3KmdfOPT5MbOj9ipJ1Jqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648813505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7i6/O5ILryekqXQJ6olrqRxKKJfslH08xthB5phvm8=;
        b=zD26LMBkhitDATDDbfX0hFJu7yVNadjpRBFsqon7/6vBOiynr8fgGGOyVVTtD3IERsSoxc
        V4kRyQMJevqrg6Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] signal/x86: Delay calling signals in atomic
Message-ID: <Ykblv2aKh3ekqpi4@linutronix.de>
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
 <8735j2xigt.fsf@email.froward.int.ebiederm.org>
 <YkHfokLO1UGCISGc@linutronix.de>
 <87zgl9pw82.fsf@email.froward.int.ebiederm.org>
 <YkLR3rGTayl/6qIm@linutronix.de>
 <87o81nl3b6.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o81nl3b6.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-30 13:10:05 [-0500], Eric W. Biederman wrote:
> But it looks like if we are coming from userspace then we use the same
> stack as any other time we would come from userspace.  AKA a stack
> that allows the kernel to sleep.
> 
> So I don't see what the problem is that is trying to be fixed.

It is not only the stack. In atomic context / disabled interrupts it is
not possible to acquire a spinlock_t (sighand_struct::siglock) which is
done later.

> I know that code has been changed over the years, perhaps this is
> something that was fixed upstream and the real time tree didn't realize
> there was no longer a need to fix anything?
> 
> Or am I missing something subtle when reading the idtentry assembly?

It certainly is true that the code changed over the years. The per-CPU
stack is one problem, the siglock in atomic context is the other one.
Thank you for the input. Let me digest the informations I have here and
get back.

> Eric

Sebastian
