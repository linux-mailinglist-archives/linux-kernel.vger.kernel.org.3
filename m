Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7CD4734F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbhLMTaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:30:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240295AbhLMTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639423800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3/Ksz/+rMbZTa7dn+INhZ/hCEUhknY7SkJcQlX+fiQ=;
        b=cu70exRGGvc8uczNnqZc9aqYKjpOHMQ5dkigHOp+2gvoWKpP8MqltGezWAtmuPrV9x452G
        kPnEboof57mC66TMgQGDFirGOfKIhd/CiUi+Zqi90MCSALx1gkIQideJeWulfN390aejha
        SLNshkyocwrhEJvjd3cqkAYtde41SjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-I2mLPfDnPhWeQxlvw16c-w-1; Mon, 13 Dec 2021 14:29:57 -0500
X-MC-Unique: I2mLPfDnPhWeQxlvw16c-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C518164146;
        Mon, 13 Dec 2021 19:29:55 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD8E413AB3;
        Mon, 13 Dec 2021 19:29:53 +0000 (UTC)
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
Date:   Mon, 13 Dec 2021 20:29:50 +0100
In-Reply-To: <697825714.30478.1639423180784.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 13 Dec 2021 14:19:40 -0500
        (EST)")
Message-ID: <87ilvstia9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

>> Could it fall back to
>> MEMBARRIER_CMD_GLOBAL instead?
>
> No. CMD_GLOBAL does not issue the required rseq fence used by the
> algorithm discussed. Also, CMD_GLOBAL has quite a few other shortcomings:
> it takes a while to execute, and is incompatible with nohz_full kernels.

What about using sched_setcpu to move the current thread to the same CPU
(and move it back afterwards)?  Surely that implies the required sort of
rseq barrier that MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ with
MEMBARRIER_CMD_FLAG_CPU performs?

That is possible even without membarrier, so I wonder why registration
of intent is needed for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.

> In order to make sure the programming model is the same for expedited
> private/global plain/sync-core/rseq membarrier commands, we require that
> each process perform a registration beforehand.

Hmm.  At least it's not possible to unregister again.

But I think it would be really useful to have some of these barriers
available without registration, possibly in a more expensive form.

Thanks,
Florian

