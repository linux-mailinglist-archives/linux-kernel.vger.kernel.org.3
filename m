Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42272524FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355226AbiELOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355238AbiELOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:21:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FFB62CD6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:21:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652365288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LKW8s1IC8MmGMecprVtPLX/4rsXDGAuIe6lI8Xw1LJM=;
        b=SSeS5NBZhKRm+kFTkFtKqwwBIglBHot0XHjIrEE4MNVTwRRSVmvFrfESZ+pKnq2jMiPA5D
        9MWCs/yBBCRT3NT0QSwJKSjkDseXDscN5NarPZVMOLxKidHtkxaPYoE84ls+r6zr1x7OWm
        UgGReWwqWnoFTXrPMtAu1dgm0Uz7DkpTIbV5F+4LnuZZUT91kUaiPhqv/TVNj4Rryrwpyb
        /T54OW2WH7bFqheJsi+d3+hei2l3VmazNeGgj3uSR5PYMAYtyv8b5F3EMvgIjdjgCon116
        jOVWEkfaRx5N/4qkCzutFWPJMtbHq4AWcGRKDtifDaVR7EYwcFe7wM3Iicl4+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652365288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LKW8s1IC8MmGMecprVtPLX/4rsXDGAuIe6lI8Xw1LJM=;
        b=R6Vr1lA/JP0T02AwerEAu6yTbUZNQRSQXwH0lL+/cua20V2rc9ONltjw7yrriAaBRX+qhp
        j4TzS/RleXWP9jBg==
To:     "H.J. Lu" <hjl.tools@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 09/10] x86/mm: Add userspace API to enable Linear
 Address Masking
In-Reply-To: <CAMe9rOpOKsKZfUpj7dXawv56N5a+x24LQhkhRXwH31GQt5S4=Q@mail.gmail.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-11-kirill.shutemov@linux.intel.com>
 <CAMe9rOpOKsKZfUpj7dXawv56N5a+x24LQhkhRXwH31GQt5S4=Q@mail.gmail.com>
Date:   Thu, 12 May 2022 16:21:27 +0200
Message-ID: <8735hex254.ffs@tglx>
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

On Wed, May 11 2022 at 07:15, H. J. Lu wrote:
>> @@ -992,7 +994,9 @@ unsigned long __get_wchan(struct task_struct *p)
>>  static long thread_feature_prctl(struct task_struct *task, int option,
>>                                  unsigned long features)
>
> Since this arch_prctl will also be used for CET,  which supports
> 32-bit processes,
> shouldn't int, instead of long, be used?

This is kernel internal code and the compat syscall takes care of the
int to long conversion. So yes, that could use unsigned int, but it does
not matter.

Thanks,

        tglx
