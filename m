Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B5E51DAAD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442274AbiEFOmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442261AbiEFOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:42:20 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467E6A42A;
        Fri,  6 May 2022 07:38:37 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59348)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmz6G-001ZSP-LU; Fri, 06 May 2022 08:38:32 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37214 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmz6E-007LHT-AD; Fri, 06 May 2022 08:38:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <20220506141403.GA16084@redhat.com>
Date:   Fri, 06 May 2022 09:38:21 -0500
In-Reply-To: <20220506141403.GA16084@redhat.com> (Oleg Nesterov's message of
        "Fri, 6 May 2022 16:14:30 +0200")
Message-ID: <87fslm3ew2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmz6E-007LHT-AD;;;mid=<87fslm3ew2.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+j4tyNBNO0MDOlgRiPNBZzf/o1+r5DdvI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1750 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (0.6%), b_tie_ro: 9 (0.5%), parse: 1.00 (0.1%),
         extract_message_metadata: 3.5 (0.2%), get_uri_detail_list: 1.39
        (0.1%), tests_pri_-1000: 4.3 (0.2%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 1.05 (0.1%), tests_pri_-90: 276 (15.8%), check_bayes:
        274 (15.7%), b_tokenize: 11 (0.6%), b_tok_get_all: 10 (0.6%),
        b_comp_prob: 4.1 (0.2%), b_tok_touch_all: 245 (14.0%), b_finish: 0.98
        (0.1%), tests_pri_0: 1430 (81.7%), check_dkim_signature: 0.79 (0.0%),
        check_dkim_adsp: 3.3 (0.2%), poll_dns_idle: 0.92 (0.1%), tests_pri_10:
        3.1 (0.2%), tests_pri_500: 9 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/05, Eric W. Biederman wrote:
>>
>> Eric W. Biederman (11): signal: Rename send_signal send_signal_locked
>> signal: Replace __group_send_sig_info with send_signal_locked
>> ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP ptrace/xtensa:
>> Replace PT_SINGLESTEP with TIF_SINGLESTEP ptrace: Remove
>> arch_ptrace_attach signal: Use lockdep_assert_held instead of
>> assert_spin_locked ptrace: Reimplement PTRACE_KILL by always sending
>> SIGKILL ptrace: Document that wait_task_inactive can't fail ptrace:
>> Admit ptrace_stop can generate spuriuos SIGTRAPs ptrace: Don't change
>> __state ptrace: Always take siglock in ptrace_resume
>>
>> Peter Zijlstra (1):
>>       sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
>
> I can't comment 5/12. to be honest I didn't even try to look into
> arch/ia64/.

I just looked at arch_ptrace_attach again and I spotted what looks like
a fairly easy analysis that is mostly arch-generic code that shows this
is dead code on ia64.

On ia64 arch_ptrace_attach is ptrace_attach_sync_user_rbs, and does
nothing if __state is not TASK_STOPPED.

When arch_ptrace_attach is called after ptrace_traceme __state is
TASK_RUNNING pretty much by definition as we are running in the
child.  Therefore ptrace_attach_sync_user_rbs does nothing in that case.

When arch_ptrace_attach is called after ptrace_attach __state there
are two possibilities.  If the tracee was already in TASK_STOPPED
before the ptrace_attach, the tracee will be in TASK_TRACED.
Otherwise the tracee will be in TASK_TRACED or on it's way to stopping
in TASK_TRACED.

Unless I totally misread ptrace_attach.  There is no way that after
a successful ptrace_attach for the tracee to be in TASK_STOPPED.
This makes ptrace_attach_sync_user_rbs a big noop, AKA dead code.
So it can be removed.

> But other than that I see no problems in this version. However, I'd
> like to actually apply the whole series and read the changed code
> carefully, but sorry, I don't think I can do this before Monday.

No rush.  I don't expect the merge window will open for a while yet.

Eric
