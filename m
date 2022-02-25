Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D634C4DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiBYSjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBYSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:39:54 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0FE574A3;
        Fri, 25 Feb 2022 10:39:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DC7273E55F8;
        Fri, 25 Feb 2022 13:39:20 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0o3zchip163a; Fri, 25 Feb 2022 13:39:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 545D83E527A;
        Fri, 25 Feb 2022 13:39:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 545D83E527A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645814360;
        bh=a2w4lmWbmq0mOVG90UVy28DB6ZZPatk+XVMbEl8SRLA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=doD4rEhsUHLA4EXFaRuPa0LIqLvW82SrLaMMqM/cDvZYa/Yq2YADm8EdMLNDqtPi0
         rH0CBL5y8HXxIXPzuj7R2b/g3ce7CiTGWLy2LqDiY17FT4kEVpY6Bh8JRtzQhGyQ4F
         bNjGqctJOAmnyqMn+buZAVWED9Tzzfj4ojXS8vka1sgGGsbIfviK/qBldaGKbP7edz
         SAfbaCXBVl2pqcrHOPk6dyeCgGjUMQkGKkYmGxEujus1yY8vw5fvbvz9XHBKpWH3u3
         2ylUJInU1lwyhsEM5qAUQQZvxCd2ULVVrtG+veX/fvbZgDxZVoIKt/WPDOPDfnJ8PL
         JcdCelL4NF2jw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VMcpw5CecI2E; Fri, 25 Feb 2022 13:39:20 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3C6583E5279;
        Fri, 25 Feb 2022 13:39:20 -0500 (EST)
Date:   Fri, 25 Feb 2022 13:39:20 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        linux-man <linux-man@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Message-ID: <1317699329.108531.1645814360159.JavaMail.zimbra@efficios.com>
In-Reply-To: <8735k6ke34.fsf@meer.lwn.net>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com> <20220218210633.23345-10-mathieu.desnoyers@efficios.com> <87k0dikfxa.fsf@meer.lwn.net> <1323451367.108396.1645811762372.JavaMail.zimbra@efficios.com> <8735k6ke34.fsf@meer.lwn.net>
Subject: Re: [RFC PATCH v2 09/11] sched: Introduce per memory space current
 virtual cpu id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Topic: sched: Introduce per memory space current virtual cpu id
Thread-Index: CaZeshN6ehwBX8NrJ0kfTDw8fz7SwQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 25, 2022, at 1:15 PM, Jonathan Corbet corbet@lwn.net wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> 
>> Some effective upper bounds for the number of vcpu ids observable in a process:
>>
>> - sysconf(3) _SC_NPROCESSORS_CONF,
>> - the number of threads which exist concurrently in the process,
>> - the number of cpus in the cpu affinity mask applied by sched_setaffinity,
>>   except in corner-case situations such as cpu hotplug removing all cpus from
>>   the affinity set,
>> - cgroup cpuset "partition" limits,
>>
>> Note that AFAIR non-partition cgroup cpusets allow a cgroup to "borrow"
>> additional cores from the rest of the system if they are idle, therefore
>> allowing the number of concurrent threads to go beyond the specified limit.
>>
>> AFAIR the sched affinity mask is tweaked independently of the cgroup cpuset.
>> Those are two mechanisms both affecting the scheduler task placement.
>>
>> I would expect the user-space code to use some sensible upper bound as a
>> hint about how many per-vcpu data structure elements to expect (and how many
>> to pre-allocate), but have a "lazy initialization" fall-back in case the
>> vcpu id goes up to the number of configured processors - 1. And I suspect
>> that even the number of configured processors may change with CRIU.
>>
>> If the above explanation makes sense (please let me know if I am wrong
>> or missed something), I suspect I should add it to the commit message.
> 
> That helps, thanks.  I do think that something like this belongs in the
> changelog - or, even better, in the upcoming restartable-sequences
> section in the userspace-api documentation :)

Just to confirm, when you say "userspace-api documentation" do you refer to
man pages ?

I did a few attempts at upstreaming a rseq.2 man page in 2020, but I have been
stuck waiting for feedback from Michael Kerrisk since then.

So for the moment I'm maintaining a rseq.2 man page here:

https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2

I'd gladly accept some help to improve the documentation of rseq.

Thanks,

Mathieu

> 
> Thanks,
> 
> jon

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
