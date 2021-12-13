Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8644734D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhLMTTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:19:43 -0500
Received: from mail.efficios.com ([167.114.26.124]:47906 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhLMTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:19:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C5D8931CEC2;
        Mon, 13 Dec 2021 14:19:41 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id batosGk9nsmz; Mon, 13 Dec 2021 14:19:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0331B31CF38;
        Mon, 13 Dec 2021 14:19:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0331B31CF38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1639423181;
        bh=6IJ768Q+9Et3bA7CRGWla9iClFZ1ud4C606P/yp0cMQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=E7EIcnzHexB40Oyf/Hdh4Y9EJRqZaGx1l8tKcCVe7Yw4xragAeBvn91oPBmjma+xA
         2Tf3znBAfXv2wBbaS2R07c8HVll6oMhuhEDbPRbHLPcE9CRVW6skR0DtUNWPwBJ3h/
         VNKfRwtOaJPfVGYV3MYLezON+hF69nHOh7ZV5Eg/tvkPFXjg+DdSwKhBiMR/VUq2Py
         kSwLhp5+68j1IR2jvCcJinO2kqJ/GwMxXEvpQ3QHH4JMLY0UMUoYWEYZK7wYgwDACi
         L8NNvggWN6NernQyRsRMAgZxeS5R9FfO6+CPxvwicfqwYwy/6qcUJ2nGEbBxE2FcDs
         k7Dfp5yy4JpqA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MZIzfRKoEqo1; Mon, 13 Dec 2021 14:19:40 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E57DA31CD70;
        Mon, 13 Dec 2021 14:19:40 -0500 (EST)
Date:   Mon, 13 Dec 2021 14:19:40 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>
Message-ID: <697825714.30478.1639423180784.JavaMail.zimbra@efficios.com>
In-Reply-To: <87tufctk82.fsf@oldenburg.str.redhat.com>
References: <87tufctk82.fsf@oldenburg.str.redhat.com>
Subject: Re: rseq + membarrier programming model
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq + membarrier programming model
Thread-Index: Jeg44R6PVmLUvL/g/E9uUG22JuKmYg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 13, 2021, at 1:47 PM, Florian Weimer fweimer@redhat.com wrote:

> I've been studying Jann Horn's biased locking example:
> 
>  Re: [PATCH 0/4 POC] Allow executing code and syscalls in another address space
>  <https://lore.kernel.org/linux-api/CAG48ez02UDn_yeLuLF4c=kX0=h2Qq8Fdb0cer1yN8atbXSNjkQ@mail.gmail.com/>
> 
> It uses MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ as part of the biased lock
> revocation.
> 
> How does the this code know that the process has called
> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ?

I won't speak for this code snippet in particular, but in general
issuing MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ from a thread which
belongs to a process which has not performed
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ will result in
membarrier returning -EPERM. If the kernel is built without CONFIG_RSEQ
support, it will return -EINVAL:

membarrier_private_expedited():

        } else if (flags == MEMBARRIER_FLAG_RSEQ) {
                if (!IS_ENABLED(CONFIG_RSEQ))
                        return -EINVAL;
                if (!(atomic_read(&mm->membarrier_state) &
                      MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY))
                        return -EPERM;

If you want to create code which optionally depends on availability
of EXPEDITED_RSEQ membarrier, I suspect you will want to perform
registration from a library constructor, and keep track of registration
success/failure in a static variable within the library.

> Could it fall back to
> MEMBARRIER_CMD_GLOBAL instead?

No. CMD_GLOBAL does not issue the required rseq fence used by the
algorithm discussed. Also, CMD_GLOBAL has quite a few other shortcomings:
it takes a while to execute, and is incompatible with nohz_full kernels.

> Why is it that MEMBARRIER_CMD_GLOBAL
> does not require registration (the broader/more expensive barrier), but
> the more restricted versions do?

The more restricted versions (which require explicit registration) have a
close integration with the Linux scheduler, and in some cases require
additional code to be executed when scheduling between threads which
belong to different processes, for instance the for "SYNC_CORE" membarrier,
which is useful for JITs:

static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
{
        if (current->mm != mm)
                return;
        if (likely(!(atomic_read(&mm->membarrier_state) &
                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
                return;
        sync_core_before_usermode();
}

Also, for the "global-expedited" commands, these can generate IPIs which will
interrupt the flow of threads running on behalf of a registered process.
Therefore, in order to make sure we do not add delays to real-time sensitive
applications, we made this registration "opt-in".

In order to make sure the programming model is the same for expedited
private/global plain/sync-core/rseq membarrier commands, we require that
each process perform a registration beforehand.

> 
> Or put differently, why wouldn't we request
> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ unconditionally at
> process start in glibc, once we start biased locking in a few places?

The registration of membarrier expedited can be either performed immediately
when the process starts, or later, possibly when there are other threads
running concurrently. Note however that the registration scheme has been
optimized for the scenario where it is called when a single thread is
running in the process (see sync_runqueues_membarrier_state()). Otherwise
we need to use the more heavyweight synchronize_rcu(). So my advice would
be to perform the membarrier expedited registration while the process
is still single-threaded if possible, rather than postpone this and
do it entirely lazily on first use, which may happen while other
threads are already running.

Thanks,

Mathieu

> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
