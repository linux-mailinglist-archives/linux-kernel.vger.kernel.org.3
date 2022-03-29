Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0514EA625
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiC2DkI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Mar 2022 23:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiC2DkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:40:04 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2AFF26;
        Mon, 28 Mar 2022 20:38:20 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:50314)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nZ2gV-00H9jE-16; Mon, 28 Mar 2022 21:38:19 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41550 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nZ2gT-0069EN-To; Mon, 28 Mar 2022 21:38:18 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Gladkov <legion@kernel.org>, Kyle Huey <me@kylehuey.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
        <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
        <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
Date:   Mon, 28 Mar 2022 22:37:41 -0500
In-Reply-To: <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 28 Mar 2022 17:33:52 -0700")
Message-ID: <87r16lmnsq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nZ2gT-0069EN-To;;;mid=<87r16lmnsq.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19JMTppDKTZYjaBsISRPeOfEDIdZvDEMr8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 511 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 9 (1.8%), parse: 1.17 (0.2%),
         extract_message_metadata: 17 (3.3%), get_uri_detail_list: 2.1 (0.4%),
        tests_pri_-1000: 16 (3.1%), tests_pri_-950: 1.34 (0.3%),
        tests_pri_-900: 1.16 (0.2%), tests_pri_-90: 123 (24.1%), check_bayes:
        122 (23.8%), b_tokenize: 9 (1.7%), b_tok_get_all: 11 (2.1%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 95 (18.6%), b_finish: 0.97
        (0.2%), tests_pri_0: 324 (63.4%), check_dkim_signature: 0.64 (0.1%),
        check_dkim_adsp: 11 (2.1%), poll_dns_idle: 0.36 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 10 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] ptrace: Cleanups for v5.18
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Mar 28, 2022 at 4:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The removal of tracehook.h is quite significant as it has been a major
>> source of confusion in recent years.  Much of that confusion was
>> around task_work and TIF_NOTIFY_SIGNAL (which I have now decoupled
>> making the semantics clearer).
>
> Hmm. I love removing tracehook.c, but this looks like it hasn't been
> in linux-next.
>
> The header file changes messes with other changes, and we have
>
>   kernel/sched/fair.c:2884:9: error: implicit declaration of function
> ‘init_task_work’; did you mean ‘init_irq_work’?
> [-Werror=implicit-function-declaration]
>    2884 |         init_task_work(&p->numa_work, task_numa_work);
>         |         ^~~~~~~~~~~~~~
>
> as a result (also a few other things in that same file).
>
> Now, this is trivial to fix - just add an include for
> <linux/task_work.h> from that file - and that's the right thing to do
> anyway.
>
> But I'm a bit unhappy that this was either not tested in linux-next,
> or if it was, I wasn't notified about the semantic in the pull
> request.
>
> So I've pulled this, and fixed up things in my merge, but I'm a bit
> worried that there might be other situations like this where some
> header file is no longer included and it was included implicitly
> before through that disgusting tracehook.h header..
>
> I *hope* it was just the scheduler header file updates that ended up
> having this effect, and nothing else is affected.
>
> Let's see if the test robots start complaining about non-x86
> architecture-specific stuff that I don't build test.

Sorry for not mentioning that.  I had tracked it down.  It was
fundamentally in the scheduler headers changes removing an include of
task_work.h, so it didn't feel like there was anything I could do in my
tree.  I asked Ingo if he could fix his tree and unfortunately forgot
about it.

For the record there were also a couple of other pretty trivial
conflicts, the removal of nds32, some block_cgroup header where
an adjacent line was modified to what I was changing.  But it thankfully
looks like none of those caused you any problems.

Sorry about all of that I am about that.  I am running pretty weak this
last couple of days as a cold has been running through the household.


Dumb question because this seems to burning a few extra creativity
points.  Is there any way to create a signed tag and a branch with the
same name?  Or in general is there a good way to manage topic branches
and then tag them at the end before I send them?

Having a tag and a branch with the same name seems to completely confuse
git and it just tells me no I won't push anything to another git tree,
because what you are asking me to do is ambiguous.  So now I am having
to come up with two names for each topic branch, even if I only push the
tags upstream.

I feel like there is a best practice on how to manage tags and topic
branches and I just haven't seen it yet.

Eric

