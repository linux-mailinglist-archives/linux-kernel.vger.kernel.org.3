Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669FD46A6DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349484AbhLFUaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229867AbhLFUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638822424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sC+8iTq9KzBU/dUk31PEoQJ9907Q0dAMvY/4uhhCArU=;
        b=EctTsvEL8WLCbH1Ba9NnseLmPBOGVS/6qi+SBLyImG6oLC13XaGvYThrzIe8ciTrBeirw8
        wERuE5f/2i8B14Ev0YkZ/1WPnCG8u1plSFN8eC1rrR+XM9iWj4sbVbM0BToZ3EEudzsUcD
        LWMrfyE4jR1kRJEYGLfMphubchL8TXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-X89JxuXOOwSDy1U9t2kUfA-1; Mon, 06 Dec 2021 15:26:58 -0500
X-MC-Unique: X89JxuXOOwSDy1U9t2kUfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42B60835E21;
        Mon,  6 Dec 2021 20:26:57 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D28FB709AA;
        Mon,  6 Dec 2021 20:26:54 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Paul E. McKenney via Libc-alpha" <libc-alpha@sourceware.org>
Cc:     paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] nptl: Add rseq registration
References: <cover.1638798186.git.fweimer@redhat.com>
        <9c58724d604e160ebda5f667331fa41416c0d12b.1638798186.git.fweimer@redhat.com>
        <1780152866.15126.1638809966443.JavaMail.zimbra@efficios.com>
        <871r2podt9.fsf@oldenburg.str.redhat.com>
        <1614144911.15213.1638816753026.JavaMail.zimbra@efficios.com>
        <87ilw1mu81.fsf@oldenburg.str.redhat.com>
        <20211206201122.GE641268@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 06 Dec 2021 21:26:51 +0100
In-Reply-To: <20211206201122.GE641268@paulmck-ThinkPad-P17-Gen-1> (Paul
        E. McKenney via Libc-alpha's message of "Mon, 6 Dec 2021 12:11:22
        -0800")
Message-ID: <87k0ghlbsk.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul E. McKenney via Libc-alpha:

>> The C memory model is broken and does not prevent out-of-thin-air
>> values.  As far as I know, this breaks single-copy atomicity.  In
>> practice, compilers will not exercise the latitude offered by the memory
>> model.  volatile does not ensure absence of data races.
>
> Within the confines of the standard, agreed, use of the volatile keyword
> does not explicitly prevent data races.
>
> However, volatile accesses are (informally) defined to suffice for
> device-driver memory accesses that communicate with devices, whether via
> MMIO or DMA-style shared memory.  The device-driver firmware is often
> written in C or C++.  So doesn't this informal device-driver guarantee
> need to also do what is needed for userspace code that is communicating
> with kernel code?  If not, why not?

The informal guarantee is probably good enough here, too.  However, the
actual accesses are behind macros, and those macros use either
non-volatile plain reads or inline assembler (which use
single-instruction naturally aligned reads).

THanks,
Florian

