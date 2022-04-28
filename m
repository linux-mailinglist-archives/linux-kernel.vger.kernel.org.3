Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E2512956
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbiD1CIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiD1CI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:08:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1603101C0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:05:11 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kpf825WlfzgYbP;
        Thu, 28 Apr 2022 10:04:50 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 10:05:10 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 10:05:09 +0800
Message-ID: <b36af592-ec3a-7a7e-3caa-0c5b15aee7fe@huawei.com>
Date:   Thu, 28 Apr 2022 10:05:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Question about kill a process group
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     lkml <linux-kernel@vger.kernel.org>, <keescook@chromium.org>,
        <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
        <elver@google.com>, <legion@kernel.org>, <oleg@redhat.com>,
        <brauner@kernel.org>
References: <aff07d75-622c-9bab-863c-0917c79da3c4@huawei.com>
 <fff65bc3-0b73-3c5e-0f31-bd5404f75353@huawei.com>
 <e70b350e-abfc-7f8d-4590-d18801a9a722@huawei.com>
 <87ilrd2dfj.fsf@email.froward.int.ebiederm.org>
 <58223bd3-b63b-0c2b-abcc-e1136090d060@huawei.com>
 <874k2mtny7.fsf@email.froward.int.ebiederm.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <874k2mtny7.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

在 2022/4/22 0:12, Eric W. Biederman 写道:
> Zhang Qiao <zhangqiao22@huawei.com> writes:
> 
>> 在 2022/4/13 23:47, Eric W. Biederman 写道:
>>> To do something about this is going to take a deep and fundamental
>>> redesign of how we maintain process lists to handle a parent
>>> with millions of children well.
>>>
>>> Is there any real world reason to care about this case?  Without
>>> real world motivation I am inclined to just note that this is
>>
>> I just foune it while i ran ltp test.
> 
> So I looked and fork12 has been around since 2002 in largely it's
> current form.  So I am puzzled why you have run into problems
> and other people have not.
> 
> Did you perhaps have lock debugging enabled?
> 
> Did you run on a very large machine where a ridiculous number processes
> could be created?
> 
> Did you happen to run fork12 on a machine where locks are much more
> expensive than on most machines?


I don't think so, I reproduced this problem on two servers with different configurations.
One of server info as follows:
cpu: Intel(R) Xeon(R) CPU E5-2698 v3 @ 2.30GHz, 64 cpus,
RAM: 377G

Do you need any other information?

> 
> 
>>> Is there a real world use case that connects to this?
>>>
>>> How many children are being created in this test?  Several million?
>>
>>   There are about 300,000+ processes.
> 
> Not as many as I was guessing, but still enough to cause a huge
> wait on locks.
> 
>>> I would like to blame this on the old issue that tasklist_lock being
>>> a global lock.  Given the number of child processes (as many as can be
>>> created) I don't think we are hurt much by using a global lock.  The
>>> problem for solubility is that we have a lock.
>>>
>>> Fundamentally there must be a lock taken to maintain the parent's
>>> list of children.
>>>
>>> I only see SIGQUIT being called once in the parent process so that
>>> should not be an issue.
>>
>>
>>   In fork12, every child will call kill(0, SIGQUIT) at cleanup().
>> There are a lot of kill(0, SIGQUIT) calls.
> 
> I had missed that.  I can see that stressing out a lot.
> 
> At the same time as I read fork12.c that is very much a bug.  The
> children in fork12.c should call _exit() instead of exit().  Which
> would suppress calling the atexit() handlers and let fork12.c
> test what it is trying to test.
> 
> That doesn't mean there isn't a mystery here, but more that if
> we really want to test lots of processes calling the same
> signal at the same time it should be a test that means to do that.
> 
> 
>>> There is a minor issue in fork12 that it calls exit(0) instead of
>>> _exit(0) in the children.  Not the problem you are dealing with
>>> but it does look like it can be a distraction.
>>>
>>> I suspect the issue really is the thundering hurd of a million+
>>> processes synchronizing on a single lock.
>>>
>>> I don't think this is a hard lockup, just a global slow down.
>>> I expect everything will eventually exit.
>>>
>>
>>  But according to the vmcore, this is a hardlockup issue, and i think
>> there may be the following scenarios:
> 
> Let me rewind a second.  I just realized that I don't have a clue what
> a hard lockup is (outside of the linux hard lockup detector).
> 
> The two kinds of lockups that I understand with a technical meaning are
> deadlock (such taking two locks in opposite orders which can never be
> escaped), and livelock (where things are so busy no progress is made for
> an extended period of time).
> 
> I meant to say this is not a deadlock situation.  This looks like a
> livelock, but I think given enough time the code would make progress and
> get out of it.
> 
> I do agree over 1 second for holding a spin lock is ridiculous and a
> denial of service attack.
> 
> 
> 
> What I unfortunately do not see is a real world scenario where this will
> happen.  Without a real world scenario it is hard to find motivation to
> spend the year or so it would take to rework all of the data structures.
> The closest I can imagine to a real world scenario is that this
> situation can be used as a denial of service attack.
> 
> The hardest part of the problem is that signals sent to a group need to
> be sent to the group atomically.  That is the signals need to be sent to
> every member of the group.
> 
> Anyway I am very curious why you are the only one seeing a problem with
> fork12.  That we can definitely investigate as tracking down what is
> different about your setup versus other people who have run ltp seems
> much easier than redesigning all of the signal processing data
> structures from scratch.

the test steps are as follows:

1. git clone https://github.com/linux-test-project/ltp.git --depth=1
2. cd ltp/
3. make autotools
4. ./configure
5. cd testcases/kernel/syscalls/
6. make -j64
7. find ./ -type f -executable > newlist
8. while read line;do ./$line -I 30;done < newlist
9. After ten hours, i trigger Ctrl+C repeatedly.

> 
> Eric
> .
> 
