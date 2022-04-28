Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145AF5133C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346345AbiD1Mgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbiD1Mgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:36:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ADEAF1F2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:33:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651149208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lf/3qq2YBykZvJUnRtfiax4Y/3nsHMdL9uUFfV/a5Q8=;
        b=U3/f17KNQ/3YZABrUPWcaKD/wUvR7H4XOXvZs9IFT/wHlFd7Ks61MZYhTVSfpRtyfISmD+
        HI6F1jRUnAMknFyr7YwOeeH3Ra3iU8sxy8RG9gNcDrk/AM91dHV/1alv6NL8tpJgRnPJVs
        9Yk+eqS1gqvauhQxJbpc9XvlX7OHzCl3trSuRWIWePbi3EPMjIFKmHtUQwf+NsFyl/bdeQ
        JV5qsn0k/RE4KVMIzH0xj4Ty5ArxCl21OpCOnNXQEsQYQITqFWwK4TuQdPeMgBlaq6DQ09
        b0BObyf8Mi5JRA1SoFXrCnrJ7IRUiap3rYjqLfVSVWN0DEiY8sSN01UU8CpBPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651149208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lf/3qq2YBykZvJUnRtfiax4Y/3nsHMdL9uUFfV/a5Q8=;
        b=XlyZ8R9exVv8XEKbQiHSmFCS4+rPu4SxHCakRPDThuf2Z4B7yc95G3ntVZzd7c0g9i3vK/
        g+x41hKiMHx403DA==
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Zhang Qiao <zhangqiao22@huawei.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, keescook@chromium.org,
        Peter Zijlstra <peterz@infradead.org>, elver@google.com,
        legion@kernel.org, oleg@redhat.com, brauner@kernel.org
Subject: Re: Question about kill a process group
In-Reply-To: <874k2mtny7.fsf@email.froward.int.ebiederm.org>
References: <aff07d75-622c-9bab-863c-0917c79da3c4@huawei.com>
 <fff65bc3-0b73-3c5e-0f31-bd5404f75353@huawei.com>
 <e70b350e-abfc-7f8d-4590-d18801a9a722@huawei.com>
 <87ilrd2dfj.fsf@email.froward.int.ebiederm.org>
 <58223bd3-b63b-0c2b-abcc-e1136090d060@huawei.com>
 <874k2mtny7.fsf@email.froward.int.ebiederm.org>
Date:   Thu, 28 Apr 2022 14:33:27 +0200
Message-ID: <87zgk5v148.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21 2022 at 11:12, Eric W. Biederman wrote:
> Zhang Qiao <zhangqiao22@huawei.com> writes:
>>> How many children are being created in this test?  Several million?
>>
>>   There are about 300,000+ processes.
>
> Not as many as I was guessing, but still enough to cause a huge
> wait on locks.

Indeed. It's about 4-5us per process to send the signal on a 2GHz
SKL-X. So with 20000k processes tasklist lock is read held for 1 second.

> I do agree over 1 second for holding a spin lock is ridiculous and a
> denial of service attack.

Exactly. Even holding it for 100ms (20k forks) is daft.

So unless the number of PIDs for a user is limited this _is_ an
unpriviledged DoS vector.

> Anyway I am very curious why you are the only one seeing a problem with
> fork12.

It's fully reproducible. It's just a question how big the machine is and
what the PID limits are on the box you are testing on.

>>> I suspect the issue really is the thundering hurd of a million+
>>> processes synchronizing on a single lock.

There are several issues:

 1) The parent sending the signal is holding the lock for an
    obscene long time.

 2) Every signaled child runs into tasklist lock contention as all of
    them need to aquire it for write in do_exit(). That means within
    (NR_CPUS - 1) * 5usec all CPUs are spinning on tasklist lock with
    interrupts disabled up to the point where #1 has finished.

So depending on the number of childs and the configured limits of a
lockup detector this is sufficient to trigger a warning.

Thanks,

        tglx
