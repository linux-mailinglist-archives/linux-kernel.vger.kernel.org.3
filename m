Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97751316E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbiD1Kpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiD1Kpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:45:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBE58567B;
        Thu, 28 Apr 2022 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Obg7F2xg/HaVtg7kDbWxiOjI5aSvCmKfzGg6J1yzII=; b=EFM4kIJ6wFaaPwpVUPaRb/7dRu
        9TqKQ2TZK3M4kIV+m+bpQm7t+HA3h3C8LF1+ipOYxmbkEoBeaQGZDfecqr0kzO2jCd0+ls6PRyUrF
        uSiN4dxQeTYOS2JEdN1Y23im0wDkcOf21YPOvRjHLf8Qgxl1WQEKY2POFK79narfg+v3YKRrsUOAZ
        5tzb8hxc6G0F/4ugvMw3o/avE/RqQKuxWtpC9BFQAevt/cm8NHs70r4eqU1mU2rnLNei17c4n5IWR
        dOEaXIF7JcZw7qlInt661gVcJxWyvJ85l91scjKVP6IjMXwBB1cost3uXyBkpRJ8SzX/6/XBxsVb1
        /EPxUamw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk1b7-00BQWS-3l; Thu, 28 Apr 2022 10:42:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 875883001EA;
        Thu, 28 Apr 2022 12:42:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F66A2029F872; Thu, 28 Apr 2022 12:42:07 +0200 (CEST)
Date:   Thu, 28 Apr 2022 12:42:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in
 ptrace_check_attach
Message-ID: <Ympvf1Pam1ckX+EA@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-7-ebiederm@xmission.com>
 <20220427151455.GE17421@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427151455.GE17421@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 05:14:57PM +0200, Oleg Nesterov wrote:
> On 04/26, Eric W. Biederman wrote:
> >
> > Asking wait_task_inactive to verify that tsk->__state == __TASK_TRACED
> > was needed to detect the when ptrace_stop would decide not to stop
> > after calling "set_special_state(TASK_TRACED)".  With the recent
> > cleanups ptrace_stop will always stop after calling set_special_state.
> >
> > Take advatnage of this by no longer asking wait_task_inactive to
> > verify the state.  If a bug is hit and wait_task_inactive does not
> > succeed warn and return -ESRCH.
> 
> ACK, but I think that the changelog is wrong.
> 
> We could do this right after may_ptrace_stop() has gone. This doesn't
> depend on the previous changes in this series.

It very much does rely on there not being any blocking between
set_special_state() and schedule() tho. So all those PREEMPT_RT
spinlock->rt_mutex things need to be gone.

That is also the reason I couldn't do wait_task_inactive(task, 0) in the
other patch, I had to really match 'TASK_TRACED or TASK_FROZEN' any
other state must fail (specifically TASK_RTLOCK_WAIT must not match).
