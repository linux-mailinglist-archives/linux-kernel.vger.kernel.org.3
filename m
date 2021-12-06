Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828A346A552
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhLFTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348199AbhLFTHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638817415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KkqcsGd+9Q/eThYWykL2b0dES0qO6sbCeXiMGqW8u8s=;
        b=L7plVkKx4EDu65H4F/hbdtOy0qbDDoDO09xiJcFYqEGCGNbIw3Ldn8+Nn2pThhdA8ApZmZ
        MqNPBpgUJniBHL1l9uuIERRtTzkmv7XqjQg3oLPNHjVaRCcffsQ8Yb2NoYyiWIi2YmMlZW
        NQoSb74xU9qfxdi/q6qTAdYyGhGLJ6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-3h91i19INPC6HuKmLCgfSw-1; Mon, 06 Dec 2021 14:03:32 -0500
X-MC-Unique: 3h91i19INPC6HuKmLCgfSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D4F81CCB5;
        Mon,  6 Dec 2021 19:03:31 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21B8145D65;
        Mon,  6 Dec 2021 19:03:28 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] nptl: Add rseq registration
References: <cover.1638798186.git.fweimer@redhat.com>
        <9c58724d604e160ebda5f667331fa41416c0d12b.1638798186.git.fweimer@redhat.com>
        <1780152866.15126.1638809966443.JavaMail.zimbra@efficios.com>
        <871r2podt9.fsf@oldenburg.str.redhat.com>
        <1614144911.15213.1638816753026.JavaMail.zimbra@efficios.com>
Date:   Mon, 06 Dec 2021 20:03:26 +0100
In-Reply-To: <1614144911.15213.1638816753026.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 6 Dec 2021 13:52:33 -0500
        (EST)")
Message-ID: <87ilw1mu81.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> [ Adding other kernel rseq maintainers in CC. ]
>
> ----- On Dec 6, 2021, at 12:14 PM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> ----- On Dec 6, 2021, at 8:46 AM, Florian Weimer fweimer@redhat.com wrote:
>>> [...]
>>>> @@ -406,6 +407,9 @@ struct pthread
>>>>   /* Used on strsignal.  */
>>>>   struct tls_internal_t tls_state;
>>>> 
>>>> +  /* rseq area registered with the kernel.  */
>>>> +  struct rseq rseq_area;
>>>
>>> The rseq UAPI requires that the fields within the rseq_area
>>> are read-written with single-copy atomicity semantics.
>>>
>>> So either we define a "volatile struct rseq" here, or we'll need
>>> to wrap all accesses with the proper volatile casts, or use the
>>> relaxed_mo atomic accesses.
>> 
>> Under the C memory model, neither volatile nor relaxed MO result in
>> single-copy atomicity semantics.  So I'm not sure what to make of this.
>> Surely switching to inline assembly on all targets is over the top.
>> 
>> I think we can rely on a plain read doing the right thing for us.
>
> AFAIU, the plain read does not prevent the compiler from re-loading the
> value in case of high register pressure.
>
> Accesses to rseq fields such as cpu_id need to be done as if those were
> concurrently modified by a signal handler nesting on top of the user-space
> code, with the particular twist that blocking signals has no effect on
> concurrent updates.
>
> I do not think we need to do the load in assembly. I was under the impression
> that both volatile load and relaxed MO result in single-copy atomicity
> semantics for an aligned pointer. Perhaps Paul, Peter, Boqun have something
> to add here ?

The C memory model is broken and does not prevent out-of-thin-air
values.  As far as I know, this breaks single-copy atomicity.  In
practice, compilers will not exercise the latitude offered by the memory
model.  volatile does not ensure absence of data races.

Using atomics or volatile would require us to materialize the thread
pointer, given the current internal interfaces we have, and I don't want
to do this because this is supposed to be performance-critical code.
The compiler barrier inherent to the function call will have to be
enough.  I can add a comment to this effect:

  /* This load has single-copy atomicity semantics (as required for
     rseq) because the function call implies a compiler barrier.  */

Thanks,
Florian

