Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716B147305F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhLMPZG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Dec 2021 10:25:06 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50962 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLMPZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:25:04 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:39534)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwnCJ-006sx4-4u; Mon, 13 Dec 2021 08:25:03 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:40714 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwnCI-00BGma-6R; Mon, 13 Dec 2021 08:25:02 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>, Tejun Heo <tj@kernel.org>,
        security@kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>
References: <20211208180501.11969-1-mkoutny@suse.com>
        <87sfv3540t.fsf@email.froward.int.ebiederm.org>
        <YbPe4+K+RlDgccIh@blackbook>
Date:   Mon, 13 Dec 2021 09:24:55 -0600
In-Reply-To: <YbPe4+K+RlDgccIh@blackbook> ("Michal \=\?utf-8\?Q\?Koutn\=C3\=BD\?\=
 \=\?utf-8\?Q\?\=22's\?\= message of "Sat,
        11 Dec 2021 00:12:35 +0100")
Message-ID: <874k7c34u0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1mwnCI-00BGma-6R;;;mid=<874k7c34u0.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xtx73jMmO3jF6HYxsRRJf4v3O2ksAPZM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?;Michal Koutn=c3=bd <mkoutny@suse.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 384 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (1.0%), b_tie_ro: 2.7 (0.7%), parse: 0.72
        (0.2%), extract_message_metadata: 12 (3.1%), get_uri_detail_list: 0.99
        (0.3%), tests_pri_-1000: 19 (4.8%), tests_pri_-950: 1.04 (0.3%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 63 (16.4%), check_bayes:
        62 (16.1%), b_tokenize: 5 (1.3%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 1.54 (0.4%), b_tok_touch_all: 45 (11.7%), b_finish: 0.73
        (0.2%), tests_pri_0: 272 (70.8%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.82 (0.2%), tests_pri_10:
        2.7 (0.7%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Koutný <mkoutny@suse.com> writes:

> On Wed, Dec 08, 2021 at 12:45:54PM -0600, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>> TL;DR the cgroup file system is checking permissions at write time.
>
> Thank you for bringing that up (handled in a separate thread now).
>
>> I think I follow your reasoning and I think it will even fix the issue
>> but no.
>
> FTR, part of Tejun's series [1] ensures that cgroup_ns is accessed
> directly without nsproxy and a reference to it is kept while the file
> is opened. I.e. that'd properly fix this particular crash reported by
> syzbot.
>
>> Please don't apply this patch.
>> 
>> exit_task_work running after exit_task_namespaces is the messenger
>> that just told us about something ugly.
>
> In (my) theory some other task_work callbacks could (transitively) rely
> on the current->nsproxy which could still be cleared by
> exit_task_namespaces().
> Is there another reason why to have exit_task_namespaces() before
> exit_task_work()?

We already have the principle that things are going to be cleaned up
before exit_task_work is called and exit_files depends upon that.

So I think the burden is to find a good reason why exit_task_work should
move not to defend it.

If we don't want things cleaned up before exit_task_work it should come
at the start of do_exit and exit_files and others need to stop depending
upon it.  Which seems like challenging change to make.

Eric
