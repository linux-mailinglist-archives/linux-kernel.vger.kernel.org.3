Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0B953F1FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 00:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiFFWLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiFFWLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:11:08 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326D96129D;
        Mon,  6 Jun 2022 15:11:05 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:48510)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyKvz-004XaN-Qz; Mon, 06 Jun 2022 16:10:51 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53402 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyKvy-008VN9-IW; Mon, 06 Jun 2022 16:10:51 -0600
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
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
        <20220518225355.784371-7-ebiederm@xmission.com>
        <20220524132553.GD14347@redhat.com>
        <20220524162808.GF14347@redhat.com> <20220525142845.GA2687@redhat.com>
Date:   Mon, 06 Jun 2022 17:10:02 -0500
In-Reply-To: <20220525142845.GA2687@redhat.com> (Oleg Nesterov's message of
        "Wed, 25 May 2022 16:28:46 +0200")
Message-ID: <87a6ap30lh.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nyKvy-008VN9-IW;;;mid=<87a6ap30lh.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+3n228nDtWW1iPO1xW1EOl4V38qn2RLFc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 680 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.5%), b_tie_ro: 9 (1.3%), parse: 0.95 (0.1%),
         extract_message_metadata: 3.3 (0.5%), get_uri_detail_list: 1.48
        (0.2%), tests_pri_-1000: 5 (0.8%), tests_pri_-950: 1.20 (0.2%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 345 (50.8%), check_bayes:
        344 (50.6%), b_tokenize: 10 (1.5%), b_tok_get_all: 11 (1.5%),
        b_comp_prob: 2.8 (0.4%), b_tok_touch_all: 316 (46.5%), b_finish: 0.90
        (0.1%), tests_pri_0: 296 (43.5%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 0.99 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 07/16] signal: Wake up the designated parent
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/24, Oleg Nesterov wrote:
>>
>> On 05/24, Oleg Nesterov wrote:
>> >
>> > I fail to understand this patch...
>> >
>> > On 05/18, Eric W. Biederman wrote:
>> > >
>> > > Today if a process is ptraced only the ptracer will ever be woken up in
>> > > wait
>> >
>> > and why is this wrong?
>> >
>> > > Fixes: 75b95953a569 ("job control: Add @for_ptrace to do_notify_parent_cldstop()")
>> >
>> > how does this change fix 75b95953a569?
>>
>> OK, I guess you mean the 2nd do_notify_parent_cldstop() in ptrace_stop(),
>> the problematic case is current->ptrace == T. Right?
>>
>> I dislike this patch anyway, but let me think more about it.
>
> OK, now that I understand the problem, the patch doesn't look bad to me,
> although I'd ask to make the changelog more clear.

I will see what I can do.

> After this change __wake_up_parent() can't accept any "parent" from
> p->parent thread group, but all callers look fine except
> ptrace_detach().

Having looked at it a little more I think the change was too
restrictive.  For the !ptrace_reparented case there are possibly
two threads of the parent process that wait_consider_task will
allow to wait even with __WNOTHREAD specified.  It is desirable
to wake them both up.

Which if I have had enough sleep reduces this patch to just:

diff --git a/kernel/exit.c b/kernel/exit.c
index f072959fcab7..c8156366b722 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1431,8 +1431,10 @@ static int child_wait_callback(wait_queue_entry_t *wait, unsigned mode,
        if (!eligible_pid(wo, p))
                return 0;
 
-       if ((wo->wo_flags & __WNOTHREAD) && wait->private != p->parent)
-               return 0;
+       if ((wo->wo_flags & __WNOTHREAD) &&
+           (wait->private != p->parent) &&
+           (wait->private != p->real_parent))
+                       return 0;
 
        return default_wake_function(wait, mode, sync, key);
 }


I think that solves the issue without missing wake-ups without adding
any more.

For the same set of reasons it looks like the __wake_up_parent in
__ptrace_detach is just simply dead code.  I don't think there is a case
where when !ptrace_reparented the thread that is the real_parent can
sleep in do_wait when the thread that was calling ptrace could not.

That needs a very close look to confirm. 

Eric

