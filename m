Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A243052585E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359519AbiELXfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359511AbiELXfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:35:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED2285EFB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:35:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652398516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pfTVpQBBfdX2IFvNH0UqLqx7jcD8qe2XwLVneMmb18E=;
        b=pGTKHFWGyDGJgUele6ZXW7WjSIn3WqOCUeDlvCENYMK9IQExnvtF/6McZTkiV9Ln7phEPY
        AUk0R/YjbBksJeAGsOz95BxNhg8/uQSosOQ4zuMoA0XBIZWnbZa3syzQhLByGkx3OlS+J9
        rasv8mRwDCimDe+tRvW5Yc/+BXPeFonlQG74i0eq0qYCk9mORijwnUdD1pEcQ5BOnaCezN
        SYTSZsFkoUlq52skEL60U33HRXu2jJOSZdHHA0bpo5+81YSZRojWhocPEJBAajEWPokKn0
        nzLIi7VVcv88PSOupz6kR9VesyUFYYvWIbbg68ZbaoZ/I7sTqqoGzG7LPOfBww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652398516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pfTVpQBBfdX2IFvNH0UqLqx7jcD8qe2XwLVneMmb18E=;
        b=SlngLJSIisI7Q2vZleWNUVBAf1fy8xHeDwS8IBxEfnWFT1XmR9Ud7N4B7QWxUH+X8OiEez
        aH+JtKpJbQUulqAQ==
To:     "H.J. Lu" <hjl.tools@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
In-Reply-To: <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
Date:   Fri, 13 May 2022 01:35:16 +0200
Message-ID: <87o802tjd7.ffs@tglx>
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

On Thu, May 12 2022 at 15:10, H. J. Lu wrote:
> On Thu, May 12, 2022 at 2:51 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> On 5/12/22 12:39, Thomas Gleixner wrote:
>> >> It's OK for a debugging build that runs on one kind of hardware.  But,
>> >> if we want LAM-using binaries to be portable, we have to do something
>> >> different.
>> >>
>> >> One of the stated reasons for adding LAM hardware is that folks want to
>> >> use sanitizers outside of debugging environments.  To me, that means
>> >> that LAM is something that the same binary might run with or without.
>> > On/off yes, but is there an actual use case where such a mechanism would
>> > at start time dynamically chose the number of bits?
>>
>> I'd love to hear from folks doing the userspace side of this.  Will
>> userspace be saying: "Give me all the bits you can!".  Or, will it
>> really just be looking for 6 bits only, and it doesn't care whether it
>> gets 6 or 15, it will use only 6?
>>
>> Do the sanitizers have more overhead with more bits?  Or *less* overhead
>> because they can store more metadata in the pointers?
>>
>> Will anyone care about the difference about potentially missing 1/64
>> issues with U57 versus 1/32768 with U48?
>
> The only LAM usage I know so far is LAM_U57 in HWASAN.

That's at least a halfways useful answer.

> An application can ask for LAM_U48 or LAM_U57. But the decision should
> be made by application.

It can ask for whatever, but the decision whether it's granted is made
by the kernel for obvious reasons.

> When an application asks for LAM_U57, I expect it will store tags in
> upper 6 bits, even if the kernel enables LAM_U48.

The kernel does not enable LAM_U48 when the application only wants to
have LAM_U57, because that would restrict the address space of the
application to 47 bits on 5-level capable system for no reason.

So what are you trying to tell me?

Thanks,

        tglx



