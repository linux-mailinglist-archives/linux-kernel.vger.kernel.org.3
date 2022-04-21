Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E9050A543
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiDUQ12 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Apr 2022 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiDUQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:15:51 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0512B241
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:13:01 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:47922)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhZQO-00FgfU-0E; Thu, 21 Apr 2022 10:12:56 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35204 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhZQM-009wda-SP; Thu, 21 Apr 2022 10:12:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, <keescook@chromium.org>,
        <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
        <elver@google.com>, <legion@kernel.org>, <oleg@redhat.com>,
        <brauner@kernel.org>
References: <aff07d75-622c-9bab-863c-0917c79da3c4@huawei.com>
        <fff65bc3-0b73-3c5e-0f31-bd5404f75353@huawei.com>
        <e70b350e-abfc-7f8d-4590-d18801a9a722@huawei.com>
        <87ilrd2dfj.fsf@email.froward.int.ebiederm.org>
        <58223bd3-b63b-0c2b-abcc-e1136090d060@huawei.com>
Date:   Thu, 21 Apr 2022 11:12:48 -0500
In-Reply-To: <58223bd3-b63b-0c2b-abcc-e1136090d060@huawei.com> (Zhang Qiao's
        message of "Thu, 14 Apr 2022 19:40:47 +0800")
Message-ID: <874k2mtny7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nhZQM-009wda-SP;;;mid=<874k2mtny7.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+x09LpwF9rV/Vq/NcUAUTBtxTT3Ay+Q9s=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Zhang Qiao <zhangqiao22@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 531 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 9 (1.8%), parse: 1.05 (0.2%),
         extract_message_metadata: 14 (2.6%), get_uri_detail_list: 2.6 (0.5%),
        tests_pri_-1000: 8 (1.5%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 76 (14.3%), check_bayes:
        74 (14.0%), b_tokenize: 9 (1.8%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 5 (1.0%), b_tok_touch_all: 44 (8.3%), b_finish: 0.99
        (0.2%), tests_pri_0: 405 (76.3%), check_dkim_signature: 0.80 (0.1%),
        check_dkim_adsp: 7 (1.3%), poll_dns_idle: 0.35 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Question about kill a process group
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Qiao <zhangqiao22@huawei.com> writes:

> 在 2022/4/13 23:47, Eric W. Biederman 写道:
>> To do something about this is going to take a deep and fundamental
>> redesign of how we maintain process lists to handle a parent
>> with millions of children well.
>> 
>> Is there any real world reason to care about this case?  Without
>> real world motivation I am inclined to just note that this is
>
> I just foune it while i ran ltp test.

So I looked and fork12 has been around since 2002 in largely it's
current form.  So I am puzzled why you have run into problems
and other people have not.

Did you perhaps have lock debugging enabled?

Did you run on a very large machine where a ridiculous number processes
could be created?

Did you happen to run fork12 on a machine where locks are much more
expensive than on most machines?


>> Is there a real world use case that connects to this?
>> 
>> How many children are being created in this test?  Several million?
>
>   There are about 300,000+ processes.

Not as many as I was guessing, but still enough to cause a huge
wait on locks.

>> I would like to blame this on the old issue that tasklist_lock being
>> a global lock.  Given the number of child processes (as many as can be
>> created) I don't think we are hurt much by using a global lock.  The
>> problem for solubility is that we have a lock.
>> 
>> Fundamentally there must be a lock taken to maintain the parent's
>> list of children.
>> 
>> I only see SIGQUIT being called once in the parent process so that
>> should not be an issue.
>
>
>   In fork12, every child will call kill(0, SIGQUIT) at cleanup().
> There are a lot of kill(0, SIGQUIT) calls.

I had missed that.  I can see that stressing out a lot.

At the same time as I read fork12.c that is very much a bug.  The
children in fork12.c should call _exit() instead of exit().  Which
would suppress calling the atexit() handlers and let fork12.c
test what it is trying to test.

That doesn't mean there isn't a mystery here, but more that if
we really want to test lots of processes calling the same
signal at the same time it should be a test that means to do that.


>> There is a minor issue in fork12 that it calls exit(0) instead of
>> _exit(0) in the children.  Not the problem you are dealing with
>> but it does look like it can be a distraction.
>> 
>> I suspect the issue really is the thundering hurd of a million+
>> processes synchronizing on a single lock.
>> 
>> I don't think this is a hard lockup, just a global slow down.
>> I expect everything will eventually exit.
>> 
>
>  But according to the vmcore, this is a hardlockup issue, and i think
> there may be the following scenarios:

Let me rewind a second.  I just realized that I don't have a clue what
a hard lockup is (outside of the linux hard lockup detector).

The two kinds of lockups that I understand with a technical meaning are
deadlock (such taking two locks in opposite orders which can never be
escaped), and livelock (where things are so busy no progress is made for
an extended period of time).

I meant to say this is not a deadlock situation.  This looks like a
livelock, but I think given enough time the code would make progress and
get out of it.

I do agree over 1 second for holding a spin lock is ridiculous and a
denial of service attack.



What I unfortunately do not see is a real world scenario where this will
happen.  Without a real world scenario it is hard to find motivation to
spend the year or so it would take to rework all of the data structures.
The closest I can imagine to a real world scenario is that this
situation can be used as a denial of service attack.

The hardest part of the problem is that signals sent to a group need to
be sent to the group atomically.  That is the signals need to be sent to
every member of the group.

Anyway I am very curious why you are the only one seeing a problem with
fork12.  That we can definitely investigate as tracking down what is
different about your setup versus other people who have run ltp seems
much easier than redesigning all of the signal processing data
structures from scratch.

Eric
