Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B851525830
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359421AbiELXVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347549AbiELXVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:21:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D361E6A025
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:21:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652397697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84nnGwOoFOoUcIxrrghgkTUTltsimr0GgYwQOdT0EGI=;
        b=STHTVqqacHev1YK2lxR+88OX4pXem4AVJ+3cV57dbs7q198GyRICOjlvUEkZ28dtOvuHdn
        dRNnAN+0bJaqGSZYgeSUI3V2xJybQ4ro5kNpkxtm4i8cLgQd9oZQRUOyXsGig+2v/OvypW
        +fBv/bru6QOH9kVzqrzZf8bo8F9eSoNvTzMHRzjt48EFCiEnRfOtkYtU0LqJbA8GO6sMQw
        Xg+5+76Uv9RAWhOZzvVtuGX4YCDUC+MJ1QbrbEFNSxu1RFJtoL0iJk3WFNdascOnZ0yut8
        vHJz9FeQmCQlk3GGyHwKa2WhKaAHwa7TFlB+4tXHLx7Qxwfu00mjShFC+aCUbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652397697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84nnGwOoFOoUcIxrrghgkTUTltsimr0GgYwQOdT0EGI=;
        b=J3yuVJUipub7m7ga0YJBYUg1KC+UBuAK7jpcyV2djuXgkdLPh/8H7UU7Lgg53y/MBxx1wY
        /WfNbkxjab5esnBg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
In-Reply-To: <878rr6v985.ffs@tglx>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <87pmkivjst.ffs@tglx> <20220512165612.gizedzgtpzbi7jbl@black.fi.intel.com>
 <878rr6v985.ffs@tglx>
Date:   Fri, 13 May 2022 01:21:37 +0200
Message-ID: <87r14ytjzy.ffs@tglx>
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

On Thu, May 12 2022 at 21:31, Thomas Gleixner wrote:
> On Thu, May 12 2022 at 19:56, Kirill A. Shutemov wrote:
>> On Thu, May 12, 2022 at 05:42:58PM +0200, Thomas Gleixner wrote:
>>> On Wed, May 11 2022 at 08:49, Peter Zijlstra wrote:
>>> > On Wed, May 11, 2022 at 05:27:40AM +0300, Kirill A. Shutemov wrote:
>>> > So aren't we creating a problem with LAM_U48 where programs relying on
>>> > it are of limited sustainability?
>>> >
>>> > Any such program simply *cannot* run on 5 level pagetables. Why do we
>>> > want to do this?
>>> 
>>> More bits are better :)
>>> 
>>> Seriously, I agree that restricting it to LAM57, which gives us 6 bits,
>>> makes a lot of sense _and_ makes the whole thing way simpler.
>>> 
>>> So supporting both needs a truly good justification and a real world use
>>> case.
>>
>> I asked the question before[1]. Basically, more bits more better:
>>
>> 	For HWASAN #bits == detection probability.
>> 	For MarkUS #bits == exponential cost reduction
>
> What is MarkUS? It's not really helpful to provide acronyms which are
> not decodable.
>
>> I would really like to have only LAM_U57, but IIUC 6 bits is not always
>> enough.
>>
>> Dmitry, could you elaborate?
>>
>> [1] https://mobile.twitter.com/dvyukov/status/1342019823400837120
>
> I don't know whether he reacts on posting a link to his twitter
> account. I've CC'ed him now. Maybe that works better.

Duh. I should have looked at 'To:' and not only at 'Cc:'

Maybe someday I get used to this email thing.

Thanks,

        tglx
