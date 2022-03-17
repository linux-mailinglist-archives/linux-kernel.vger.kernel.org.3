Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEC24DCF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiCQUPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCQUPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D915171EFD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647547994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qNtFrtkLvPTt+C4lJhyxR9PYkHaXFWorb7+v2VNB60=;
        b=K13O57P+kOOV4fP7twTgvpfPTJHf8aUEEZZ4s98Z3n4/Us9aoMyCCAfXyZxU12MCbIXnSs
        N/nGqNrPyOcZv63tIdNCirRyKYAYrp8CsIF6xpLbRjclfOouJWnaunSXbJ9Sqc2wrPHKTt
        a1MohrjuxuF5IntnSAtVPZ+B5Ms2LLE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-BvINtsxcOa6wZL1C7IXwhw-1; Thu, 17 Mar 2022 16:13:11 -0400
X-MC-Unique: BvINtsxcOa6wZL1C7IXwhw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E35EE296A613;
        Thu, 17 Mar 2022 20:13:10 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0662D401E75;
        Thu, 17 Mar 2022 20:13:06 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
References: <20220210223134.233757-1-morbo@google.com>
        <20220301201903.4113977-1-morbo@google.com>
        <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
        <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com>
        <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
        <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
        <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
        <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
Date:   Thu, 17 Mar 2022 21:13:05 +0100
In-Reply-To: <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 17 Mar 2022 11:52:26 -0700")
Message-ID: <878rt8gwxa.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> You can actually operate on EFLAGS at multiple granularities.
>
>  - normal pushf/popf. Don't do it unless you are doing system software.

There's one exception: PUSHF/twiddle/POPF/PUSHF/compare is the
recommended sequence to detect CPUID support on i386 (in userspace and
elsewhere).

>  - you can use lahf/sahc to load/store only the arithmetic flags
> into/from AH. Deprecated, and going away, but historically supported.

And these instructions were missing from the original long mode, but
they were added back.

> Yes, yes, that complete mental breakdown with pushf/popf did get
> fixed, but it really makes me very wary of thinking that we should
> ever use a built-in that compiler writers really fundamentally got so
> wrong before.
>
> What would make me think that you'd get it right now? In user space,
> you'll basically never actually see the whole system flags issues, so
> your test-cases would never work or be very contrieved. You'd have to
> really work at it to see the problems.

I think as the result of the nature of that kind of bug it does not
matter whether you use a compiler builtin to access the flags (to put
their combined value into a general-purpose register).

GCC doesn't have barriers in the built-ins (if we are talking about
__builtin_ia32_readeflags_u64 and __builtin_ia32_writeeflags_u64).  I
expect they are actually pretty useless, and were merely added for
completeness of the intrinsics headers.

It's not that you can write

  unsigned a, b, c;
  // =E2=80=A6
  c =3D a + b;

and examine __builtin_ia32_readeflags_u64() to see if there was an
overflow.  Neither GCC nor Clang model the EFLAGS register and
arithmetic expression side effects to make this possible.

Thanks,
Florian

