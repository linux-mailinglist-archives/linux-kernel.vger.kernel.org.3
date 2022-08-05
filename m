Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0912C58A826
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiHEIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiHEIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4AC618F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659688585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWEEAO6UGfW/YnjBP9VOyZB3NA9ALsAqziwzeAGrxtU=;
        b=VyO+bjXz4uCDBI8zo8Y8JTgHDMos9n92/f7xTm8n/0oWLrwEqihCEdGilfczEqviz97WIM
        y6+Lu143cxIPTjyDs699czqJBzSv213xPXGxy9b9A5i1Tx6nJ1lOiD5tz5tmhIAMv/2+z/
        ZqwgshXZMp+J4hbSAbABnT0kKHMHkuk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-gQzcc_3NN-a-RNHlJCBRag-1; Fri, 05 Aug 2022 04:36:21 -0400
X-MC-Unique: gQzcc_3NN-a-RNHlJCBRag-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAFDD1019C91;
        Fri,  5 Aug 2022 08:36:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5303F492C3B;
        Fri,  5 Aug 2022 08:36:18 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
References: <20220729145525.1729066-1-Jason@zx2c4.com>
        <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
        <YuXCpyULk6jFgGV5@zx2c4.com> <87zggnsqwj.ffs@tglx>
        <Yuhe6IIFXqNMZs5b@zx2c4.com> <87bkt2sqq4.ffs@tglx>
        <YuktqQS7Rb0IbJNh@zx2c4.com> <878ro6smmm.ffs@tglx>
Date:   Fri, 05 Aug 2022 10:36:16 +0200
In-Reply-To: <878ro6smmm.ffs@tglx> (Thomas Gleixner's message of "Tue, 02 Aug
        2022 17:14:57 +0200")
Message-ID: <87v8r713zz.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner:

> On Tue, Aug 02 2022 at 15:59, Jason A. Donenfeld wrote:
>> On Tue, Aug 02, 2022 at 03:46:27PM +0200, Thomas Gleixner wrote:
>>> Right now the Linux VDSO functions are 1:1 replacements for system calls
>>> and not adding a magic pile of functionality which is otherwise not
>>> available.
>>> 
>>> What you are proposing is to have an implementation which is not
>>> available via a regular syscall. Which means you are creating a VDSO
>>> only syscall which still has the same problem as any other syscall in
>>> terms of API design and functionality which needs to be supported
>>> forever.
>>
>> Wait, what? That's not correct. The WHOLE point is that vdso getrandom()
>> will generate bytes in the same way as the ordinary syscall, without
>> differences. Same function name, same algorithm. But just faster,
>> because vDSO. I explicitly don't want to dip into introducing something
>> different. That's the big selling point: that vDSO getrandom() and
>> syscall getrandom() are the same thing. If you trust one, you can trust
>> the other. If you expect properties of one, you get that from the other.
>> If you know the API of one, you can use the other.
>
> Seriously no. All existing VDSO functions have exactly the same function
> signature and semantics as their syscall counterparts. So they are drop
> in equivalent.
>
> But:
>
>   ssize_t getrandom(void *, void *, size_t, unsigned int);
>
> is very much different than
>
>   ssize_t getrandom(void *, size_t, unsigned int);
>
> Different signature and different semantics.

Just use

   ssize_t getrandom(size_t, unsigned int, void *);

then and have the system call ignore the argument.  There is recent
precedent for adding additional arguments to system calls, see
membarrier.  If we want to be super-conservative, we could add a new
flag and have the vDSO version always call into the kernel if the flag
isn't set.

*This* part is far less problematic compared to the approach to
per-thread memory allocation.

We now have:

* Explicit donation of memory areas to the kernel (set_robust_list,
  rseq).

* This getrandom_alloc vDSO call which does something unspecified and
  may return pointers which are or are not abstract.  (How is CRIU
  expected to handle this?)

* There's also userspace shadow stack coming.  I think the kernel moved
  away from implicit allocation, to something mmap-based.  It's not
  clear to me why that would be okay here, but not for shadow stacks.

Does io_uring have to handle a similar problem, too?

As long as the vDSO doesn't use private system calls, I don't expect any
practical problems, but this optimization doesn't really look to me like
something that intrinsically benefits from a completely new way of
allocating userspace memory for use by the kernel.

Thanks,
Florian

