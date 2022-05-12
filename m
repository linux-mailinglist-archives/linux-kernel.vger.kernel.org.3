Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30862524CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353632AbiELMYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiELMY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:24:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515BA23BB67
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652358262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DVZxZFuMkEfBe60LNYj65QHxhgAKYNVpBhi0MdB9lK8=;
        b=gBh9EUjm8OHWsyt3Bhmp8aXcBfegq7ceUs07OGjvIClwgVhSWQxueqp6gHTGX9SuSLQwF5
        uw+NzDCWqyySFNdF1TO2JOrK3OwAPJK9Ib4wqoW5LVLqhznq5sjNT6Wc6IqJKWqksCNqsR
        +pS3EJSfxxsfeZEXoHCXjVe4gMNBgBH3jCD+XTQlTuNIuzqN7R56yhcUnIHtyX/jcqRjh4
        PF9Ltjm0+fdJyO+wwId892lhnwSonWHa/mQoMzjjNrwLwg86+ICwnd+qBpOVkrZ2MXZoYG
        br8uqG0aCmU1f5c7SFxv7zM1RmjssdSnjg1/9jNnwY5/WljG9yaTL0JOvKBauQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652358262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DVZxZFuMkEfBe60LNYj65QHxhgAKYNVpBhi0MdB9lK8=;
        b=Psyau2D9q2q0Tphp54E/cLDjph4z3qZGCb3Hg68lQj0iavPkDB9wn7jIfzFsacapGDhvFg
        JRoiCrjUQ/iiCNAQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 04/10] x86/mm: Introduce X86_THREAD_LAM_U48 and
 X86_THREAD_LAM_U57
In-Reply-To: <20220511070211.GS76023@worktop.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-6-kirill.shutemov@linux.intel.com>
 <20220511070211.GS76023@worktop.programming.kicks-ass.net>
Date:   Thu, 12 May 2022 14:24:22 +0200
Message-ID: <87ee0zvszt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022 at 09:02, Peter Zijlstra wrote:
> On Wed, May 11, 2022 at 05:27:45AM +0300, Kirill A. Shutemov wrote:
>
>> +#define LAM_NONE	0
>> +#define LAM_U57		1
>> +#define LAM_U48		2
>
>> +#define X86_THREAD_LAM_U48		0x1
>> +#define X86_THREAD_LAM_U57		0x2
>
> Seriously pick an order and stick with it. I would suggest keeping the
> hardware order and then you can do:
>
>> +static inline unsigned long lam_to_cr3(u8 lam)
>> +{
>
> 	return (lam & 0x3) << X86_CR3_LAM_U57;

This "works" because the hardware ignores LAM_U48 if LAM_U57 is set, but
I'd rather make that exclusive in the prctl() as setting both does not
make any sense.

> I'm still not liking LAM(e), I'm thikning it's going to create more
> problems than it solves.

Isn't that true for most new hardware features?

Thanks,

        tglx
