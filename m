Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392364E926A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbiC1KWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiC1KWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A34C326E2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648462848;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Laf/K1cWVWhxaqqakxKFWK3semcWDCO2R58wSsFAsPU=;
        b=Dgn3bAc/MT+YJ4LF116u9/yuo3X4huMKokG0JDEwFTZWSiXKe0gu+LKYL1SptcmEA+BW/E
        acLqSxrpeAgM2znw3Gcw/c/d7+F0kk4xxldN2X9Cg96pDs4F6ZisgKjRRw9VdBd31G5+73
        p63+g+BB1+o11cSt5CYYYQd3Ga52g5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-zmpxLUDzPtyjxwC4iX_jRQ-1; Mon, 28 Mar 2022 06:20:47 -0400
X-MC-Unique: zmpxLUDzPtyjxwC4iX_jRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DEB2185A794;
        Mon, 28 Mar 2022 10:20:46 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB590C15D40;
        Mon, 28 Mar 2022 10:20:45 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 22SAKfDe3603422
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 12:20:42 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 22SAKdAM3603421;
        Mon, 28 Mar 2022 12:20:39 +0200
Date:   Mon, 28 Mar 2022 12:20:39 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: clang memcpy calls
Message-ID: <YkGL929QoFiTfMK7@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
 <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
 <Yj2yYFloadFobRPx@lakrids>
 <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net>
 <20220325151238.GB614@gate.crashing.org>
 <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 10:52:54AM +0100, Mark Rutland wrote:
> I think we're talking past each other here, so let me be more precise. :)
> 
> The key thing is that when the user passes `-fsantize=address`, instrumentation
> is added by (a part of) the compiler. That instrumentation is added under some
> assumptions as to how the compiler as a whole will behave.
> 
> With that in mind, the question is how is __attribute__((no_sanitize_address))
> intended to work when considering all the usual expectations around how the
> compiler can play with memcpy and similar?

no_sanitize_address or lack thereof is whether the current function
shouldn't be or should be ASan instrumented, not on whether other functions
it calls are instrumented or not.  memcpy/memmove/memset are just a tiny bit
special case because the compiler can add them on their own even if they
aren't present in the source (there are a few others the compiler can
pattern match too) and various builtins can be on the other side expanded
inline instead of called, so one then gets the sanitization status of the
function in which it is used rather than whether the out of line
implementation of the function is sanitized.

If coexistence of instrumented and non-instrumented memcpy etc. was the goal
(it clearly wasn't), then the sanitizer libraries wouldn't be overriding
memcpy calls, but instead the compiler would redirect calls to memcpy in
instrumented functions to say __asan_memcpy which then would be
instrumented.

> Given the standard doesn't say *anything* about instrumentation, what does GCC
> *require* instrumentation-wise of the memcpy implementation? What happens *in
> practice* today?
> 
> For example, is the userspace implementation of memcpy() instrumented for
> AddressSanitizer, or not?

It is, for all functions, whether compiled with -fsanitize=address or not,
if user app is linked with -fsanitize=address, libasan is linked in and
overrides the libc memcpy with its instrumented version.

Note that the default shadow memory value is 0 which means accessible,
so even when memcpy is instrumented, when called from non-instrumented code
often it will not do anything beyond normal behavior, as non-instrumented
functions don't poison the paddings in between variable (there even doesn't
have to be any) etc.  But e.g. malloc/operator new etc. is also overridden,
so buffer overflows/underflows on memory allocated that way from
uninstrumented code using memcpy etc. will be diagnosed.

	Jakub

