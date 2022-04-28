Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6A513B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350580AbiD1Rs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiD1RsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:48:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B21A040;
        Thu, 28 Apr 2022 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x4bCwPiDyDUtcqSO6dXG3Rqb1J6ca25XD5S5LJUlF2A=; b=glC31awJB3JLoQZWiivVNLiz+T
        bz+k+6MK3LQkG+a0f6TVVnUzq4pETS64xttDxwteh8hY28D4tLcgDR/Y/2p2tNsxHwcWiZ7LIxUtG
        fU8sacrMWOw/NFfMsa5/hJeVHGWMHE9VgjvgQKrXEZqUPUi0uihkKMmBXw+qNCEWIFTKeMnaTMIP8
        fqYcEUJjy2VP6fOZ61ZdLddwHfa2p9SDPkovQOZCwhl5MIdxFUP+nfiUEvxC90uZO5Y8aSozTD/9/
        M+xPKeTR8s7k+41drsZBQC3lwbsa+odCXg1CiF/bjYeEA5rtsUwAnHyOi+aCHCCL4ow2Lxun7/YX2
        ECbRvgrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk8C6-009NoF-S5; Thu, 28 Apr 2022 17:44:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67B7130031D;
        Thu, 28 Apr 2022 19:44:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27DCE20296EE4; Thu, 28 Apr 2022 19:44:42 +0200 (CEST)
Date:   Thu, 28 Apr 2022 19:44:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
 <20220427141018.GA17421@redhat.com>
 <874k2ea9q4.fsf@email.froward.int.ebiederm.org>
 <87zgk67fdd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgk67fdd.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:47:10AM -0500, Eric W. Biederman wrote:

> Hmm.  If we have the following process tree.
> 
>     A
>      \
>       B
>        \
>         C
> 
> Process A, B, and C are all in the same process group.
> Process A and B are setup to receive SIGCHILD when
> their process stops.
> 
> Process C traces process A.
> 
> When a sigstop is delivered to the group we can have:
> 
> Process B takes siglock(B) siglock(A) to notify the real_parent
> Process C takes siglock(C) siglock(B) to notify the real_parent
> Process A takes siglock(A) siglock(C) to notify the tracer
> 
> If they all take their local lock at the same time there is
> a deadlock.
> 
> I don't think the restriction that you can never ptrace anyone
> up the process tree is going to fly.  So it looks like I am back to the
> drawing board for this one.

I've not had time to fully appreciate the nested locking here, but if it
is possible to rework things to always take both locks at the same time,
then it would be possible to impose an arbitrary lock order on things
and break the cycle that way.

That is, simply order the locks by their heap address or something:

static void double_siglock_irq(struct sighand *sh1, struct sighand2 *sh2)
{
	if (sh1 > sh2)
		swap(sh1, sh2)

	spin_lock_irq(&sh1->siglock);
	spin_lock_nested(&sh2->siglock, SINGLE_DEPTH_NESTING);
}

