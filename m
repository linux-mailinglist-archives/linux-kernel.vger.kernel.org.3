Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C986050A83F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391477AbiDUSoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391466AbiDUSn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:43:58 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6434BBA8;
        Thu, 21 Apr 2022 11:41:07 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38164)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhbjl-00GJ9M-6f; Thu, 21 Apr 2022 12:41:05 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35232 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhbjk-00DEDL-5X; Thu, 21 Apr 2022 12:41:04 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
Date:   Thu, 21 Apr 2022 13:40:57 -0500
In-Reply-To: <20220421150654.817117821@infradead.org> (Peter Zijlstra's
        message of "Thu, 21 Apr 2022 17:02:50 +0200")
Message-ID: <87czhap9dy.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nhbjk-00DEDL-5X;;;mid=<87czhap9dy.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18PMzTGLHG+SMKtZ4xb/VVhwetJ6uYY8Rc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 452 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (1.9%), parse: 1.18 (0.3%),
         extract_message_metadata: 14 (3.2%), get_uri_detail_list: 1.36 (0.3%),
         tests_pri_-1000: 14 (3.0%), tests_pri_-950: 1.83 (0.4%),
        tests_pri_-900: 1.46 (0.3%), tests_pri_-90: 121 (26.7%), check_bayes:
        117 (25.9%), b_tokenize: 8 (1.8%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.7 (0.6%), b_tok_touch_all: 93 (20.7%), b_finish: 1.03
        (0.2%), tests_pri_0: 268 (59.2%), check_dkim_signature: 1.10 (0.2%),
        check_dkim_adsp: 4.0 (0.9%), poll_dns_idle: 0.15 (0.0%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 14 (3.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> Rework ptrace_check_attach() / ptrace_unfreeze_traced() to not rely on
> task->__state as much.
>
> Due to how PREEMPT_RT is changing the rules vs task->__state with the
> introduction of task->saved_state while TASK_RTLOCK_WAIT (the whole
> blocking spinlock thing), the way ptrace freeze tries to do things no
> longer works.


The problem with ptrace_stop and do_signal_stop that requires dropping
siglock and grabbing tasklist_lock is that do_notify_parent_cldstop
needs tasklist_lock to keep parent and real_parent stable.

With just some very modest code changes it looks like we can use
a processes own siglock to keep parent and real_parent stable.  The
siglock is already acquired in all of those places it is just not held
over the changing parent and real_parent.

Then make a rule that a child's siglock must be grabbed before a parents
siglock and do_notify_parent_cldstop can be always be called under the
childs siglock.

This means ptrace_stop can be significantly simplified, and the
notifications can be moved far enough up that set_special_state
can be called after do_notify_parent_cldstop.  With the result
that there is simply no PREEMPT_RT issue to worry about and
wait_task_inactive can be used as is.

I remember Oleg suggesting a change something like this a long
time ago.


I need to handle the case where the parent and the child share
the same sighand but that is just remembering to handle it in
do_notify_parent_cldstop, as the handling is simply not taking
the lock twice.

I am going to play with that and see if I there are any gotcha's
I missed when looking through the code.

Eric
