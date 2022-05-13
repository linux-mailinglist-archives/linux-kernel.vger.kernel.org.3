Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E6F52595F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376343AbiEMB1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352238AbiEMB13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:27:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454E5F8D5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:27:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652405244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTKi6sAW5Wnn5JxzuBjnHsq9FW1AedE2Tm2sMJNjbuM=;
        b=cP2hgRZZ9plq+O0IDo1vTL/H0jE/EJ1Y2NZBsQDfMBpPMcjzlwqJOyRJJvBgduC4fhn4It
        s82N19W5bKEdOjAASaYozJhL3Yy54FttXUYFHjIaLCmYqao4kp5NCUxbPkeZvpbwFev8Wz
        wR5cect9useyVtBbWtuvYdBA34RBti4i4y+E66g8qHBWlrNKErBx6YQ4KRF9YeizazgtpA
        Kld6uymOt/7hkujS8+A4E466kc71OJyQwaVqefmpLVnU79r4sC4SytznDmTFfaPIKNdxfp
        /VMc6SefkJ0NvzKaFk9ySGgB9zS/c/nRae732sg83j0iVsiUqRo97CpM3xJdcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652405244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTKi6sAW5Wnn5JxzuBjnHsq9FW1AedE2Tm2sMJNjbuM=;
        b=BOPHxlmulNJXw0lNYAY/ujR+fw7MmSFJ73d3UhTHWAB6nTWKOeF/L5ioXz0e9rVPzWTBj1
        gyY8akMvERY14IAg==
To:     Dave Hansen <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>
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
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
In-Reply-To: <67aef839-0757-37b1-a42d-154c0116cbf5@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
 <87o802tjd7.ffs@tglx>
 <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
 <67aef839-0757-37b1-a42d-154c0116cbf5@intel.com>
Date:   Fri, 13 May 2022 03:27:24 +0200
Message-ID: <878rr6te6b.ffs@tglx>
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

On Thu, May 12 2022 at 17:46, Dave Hansen wrote:
> On 5/12/22 17:08, H.J. Lu wrote:
> If I had to take a shot at this today, I think I'd opt for:
>
> 	mask = sys_enable_masking(bits=6, flags=FUZZY_NR_BITS);
>
> although I'm not super confident about the "fuzzy" flag.  I also don't
> think I'd totally hate the "blind" interface where the kernel just gets
> to pick unilaterally and takes zero input from userspace.

That's the only sane choice and you can make it simple for userspace:

       ret = prctl(GET_XXX_MASK, &mask);

and then let it decide based on @ret and @mask whether to use it or not.

But of course nobody thought about this as a generic feature and so we
have the ARM64 TBI muck as a precedence.

So much for coordination and portability...

I'm so tired of this short sighted 'cram my feature in' approach of
_all_ involved parties.

Thanks,

        tglx


