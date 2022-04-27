Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE63D51115C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbiD0Gn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiD0GnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:43:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D02A11A2B;
        Tue, 26 Apr 2022 23:40:12 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:40:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651041610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=paVLZO6SgCr0UrGdptVCdFgDeX99cTy3N3P6FwSbTBw=;
        b=K8VniVrJBXCsLkpIlUyoIsTG5YFfmiBAt8TmItXQuFesgztwqexbeirZYaYOlFVHNbwZ7k
        IFhO3XxZAWQjObCXEWg+5vf3/mhZFWl4kSgyrpPOyX3KF9FsOUVfePppMHwVfGU6PtU3M2
        42KW0lHZpNnfub4qV5IZ7feKlaenTqTdYm7PBqqA18xb+hlVvxAP44j93c19RS3UTGDia8
        S1EnQJkIGrVtz5TttK80imHjWt7SqRXg564kXoWf8KXoVE4B/e/IBNUkp4JYlZwZ3rFXjA
        o+CIGiakM92KDYXNDoafiMbQiXYQGfqljPAq/yhI5jklqn2EN5KVg9RYGffiZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651041610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=paVLZO6SgCr0UrGdptVCdFgDeX99cTy3N3P6FwSbTBw=;
        b=J9IKWy/WLpTIswdEoFBB+X2iQg6lwnZd/dAkiijii0UAHZFsmezsTIfM5plk5NNQQyxhvV
        AJeN60d+QCAYBCAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 5/9] signal: Protect parent child relationships by childs
 siglock
Message-ID: <YmjlScztfmfWBfGi@linutronix.de>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-5-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-26 17:52:07 [-0500], Eric W. Biederman wrote:
> The functions ptrace_stop and do_signal_stop have to drop siglock
> and grab tasklist_lock because the parent/child relation ship
> is guarded by siglock and not siglock.

 "is guarded by tasklist_lock and not siglock." ?

> Simplify things by guarding the parent/child relationship
> with siglock.  For the most part this just requires a little bit
> of code motion.  In a couple of places more locking was needed.
> 
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Sebastian
