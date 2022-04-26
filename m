Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE4510530
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiDZRWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiDZRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:22:44 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD7D44753;
        Tue, 26 Apr 2022 10:19:34 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:49348)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njOqb-00AeV8-5Z; Tue, 26 Apr 2022 11:19:33 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35722 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njOqa-002Nau-7s; Tue, 26 Apr 2022 11:19:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
In-Reply-To: <20220426055122.GA29684@redhat.com> (Oleg Nesterov's message of
        "Tue, 26 Apr 2022 07:51:23 +0200")
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <20220425143537.GA12412@redhat.com>
        <20220425183343.GM2731@worktop.programming.kicks-ass.net>
        <87pml4llvm.fsf@email.froward.int.ebiederm.org>
        <20220426055122.GA29684@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 26 Apr 2022 12:19:20 -0500
Message-ID: <878rrrkbjb.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njOqa-002Nau-7s;;;mid=<878rrrkbjb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+mtzpiqhlhzhmU0iIbDnQQBdvVxBQ/W88=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 301 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (3.7%), b_tie_ro: 10 (3.2%), parse: 1.33
        (0.4%), extract_message_metadata: 4.0 (1.3%), get_uri_detail_list:
        1.13 (0.4%), tests_pri_-1000: 5 (1.8%), tests_pri_-950: 1.77 (0.6%),
        tests_pri_-900: 1.48 (0.5%), tests_pri_-90: 86 (28.7%), check_bayes:
        84 (28.0%), b_tokenize: 7 (2.4%), b_tok_get_all: 6 (2.0%),
        b_comp_prob: 2.3 (0.8%), b_tok_touch_all: 65 (21.6%), b_finish: 1.03
        (0.3%), tests_pri_0: 168 (55.9%), check_dkim_signature: 0.51 (0.2%),
        check_dkim_adsp: 2.8 (0.9%), poll_dns_idle: 0.96 (0.3%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 8 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/25, Eric W. Biederman wrote:
>>
>> I don't see JOBCTL_TRACED_QUIESCE being cleared "if (!current->ptrace)".
>
> As Peter explained, in this case we can rely on __ptrace_unlink() which
> should clear this flag.

I had missed that that signal_wake_up_state was clearing
JOBCTL_TRACED_QUIESCE.

Relying on __ptrace_unlink assumes the __ptrace_unlink happens after
siglock is taken before calling ptrace_stop.  Especially with the
ptrace_notify in signal_delivered that does not look guaranteed.

The __ptrace_unlink could also happen during arch_ptrace_stop.

Relying on siglock is sufficient because __ptrace_unlink holds siglock
over clearing task->ptrace.  Which means that the simple fix for this is
to just test task->ptrace before we set JOBCTL_TRACED_QUEIESCE.

Eric

