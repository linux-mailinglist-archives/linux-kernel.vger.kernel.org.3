Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBB4C4D74
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiBYSPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBYSPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:15:44 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6AE1F634D;
        Fri, 25 Feb 2022 10:15:12 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A49E22A0;
        Fri, 25 Feb 2022 18:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A49E22A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645812911; bh=oUN6Pog7J8FgoaWGTBczYy16pRgLbEf5z+vxasmFPJ4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=r7wIfyR5nqun/xkfnd1eampwJGtpTzMwGB5yA76V+8NAGQmLmkOACFoZXyS5099ZI
         1pTngONPzPM0JrjVm144/0g0/eKwBvHUkgxyJhIPpZKM0arwNMf3TZV1d9DmIqrKTj
         1aqGEgZSBxumAX6NkwTXHM4wbzlR5vqzCsgxQooXmR14Sdlq8EwkvHt/RTh35wpLmf
         NOQ2Vz2dTlrS+XCFrTTtPwkuqUV/f1lp2kLzGSmtRJw0iqXYElfTHppsGbvyX4TRIj
         HGeDoW+31I2edKkf7BQsmbYxzMTdV3foMGiZ6vFeh77elayUwKX5oAXZKsMrjdVxUr
         Xz2OGoeFKmeNg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [RFC PATCH v2 09/11] sched: Introduce per memory space current
 virtual cpu id
In-Reply-To: <1323451367.108396.1645811762372.JavaMail.zimbra@efficios.com>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
 <20220218210633.23345-10-mathieu.desnoyers@efficios.com>
 <87k0dikfxa.fsf@meer.lwn.net>
 <1323451367.108396.1645811762372.JavaMail.zimbra@efficios.com>
Date:   Fri, 25 Feb 2022 11:15:11 -0700
Message-ID: <8735k6ke34.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> Some effective upper bounds for the number of vcpu ids observable in a process:
>
> - sysconf(3) _SC_NPROCESSORS_CONF,
> - the number of threads which exist concurrently in the process,
> - the number of cpus in the cpu affinity mask applied by sched_setaffinity,
>   except in corner-case situations such as cpu hotplug removing all cpus from
>   the affinity set,
> - cgroup cpuset "partition" limits,
>
> Note that AFAIR non-partition cgroup cpusets allow a cgroup to "borrow"
> additional cores from the rest of the system if they are idle, therefore
> allowing the number of concurrent threads to go beyond the specified limit.
>
> AFAIR the sched affinity mask is tweaked independently of the cgroup cpuset.
> Those are two mechanisms both affecting the scheduler task placement.
>
> I would expect the user-space code to use some sensible upper bound as a
> hint about how many per-vcpu data structure elements to expect (and how many
> to pre-allocate), but have a "lazy initialization" fall-back in case the
> vcpu id goes up to the number of configured processors - 1. And I suspect
> that even the number of configured processors may change with CRIU.
>
> If the above explanation makes sense (please let me know if I am wrong
> or missed something), I suspect I should add it to the commit message.

That helps, thanks.  I do think that something like this belongs in the
changelog - or, even better, in the upcoming restartable-sequences
section in the userspace-api documentation :)

Thanks,

jon
