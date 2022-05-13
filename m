Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16A525F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354119AbiEMJ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379063AbiEMJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:27:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7820131C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:27:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652434020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Php+ZJ83A5DPq79iQSx2r7Rgggl0xBFSJkKdjRMuVAM=;
        b=n2+cKQf7QtlEHZ7/6xhAPT21fnqoei1jVHC0efwy9KrOEHxm5OdXniXQw50LIbgdP/Dand
        APAQ89v6fLyYpX8/V2/Gy2C6g/ucOPN9VgDCh52bk86cuNYe9Zanbs9lK3dQLVdUxbX78J
        VeMuaPIiA54X8qwtVZ7on71eG9tNSjUIHNG++AwSRh2YtcF4y/9u4pgzC8oJlY5HRDsgkP
        XtDwGrBbU7w9Ia+jwyOqW/EoiPZMWG+vXUBuvgrkL02inXUULsy0r+eJFzbyCRdafAaWCg
        55xL/+MbIoOvNozNrh8SBX82QoOISv888VkvPcHVn5TrExo/mBZmIma8NZwFAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652434020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Php+ZJ83A5DPq79iQSx2r7Rgggl0xBFSJkKdjRMuVAM=;
        b=qLTgxfdko9IOD+Xt5izjeOXBMTbSyXbQH8RnIupuq5f+bqLQWqrtMgG6AsGgk021/VxvDJ
        ETem9/Ks5+HTOLAA==
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
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
In-Reply-To: <Yn4hYSVSHvWGZCOo@arm.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
 <87o802tjd7.ffs@tglx>
 <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
 <67aef839-0757-37b1-a42d-154c0116cbf5@intel.com> <878rr6te6b.ffs@tglx>
 <Yn4hYSVSHvWGZCOo@arm.com>
Date:   Fri, 13 May 2022 11:26:59 +0200
Message-ID: <8735hdu6jg.ffs@tglx>
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

On Fri, May 13 2022 at 10:14, Catalin Marinas wrote:
> On Fri, May 13, 2022 at 03:27:24AM +0200, Thomas Gleixner wrote:
>> On Thu, May 12 2022 at 17:46, Dave Hansen wrote:
>> > On 5/12/22 17:08, H.J. Lu wrote:
>> > If I had to take a shot at this today, I think I'd opt for:
>> >
>> > 	mask = sys_enable_masking(bits=6, flags=FUZZY_NR_BITS);
>> >
>> > although I'm not super confident about the "fuzzy" flag.  I also don't
>> > think I'd totally hate the "blind" interface where the kernel just gets
>> > to pick unilaterally and takes zero input from userspace.
>> 
>> That's the only sane choice and you can make it simple for userspace:
>> 
>>        ret = prctl(GET_XXX_MASK, &mask);
>> 
>> and then let it decide based on @ret and @mask whether to use it or not.
>
> Getting the mask would work for arm64 as well (it's always 0xffUL << 56,
> top-byte-ignore). Setting the mask from user space won't be of any use
> to us, it's baked in hardware.

Sure.

> Dave indeed mentioned passing a mask to allow a more flexible control
> but, as already mentioned in the old thread, for arm64 the feature was
> already on, so it didn't make much sense, it seemed more like
> over-engineering. Had we known that Intel is pursing something similar,
> maybe we'd have designed the interface differently (we didn't get the
> hint).

Fair enough

> Intel's LAM has more flexibility but I don't see the arm64 TBI getting
> in the way. Just don't use it as an example because they evolved in
> different ways. I'm happy for arm64 to adopt a more flexible interface
> while keeping the current one around for backwards compatibility). But
> on arm64 we can't control the masking, not even disable it per process
> since it has always been on.

That's fine. The point is that we want uniform interfaces for the same
functionality. It's obviously hardware specific which subset of the
interface is supported.

>> I'm so tired of this short sighted 'cram my feature in' approach of
>> _all_ involved parties.
>
> Unfortunately it happens occasionally, especially when developers can't
> disclose that their companies work on similar features (resctrl is a
> good example where arm64 would have benefited from a more generic
> approach but at the time MPAM was not public).

Yeah. It's a constant pain.

Thanks,

        tglx
