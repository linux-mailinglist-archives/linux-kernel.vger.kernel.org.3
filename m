Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D33758ED2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiHJN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiHJN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:27:40 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3495E31DE5;
        Wed, 10 Aug 2022 06:27:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2E83643EE6D;
        Wed, 10 Aug 2022 09:27:38 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MJib_laXykSn; Wed, 10 Aug 2022 09:27:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AC46643F1C7;
        Wed, 10 Aug 2022 09:27:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AC46643F1C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1660138057;
        bh=NPRedLsPVS59v5tcpWRZeGzk9PUOEhDQ6s4F/doEc0M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Fs6t9Ze7hq023TBFz39CV5kXBR8TA6pz8xaD4rsZ48R78lc1jaocA4Tvx+rnuqYuH
         rRqudIHuZM1znPL/2JZVNSHPMqs6xRTmUS8nfitOx0vFsDCbI3xke3tLhX+s0O90n2
         tP8lWAgJeA6dza8zST5I6f6K/e0v30KTJLZOccZZ7m4XfcrYIz4yo/zATAlYN3EIRS
         h0Vm3YRVIIqNWpVyAJmfGA11zxEH01GEOOZ/nKZYFBcgyjV9/ub5MVb8+a87Hxgj0f
         C9jl5I0Cq/eEvp1OGb1yA+Zjq7oLlapO1FxC6Ws2ZA5sy/5RA+KuEbw4cQR4EmwTQc
         2/SNldCF9kYOQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mw2fUtflSjGQ; Wed, 10 Aug 2022 09:27:37 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9232B43F30C;
        Wed, 10 Aug 2022 09:27:37 -0400 (EDT)
Date:   Wed, 10 Aug 2022 09:27:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Message-ID: <10664496.447.1660138057500.JavaMail.zimbra@efficios.com>
In-Reply-To: <8735e4hajt.fsf@oldenburg.str.redhat.com>
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com> <20220729190225.12726-3-mathieu.desnoyers@efficios.com> <8735e4hajt.fsf@oldenburg.str.redhat.com>
Subject: Re: [PATCH v3 02/23] rseq: Introduce extensible rseq ABI
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103 (Linux)/8.8.15_GA_4372)
Thread-Topic: rseq: Introduce extensible rseq ABI
Thread-Index: ubZeGluYZawXefnGZNHU0cuZYToYsw==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 10, 2022, at 2:33 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> Introduce the extensible rseq ABI, where the feature size supported by
>> the kernel and the required alignment are communicated to user-space
>> through ELF auxiliary vectors.
>>
>> This allows user-space to call rseq registration with a rseq_len of
>> either 32 bytes for the original struct rseq size (which includes
>> padding), or larger.
>>
>> If rseq_len is larger than 32 bytes, then it must be large enough to
>> contain the feature size communicated to user-space through ELF
>> auxiliary vectors.
> 
> I don't think this works with the glibc extension mechanism because
> __rseq_size does not change until the padding is exhausted.

In order to deal with this existing discrepancy between feature-set vs
size, the proposed extension scheme would require that glibc expose a new
__rseq_feature_size, which would give us:

/*
 * Size of the registered rseq area. 0 if the registration was
 * unsuccessful.
 */
unsigned int __rseq_size = -1U;

/* Flags used during rseq registration.  */
unsigned int __rseq_flags;

/*
 * rseq feature size supported by the kernel. 0 if the registration was
 * unsuccessful.
 */
unsigned int __rseq_feature_size = -1U;

> I think you'll need to add the suggested flags to the auxiliary vector,
> and then we can use that during registration and also communicate these
> flags via __rseq_flags.

For the struct rseq extension, with the "__rseq_feature_size" symbol
I don't think we need to suggest rseq registration flags through
auxiliary vectors.

However, the kernel could provide the set of "supported flags" which
can be passed as rseq flags argument through auxiliary vectors. Is
that what you have in mind ?

This can be useful to ensure we don't require userspace to rely on
rseq returning -1, errno=-EINVAL to detect supported feature flags.

> 
> Size and alignment can be stored in a single auxiliary vector entry.

getauxval returns a single "unsigned long". I'm not sure how to extract
size and alignment other than using bitwise operations. Is that what you
have in mind ? Are there other auxval entries that use this kind of
bitwise scheme ?

And by "size", do you mean "supported feature size" or "allocation size" ?
Because the allocation size will be typically aligned to the next power of
two, but not the "supported feature size". AFAIU though, the kernel only
needs to express the supported feature size and the allocation alignment
through auxv. The rest can be figured out from userspace.

Thanks,

Mathieu

> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
