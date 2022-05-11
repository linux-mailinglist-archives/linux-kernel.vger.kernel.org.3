Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B32523E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347529AbiEKUDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347496AbiEKUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:03:41 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392072311F3;
        Wed, 11 May 2022 13:03:34 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:40998)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nosYV-00G91D-6r; Wed, 11 May 2022 14:03:31 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37876 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nosYT-003AbW-14; Wed, 11 May 2022 14:03:30 -0600
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
        <20220510141119.GA23277@redhat.com>
        <87lev9xy3n.fsf@email.froward.int.ebiederm.org>
Date:   Wed, 11 May 2022 15:00:12 -0500
In-Reply-To: <87lev9xy3n.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 10 May 2022 09:26:36 -0500")
Message-ID: <87zgjnsuur.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nosYT-003AbW-14;;;mid=<87zgjnsuur.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18ah17+fWlXXydck23OvW2XhGaBfirtO18=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1554 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 15 (0.9%), b_tie_ro: 13 (0.8%), parse: 1.08
        (0.1%), extract_message_metadata: 13 (0.8%), get_uri_detail_list: 1.15
        (0.1%), tests_pri_-1000: 11 (0.7%), tests_pri_-950: 1.42 (0.1%),
        tests_pri_-900: 1.18 (0.1%), tests_pri_-90: 92 (5.9%), check_bayes: 90
        (5.8%), b_tokenize: 6 (0.4%), b_tok_get_all: 9 (0.6%), b_comp_prob:
        2.3 (0.1%), b_tok_touch_all: 67 (4.3%), b_finish: 1.31 (0.1%),
        tests_pri_0: 294 (18.9%), check_dkim_signature: 0.54 (0.0%),
        check_dkim_adsp: 3.6 (0.2%), poll_dns_idle: 1106 (71.2%),
        tests_pri_10: 2.7 (0.2%), tests_pri_500: 1120 (72.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Oleg Nesterov <oleg@redhat.com> writes:
>
>> On 05/05, Eric W. Biederman wrote:
>>>
>>> Eric W. Biederman (11):
>>>       signal: Rename send_signal send_signal_locked
>>>       signal: Replace __group_send_sig_info with send_signal_locked
>>>       ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
>>>       ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
>>>       ptrace: Remove arch_ptrace_attach
>>>       signal: Use lockdep_assert_held instead of assert_spin_locked
>>>       ptrace: Reimplement PTRACE_KILL by always sending SIGKILL
>>>       ptrace: Document that wait_task_inactive can't fail
>>>       ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs
>>>       ptrace: Don't change __state
>>>       ptrace: Always take siglock in ptrace_resume
>>>
>>> Peter Zijlstra (1):
>>>       sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
>>
>> OK, lgtm.
>>
>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>>
>>
>> I still dislike you removed TASK_WAKEKILL from TASK_TRACED, but I can't
>> find a good argument against it ;) and yes, this is subjective.
>
> Does anyone else have any comments on this patchset?
>
> If not I am going to apply this to a branch and get it into linux-next.

Thank you all.

I have pushed this to my ptrace_stop-cleanup-for-v5.19 branch
and placed the branch in linux-next.

Eric
