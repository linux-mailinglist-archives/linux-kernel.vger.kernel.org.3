Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0784735A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbhLMUMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237759AbhLMUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639426342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xU/SmztKLLgt1uf7mPiopLf2mkRcYGHM3iLZTJn1eYs=;
        b=WRTNUkNJq2GNHrO4KRuV7QryxpVi1OnUPl+ICk5FxF0nsWxROxBQoTVjv6kSJVXP39QzO+
        Qa3y/iuewwNFxTNkWu+ASoBXwaNBAcTqWpa+6n1GVyx6AY8XNfYdgzRP8tG2fCGXMXQPH2
        ZOsh0MyMZ7G0ZdPVx9hUJ1OCnzEX7P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-2EeCaazvPlmBrHa0cftLEg-1; Mon, 13 Dec 2021 15:12:18 -0500
X-MC-Unique: 2EeCaazvPlmBrHa0cftLEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F3FE192FDA0;
        Mon, 13 Dec 2021 20:12:17 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50EBE5F70B;
        Mon, 13 Dec 2021 20:12:15 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-api <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>
Subject: Re: rseq + membarrier programming model
References: <87tufctk82.fsf@oldenburg.str.redhat.com>
        <697825714.30478.1639423180784.JavaMail.zimbra@efficios.com>
        <87ilvstia9.fsf@oldenburg.str.redhat.com>
        <1424606270.30586.1639425414221.JavaMail.zimbra@efficios.com>
Date:   Mon, 13 Dec 2021 21:12:12 +0100
In-Reply-To: <1424606270.30586.1639425414221.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 13 Dec 2021 14:56:54 -0500
        (EST)")
Message-ID: <87bl1ktgbn.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Dec 13, 2021, at 2:29 PM, Florian Weimer fweimer@redhat.com wrot=
e:
>
>> * Mathieu Desnoyers:
>>=20
>>>> Could it fall back to
>>>> MEMBARRIER_CMD_GLOBAL instead?
>>>
>>> No. CMD_GLOBAL does not issue the required rseq fence used by the
>>> algorithm discussed. Also, CMD_GLOBAL has quite a few other shortcoming=
s:
>>> it takes a while to execute, and is incompatible with nohz_full kernels.
>>=20
>> What about using sched_setcpu to move the current thread to the same CPU
>> (and move it back afterwards)?  Surely that implies the required sort of
>> rseq barrier that MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ with
>> MEMBARRIER_CMD_FLAG_CPU performs?
>
> I guess you refer to using sched_setaffinity(2) there ? There are various
> reasons why this may fail. For one, the affinity mask is a shared global
> resource which can be changed by external applications.

So is process memory =E2=80=A6

> Also, setting the affinity is really just a hint. In the presence of
> cpu hotplug and or cgroup cpuset, it is known to lead to situations
> where the kernel just gives up and provides an affinity mask including
> all CPUs.

How does CPU hotplug impact this negatively?

The cgroup cpuset issue clearly is a bug.

> Therefore, using sched_setaffinity() and expecting to be pinned to
> a specific CPU for correctness purposes seems brittle.

I'm pretty sure it used to work reliably for some forms of concurrency
control.

> But _if_ we'd have something like a sched_setaffinity which we can
> trust, yes, temporarily migrating to the target CPU, and observing that
> we indeed run there, would AFAIU provide the same guarantee as the rseq
> fence provided by membarrier. It would have a higher overhead than
> membarrier as well.

Presumably a signal could do it as well.

>> That is possible even without membarrier, so I wonder why registration
>> of intent is needed for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
>
> I would answer that it is not possible to do this _reliably_ today
> without membarrier (see above discussion of cpu hotplug, cgroups, and
> modification of cpu affinity by external processes).
>
> AFAIR, registration of intent for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
> is mainly there to provide a programming model similar to private expedit=
ed
> plain and core-sync cmds.
>
> The registration of intent allows the kernel to further tweak what is
> done internally and make tradeoffs which only impact applications
> performing the registration.

But if there is no strong performance argument to do so, this introduces
additional complexity into userspace.  Surely we could say we just do
MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ at process start and document
failure (in case of seccomp etc.), but then why do this at all?

>>> In order to make sure the programming model is the same for expedited
>>> private/global plain/sync-core/rseq membarrier commands, we require that
>>> each process perform a registration beforehand.
>>=20
>> Hmm.  At least it's not possible to unregister again.
>>=20
>> But I think it would be really useful to have some of these barriers
>> available without registration, possibly in a more expensive form.
>
> What would be wrong with doing a membarrier private-expedited-rseq
> registration on libc startup, and exposing a glibc tunable to allow
> disabling this ?

The configurations that need to be supported go from =E2=80=9Cno rseq=E2=80=
=9C/=E2=80=9Crseq=E2=80=9D
to =E2=80=9Cno rseq=E2=80=9C/=E2=80=9Crseq=E2=80=9D/=E2=80=9Crseq with memb=
arrier=E2=80=9D.  Everyone now needs to
think about implementing support for all three instead just the obvious
two.

Thanks,
Florian

