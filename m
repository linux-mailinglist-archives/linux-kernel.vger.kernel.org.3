Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B00525911
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359798AbiEMAql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359811AbiEMAqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:46:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B666219
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:46:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652402789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xd8me3zJySDc9HaBBmJv3HcDQGa35Kv/TIv1nYHhe6s=;
        b=vddEIncvnG/nsi6VTvMIXkJG01KEpPIw3AwzEeuxtq8S6ZYkEPjYwvcjt4O3sV8QdzrITN
        mLP6Yh9yPHI8BmaCCS3CKeGxSslKlxZ5Q1J4+mqMz8FFAVf//4OfBRQMEb0m38qxwX1A7w
        fmHEfDokYTHRdP5GxH3UMMLCOt36M3x7Va+TaPazXgrn9o2ksmG7Sm4sgcF6b8fsffAhGN
        1WLwZMooyXlLFKdMxEHGA7tZTXuUOqBZNEPFEeHwID82pe3AAzREkXePwOtYr9Oi3ZCCdO
        Pxw6dEPuKAl4yt4nJOWyTz76y6D62MF7wURBFgOS8QAQBCx826uZolpV6BhMEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652402789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xd8me3zJySDc9HaBBmJv3HcDQGa35Kv/TIv1nYHhe6s=;
        b=3F06efiAuRLVvpsUQlMIvmVqjkkqV4jjSnt5hSCvdcckZpqqCC3UcmlC+Sjf38puwTU16t
        VMWqX7G1P0OqADBw==
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
 <87o802tjd7.ffs@tglx>
 <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
Date:   Fri, 13 May 2022 02:46:28 +0200
Message-ID: <87czgitg2j.ffs@tglx>
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

On Thu, May 12 2022 at 17:08, H. J. Lu wrote:
> On Thu, May 12, 2022 at 4:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > When an application asks for LAM_U57, I expect it will store tags in
>> > upper 6 bits, even if the kernel enables LAM_U48.
>>
>> The kernel does not enable LAM_U48 when the application only wants to
>> have LAM_U57, because that would restrict the address space of the
>> application to 47 bits on 5-level capable system for no reason.
>>
>> So what are you trying to tell me?
>>
> I am expecting applications to ask for LAM_U48 or LAM_U57, not just
> LAM.

That still does not tell anything.

You can as well tell me, that this will depend on the moon phase. That
would be more telling at least.

If we commit to an ABI, which we have to support forever, then we want
factual arguments, not expectations.

The fact that hardware supports 5 variants does not mean that all of
them make sense to support in the OS.

Quite the contrary, 99% of all 'flexible' hardware features are based on
bogus assumptions. The worst of these assumptions is:

      'We can handle this in software'

Sure, most of the trainwrecks hardware people provide can be 'handled'
in software, but you have to consider the price for doing so.

   The price is that we amount technical debt.

You are well aware of this as you have contributed your share of
technical debt by cramming unsupportable crap into user space projects
prematurely.

So can you please take a step back and seriously think about the
semantics and long term consequences instead of providing handwaving
expectations which are biased by uninformed wishful thinking, AKA
marketing?

Thanks,

        tglx
