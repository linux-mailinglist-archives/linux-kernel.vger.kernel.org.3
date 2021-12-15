Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C1476206
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhLOTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:43:02 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:37404 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:43:01 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:51974)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mxaAz-00C2tz-3k; Wed, 15 Dec 2021 12:42:57 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:48176 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mxaAx-00FWKo-Lr; Wed, 15 Dec 2021 12:42:56 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Barret Rhoden <brho@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211213220401.1039578-1-brho@google.com>
        <8735mww2w3.fsf@email.froward.int.ebiederm.org>
        <456a056e-453e-71b0-0f9e-03511b9f56b1@google.com>
Date:   Wed, 15 Dec 2021 13:42:32 -0600
In-Reply-To: <456a056e-453e-71b0-0f9e-03511b9f56b1@google.com> (Barret
        Rhoden's message of "Wed, 15 Dec 2021 14:00:11 -0500")
Message-ID: <87zgp1psd3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mxaAx-00FWKo-Lr;;;mid=<87zgp1psd3.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/H5bM6vXl/B8OAznoBP7d9IHqE6Sa2M8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,XMSubLong,
        XM_B_Investor,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_B_Investor BODY: Commonly used business phishing phrases
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Barret Rhoden <brho@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 789 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.2%), b_tie_ro: 8 (1.1%), parse: 1.50 (0.2%),
         extract_message_metadata: 8 (1.0%), get_uri_detail_list: 5 (0.6%),
        tests_pri_-1000: 6 (0.8%), tests_pri_-950: 1.72 (0.2%),
        tests_pri_-900: 1.48 (0.2%), tests_pri_-90: 245 (31.1%), check_bayes:
        243 (30.8%), b_tokenize: 19 (2.4%), b_tok_get_all: 12 (1.5%),
        b_comp_prob: 6 (0.8%), b_tok_touch_all: 201 (25.5%), b_finish: 0.96
        (0.1%), tests_pri_0: 491 (62.3%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 0.98 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 9 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] rlimits: do not grab tasklist_lock for do_prlimit on current
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> Hi -
>
> On 12/13/21 5:34 PM, Eric W. Biederman wrote:
>> Do you have any numbers?  As the entire point of this change is
>> performance it would be good to see how the performance changes.
>>
>> Especially as a read_lock should not be too bad as it allows sharing,
>> nor do I expect reading or writing the rlimit values to be particularly
>> frequent.  So some insight into what kinds of userspace patterns make
>> this a problem would be nice.
>
> This was motivated by slowdowns we observed on a few machines running
> tests in a cluster.  AFAIK, there were a lot of small tests, many of
> which mucked with process management syscalls while fork/joining other
> tasks.
>
> Based on a cycles profile, it looked like ~87% of the time was spent
> in the kernel, ~42% of which was just trying to get *some* spinlock
> (queued_spin_lock_slowpath, not necessarily the tasklist_lock).
>
> The big offenders (with rough percentages in cycles of the overall trace):
>
> - do_wait 11%
> - setpriority 8% (potential future patch)
> - kill 8%
> - do_exit 5%
> - clone 3%
> - prlimit64 2%   (this patch)
> - getrlimit 1%   (this patch)
>
> Even though do_prlimit was using a read_lock, it was still contending
> on the internal queued_spin_lock.
>
> The prlimit was only 3% of the total.  This patch was more of a "oh,
> this doesn't *need* the tasklist_lock for p == current" - can we fix
> that?  I actually don't even know often those prlimit64 calls had p ==
> current.
>
> setpriority was a bigger one too - is the tasklist lock only needed
> for the PGRP ops?  (I thought so based on where the tasklist_lock is
> write locked and the comment on task_pgrp()).  If so, I could do that
> in another patch.

That is my understanding.  For setpriority to change everything
atomically it must hold the tasklist lock when dealing with more than
one process at a time.

>> This change is a bit scary as it makes taking a lock conditional and
>> increases the probability of causing a locking mistake.
>
> I definitely see how making the code more brittle might not be worth
> the small win.  If this is more "damage" than "cleanup", then I can
> drop it.
>
>> If you are going to make this change I would say that do_prlimit should
>> become static and taking the tasklist_lock should move into prlimit64.
>>
>>
>> Looking a little closer it looks like that update_rlimit_cpu should use
>> lock_task_sighand, and once lock_task_sighand is used there is actually
>> no need for the tasklist_lock at all.  As holding the reference to tsk
>> guarantees that tsk->signal remains valid.
>
> Maybe do both?  unconditionally grab lock_task_sighand (instead of
> tasklist_lock) in prlimit64.

In update_rlimit_cpu use lock_task_sighand instead of unconditionally
grabbing sighand->siglock (because without tasklist_lock sighand might
be NULL).

Then do_prlimit64 can drop the tasklist lock and the test for
sighand == NULL.

This will address every prlimit64 case instead of just when updating
current.  With prlimit64 in your profile I expect some of those are
non-current.


>> So I completely agree there are cleanups that can happen in this area.
>> Please make those and show numbers in how they improve things, instead
>> of making the code worse with a conditional lock.
>
> Unfortunately, I can't easily get a "before and after" on this
> change. The motivating issue popped up sporadically, but getting it to
> happen in a setup under *my* control is organizationally a pain.  So I
> understand if you wouldn't want the patch for that reason.  Ideally,
> the changes would make the code easier to follow and clearer about why
> we're locking.

Even a microbenchmark that stresses the lock and can show the
performance impact of the change you are making is useful.

Simply reorganizing and removing an unnecessary lock lowers the bar
because the code is then both simpler and pretty much by definition
faster.  Although sometimes another lock is then hit and the contention
moves.

> If you're OK with two patches that 1) grab lock_task_sighand in
> prlimit64 and 2) moving the read_lock in {set,get}priority into the
> PGRP cases (assuming I was correct on that), I can send them out.

I think getpriority can only use the rcu_read_lock.  I don't think it
has any atomicity guarantees.

For setpriority the single process case should be safe just use rcu.
I haven't read through all of what set_one_prio is doing to confirm it
is safe, but in principle it should be safe.

> If it's too much of a risk/ugliness for not clear enough gain (in code
> quality or performance), I'm fine with dropping it.

Removing the tasklist_lock where we can is definitely a clear gain.

Simply shoving tasklist_lock aside and making the code more complicated
is much less clear.

Plus anything you can benchmark (even microbenchmark) and show the
benefit of is welcome.  Especially when you have indications that it
makes a difference in a larger context.

Eric
