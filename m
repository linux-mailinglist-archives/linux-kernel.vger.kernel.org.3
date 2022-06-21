Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F86B553841
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352061AbiFUQzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFUQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:55:43 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A501AD8A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:55:42 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54748)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o3hAD-002HzD-82; Tue, 21 Jun 2022 10:55:41 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57192 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o3hAC-00FQTB-9x; Tue, 21 Jun 2022 10:55:40 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Roman Penyaev <rpenyaev@suse.de>
In-Reply-To: <CAHk-=wiEZmzBUFkZkBrJv3JSJkQ+qxaMZU_Sx1WTpMHs2SOAiQ@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 17 Jun 2022 14:48:08 -0500")
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
        <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net>
        <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
        <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
        <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com>
        <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
        <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com>
        <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
        <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net>
        <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
        <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
        <CANn89i+wBM+ewcP9u+ZWDqv3zQeK7ovKB+YJf9S6Om5QkqhLHA@mail.gmail.com>
        <CAHk-=wi9ut1VkB=Ja_gYtH67DZ7cc5QBG-uJCPkOpU=MZDJSUw@mail.gmail.com>
        <CANn89iJXeUJRV2+8reUdaeARxYPPbCoG+9atmRFfy4kv0XX00A@mail.gmail.com>
        <CAHk-=wiEZmzBUFkZkBrJv3JSJkQ+qxaMZU_Sx1WTpMHs2SOAiQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 21 Jun 2022 11:55:33 -0500
Message-ID: <87tu8eez22.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o3hAC-00FQTB-9x;;;mid=<87tu8eez22.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18on2zH4h5fLZp+a7t0a7VDglmpIOcj6wo=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 389 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 13 (3.3%), b_tie_ro: 11 (2.7%), parse: 1.29
        (0.3%), extract_message_metadata: 14 (3.7%), get_uri_detail_list: 1.72
        (0.4%), tests_pri_-1000: 15 (3.8%), tests_pri_-950: 1.29 (0.3%),
        tests_pri_-900: 1.04 (0.3%), tests_pri_-90: 101 (26.0%), check_bayes:
        100 (25.6%), b_tokenize: 7 (1.7%), b_tok_get_all: 8 (2.0%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 80 (20.4%), b_finish: 0.96
        (0.2%), tests_pri_0: 226 (58.0%), check_dkim_signature: 0.73 (0.2%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.81 (0.2%), tests_pri_10:
        3.1 (0.8%), tests_pri_500: 10 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 17, 2022 at 2:39 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> I am converting RAW sockets to RCU.
>
> RCU is usually absolutely the best approach. Use regular spinlocks for
> writers, and RCU for readers.
>
> I'd love to see the tasklist_lock be converted to RCU too.  But that
> locks predates RCU (and probably 99% of all kernel code), and it's
> messy, so nobody sane has ever willingly tried to do that afaik.

Well sort of.  I converted proc many many years ago.

Like Peter mentioned the big obvious challenge for converting
signal delivery to something else is the atomic delivery aspect.

I am playing with it, and I think I see how to convert signal delivery.
Something like a quick grab of lock that updates struct pid and creates
a list of signals are pending to be delivered.  Plus code that forces
clone to deliver the pending signal before clone creates a new task.

Plus something like a generation counter so I can see when pulling the
signal in clone if the signal has already been delivered.

I think tasks exiting before getting a signal is ok, and does not need
any code.


I have some patches that are almost working that can use siglock to
protect the parent/child/ptrace relation ship for SIGCHLD processing.
Which will remove the pressure on tasklist_lock when I get them sorted.


Not that any of this will kill tasklist_lock but with a little luck we
can get to short deterministic hold times.

Eric
